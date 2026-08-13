[CmdletBinding()]
param(
    [ValidateSet('Campaign', 'Outer', 'Inner', 'DescribeLifecycle', 'ValidateLifecycle')]
    [string]$Mode = 'Outer',

    [string]$BindingPath,

    [string]$AuthoritySnapshotPath,

    [string]$CarrierManifestPath,

    [string]$FrozenInputsPath,

    [string]$ReceiptPath,

    [string]$DispatchStatePath,

    [string]$ExpectedPhase,

    [string]$ChildExecutablePath,

    [string]$ChildOperationId,

    [ValidateSet(
        'd52-powershell-current',
        'd52-windows-whoami',
        'd52-codex-app-server-0.147.0-alpha.6.6',
        'd52-git-2.54.0.windows.1'
    )]
    [string]$ChildExecutableAnchorId,

    [string]$ChildArgumentsPath,

    [string]$ChildWorkingDirectory,

    [string]$NextDispatchPath,

    [string]$LifecycleEvidenceRoot,

    [ValidateSet(
        'ZERO_MODEL_QUALIFICATION_PENDING',
        'CANARY_AUTHORIZED_AFTER_QUALIFICATION',
        'FREEZE_PENDING_AFTER_CANARIES',
        'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION',
        'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN',
        'TERMINAL'
    )]
    [string]$ExpectedLifecycleState,

    [switch]$RequireActionProvenance,

    [ValidateRange(1, 3600)]
    [int]$ReceiptMaxAgeSeconds = 300,

    [string]$RootContractPath,

    [string]$RootContractSha256,

    [string]$RepositoryRoot,

    [string]$CampaignRoot,

    [string]$CarrierRoot,

    [string]$SourceBundleRoot,

    [string]$EvidenceRoot,

    [string]$D53PredecessorRoot,

    [string]$D49PredecessorRoot
)

$ErrorActionPreference = 'Stop'
$script:RunnerFailureExitCode = 86
$script:StrictUtf8 = [System.Text.UTF8Encoding]::new($false, $true)
$script:CampaignId = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
$script:StableSubject = 'Work Charter v0.2.0 exact candidate'
$script:CandidateCommit = 'c4810057c3f28cca9f12004ca2018784cd21f449'
$script:CandidateManifestSha256 = '04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44'
$script:ControlCommit = 'ceed607152849775b981c54add74bfa30d858e4d'
$script:D54RootInputs = [pscustomobject]@{
    RootContractPath = $RootContractPath
    RootContractSha256 = $RootContractSha256
    RepositoryRoot = $RepositoryRoot
    CampaignRoot = $CampaignRoot
    CarrierRoot = $CarrierRoot
    SourceBundleRoot = $SourceBundleRoot
    EvidenceRoot = $EvidenceRoot
    PredecessorRoots = @($D53PredecessorRoot, $D49PredecessorRoot)
}
$script:RepositoryRoot = $null
$script:CampaignRoot = $null
$script:CampaignContractPath = $null
$script:PrivateCarrierRoot = $null
$script:SourceBundleRoot = $null
$script:EvidenceRoot = $null
$script:PredecessorRoots = @()
$script:RootContractPath = $null
$script:RootContractSha256 = $null
$script:RootContract = $null
$script:RunnerRepositoryPath = 'evals/invoke-work-charter-gate2.ps1'
$script:ZeroModelQualificationPhase = 'runner-zero-model-qualification'
$script:PredecessorTerminalReceiptSha256 = `
    'e8e9fb645b83beaa9c64cd5ccf3d8fc3e283d21cdbb964cde8c72adb8849882b'
$script:ProductionDispatchDepth = 0
$script:OuterInnerCapability = $null
$script:ActiveCampaignController = $null
$script:SegmentInputReader = [Console]::In
$script:RulesetSources = @()

function Get-RootedPath {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Purpose
    )

    if (-not [System.IO.Path]::IsPathFullyQualified($Path)) {
        throw "$Purpose must be an absolute path."
    }
    return [System.IO.Path]::GetFullPath($Path)
}

function Get-OrdinaryFile {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Purpose
    )

    $fullPath = Get-RootedPath -Path $Path -Purpose $Purpose
    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        throw "$Purpose is absent."
    }
    $item = Get-Item -LiteralPath $fullPath -Force -ErrorAction Stop
    if (-not $item.PSIsContainer -and
        -not ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        $ancestor = $item.Directory
        while ($null -ne $ancestor) {
            if ($ancestor.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
                throw "$Purpose has a reparse ancestor: $($ancestor.FullName)"
            }
            $ancestor = $ancestor.Parent
        }
        return $item
    }
    throw "$Purpose must be an ordinary non-reparse file."
}

function Get-OrdinaryDirectory {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Purpose
    )

    $fullPath = Get-RootedPath -Path $Path -Purpose $Purpose
    $item = Get-Item -LiteralPath $fullPath -Force -ErrorAction Stop
    if ($item.PSIsContainer -and
        -not ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        $ancestor = $item.Parent
        while ($null -ne $ancestor) {
            if ($ancestor.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
                throw "$Purpose has a reparse ancestor: $($ancestor.FullName)"
            }
            $ancestor = $ancestor.Parent
        }
        return $item
    }
    throw "$Purpose must be an ordinary non-reparse directory."
}

function Get-BytesSha256 {
    param([Parameter(Mandatory)][AllowEmptyCollection()][byte[]]$Bytes)

    return [System.Convert]::ToHexString(
        [System.Security.Cryptography.SHA256]::HashData($Bytes)
    ).ToLowerInvariant()
}

function Get-NormalizedTextSha256 {
    param([Parameter(Mandatory)][byte[]]$Bytes)

    $offset = if ($Bytes.Length -ge 3 -and
        $Bytes[0] -eq 0xEF -and $Bytes[1] -eq 0xBB -and $Bytes[2] -eq 0xBF) { 3 } else { 0 }
    $count = $Bytes.Length - $offset
    $text = $script:StrictUtf8.GetString($Bytes, $offset, $count)
    $normalized = $text.Replace("`r`n", "`n").Replace("`r", "`n")
    return Get-BytesSha256 -Bytes $script:StrictUtf8.GetBytes($normalized)
}

function Read-JsonSnapshot {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Purpose
    )

    $item = Get-OrdinaryFile -Path $Path -Purpose $Purpose
    $bytes = [System.IO.File]::ReadAllBytes($item.FullName)
    $text = $script:StrictUtf8.GetString($bytes)
    try {
        $value = $text | ConvertFrom-Json -Depth 100 -DateKind String -NoEnumerate
    }
    catch {
        throw "$Purpose is not strict JSON: $($_.Exception.Message)"
    }
    return [pscustomobject]@{
        FullName = $item.FullName
        Sha256 = Get-BytesSha256 -Bytes $bytes
        Value = $value
    }
}

function Read-JsonFile {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Purpose
    )

    return (Read-JsonSnapshot -Path $Path -Purpose $Purpose).Value
}

function Write-NewJsonFile {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][object]$Value,
        [Parameter(Mandatory)][string]$Purpose
    )

    $fullPath = Get-RootedPath -Path $Path -Purpose $Purpose
    $parent = Split-Path -Parent $fullPath
    [void](Get-OrdinaryDirectory -Path $parent -Purpose "$Purpose parent")
    $json = $Value | ConvertTo-Json -Depth 100 -Compress
    $bytes = $script:StrictUtf8.GetBytes($json + "`n")
    try {
        $stream = [System.IO.FileStream]::new(
            $fullPath,
            [System.IO.FileMode]::CreateNew,
            [System.IO.FileAccess]::Write,
            [System.IO.FileShare]::None
        )
        try {
            $stream.Write($bytes, 0, $bytes.Length)
            $stream.Flush($true)
        }
        finally {
            $stream.Dispose()
        }
    }
    catch [System.IO.IOException] {
        throw "$Purpose already exists or could not be claimed exactly once."
    }
}

function Write-ExistingJsonFile {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][object]$Value,
        [Parameter(Mandatory)][string]$Purpose
    )

    $item = Get-OrdinaryFile -Path $Path -Purpose $Purpose
    $json = $Value | ConvertTo-Json -Depth 100 -Compress
    [System.IO.File]::WriteAllText(
        $item.FullName,
        $json + "`n",
        $script:StrictUtf8
    )
}

function Get-FileSha256 {
    param([Parameter(Mandatory)][string]$Path)

    $item = Get-OrdinaryFile -Path $Path -Purpose 'hash input'
    return (Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Assert-ExactPathValue {
    param(
        [Parameter(Mandatory)][string]$Actual,
        [Parameter(Mandatory)][string]$Expected,
        [Parameter(Mandatory)][string]$Purpose
    )

    $actualPath = Get-RootedPath -Path $Actual -Purpose $Purpose
    $expectedPath = Get-RootedPath -Path $Expected -Purpose "$Purpose contract"
    if (-not [string]::Equals(
        $actualPath,
        $expectedPath,
        [StringComparison]::OrdinalIgnoreCase
    )) {
        throw "$Purpose does not match the authenticated explicit root contract."
    }
    return $actualPath
}

function Get-CanonicalBundleSha256 {
    param([Parameter(Mandatory)][System.Collections.Generic.List[object]]$Rows)

    $json = ConvertTo-Json -InputObject @($Rows) -Depth 10 -Compress
    return Get-BytesSha256 -Bytes $script:StrictUtf8.GetBytes($json)
}

function Assert-SourceBundleContent {
    param(
        [Parameter(Mandatory)][string]$SourceRoot,
        [Parameter(Mandatory)][string]$ManifestPath,
        [Parameter(Mandatory)][object]$Manifest,
        [Parameter(Mandatory)][string]$ExpectedBundleSha256,
        [Parameter(Mandatory)][long]$ExpectedFileCount
    )

    $manifestRows = @($Manifest.files)
    if ($manifestRows.Count -ne $ExpectedFileCount -or $manifestRows.Count -eq 0) {
        throw 'D54 source-bundle manifest file-count schema mismatch.'
    }
    $observedPaths = [System.Collections.Generic.List[string]]::new()
    $canonicalRows = [System.Collections.Generic.List[object]]::new()
    foreach ($row in $manifestRows) {
        $relativeText = [string]$row.path
        $parts = @($relativeText -split '/')
        if ([string]::IsNullOrWhiteSpace($relativeText) -or
            [IO.Path]::IsPathFullyQualified($relativeText) -or
            $relativeText.Contains('\') -or
            @($parts | Where-Object { $_ -ceq '' -or $_ -ceq '.' -or $_ -ceq '..' }).Count -ne 0 -or
            [string]$row.sha256 -cnotmatch '^[0-9a-f]{64}$' -or
            $row.length -isnot [long] -or [long]$row.length -lt 0) {
            throw "D54 source-bundle manifest row schema mismatch: $relativeText"
        }
        $target = [IO.Path]::GetFullPath((Join-Path $SourceRoot ($relativeText.Replace('/', '\'))))
        Assert-PathUnderRoot -Path $target -Root $SourceRoot -Purpose 'source-bundle file containment'
        if ([string]::Equals(
            $target,
            $ManifestPath,
            [StringComparison]::OrdinalIgnoreCase
        )) {
            throw 'D54 source-bundle manifest cannot also be a payload file.'
        }
        $item = Get-OrdinaryFile -Path $target -Purpose "D54 source-bundle file $relativeText"
        if ($item.Length -ne [long]$row.length -or
            (Get-FileSha256 -Path $item.FullName) -cne [string]$row.sha256) {
            throw "D54 source-bundle file identity drift: $relativeText"
        }
        $observedPaths.Add($relativeText)
        $canonicalRows.Add([ordered]@{
            length = [long]$row.length
            path = $relativeText
            sha256 = [string]$row.sha256
        })
    }
    $sortedObserved = $observedPaths.ToArray()
    [Array]::Sort($sortedObserved, [StringComparer]::Ordinal)
    if (-not [Linq.Enumerable]::SequenceEqual[string]($observedPaths, $sortedObserved) -or
        @($observedPaths | Select-Object -Unique).Count -ne $observedPaths.Count) {
        throw 'D54 source-bundle manifest paths are not sorted and unique.'
    }

    $actualPaths = [System.Collections.Generic.List[string]]::new()
    $pending = [System.Collections.Generic.Queue[IO.DirectoryInfo]]::new()
    $pending.Enqueue((Get-OrdinaryDirectory -Path $SourceRoot -Purpose 'source-bundle root'))
    while ($pending.Count -gt 0) {
        $directory = $pending.Dequeue()
        foreach ($item in @(Get-ChildItem -LiteralPath $directory.FullName -Force -ErrorAction Stop)) {
            if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                throw "D54 source-bundle contains a reparse entry: $($item.FullName)"
            }
            if ($item.PSIsContainer) {
                $pending.Enqueue([IO.DirectoryInfo]$item)
            }
            else {
                if ([string]::Equals(
                    $item.FullName,
                    $ManifestPath,
                    [StringComparison]::OrdinalIgnoreCase
                )) {
                    continue
                }
                $relative = [IO.Path]::GetRelativePath($SourceRoot, $item.FullName).Replace('\', '/')
                $actualPaths.Add($relative)
            }
        }
    }
    $sortedActual = $actualPaths.ToArray()
    [Array]::Sort($sortedActual, [StringComparer]::Ordinal)
    if (-not [Linq.Enumerable]::SequenceEqual[string]($sortedObserved, $sortedActual) -or
        (Get-CanonicalBundleSha256 -Rows $canonicalRows) -cne $ExpectedBundleSha256) {
        throw 'D54 source-bundle inventory or aggregate hash drift.'
    }
}

function Get-RepositoryHead {
    param([Parameter(Mandatory)][string]$RepositoryRoot)

    $git = Get-TrustedExecutableAnchor -Id 'd52-git-2.54.0.windows.1'
    $startInfo = [Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $git.Path
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.CreateNoWindow = $true
    foreach ($argument in @('-C', $RepositoryRoot, '--no-pager', 'rev-parse', 'HEAD')) {
        $startInfo.ArgumentList.Add($argument)
    }
    $process = [Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    if (-not $process.Start()) {
        throw 'D54 repository HEAD probe failed to start.'
    }
    $stdout = $process.StandardOutput.ReadToEnd()
    $stderr = $process.StandardError.ReadToEnd()
    $process.WaitForExit()
    $head = $stdout.Trim()
    if ($process.ExitCode -ne 0 -or -not [string]::IsNullOrWhiteSpace($stderr) -or
        $head -cnotmatch '^[0-9a-f]{40}$') {
        throw 'D54 repository HEAD probe failed closed.'
    }
    return $head
}

function Initialize-D54ExplicitRootContract {
    $rootInput = $script:D54RootInputs
    foreach ($entry in @(
        @('RootContractPath', $rootInput.RootContractPath),
        @('RootContractSha256', $rootInput.RootContractSha256),
        @('RepositoryRoot', $rootInput.RepositoryRoot),
        @('CampaignRoot', $rootInput.CampaignRoot),
        @('CarrierRoot', $rootInput.CarrierRoot),
        @('SourceBundleRoot', $rootInput.SourceBundleRoot),
        @('EvidenceRoot', $rootInput.EvidenceRoot)
    )) {
        if ([string]::IsNullOrWhiteSpace([string]$entry[1])) {
            throw "D54 explicit-root input is missing: $($entry[0])"
        }
    }
    if ($rootInput.RootContractSha256 -cnotmatch '^[0-9a-f]{64}$') {
        throw 'D54 explicit-root contract hash is malformed.'
    }
    if (@($rootInput.PredecessorRoots).Count -ne 2 -or
        @($rootInput.PredecessorRoots | Select-Object -Unique).Count -ne 2) {
        throw 'D54 explicit-root contract requires exactly two distinct predecessor roots.'
    }

    $contractSnapshot = Read-JsonSnapshot `
        -Path $rootInput.RootContractPath `
        -Purpose 'D54 explicit-root contract'
    if ($contractSnapshot.Sha256 -cne $rootInput.RootContractSha256) {
        throw 'D54 explicit-root contract hash mismatch.'
    }
    $contract = $contractSnapshot.Value
    if ([string]$contract.schema_version -cne 'work-charter-d54-explicit-root-contract/v1' -or
        [string]$contract.campaign_id -cne $script:CampaignId -or
        [string]$contract.stable_subject -cne $script:StableSubject -or
        [string]$contract.candidate_commit -cne $script:CandidateCommit -or
        [string]$contract.candidate_manifest_sha256 -cne $script:CandidateManifestSha256 -or
        [string]$contract.control_commit -cne $script:ControlCommit -or
        [string]$contract.predecessor_terminal_receipt_sha256 -cne
            $script:PredecessorTerminalReceiptSha256) {
        throw 'D54 explicit-root contract schema or stable identity mismatch.'
    }

    $roots = $contract.roots
    if ($null -eq $roots) {
        throw 'D54 explicit-root contract omits roots.'
    }
    $repositoryPath = Assert-ExactPathValue `
        -Actual $rootInput.RepositoryRoot `
        -Expected ([string]$roots.repository.path) `
        -Purpose 'repository root'
    $campaignPath = Assert-ExactPathValue `
        -Actual $rootInput.CampaignRoot `
        -Expected ([string]$roots.campaign.path) `
        -Purpose 'campaign root'
    $carrierPath = Assert-ExactPathValue `
        -Actual $rootInput.CarrierRoot `
        -Expected ([string]$roots.carrier.path) `
        -Purpose 'carrier root'
    $sourcePath = Assert-ExactPathValue `
        -Actual $rootInput.SourceBundleRoot `
        -Expected ([string]$roots.source_bundle.path) `
        -Purpose 'source-bundle root'
    $evidencePath = Assert-ExactPathValue `
        -Actual $rootInput.EvidenceRoot `
        -Expected ([string]$roots.evidence.path) `
        -Purpose 'evidence root'

    [void](Get-OrdinaryDirectory -Path $repositoryPath -Purpose 'repository root')
    [void](Get-OrdinaryDirectory -Path $campaignPath -Purpose 'campaign root')
    [void](Get-OrdinaryDirectory -Path $carrierPath -Purpose 'carrier root')
    [void](Get-OrdinaryDirectory -Path $sourcePath -Purpose 'source-bundle root')
    [void](Get-OrdinaryDirectory -Path $evidencePath -Purpose 'evidence root')
    Assert-PathUnderRoot -Path $carrierPath -Root $campaignPath -Purpose 'carrier root containment'
    Assert-PathUnderRoot -Path $evidencePath -Root $carrierPath -Purpose 'evidence root containment'

    if ([string]$roots.evidence.schema_version -cne 'work-charter-d54-evidence-root/v1') {
        throw 'D54 evidence-root schema mismatch.'
    }
    $runnerRelative = [string]$roots.repository.runner_relative_path
    if ($runnerRelative -cne $script:RunnerRepositoryPath) {
        throw 'D54 repository root contract identifies the wrong runner path.'
    }
    $runnerPath = Join-Path $repositoryPath $runnerRelative.Replace('/', '\')
    $runnerItem = Get-OrdinaryFile -Path $runnerPath -Purpose 'D54 tracked runner'
    if (-not [string]::Equals(
        $runnerItem.FullName,
        (Get-RootedPath -Path $PSCommandPath -Purpose 'active D54 runner'),
        [StringComparison]::OrdinalIgnoreCase
    ) -or (Get-FileSha256 -Path $runnerItem.FullName) -cne
        [string]$roots.repository.runner_sha256 -or
        [string]$roots.repository.expected_head -cnotmatch '^[0-9a-f]{40}$' -or
        (Get-RepositoryHead -RepositoryRoot $repositoryPath) -cne
            [string]$roots.repository.expected_head) {
        throw 'D54 repository root, runner identity, or expected HEAD mismatch.'
    }

    $manifestPath = Assert-ExactPathValue `
        -Actual ([string]$roots.source_bundle.manifest_path) `
        -Expected ([string]$roots.source_bundle.manifest_path) `
        -Purpose 'source-bundle manifest'
    Assert-PathUnderRoot `
        -Path $manifestPath `
        -Root $sourcePath `
        -Purpose 'source-bundle manifest containment'
    $manifestSnapshot = Read-JsonSnapshot `
        -Path $manifestPath `
        -Purpose 'D54 source-bundle manifest'
    $manifest = $manifestSnapshot.Value
    if ($manifestSnapshot.Sha256 -cne [string]$roots.source_bundle.manifest_sha256 -or
        [long]$roots.source_bundle.manifest_schema_version -ne 1 -or
        [long]$manifest.schema_version -ne 1 -or
        [string]$manifest.execution_identity -cne
            [string]$roots.source_bundle.execution_identity -or
        [string]$manifest.bundle_sha256 -cne [string]$roots.source_bundle.bundle_sha256 -or
        @($manifest.files).Count -ne [long]$roots.source_bundle.file_count) {
        throw 'D54 source-bundle manifest hash or schema mismatch.'
    }
    Assert-SourceBundleContent `
        -SourceRoot $sourcePath `
        -ManifestPath $manifestSnapshot.FullName `
        -Manifest $manifest `
        -ExpectedBundleSha256 ([string]$roots.source_bundle.bundle_sha256) `
        -ExpectedFileCount ([long]$roots.source_bundle.file_count)

    $declaredPredecessors = @($roots.predecessors)
    if ($declaredPredecessors.Count -ne 2) {
        throw 'D54 explicit-root contract predecessor schema mismatch.'
    }
    $expectedPredecessorIds = @('d53-terminal', 'd49-admitted-evidence')
    $resolvedPredecessors = [System.Collections.Generic.List[string]]::new()
    for ($index = 0; $index -lt 2; $index++) {
        $declared = $declaredPredecessors[$index]
        if ([string]$declared.id -cne $expectedPredecessorIds[$index]) {
            throw 'D54 predecessor root ordering or schema mismatch.'
        }
        $resolved = Assert-ExactPathValue `
            -Actual ([string]$rootInput.PredecessorRoots[$index]) `
            -Expected ([string]$declared.path) `
            -Purpose "predecessor root $($declared.id)"
        [void](Get-OrdinaryDirectory -Path $resolved -Purpose "predecessor root $($declared.id)")
        $resolvedPredecessors.Add($resolved)
    }

    $d53Artifact = Join-Path $resolvedPredecessors[0] `
        ([string]$declaredPredecessors[0].artifact_relative_path).Replace('/', '\')
    Assert-PathUnderRoot `
        -Path ([IO.Path]::GetFullPath($d53Artifact)) `
        -Root $resolvedPredecessors[0] `
        -Purpose 'D53 predecessor artifact containment'
    $d53Snapshot = Read-JsonSnapshot -Path $d53Artifact -Purpose 'D53 terminal predecessor receipt'
    if ($d53Snapshot.Sha256 -cne [string]$declaredPredecessors[0].artifact_sha256 -or
        $d53Snapshot.Sha256 -cne $script:PredecessorTerminalReceiptSha256 -or
        [string]$d53Snapshot.Value.schema_version -cne
            [string]$declaredPredecessors[0].artifact_schema_version) {
        throw 'D53 terminal predecessor receipt hash or schema mismatch.'
    }

    $d49TerminalPath = Join-Path $resolvedPredecessors[1] `
        ([string]$declaredPredecessors[1].terminal_relative_path).Replace('/', '\')
    $d49ViewPath = Join-Path $resolvedPredecessors[1] `
        ([string]$declaredPredecessors[1].view_relative_path).Replace('/', '\')
    Assert-PathUnderRoot `
        -Path ([IO.Path]::GetFullPath($d49TerminalPath)) `
        -Root $resolvedPredecessors[1] `
        -Purpose 'D49 predecessor terminal containment'
    Assert-PathUnderRoot `
        -Path ([IO.Path]::GetFullPath($d49ViewPath)) `
        -Root $resolvedPredecessors[1] `
        -Purpose 'D49 predecessor view containment'
    $d49Terminal = Read-JsonSnapshot -Path $d49TerminalPath -Purpose 'D49 predecessor terminal'
    $d49View = Read-JsonSnapshot -Path $d49ViewPath -Purpose 'D49 predecessor assessor view'
    if ($d49Terminal.Sha256 -cne [string]$declaredPredecessors[1].terminal_sha256 -or
        $d49View.Sha256 -cne [string]$declaredPredecessors[1].view_sha256 -or
        $null -eq $d49Terminal.Value -or $null -eq $d49View.Value) {
        throw 'D49 predecessor root artifact hash or schema mismatch.'
    }

    $campaignContractPath = Assert-ExactPathValue `
        -Actual ([string]$contract.campaign_contract.path) `
        -Expected ([string]$contract.campaign_contract.path) `
        -Purpose 'D54 Campaign contract'
    if ((Get-FileSha256 -Path $campaignContractPath) -cne
        [string]$contract.campaign_contract.sha256) {
        throw 'D54 Campaign contract hash mismatch.'
    }

    $expectedRuleset = [ordered]@{
        '~/.codex/AGENTS.md' = 'fefaad2225dfefc0a4e8048c1fe9ba744035ab101c11851954bcf432b1691be1'
        'AGENTS.md' = '49e622e564ba22fb30e4601d1609c4be25a8285f8a9076629de75c7007f2b1db'
        '~/.codex/skills/work-charter/SKILL.md' = 'd0c86e80d6f8eec0d91c25f4f0c687d60b1e0821ac823e28cf62777bb1badda2'
        '~/.codex/skills/work-charter/references/coordination-and-recovery.md' = '8c944b3434e14e70dea705a8b877b70b497c6f512db8681ff0000f418a270483'
        '~/.codex/reference/codex-usage-guidance.md' = '8139fa6765e0fe7a2972b84a8cb370df386e28736d16228a07780625f7888383'
        'docs/RUNBOOK.md' = 'f4f42193d45fd279a50f8737ca2e7fe739dbebf703e9cda50118bc66d145ff13'
        'evals/README.md' = '50001f3dcecf43e7d4bf6ab022eca768cc6fde9f8bacd3321021945bacd81860'
    }
    $observedRuleset = @($contract.ruleset_sources)
    if ($observedRuleset.Count -ne $expectedRuleset.Count) {
        throw 'D54 explicit-root contract ruleset schema mismatch.'
    }
    [string[]]$expectedLocators = @($expectedRuleset.Keys | ForEach-Object { [string]$_ })
    [string[]]$observedLocators = @($observedRuleset | ForEach-Object { [string]$_.locator })
    [Array]::Sort($expectedLocators, [StringComparer]::Ordinal)
    [Array]::Sort($observedLocators, [StringComparer]::Ordinal)
    if (-not [Linq.Enumerable]::SequenceEqual[string]($expectedLocators, $observedLocators)) {
        throw 'D54 explicit-root contract ruleset locators are not exact and unique.'
    }
    $script:RulesetSources = @($observedRuleset | ForEach-Object {
        $locator = [string]$_.locator
        $path = Get-RootedPath -Path ([string]$_.path) -Purpose "ruleset source $locator"
        $hash = [string]$_.normalized_text_sha256
        if (-not $expectedRuleset.Contains($locator) -or
            $hash -cne [string]$expectedRuleset[$locator] -or
            (Get-NormalizedTextSha256 -Bytes ([IO.File]::ReadAllBytes(
                (Get-OrdinaryFile -Path $path -Purpose "ruleset source $locator").FullName
            ))) -cne $hash) {
            throw "D54 ruleset source hash or schema mismatch: $locator"
        }
        [pscustomobject]@{ Locator = $locator; Path = $path; Sha256 = $hash }
    })

    $script:RepositoryRoot = $repositoryPath
    $script:CampaignRoot = $campaignPath
    $script:CampaignContractPath = $campaignContractPath
    $script:PrivateCarrierRoot = $carrierPath
    $script:SourceBundleRoot = $sourcePath
    $script:EvidenceRoot = $evidencePath
    $script:PredecessorRoots = $resolvedPredecessors.ToArray()
    $script:RootContractPath = $contractSnapshot.FullName
    $script:RootContractSha256 = $contractSnapshot.Sha256
    $script:RootContract = $contract
}

function Get-TrustedExecutableAnchor {
    param(
        [Parameter(Mandatory)]
        [ValidateSet(
            'd52-powershell-current',
            'd52-windows-whoami',
            'd52-codex-app-server-0.147.0-alpha.6.6',
            'd52-git-2.54.0.windows.1'
        )]
        [string]$Id
    )

    if (-not $IsWindows) {
        throw "Executable trust anchor is not qualified on this platform: $Id"
    }

    $expectedSha256 = $null
    $expectedSubjectPattern = $null
    $candidates = switch ($Id) {
        'd52-powershell-current' {
            $expectedSubjectPattern = 'O=Microsoft Corporation'
            @((Join-Path $PSHOME 'pwsh.exe'))
        }
        'd52-windows-whoami' {
            $expectedSubjectPattern = 'O=Microsoft Corporation'
            @((Join-Path ([System.Environment]::SystemDirectory) 'whoami.exe'))
        }
        'd52-codex-app-server-0.147.0-alpha.6.6' {
            $expectedSha256 = '592958896cbffa154709618476fc9c9bf7fe73957e9a4fc12094c5051b6c69b3'
            $expectedSubjectPattern = 'O="OpenAI OpCo, LLC"'
            $codexBinRoot = Join-Path $env:LOCALAPPDATA 'OpenAI\Codex\bin'
            if (-not (Test-Path -LiteralPath $codexBinRoot -PathType Container)) {
                throw 'The authenticated Codex executable root is absent.'
            }
            @(
                Get-ChildItem -LiteralPath $codexBinRoot -Directory -Force |
                    ForEach-Object { Join-Path $_.FullName 'codex.exe' } |
                    Where-Object { Test-Path -LiteralPath $_ -PathType Leaf }
            )
        }
        'd52-git-2.54.0.windows.1' {
            $expectedSha256 = '81ef35ae005ca9318018d18e3327578ce939fb99feaad6b2d7c8ab15f3de8db5'
            $expectedSubjectPattern = 'O=Johannes Schindelin'
            @((Join-Path $env:ProgramFiles 'Git\bin\git.exe'))
        }
    }

    $anchorCandidates = [System.Collections.Generic.List[object]]::new()
    foreach ($candidate in $candidates) {
        $item = Get-OrdinaryFile -Path $candidate -Purpose "trusted executable anchor $Id"
        $sha256 = Get-FileSha256 -Path $item.FullName
        if ($null -ne $expectedSha256 -and $sha256 -cne $expectedSha256) {
            continue
        }
        $signature = Get-AuthenticodeSignature -LiteralPath $item.FullName
        if ([string]$signature.Status -cne 'Valid' -or
            [string]$signature.SignerCertificate.Subject -cnotmatch $expectedSubjectPattern) {
            continue
        }
        $anchorCandidates.Add([pscustomobject]@{
            Id = $Id
            Path = $item.FullName
            Sha256 = $sha256
            SignatureStatus = [string]$signature.Status
            SignerSubject = [string]$signature.SignerCertificate.Subject
        })
    }
    if ($anchorCandidates.Count -ne 1) {
        throw "Executable trust anchor must resolve to exactly one authenticated file: $Id"
    }
    return $anchorCandidates[0]
}

function Get-TextSha256 {
    param([Parameter(Mandatory)][string]$Text)

    return [System.Convert]::ToHexString(
        [System.Security.Cryptography.SHA256]::HashData(
            $script:StrictUtf8.GetBytes($Text)
        )
    ).ToLowerInvariant()
}

function Get-RulesetSha256 {
    $rows = @(
        $script:RulesetSources | ForEach-Object { "$($_.Locator)|$($_.Sha256)" }
    )
    return Get-TextSha256 -Text ($rows -join "`n")
}

function Get-AuthorizationLifecycleStates {
    $definitions = @(
        @(
            'ZERO_MODEL_QUALIFICATION_PENDING',
            'CANARY_AUTHORIZED_AFTER_QUALIFICATION',
            'tracked-zero-model-gate'
        ),
        @(
            'CANARY_AUTHORIZED_AFTER_QUALIFICATION',
            'FREEZE_PENDING_AFTER_CANARIES',
            'three-canary-chain'
        ),
        @(
            'FREEZE_PENDING_AFTER_CANARIES',
            'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION',
            'post-canary-freeze'
        ),
        @(
            'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION',
            'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN',
            'campaign-activation-gate'
        ),
        @(
            'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN',
            'TERMINAL',
            'product-and-assessor-chain'
        ),
        @('TERMINAL', '', 'terminal-closeout')
    )
    $result = [System.Collections.Generic.List[object]]::new()
    for ($index = 0; $index -lt $definitions.Count; $index++) {
        $definition = $definitions[$index]
        $result.Add([pscustomobject]@{
            Ordinal = $index + 1
            State = [string]$definition[0]
            NextState = [string]$definition[1]
            Boundary = [string]$definition[2]
        })
    }
    return $result.ToArray()
}

function Get-AuthorizationLifecyclePolicySha256 {
    $rows = [System.Collections.Generic.List[string]]::new()
    foreach ($row in @(
        'work-charter-d54-authorization-lifecycle/v1',
        $script:CampaignId,
        $script:StableSubject,
        $script:CandidateCommit,
        $script:CandidateManifestSha256,
        $script:PredecessorTerminalReceiptSha256,
        'qualification|56|56',
        'evidence|formal-qualification.json|work-charter-d54-formal-qualification/v1',
        'evidence|transport-canary-batch-result.json|work-charter-d54-canary-gate/v1',
        'evidence|freeze-manifest.json|work-charter-d54-freeze/v1',
        'evidence|model-activity-authorization.json|work-charter-d54-product-activation/v1',
        'evidence|terminal-packet.json|work-charter-d54-admitted-product-packet/v1',
        'evidence|assessor-view.json|work-charter-d54-assessor-view/v1',
        'evidence|assessor-view-local-review.json|work-charter-d54-assessor-view-review/v1',
        'evidence|assessor-eligibility.json|work-charter-d54-assessor-eligibility/v1',
        'evidence|d54-terminal.json|work-charter-d54-terminal/v1',
        "production-policy|$(Get-ProductionPolicySha256)"
    )) {
        $rows.Add([string]$row)
    }
    foreach ($state in Get-AuthorizationLifecycleStates) {
        $rows.Add((@(
            'state', $state.Ordinal, $state.State, $state.NextState, $state.Boundary
        ) -join '|'))
    }
    return Get-TextSha256 -Text ($rows.ToArray() -join "`n")
}

function Get-AuthorizationLifecycleActiveState {
    param([AllowEmptyString()][string]$Phase)

    if (Test-IsAuthorizedProductionPhase -Phase $Phase) {
        if ($Phase.StartsWith('canary-', [StringComparison]::Ordinal)) {
            return 'CANARY_AUTHORIZED_AFTER_QUALIFICATION'
        }
        return 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
    }
    return 'ZERO_MODEL_QUALIFICATION_PENDING'
}

function Get-AuthorizationLifecycleEnvelope {
    param([AllowEmptyString()][string]$Phase)

    return [ordered]@{
        schema_version = 'work-charter-d54-authorization-lifecycle/v1'
        campaign_id = $script:CampaignId
        stable_subject = $script:StableSubject
        candidate_commit = $script:CandidateCommit
        candidate_manifest_sha256 = $script:CandidateManifestSha256
        predecessor_terminal_receipt_sha256 = $script:PredecessorTerminalReceiptSha256
        policy_sha256 = Get-AuthorizationLifecyclePolicySha256
        qualification = [ordered]@{
            required_passed = [long]56
            required_total = [long]56
        }
        active_state = if ([string]::IsNullOrEmpty($Phase)) {
            $null
        }
        else {
            Get-AuthorizationLifecycleActiveState -Phase $Phase
        }
        states = @(
            Get-AuthorizationLifecycleStates | ForEach-Object {
                [ordered]@{
                    ordinal = [long]$_.Ordinal
                    state = $_.State
                    next_state = $_.NextState
                    boundary = $_.Boundary
                }
            }
        )
    }
}

function Assert-NoPredecessorAuthorizationState {
    param(
        [Parameter(Mandatory)][object]$Artifact,
        [Parameter(Mandatory)][string]$Purpose
    )

    $rendered = ConvertTo-Json -InputObject $Artifact -Depth 100 -Compress
    foreach ($predecessorState in @(
        'PENDING_D52_TRACKED_OUTER_QUALIFICATION',
        'PENDING_POST_FREEZE_CAMPAIGN_ACTIVATION',
        'PRE_MODEL_FROZEN_AWAITING_CAMPAIGN_ACTIVATION',
        'PRE_MODEL_FROZEN_AWAITING_MODEL_AUTHORIZATION'
    )) {
        if ($rendered.Contains($predecessorState, [StringComparison]::Ordinal)) {
            throw "$Purpose contains a predecessor-only authorization state."
        }
    }
}

function Assert-AuthorizationLifecycleArtifact {
    param(
        [Parameter(Mandatory)][object]$Artifact,
        [Parameter(Mandatory)][AllowEmptyString()][string]$Phase,
        [Parameter(Mandatory)][string]$Purpose
    )

    Assert-NoPredecessorAuthorizationState -Artifact $Artifact -Purpose $Purpose
    $observed = $Artifact.authorization_lifecycle
    if ($null -eq $observed) {
        throw "$Purpose omits the D54 authorization lifecycle."
    }
    $expected = Get-AuthorizationLifecycleEnvelope -Phase $Phase
    foreach ($field in @(
        'schema_version', 'campaign_id', 'stable_subject', 'candidate_commit',
        'candidate_manifest_sha256', 'predecessor_terminal_receipt_sha256',
        'policy_sha256', 'active_state'
    )) {
        if ([string]$observed.$field -cne [string]$expected.$field) {
            throw "$Purpose authorization lifecycle field is mismatched: $field"
        }
    }
    if ($null -eq $observed.qualification -or
        [long]$observed.qualification.required_passed -ne 56 -or
        [long]$observed.qualification.required_total -ne 56) {
        throw "$Purpose authorization lifecycle qualification threshold is not 56/56."
    }
    $observedStates = @($observed.states)
    $expectedStates = @($expected.states)
    if ($observedStates.Count -ne $expectedStates.Count) {
        throw "$Purpose authorization lifecycle state count is mismatched."
    }
    for ($index = 0; $index -lt $expectedStates.Count; $index++) {
        foreach ($field in @('ordinal', 'state', 'next_state', 'boundary')) {
            if ([string]$observedStates[$index].$field -cne
                [string]$expectedStates[$index].$field) {
                throw "$Purpose authorization lifecycle transition is mismatched at ordinal $($index + 1)."
            }
        }
    }
}

function Assert-LifecycleEvidenceCommon {
    param(
        [Parameter(Mandatory)][object]$Record,
        [Parameter(Mandatory)][string]$SchemaVersion,
        [Parameter(Mandatory)][string]$State,
        [Parameter(Mandatory)][string]$Purpose
    )

    Assert-NoPredecessorAuthorizationState -Artifact $Record -Purpose $Purpose
    if ([string]$Record.schema_version -cne $SchemaVersion -or
        [string]$Record.campaign_id -cne $script:CampaignId -or
        [string]$Record.candidate_commit -cne $script:CandidateCommit -or
        [string]$Record.candidate_manifest_sha256 -cne $script:CandidateManifestSha256 -or
        [string]$Record.authorization_lifecycle_policy_sha256 -cne
            (Get-AuthorizationLifecyclePolicySha256) -or
        [string]$Record.state -cne $State) {
        throw "$Purpose does not bind the authorized D54 lifecycle state."
    }
}

function Get-LifecycleEvidenceSnapshots {
    param([Parameter(Mandatory)][string]$EvidenceRoot)

    [void](Assert-ExactPathIdentity `
        -Actual $EvidenceRoot `
        -Expected $script:EvidenceRoot `
        -Purpose 'lifecycle evidence root')
    $root = (
        Get-OrdinaryDirectory -Path $script:EvidenceRoot -Purpose 'lifecycle evidence root'
    ).FullName
    return [ordered]@{
        Root = $root
        Qualification = Read-JsonSnapshot `
            -Path (Join-Path $root 'formal-qualification.json') `
            -Purpose 'formal qualification receipt'
        Canary = if (Test-Path -LiteralPath (Join-Path $root 'transport-canary-batch-result.json')) {
            Read-JsonSnapshot `
                -Path (Join-Path $root 'transport-canary-batch-result.json') `
                -Purpose 'transport canary gate receipt'
        }
        else { $null }
        Freeze = if (Test-Path -LiteralPath (Join-Path $root 'freeze-manifest.json')) {
            Read-JsonSnapshot `
                -Path (Join-Path $root 'freeze-manifest.json') `
                -Purpose 'freeze manifest'
        }
        else { $null }
        Activation = if (Test-Path -LiteralPath (Join-Path $root 'model-activity-authorization.json')) {
            Read-JsonSnapshot `
                -Path (Join-Path $root 'model-activity-authorization.json') `
                -Purpose 'product activation receipt'
        }
        else { $null }
    }
}

function Assert-LifecycleTransitionEvidence {
    param(
        [Parameter(Mandatory)][string]$EvidenceRoot,
        [Parameter(Mandatory)][string]$State,
        [Parameter(Mandatory)][string]$RunnerPath,
        [switch]$RequireActionProvenance
    )

    [void](Assert-ExactPathIdentity `
        -Actual $EvidenceRoot `
        -Expected $script:EvidenceRoot `
        -Purpose 'lifecycle evidence root')
    if ($RequireActionProvenance) {
        [void](Get-LiveCampaignController)
    }
    if ($State -ceq 'TERMINAL') {
        Assert-TerminalLifecycleEvidence `
            -EvidenceRoot $EvidenceRoot `
            -RunnerPath $RunnerPath `
            -RequireActionProvenance:$RequireActionProvenance
        return
    }
    if ($State -ceq 'ZERO_MODEL_QUALIFICATION_PENDING') {
        return
    }
    $snapshots = Get-LifecycleEvidenceSnapshots -EvidenceRoot $EvidenceRoot
    $qualification = $snapshots.Qualification.Value
    Assert-LifecycleEvidenceCommon `
        -Record $qualification `
        -SchemaVersion 'work-charter-d54-formal-qualification/v1' `
        -State 'CANARY_AUTHORIZED_AFTER_QUALIFICATION' `
        -Purpose 'Formal qualification receipt'
    if ([string]$qualification.previous_state -cne 'ZERO_MODEL_QUALIFICATION_PENDING' -or
        [long]$qualification.qualification.passed -ne 56 -or
        [long]$qualification.qualification.total -ne 56 -or
        [long]$qualification.qualification.private_passed -ne 24 -or
        [long]$qualification.qualification.private_total -ne 24 -or
        [long]$qualification.qualification.tracked_passed -ne 32 -or
        [long]$qualification.qualification.tracked_total -ne 32 -or
        [string]$qualification.tracked_runner_sha256 -cne (Get-FileSha256 -Path $RunnerPath)) {
        throw 'Formal qualification receipt is not the exact D54 56/56 gate.'
    }
    if ($State -ceq 'CANARY_AUTHORIZED_AFTER_QUALIFICATION') {
        return
    }

    if ($null -eq $snapshots.Canary) {
        throw 'D54 lifecycle is missing the canary gate receipt.'
    }
    $canary = $snapshots.Canary.Value
    Assert-LifecycleEvidenceCommon `
        -Record $canary `
        -SchemaVersion 'work-charter-d54-canary-gate/v1' `
        -State 'FREEZE_PENDING_AFTER_CANARIES' `
        -Purpose 'Canary gate receipt'
    if ([string]$canary.previous_state -cne 'CANARY_AUTHORIZED_AFTER_QUALIFICATION' -or
        [string]$canary.formal_qualification_sha256 -cne $snapshots.Qualification.Sha256 -or
        [long]$canary.model_contexts -ne 3 -or
        [long]$canary.turn_starts -ne 3 -or
        $canary.receipt_max_age_seconds -isnot [long] -or
        [long]$canary.receipt_max_age_seconds -ne $ReceiptMaxAgeSeconds) {
        throw 'Canary gate receipt does not follow the D54 qualification state.'
    }
    $expectedCanaries = @(Get-AuthorizedProductionPhases | Where-Object { $_.Segment -ceq 'canary' })
    $observedCanaries = @($canary.routes)
    if ($observedCanaries.Count -ne $expectedCanaries.Count) {
        throw 'Canary gate receipt route count is mismatched.'
    }
    for ($index = 0; $index -lt $expectedCanaries.Count; $index++) {
        $expected = $expectedCanaries[$index]
        $observed = $observedCanaries[$index]
        $carrierRoot = $script:PrivateCarrierRoot
        $phaseRoot = Join-Path (Join-Path $carrierRoot 'phases') $expected.DirectoryName
        $receiptSnapshot = Read-JsonSnapshot `
            -Path (Join-Path $phaseRoot 'receipt.json') `
            -Purpose 'canary outer receipt'
        $stateSnapshot = Read-JsonSnapshot `
            -Path (Join-Path $phaseRoot 'dispatch-state.json') `
            -Purpose 'canary dispatch state'
        $receipt = $receiptSnapshot.Value
        $dispatchState = $stateSnapshot.Value
        if ([string]$observed.phase -cne $expected.Phase -or
            [string]$observed.model -cne $expected.Model -or
            [string]$observed.reasoning_effort -cne $expected.Effort -or
            [long]$observed.turn_starts -ne 1 -or
            [string]$observed.verdict -cne 'PASS' -or
            [string]$observed.outer_receipt_sha256 -cne $receiptSnapshot.Sha256 -or
            [string]$observed.dispatch_state_sha256 -cne $stateSnapshot.Sha256 -or
            [string]$observed.inner_consumption_sha256 -cnotmatch '^[0-9a-f]{64}$' -or
            [string]$receipt.schema_version -cne 'work-charter-d54-launch-receipt/v1' -or
            [string]$receipt.campaign_id -cne $script:CampaignId -or
            [string]$receipt.phase -cne $expected.Phase -or
            [string]$receipt.status -cne 'consumed' -or
            [string]$dispatchState.schema_version -cne 'work-charter-d54-dispatch-state/v1' -or
            [string]$dispatchState.campaign_id -cne $script:CampaignId -or
            [string]$dispatchState.phase -cne $expected.Phase -or
            [string]$dispatchState.status -cne 'completed' -or
            [long]$dispatchState.child_exit_code -ne 0 -or
            [long]$dispatchState.next_dispatch_count -ne
                $(if ([string]::IsNullOrEmpty($expected.NextPhase)) { 0 } else { 1 })) {
            throw "Canary gate receipt route is mismatched at ordinal $($index + 1)."
        }
        if ($RequireActionProvenance) {
            Assert-CompletedModelOuterDispatch `
                -RunnerPath $RunnerPath `
                -PhaseRoot $phaseRoot `
                -Policy $expected `
                -ReceiptSnapshot $receiptSnapshot `
                -StateSnapshot $stateSnapshot `
                -ExpectedConsumptionSha256 ([string]$observed.inner_consumption_sha256) `
                -MaxAgeSeconds $ReceiptMaxAgeSeconds `
                -RequireLiveCampaignEvidence
        }
    }
    if ($State -ceq 'FREEZE_PENDING_AFTER_CANARIES') {
        return
    }

    if ($null -eq $snapshots.Freeze) {
        throw 'D54 lifecycle is missing the freeze manifest.'
    }
    $freeze = $snapshots.Freeze.Value
    Assert-LifecycleEvidenceCommon `
        -Record $freeze `
        -SchemaVersion 'work-charter-d54-freeze/v1' `
        -State 'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION' `
        -Purpose 'Freeze manifest'
    if ([string]$freeze.previous_state -cne 'FREEZE_PENDING_AFTER_CANARIES' -or
        [string]$freeze.canary_gate_sha256 -cne $snapshots.Canary.Sha256 -or
        $freeze.model_activity_authorized -isnot [bool] -or
        [bool]$freeze.model_activity_authorized) {
        throw 'Freeze manifest does not follow the complete D54 canary gate.'
    }
    if ($State -ceq 'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION') {
        return
    }

    if ($null -eq $snapshots.Activation) {
        throw 'D54 lifecycle is missing the post-freeze product activation receipt.'
    }
    $activation = $snapshots.Activation.Value
    Assert-LifecycleEvidenceCommon `
        -Record $activation `
        -SchemaVersion 'work-charter-d54-product-activation/v1' `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' `
        -Purpose 'Product activation receipt'
    if ([string]$activation.previous_state -cne
            'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION' -or
        $activation.authorized -isnot [bool] -or
        -not [bool]$activation.authorized -or
        [string]$activation.freeze_manifest_sha256 -cne $snapshots.Freeze.Sha256 -or
        [string]$activation.campaign_contract_sha256 -cne
            (Get-FileSha256 -Path $script:CampaignContractPath)) {
        throw 'Product activation receipt is not bound to the approved D54 Campaign and freeze.'
    }
    if ($State -cne 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN') {
        throw 'D54 lifecycle state is not supported by the transition evidence chain.'
    }
}

function Assert-TerminalLifecycleEvidence {
    param(
        [Parameter(Mandatory)][string]$EvidenceRoot,
        [Parameter(Mandatory)][string]$RunnerPath,
        [switch]$RequireActionProvenance
    )

    $evidenceDirectory = (
        Get-OrdinaryDirectory -Path $EvidenceRoot -Purpose 'terminal evidence root'
    ).FullName
    $terminalSnapshot = Read-JsonSnapshot `
        -Path (Join-Path $evidenceDirectory 'd54-terminal.json') `
        -Purpose 'D54 terminal receipt'
    $terminal = $terminalSnapshot.Value
    Assert-LifecycleEvidenceCommon `
        -Record $terminal `
        -SchemaVersion 'work-charter-d54-terminal/v1' `
        -State 'TERMINAL' `
        -Purpose 'D54 terminal receipt'
    $dispositionsByPreviousState = @{
        ZERO_MODEL_QUALIFICATION_PENDING = @(
            'QUALIFICATION_FAILED / PRODUCT_UNKNOWN'
        )
        CANARY_AUTHORIZED_AFTER_QUALIFICATION = @(
            'CANARY_FAILED / PRODUCT_UNKNOWN'
        )
        FREEZE_PENDING_AFTER_CANARIES = @(
            'FREEZE_FAILED / PRODUCT_UNKNOWN'
        )
        PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION = @(
            'ACTIVATION_FAILED / PRODUCT_UNKNOWN'
        )
        PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN = @(
            'PRODUCT_FAILED / NOT_ACCEPTED',
            'ASSESSOR_FAILED / NOT_ACCEPTED',
            'ACCEPTED'
        )
    }
    $previousState = [string]$terminal.previous_state
    $terminalDisposition = [string]$terminal.terminal_disposition
    if (-not $dispositionsByPreviousState.ContainsKey($previousState) -or
        $terminalDisposition -notin @($dispositionsByPreviousState[$previousState]) -or
        $terminal.candidate_accepted -isnot [bool] -or
        $terminal.model_contexts -isnot [long] -or
        [long]$terminal.model_contexts -lt 0 -or
        [long]$terminal.model_contexts -gt 16 -or
        $terminal.turn_starts -isnot [long] -or
        [long]$terminal.turn_starts -lt 0 -or
        [long]$terminal.turn_starts -gt 18 -or
        $terminal.rehearsal_corrections_used -isnot [long] -or
        [long]$terminal.rehearsal_corrections_used -lt 0 -or
        [long]$terminal.rehearsal_corrections_used -gt 3 -or
        $terminal.formal_corrections_used -isnot [long] -or
        [long]$terminal.formal_corrections_used -lt 0 -or
        [long]$terminal.formal_corrections_used -gt 2) {
        throw 'D54 terminal receipt disposition does not match its predecessor state or budget.'
    }
    $accepted = [bool]$terminal.candidate_accepted
    if (($accepted -and [string]$terminal.terminal_disposition -cne 'ACCEPTED') -or
        (-not $accepted -and [string]$terminal.terminal_disposition -ceq 'ACCEPTED')) {
        throw 'D54 terminal receipt acceptance flag and disposition disagree.'
    }
    Assert-LifecycleTransitionEvidence `
        -EvidenceRoot $evidenceDirectory `
        -State $previousState `
        -RunnerPath $RunnerPath `
        -RequireActionProvenance:$RequireActionProvenance
    if (-not $accepted) {
        return
    }
    if (-not $RequireActionProvenance) {
        throw 'Accepted D54 terminal receipt requires action provenance.'
    }
    if ([string]$terminal.previous_state -cne 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' -or
        [long]$terminal.model_contexts -ne 16 -or
        [long]$terminal.turn_starts -ne 18) {
        throw 'Accepted D54 terminal receipt lacks the complete authorized evidence budget.'
    }
    Assert-AssessorEligibility -EvidenceRoot $evidenceDirectory
    $carrierRoot = $script:PrivateCarrierRoot
    $productPacketSnapshot = Read-JsonSnapshot `
        -Path (Join-Path (Join-Path $carrierRoot 'execution\terminal') 'terminal-packet.json') `
        -Purpose 'accepted admitted product packet'
    $productRoutes = @(Get-ValidatedProductRoutes -Packet $productPacketSnapshot.Value)
    $productPolicies = @(Get-AuthorizedProductionPhases | Where-Object {
        $_.Segment -ceq 'product'
    })
    for ($index = 0; $index -lt $productPolicies.Count; $index++) {
        $policy = $productPolicies[$index]
        $route = $productRoutes[$index]
        $phaseRoot = Join-Path `
            (Join-Path $carrierRoot 'phases') `
            $policy.DirectoryName
        $receiptSnapshot = Read-JsonSnapshot `
            -Path (Join-Path $phaseRoot 'receipt.json') `
            -Purpose 'product outer receipt'
        $stateSnapshot = Read-JsonSnapshot `
            -Path (Join-Path $phaseRoot 'dispatch-state.json') `
            -Purpose 'product dispatch state'
        if ([string]$route.outer_receipt_sha256 -cne $receiptSnapshot.Sha256 -or
            [string]$route.dispatch_state_sha256 -cne $stateSnapshot.Sha256) {
            throw "Accepted D54 product route evidence is mismatched at ordinal $($index + 1)."
        }
        Assert-CompletedModelOuterDispatch `
            -RunnerPath $RunnerPath `
            -PhaseRoot $phaseRoot `
            -Policy $policy `
            -ReceiptSnapshot $receiptSnapshot `
            -StateSnapshot $stateSnapshot `
            -ExpectedConsumptionSha256 ([string]$route.inner_consumption_sha256) `
            -MaxAgeSeconds $ReceiptMaxAgeSeconds `
            -RequireLiveCampaignEvidence
    }
    $assessmentSnapshot = Read-JsonSnapshot `
        -Path (Join-Path (Join-Path $carrierRoot 'execution\assessor') 'assessment.json') `
        -Purpose 'D54 assessor result'
    $assessment = $assessmentSnapshot.Value
    Assert-LifecycleEvidenceCommon `
        -Record $assessment `
        -SchemaVersion 'work-charter-d54-assessment/v1' `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' `
        -Purpose 'D54 assessor result'
    $assessorPolicy = Get-AuthorizedProductionPhase -Phase 'assessor-terra-high'
    $assessorPhaseRoot = Join-Path `
        (Join-Path $carrierRoot 'phases') `
        $assessorPolicy.DirectoryName
    $assessorReceiptSnapshot = Read-JsonSnapshot `
        -Path (Join-Path $assessorPhaseRoot 'receipt.json') `
        -Purpose 'assessor outer receipt'
    $assessorStateSnapshot = Read-JsonSnapshot `
        -Path (Join-Path $assessorPhaseRoot 'dispatch-state.json') `
        -Purpose 'assessor dispatch state'
    $eligibilitySnapshot = Read-JsonSnapshot `
        -Path (Join-Path $evidenceDirectory 'assessor-eligibility.json') `
        -Purpose 'assessor eligibility receipt'
    $viewSnapshot = Read-JsonSnapshot `
        -Path (Join-Path (Join-Path $carrierRoot 'execution\terminal') 'assessor-view.json') `
        -Purpose 'assessor view'
    if ([string]$assessment.verdict -cne 'ACCEPTED' -or
        [string]$assessment.assessor_phase -cne $assessorPolicy.Phase -or
        [string]$assessment.assessor_outer_receipt_sha256 -cne $assessorReceiptSnapshot.Sha256 -or
        [string]$assessment.assessor_dispatch_state_sha256 -cne $assessorStateSnapshot.Sha256 -or
        [string]$assessment.assessor_inner_consumption_sha256 -cnotmatch '^[0-9a-f]{64}$' -or
        [string]$assessment.assessor_eligibility_sha256 -cne $eligibilitySnapshot.Sha256 -or
        [string]$assessment.assessor_view_sha256 -cne $viewSnapshot.Sha256 -or
        [string]$terminal.assessment_sha256 -cne $assessmentSnapshot.Sha256) {
        throw 'Accepted D54 terminal receipt is not bound to the eligible consumed assessor result.'
    }
    Assert-CompletedModelOuterDispatch `
        -RunnerPath $RunnerPath `
        -PhaseRoot $assessorPhaseRoot `
        -Policy $assessorPolicy `
        -ReceiptSnapshot $assessorReceiptSnapshot `
        -StateSnapshot $assessorStateSnapshot `
        -ExpectedConsumptionSha256 ([string]$assessment.assessor_inner_consumption_sha256) `
        -MaxAgeSeconds $ReceiptMaxAgeSeconds `
        -RequireLiveCampaignEvidence
}

function Get-ValidatedProductRoutes {
    param([Parameter(Mandatory)][object]$Packet)

    $expected = @(Get-AuthorizedProductionPhases | Where-Object {
        $_.Segment -ceq 'product'
    })
    $observed = @($Packet.routes)
    if ($observed.Count -ne $expected.Count) {
        throw 'Assessor admitted product packet does not contain all twelve product routes.'
    }
    for ($index = 0; $index -lt $expected.Count; $index++) {
        $policy = $expected[$index]
        $route = $observed[$index]
        if ([string]$route.phase -cne $policy.Phase -or
            [string]$route.model -cne $policy.Model -or
            [string]$route.reasoning_effort -cne $policy.Effort -or
            [long]$route.model_contexts -ne 1 -or
            [long]$route.turn_starts -ne [long]$policy.TurnStarts -or
            [string]$route.verdict -cne 'PASS' -or
            [string]$route.outer_receipt_sha256 -cnotmatch '^[0-9a-f]{64}$' -or
            [string]$route.dispatch_state_sha256 -cnotmatch '^[0-9a-f]{64}$' -or
            [string]$route.inner_consumption_sha256 -cnotmatch '^[0-9a-f]{64}$') {
            throw "Assessor admitted product route is incomplete at ordinal $($index + 1)."
        }
    }
    return $observed
}

function Assert-LiveCampaignProductEvidence {
    param(
        [Parameter(Mandatory)][string]$RunnerPath,
        [Parameter(Mandatory)][int]$MaxAgeSeconds
    )

    Assert-LiveCampaignSegmentEvidence -Segment 'product'
    $packetSnapshot = Read-JsonSnapshot `
        -Path (Join-Path $script:PrivateCarrierRoot 'execution\terminal\terminal-packet.json') `
        -Purpose 'live admitted product packet'
    $routes = @(Get-ValidatedProductRoutes -Packet $packetSnapshot.Value)
    $policies = @(Get-AuthorizedProductionPhases | Where-Object {
        $_.Segment -ceq 'product'
    })
    for ($index = 0; $index -lt $policies.Count; $index++) {
        $policy = $policies[$index]
        $route = $routes[$index]
        $phaseRoot = Get-ProductionPhaseRoot -Policy $policy
        $receiptSnapshot = Read-JsonSnapshot `
            -Path (Join-Path $phaseRoot 'receipt.json') `
            -Purpose 'live product outer receipt'
        $stateSnapshot = Read-JsonSnapshot `
            -Path (Join-Path $phaseRoot 'dispatch-state.json') `
            -Purpose 'live product dispatch state'
        if ([string]$route.outer_receipt_sha256 -cne $receiptSnapshot.Sha256 -or
            [string]$route.dispatch_state_sha256 -cne $stateSnapshot.Sha256) {
            throw "Live product route evidence is mismatched at ordinal $($index + 1)."
        }
        Assert-CompletedModelOuterDispatch `
            -RunnerPath $RunnerPath `
            -PhaseRoot $phaseRoot `
            -Policy $policy `
            -ReceiptSnapshot $receiptSnapshot `
            -StateSnapshot $stateSnapshot `
            -ExpectedConsumptionSha256 ([string]$route.inner_consumption_sha256) `
            -MaxAgeSeconds $MaxAgeSeconds `
            -RequireLiveCampaignEvidence
    }
}

function Assert-AssessorEligibility {
    param([Parameter(Mandatory)][string]$EvidenceRoot)

    [void](Assert-ExactPathIdentity `
        -Actual $EvidenceRoot `
        -Expected $script:EvidenceRoot `
        -Purpose 'assessor evidence root')
    $evidenceDirectory = (
        Get-OrdinaryDirectory -Path $script:EvidenceRoot -Purpose 'assessor evidence root'
    ).FullName
    $carrierRoot = $script:PrivateCarrierRoot
    $terminalRoot = Join-Path (Join-Path $carrierRoot 'execution') 'terminal'
    $packet = Read-JsonSnapshot `
        -Path (Join-Path $terminalRoot 'terminal-packet.json') `
        -Purpose 'admitted product packet'
    $view = Read-JsonSnapshot `
        -Path (Join-Path $terminalRoot 'assessor-view.json') `
        -Purpose 'assessor view'
    $review = Read-JsonSnapshot `
        -Path (Join-Path $terminalRoot 'assessor-view-local-review.json') `
        -Purpose 'assessor view local review'
    $eligibility = Read-JsonSnapshot `
        -Path (Join-Path $evidenceDirectory 'assessor-eligibility.json') `
        -Purpose 'assessor eligibility receipt'

    Assert-LifecycleEvidenceCommon `
        -Record $packet.Value `
        -SchemaVersion 'work-charter-d54-admitted-product-packet/v1' `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' `
        -Purpose 'Admitted product packet'
    if ([long]$packet.Value.score.passed -ne 28 -or
        [long]$packet.Value.score.total -ne 28 -or
        [string]$packet.Value.candidate_calibration.verdict -cne 'PASS' -or
        [long]$packet.Value.candidate_calibration.model_contexts -ne 1 -or
        [long]$packet.Value.candidate_calibration.turn_starts -ne 2 -or
        [long]$packet.Value.imported_scored_cells -ne 17 -or
        [long]$packet.Value.fresh_scored_cells -ne 11 -or
        [long]$packet.Value.product_model_contexts -ne 12 -or
        [long]$packet.Value.product_turn_starts -ne 14 -or
        [string]$packet.Value.controller_disposition -cne 'ADMISSIBLE') {
        throw 'Assessor admitted product packet is incomplete or ineligible.'
    }
    [void](Get-ValidatedProductRoutes -Packet $packet.Value)

    Assert-LifecycleEvidenceCommon `
        -Record $view.Value `
        -SchemaVersion 'work-charter-d54-assessor-view/v1' `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' `
        -Purpose 'Assessor view'
    if ([string]$view.Value.source_packet_sha256 -cne $packet.Sha256) {
        throw 'Assessor view is not bound to the admitted product packet.'
    }

    Assert-LifecycleEvidenceCommon `
        -Record $review.Value `
        -SchemaVersion 'work-charter-d54-assessor-view-review/v1' `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' `
        -Purpose 'Assessor view local review'
    if ([string]$review.Value.verdict -cne 'PASS' -or
        $review.Value.disclosure_safe -isnot [bool] -or
        -not [bool]$review.Value.disclosure_safe -or
        [string]$review.Value.assessor_view_sha256 -cne $view.Sha256) {
        throw 'Assessor view local disclosure review is not PASS.'
    }

    Assert-LifecycleEvidenceCommon `
        -Record $eligibility.Value `
        -SchemaVersion 'work-charter-d54-assessor-eligibility/v1' `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' `
        -Purpose 'Assessor eligibility receipt'
    if ($eligibility.Value.eligible -isnot [bool] -or
        -not [bool]$eligibility.Value.eligible -or
        [string]$eligibility.Value.admitted_product_packet_sha256 -cne $packet.Sha256 -or
        [string]$eligibility.Value.assessor_view_sha256 -cne $view.Sha256 -or
        [string]$eligibility.Value.local_review_sha256 -cne $review.Sha256) {
        throw 'Assessor eligibility receipt does not bind the admitted packet and reviewed view.'
    }
}

function Assert-ExecutionParameters {
    foreach ($pair in @(
        @('BindingPath', $BindingPath),
        @('AuthoritySnapshotPath', $AuthoritySnapshotPath),
        @('CarrierManifestPath', $CarrierManifestPath),
        @('FrozenInputsPath', $FrozenInputsPath),
        @('ReceiptPath', $ReceiptPath),
        @('DispatchStatePath', $DispatchStatePath),
        @('ExpectedPhase', $ExpectedPhase),
        @('ChildExecutablePath', $ChildExecutablePath),
        @('ChildOperationId', $ChildOperationId),
        @('ChildExecutableAnchorId', $ChildExecutableAnchorId),
        @('ChildArgumentsPath', $ChildArgumentsPath)
    )) {
        if ([string]::IsNullOrWhiteSpace([string]$pair[1])) {
            throw "Execution parameter is required outside DescribeLifecycle mode: $($pair[0])"
        }
    }
}

function Assert-CampaignParameters {
    foreach ($pair in @(
        @('BindingPath', $BindingPath),
        @('AuthoritySnapshotPath', $AuthoritySnapshotPath),
        @('CarrierManifestPath', $CarrierManifestPath),
        @('FrozenInputsPath', $FrozenInputsPath),
        @('ReceiptPath', $ReceiptPath),
        @('DispatchStatePath', $DispatchStatePath),
        @('ExpectedPhase', $ExpectedPhase),
        @('ChildExecutablePath', $ChildExecutablePath),
        @('ChildOperationId', $ChildOperationId),
        @('ChildExecutableAnchorId', $ChildExecutableAnchorId),
        @('ChildArgumentsPath', $ChildArgumentsPath),
        @('ChildWorkingDirectory', $ChildWorkingDirectory),
        @('NextDispatchPath', $NextDispatchPath),
        @('LifecycleEvidenceRoot', $LifecycleEvidenceRoot),
        @('ExpectedLifecycleState', $ExpectedLifecycleState)
    )) {
        if (-not [string]::IsNullOrWhiteSpace([string]$pair[1])) {
            throw "Campaign mode derives its exact route and rejects caller input: $($pair[0])"
        }
    }
    if ($RequireActionProvenance) {
        throw 'Campaign mode owns action provenance and rejects a caller assertion.'
    }
}

function Test-IsZeroModelAppServerQualification {
    param(
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase
    )

    return $OperationId -ceq 'd52-codex-app-server' -and
        $Phase -ceq $script:ZeroModelQualificationPhase
}

function Test-RequiresCommittedRunner {
    param(
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase
    )

    if ($OperationId -ceq 'd52-test-production-runner-binding') {
        return $true
    }
    return $OperationId -ceq 'd52-codex-app-server' -and
        -not (Test-IsZeroModelAppServerQualification -OperationId $OperationId -Phase $Phase)
}

function Get-AuthorizedProductionPhases {
    $definitions = @(
        @('canary', 'canary-sol-high', 'gpt-5.6-sol', 'high', 1),
        @('canary', 'canary-sol-xhigh', 'gpt-5.6-sol', 'xhigh', 1),
        @('canary', 'canary-terra-high', 'gpt-5.6-terra', 'high', 1),
        @('product', 'candidate-calibration', 'gpt-5.6-sol', 'high', 2),
        @('product', 'released-control-a18', 'gpt-5.6-sol', 'high', 2),
        @('product', 'candidate-a19', 'gpt-5.6-sol', 'high', 1),
        @('product', 'candidate-a20', 'gpt-5.6-sol', 'high', 1),
        @('product', 'candidate-b01', 'gpt-5.6-sol', 'xhigh', 1),
        @('product', 'candidate-b02', 'gpt-5.6-sol', 'xhigh', 1),
        @('product', 'candidate-b03', 'gpt-5.6-sol', 'xhigh', 1),
        @('product', 'candidate-b04', 'gpt-5.6-sol', 'xhigh', 1),
        @('product', 'candidate-c01', 'gpt-5.6-terra', 'high', 1),
        @('product', 'candidate-c02', 'gpt-5.6-terra', 'high', 1),
        @('product', 'candidate-c03', 'gpt-5.6-terra', 'high', 1),
        @('product', 'candidate-c04', 'gpt-5.6-terra', 'high', 1),
        @('assessor', 'assessor-terra-high', 'gpt-5.6-terra', 'high', 1)
    )
    $remainingContexts = 16
    $remainingTurns = 18
    $segmentOrdinals = @{}
    $result = [System.Collections.Generic.List[object]]::new()
    for ($index = 0; $index -lt $definitions.Count; $index++) {
        $definition = $definitions[$index]
        $segment = [string]$definition[0]
        $phase = [string]$definition[1]
        $segmentOrdinals[$segment] = 1 + [int]$segmentOrdinals[$segment]
        $nextPhase = if ($index + 1 -lt $definitions.Count -and
            [string]$definitions[$index + 1][0] -ceq $segment) {
            [string]$definitions[$index + 1][1]
        }
        else { '' }
        $result.Add([pscustomobject]@{
            Ordinal = $index + 1
            Segment = $segment
            SegmentOrdinal = [int]$segmentOrdinals[$segment]
            Phase = $phase
            Model = [string]$definition[2]
            Effort = [string]$definition[3]
            TurnStarts = [int]$definition[4]
            RemainingContexts = $remainingContexts
            RemainingTurns = $remainingTurns
            NextPhase = $nextPhase
            DirectoryName = ('{0:d2}-{1}' -f ($index + 1), $phase)
        })
        $remainingContexts--
        $remainingTurns -= [int]$definition[4]
    }
    return $result.ToArray()
}

function Get-ProductionPhaseRoot {
    param([Parameter(Mandatory)][object]$Policy)

    return Join-Path `
        (Join-Path $script:PrivateCarrierRoot 'phases') `
        ([string]$Policy.DirectoryName)
}

function Get-LiveCampaignController {
    if ($null -eq $script:ActiveCampaignController -or
        $null -eq $script:ActiveCampaignController.Guard -or
        $script:ActiveCampaignController.Active -isnot [bool] -or
        -not [bool]$script:ActiveCampaignController.Active) {
        throw 'Production dispatch requires the live D54 Campaign controller capability.'
    }
    return $script:ActiveCampaignController
}

function Assert-LiveCampaignDispatchAuthorization {
    param([Parameter(Mandatory)][object]$Policy)

    $controller = Get-LiveCampaignController
    if ([string]$controller.CurrentSegment -cne [string]$Policy.Segment) {
        throw 'Production dispatch is outside the live Campaign controller segment.'
    }
    if ([string]$controller.NextSegment -cne [string]$Policy.Segment) {
        throw 'Production dispatch does not follow the live Campaign segment order.'
    }
    if ([string]$Policy.Segment -ceq 'product' -and
        -not $controller.CompletedSegments.Contains('canary')) {
        throw 'Live Campaign controller has not completed the canary segment.'
    }
    if ([string]$Policy.Segment -ceq 'assessor' -and
        (-not $controller.CompletedSegments.Contains('canary') -or
         -not $controller.CompletedSegments.Contains('product'))) {
        throw 'Live Campaign controller has not completed the product segment.'
    }
}

function Get-LiveCampaignPhaseFingerprint {
    param([Parameter(Mandatory)][object]$Policy)

    $phaseRoot = Get-ProductionPhaseRoot -Policy $Policy
    $paths = [ordered]@{
        binding = Join-Path $phaseRoot 'binding.json'
        authority = Join-Path $phaseRoot 'authority-snapshot.json'
        carrier = Join-Path $phaseRoot 'carrier-manifest.json'
        frozen = Join-Path $phaseRoot 'frozen-inputs.json'
        arguments = Join-Path $phaseRoot 'child-argv.json'
        receipt = Join-Path $phaseRoot 'receipt.json'
        consumption = (Join-Path $phaseRoot 'receipt.json') + '.consumed'
        state = Join-Path $phaseRoot 'dispatch-state.json'
    }
    if (-not [string]::IsNullOrEmpty([string]$Policy.NextPhase)) {
        $paths.next = Join-Path $phaseRoot 'next-dispatch.json'
    }
    $rows = [System.Collections.Generic.List[string]]::new()
    $rows.Add("phase|$([string]$Policy.Phase)")
    foreach ($entry in $paths.GetEnumerator()) {
        $rows.Add("$([string]$entry.Key)|$(Get-FileSha256 -Path ([string]$entry.Value))")
    }
    return Get-TextSha256 -Text ($rows.ToArray() -join "`n")
}

function Assert-LiveCampaignPhaseEvidence {
    param([Parameter(Mandatory)][object]$Policy)

    $controller = Get-LiveCampaignController
    if (-not $controller.PhaseEvidence.ContainsKey([string]$Policy.Phase)) {
        throw "Live Campaign controller did not observe completed phase: $($Policy.Phase)"
    }
    $current = Get-LiveCampaignPhaseFingerprint -Policy $Policy
    if ([string]$controller.PhaseEvidence[[string]$Policy.Phase] -cne $current) {
        throw "Persisted phase evidence changed after live completion: $($Policy.Phase)"
    }
}

function Assert-LiveCampaignSegmentEvidence {
    param([Parameter(Mandatory)][ValidateSet('canary', 'product', 'assessor')][string]$Segment)

    $controller = Get-LiveCampaignController
    if (-not $controller.CompletedSegments.Contains($Segment)) {
        throw "Live Campaign controller has not completed the $Segment segment."
    }
    foreach ($policy in @(Get-AuthorizedProductionPhases | Where-Object {
        $_.Segment -ceq $Segment
    })) {
        Assert-LiveCampaignPhaseEvidence -Policy $policy
    }
}

function Get-ProtocolQualificationPhases {
    $definitions = @(
        @('qualification-segment-01', 'gpt-5.6-sol', 'high', 1, 'qualification-segment-02'),
        @('qualification-segment-02', 'gpt-5.6-sol', 'xhigh', 1, 'qualification-segment-03'),
        @('qualification-segment-03', 'gpt-5.6-terra', 'high', 1, '')
    )
    $result = [System.Collections.Generic.List[object]]::new()
    for ($index = 0; $index -lt $definitions.Count; $index++) {
        $definition = $definitions[$index]
        $result.Add([pscustomobject]@{
            Ordinal = $index + 1
            Segment = 'qualification'
            SegmentOrdinal = $index + 1
            Phase = [string]$definition[0]
            Model = [string]$definition[1]
            Effort = [string]$definition[2]
            TurnStarts = [int]$definition[3]
            RemainingContexts = $definitions.Count - $index
            RemainingTurns = $definitions.Count - $index
            NextPhase = [string]$definition[4]
            DirectoryName = ('qualification-{0:d2}' -f ($index + 1))
        })
    }
    return $result.ToArray()
}

function Get-ProtocolQualificationPhase {
    param([Parameter(Mandatory)][string]$Phase)

    $matches = @(Get-ProtocolQualificationPhases | Where-Object {
        $_.Phase -ceq $Phase
    })
    if ($matches.Count -ne 1) {
        throw "Protocol qualification phase is not authorized: $Phase"
    }
    return $matches[0]
}

function Test-IsProtocolQualificationPhase {
    param([Parameter(Mandatory)][string]$Phase)

    return @(Get-ProtocolQualificationPhases | Where-Object {
        $_.Phase -ceq $Phase
    }).Count -eq 1
}

function Get-ProductionPolicySha256 {
    $rows = @(
        Get-AuthorizedProductionPhases | ForEach-Object {
            @(
                $_.Ordinal, $_.Segment, $_.SegmentOrdinal, $_.Phase,
                $_.Model, $_.Effort, $_.TurnStarts,
                $_.RemainingContexts, $_.RemainingTurns, $_.NextPhase,
                $_.DirectoryName, 'd52-codex-app-server',
                'd52-codex-app-server-0.147.0-alpha.6.6', 'app-server', '--stdio'
            ) -join '|'
        }
    )
    return Get-TextSha256 -Text ($rows -join "`n")
}

function Get-AuthorizedProductionPhase {
    param([Parameter(Mandatory)][string]$Phase)

    $matches = @(Get-AuthorizedProductionPhases | Where-Object { $_.Phase -ceq $Phase })
    if ($matches.Count -ne 1) {
        throw 'Phase is not present in the committed D54 production authorization policy.'
    }
    return $matches[0]
}

function Assert-PathUnderRoot {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][string]$Purpose
    )

    $fullPath = Get-RootedPath -Path $Path -Purpose $Purpose
    $fullRoot = Get-RootedPath -Path $Root -Purpose "$Purpose root"
    $prefix = $fullRoot.TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar
    if (-not $fullPath.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "$Purpose is outside its authorized root."
    }
}

function Assert-AuthoritySnapshot {
    param(
        [Parameter(Mandatory)][object]$Snapshot,
        [Parameter(Mandatory)][string]$SnapshotSha256,
        [Parameter(Mandatory)][object]$Binding
    )

    if ([string]$Snapshot.schema_version -cne 'work-charter-d54-authority-snapshot/v1' -or
        [string]$Snapshot.campaign_id -cne $script:CampaignId -or
        [string]$Snapshot.stable_subject -cne $script:StableSubject -or
        [string]$Snapshot.candidate_commit -cne $script:CandidateCommit -or
        [string]$Snapshot.candidate_manifest_sha256 -cne $script:CandidateManifestSha256) {
        throw 'Authority snapshot does not identify the authorized D54 subject.'
    }
    Assert-AuthorizationLifecycleArtifact `
        -Artifact $Snapshot `
        -Phase ([string]$Binding.phase) `
        -Purpose 'Authority snapshot'
    $contractPath = (Get-OrdinaryFile `
        -Path ([string]$Snapshot.campaign_contract_path) `
        -Purpose 'Campaign contract').FullName
    if (-not [string]::Equals(
        $contractPath,
        $script:CampaignContractPath,
        [StringComparison]::OrdinalIgnoreCase
    )) {
        throw 'Authority snapshot does not identify the tracked D54 Campaign contract.'
    }
    $contractSha256 = Get-FileSha256 -Path $contractPath
    if ([string]$Snapshot.campaign_contract_sha256 -cne $contractSha256 -or
        [string]$Binding.campaign_contract_sha256 -cne $contractSha256) {
        throw 'Campaign contract content does not match the authority snapshot and binding.'
    }
    $observedSources = @($Snapshot.ruleset_sources)
    if ($observedSources.Count -ne $script:RulesetSources.Count) {
        throw 'Authority snapshot ruleset source count is mismatched.'
    }
    for ($index = 0; $index -lt $script:RulesetSources.Count; $index++) {
        $expected = $script:RulesetSources[$index]
        $observed = $observedSources[$index]
        $sourcePath = (Get-OrdinaryFile `
            -Path ([string]$observed.path) `
            -Purpose 'ruleset source').FullName
        if ([string]$observed.logical_locator -cne [string]$expected.Locator -or
            -not [string]::Equals(
            $sourcePath,
            [string]$expected.Path,
            [StringComparison]::OrdinalIgnoreCase
        ) -or [string]$observed.normalized_sha256 -cne [string]$expected.Sha256) {
            throw 'Authority snapshot ruleset identity is mismatched.'
        }
        $sourceBytes = [IO.File]::ReadAllBytes($sourcePath)
        if ((Get-NormalizedTextSha256 -Bytes $sourceBytes) -cne [string]$expected.Sha256) {
            throw 'Actually loaded ruleset source content is mismatched.'
        }
    }
    if ([string]$Binding.ruleset_sha256 -cne (Get-RulesetSha256)) {
        throw 'Launch binding ruleset aggregate is not the authenticated D54 ruleset.'
    }
    if ([string]$Binding.authority_snapshot_sha256 -cne $SnapshotSha256) {
        throw 'Authority snapshot content does not match the launch binding.'
    }
}

function Assert-EvidenceSnapshots {
    param(
        [Parameter(Mandatory)][object]$Binding,
        [Parameter(Mandatory)][object]$AuthoritySnapshot,
        [Parameter(Mandatory)][object]$CarrierSnapshot,
        [Parameter(Mandatory)][object]$FrozenSnapshot,
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase,
        [switch]$SkipProductionLifecycleEvidence
    )

    if ([string]$Binding.authority_snapshot_path_sha256 -cne
        (Get-TextSha256 -Text $AuthoritySnapshot.FullName) -or
        [string]$Binding.carrier_manifest_path_sha256 -cne
        (Get-TextSha256 -Text $CarrierSnapshot.FullName) -or
        [string]$Binding.frozen_inputs_path_sha256 -cne
        (Get-TextSha256 -Text $FrozenSnapshot.FullName)) {
        throw 'Evidence artifact path does not match the frozen launch binding.'
    }
    if ([string]$Binding.carrier_manifest_sha256 -cne $CarrierSnapshot.Sha256 -or
        [string]$Binding.frozen_inputs_sha256 -cne $FrozenSnapshot.Sha256) {
        throw 'Evidence artifact content does not match the frozen launch binding.'
    }
    $authoritySha256 = $AuthoritySnapshot.Sha256
    $frozen = $FrozenSnapshot.Value
    if ([string]$frozen.schema_version -cne 'work-charter-d54-frozen-inputs/v1' -or
        [string]$frozen.campaign_id -cne $script:CampaignId -or
        [string]$frozen.candidate_commit -cne $script:CandidateCommit -or
        [string]$frozen.candidate_manifest_sha256 -cne $script:CandidateManifestSha256 -or
        [string]$frozen.authority_snapshot_sha256 -cne $authoritySha256 -or
        [string]$frozen.phase -cne [string]$Binding.phase) {
        throw 'Frozen-input manifest does not bind the authorized D54 phase.'
    }
    Assert-AuthorizationLifecycleArtifact `
        -Artifact $frozen `
        -Phase ([string]$Binding.phase) `
        -Purpose 'Frozen-input manifest'
    $carrier = $CarrierSnapshot.Value
    if ([string]$carrier.schema_version -cne 'work-charter-d54-carrier-manifest/v1' -or
        [string]$carrier.campaign_id -cne $script:CampaignId -or
        [string]$carrier.candidate_commit -cne $script:CandidateCommit -or
        [string]$carrier.candidate_manifest_sha256 -cne $script:CandidateManifestSha256 -or
        [string]$carrier.launcher_sha256 -cne [string]$Binding.launcher_sha256 -or
        [string]$carrier.launcher_commit -cne [string]$Binding.launcher_commit -or
        [string]$carrier.launcher_blob_oid -cne [string]$Binding.launcher_blob_oid -or
        [string]$carrier.authority_snapshot_sha256 -cne $authoritySha256 -or
        [string]$carrier.frozen_inputs_sha256 -cne $FrozenSnapshot.Sha256 -or
        [string]$carrier.campaign_contract_sha256 -cne [string]$Binding.campaign_contract_sha256 -or
        [string]$carrier.ruleset_sha256 -cne [string]$Binding.ruleset_sha256 -or
        [string]$carrier.phase -cne [string]$Binding.phase) {
        throw 'Carrier manifest does not bind the authenticated D54 authority and frozen phase.'
    }
    Assert-AuthorizationLifecycleArtifact `
        -Artifact $carrier `
        -Phase ([string]$Binding.phase) `
        -Purpose 'Carrier manifest'
    if ($OperationId -ceq 'd52-codex-app-server' -and
        -not (Test-IsZeroModelAppServerQualification -OperationId $OperationId -Phase $Phase)) {
        Assert-PathUnderRoot -Path $AuthoritySnapshot.FullName -Root $script:PrivateCarrierRoot -Purpose 'authority snapshot'
        Assert-PathUnderRoot -Path $CarrierSnapshot.FullName -Root $script:PrivateCarrierRoot -Purpose 'carrier manifest'
        Assert-PathUnderRoot -Path $FrozenSnapshot.FullName -Root $script:PrivateCarrierRoot -Purpose 'frozen inputs'
    }
    Assert-ProductionAuthorization `
        -Binding $Binding `
        -Carrier $carrier `
        -Frozen $frozen `
        -OperationId $OperationId `
        -Phase ([string]$Binding.phase) `
        -SkipLifecycleEvidence:$SkipProductionLifecycleEvidence
    Assert-AuthoritySnapshot `
        -Snapshot $AuthoritySnapshot.Value `
        -SnapshotSha256 $AuthoritySnapshot.Sha256 `
        -Binding $Binding
}

function Assert-ProductionRoutePaths {
    param(
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase,
        [Parameter(Mandatory)][AllowEmptyString()][string[]]$Paths
    )

    if ($OperationId -cne 'd52-codex-app-server' -or
        (Test-IsZeroModelAppServerQualification -OperationId $OperationId -Phase $Phase)) {
        return
    }
    foreach ($path in $Paths) {
        if (-not [string]::IsNullOrWhiteSpace($path)) {
            Assert-PathUnderRoot -Path $path -Root $script:PrivateCarrierRoot -Purpose 'production route path'
        }
    }
}

function Get-CommittedRunnerIdentity {
    param([Parameter(Mandatory)][string]$RunnerPath)

    $gitAnchor = Get-TrustedExecutableAnchor -Id 'd52-git-2.54.0.windows.1'
    $common = @('-C', $script:RepositoryRoot)
    $commitResult = Invoke-ExactProcess `
        -ExecutablePath $gitAnchor.Path `
        -Arguments @($common + @('rev-parse', '--verify', 'HEAD')) `
        -WorkingDirectory $script:RepositoryRoot `
        -TrustedAnchorId $gitAnchor.Id
    $blobResult = Invoke-ExactProcess `
        -ExecutablePath $gitAnchor.Path `
        -Arguments @($common + @('rev-parse', '--verify', "HEAD`:$($script:RunnerRepositoryPath)")) `
        -WorkingDirectory $script:RepositoryRoot `
        -TrustedAnchorId $gitAnchor.Id
    $workingBlobResult = Invoke-ExactProcess `
        -ExecutablePath $gitAnchor.Path `
        -Arguments @($common + @('hash-object', '--no-filters', '--', $RunnerPath)) `
        -WorkingDirectory $script:RepositoryRoot `
        -TrustedAnchorId $gitAnchor.Id
    if ($commitResult.ExitCode -ne 0 -or $blobResult.ExitCode -ne 0 -or
        $workingBlobResult.ExitCode -ne 0) {
        throw 'Tracked runner committed identity is unavailable.'
    }
    $commit = $commitResult.Stdout.Trim()
    $blob = $blobResult.Stdout.Trim()
    $workingBlob = $workingBlobResult.Stdout.Trim()
    foreach ($identity in @($commit, $blob, $workingBlob)) {
        if ($identity -cnotmatch '^(?:[0-9a-f]{40}|[0-9a-f]{64})$') {
            throw 'Tracked runner committed identity is malformed.'
        }
    }
    if ($workingBlob -cne $blob) {
        throw 'Tracked runner working bytes differ from the committed runner blob.'
    }
    return [pscustomobject]@{ Commit = $commit; BlobOid = $blob }
}

function Assert-ProductionRunnerIdentity {
    param(
        [Parameter(Mandatory)][string]$RunnerPath,
        [Parameter(Mandatory)][object]$Binding,
        [Parameter(Mandatory)][object]$Carrier,
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase
    )

    if (-not (Test-RequiresCommittedRunner -OperationId $OperationId -Phase $Phase)) {
        return
    }
    $identity = Get-CommittedRunnerIdentity -RunnerPath $RunnerPath
    if ([string]$Binding.launcher_commit -cne $identity.Commit -or
        [string]$Carrier.launcher_commit -cne $identity.Commit -or
        [string]$Binding.launcher_blob_oid -cne $identity.BlobOid -or
        [string]$Carrier.launcher_blob_oid -cne $identity.BlobOid) {
        throw 'Carrier and binding do not identify the committed runner commit and blob.'
    }
}

function Test-RequiresProductionAuthorization {
    param(
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase
    )

    return $OperationId -ceq 'd52-codex-app-server' -and
        -not (Test-IsZeroModelAppServerQualification -OperationId $OperationId -Phase $Phase)
}

function Test-IsAppServerOperation {
    param([Parameter(Mandatory)][string]$OperationId)

    return $OperationId -in @(
        'd52-codex-app-server',
        'd52-test-protocol-adapter',
        'd52-test-protocol-failed-completion'
    )
}

function Test-IsAuthorizedProductionPhase {
    param([Parameter(Mandatory)][string]$Phase)

    return @(Get-AuthorizedProductionPhases | Where-Object { $_.Phase -ceq $Phase }).Count -eq 1
}

function Assert-ProductionAuthorization {
    param(
        [Parameter(Mandatory)][object]$Binding,
        [Parameter(Mandatory)][object]$Carrier,
        [Parameter(Mandatory)][object]$Frozen,
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase,
        [switch]$SkipLifecycleEvidence
    )

    if (-not (Test-RequiresProductionAuthorization -OperationId $OperationId -Phase $Phase)) {
        return
    }
    $policy = Get-AuthorizedProductionPhase -Phase $Phase
    if (-not $SkipLifecycleEvidence) {
        $lifecycleState = Get-AuthorizationLifecycleActiveState -Phase $Phase
        Assert-LifecycleTransitionEvidence `
            -EvidenceRoot $script:EvidenceRoot `
            -State $lifecycleState `
            -RunnerPath $PSCommandPath `
            -RequireActionProvenance
        if ($policy.Segment -ceq 'assessor') {
            Assert-AssessorEligibility `
                -EvidenceRoot $script:EvidenceRoot
            Assert-LiveCampaignProductEvidence `
                -RunnerPath $PSCommandPath `
                -MaxAgeSeconds ([int]$Binding.receipt_max_age_seconds)
        }
    }
    $policySha256 = Get-ProductionPolicySha256
    foreach ($artifact in @($Binding, $Carrier, $Frozen)) {
        if ([string]$artifact.authorization_policy_sha256 -cne $policySha256 -or
            [long]$artifact.phase_ordinal -ne [long]$policy.Ordinal -or
            [string]$artifact.phase -cne $policy.Phase -or
            [string]$artifact.model -cne $policy.Model -or
            [string]$artifact.reasoning_effort -cne $policy.Effort -or
            [long]$artifact.phase_turn_starts -ne [long]$policy.TurnStarts -or
            [string]$artifact.successor_phase -cne $policy.NextPhase) {
            throw 'Production artifact does not match the committed D54 phase authorization policy.'
        }
    }
    if ([long]$Binding.remaining_budget.model_contexts -ne [long]$policy.RemainingContexts -or
        [long]$Binding.remaining_budget.turn_starts -ne [long]$policy.RemainingTurns -or
        [string]$Binding.child_operation_id -cne 'd52-codex-app-server' -or
        [string]$Binding.child_executable_anchor_id -cne
            'd52-codex-app-server-0.147.0-alpha.6.6') {
        throw 'Production binding route or budget does not match the committed D54 phase authorization policy.'
    }
    $expectsSuccessor = -not [string]::IsNullOrEmpty($policy.NextPhase)
    if (($expectsSuccessor -and [string]$Binding.next_dispatch_sha256 -ceq ('0' * 64)) -or
        (-not $expectsSuccessor -and [string]$Binding.next_dispatch_sha256 -cne ('0' * 64))) {
        throw 'Production successor binding does not match the committed D54 phase authorization policy.'
    }
}

function Assert-ExactPathIdentity {
    param(
        [Parameter(Mandatory)][string]$Actual,
        [Parameter(Mandatory)][string]$Expected,
        [Parameter(Mandatory)][string]$Purpose
    )

    $actualPath = Get-RootedPath -Path $Actual -Purpose $Purpose
    $expectedPath = Get-RootedPath -Path $Expected -Purpose "$Purpose policy"
    if (-not [string]::Equals(
        $actualPath,
        $expectedPath,
        [StringComparison]::OrdinalIgnoreCase
    )) {
        throw "$Purpose does not match the committed D54 production path policy."
    }
}

function Assert-ProductionArtifactPaths {
    param(
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase,
        [Parameter(Mandatory)][string]$Binding,
        [Parameter(Mandatory)][string]$Authority,
        [Parameter(Mandatory)][string]$Carrier,
        [Parameter(Mandatory)][string]$Frozen,
        [Parameter(Mandatory)][string]$Receipt,
        [Parameter(Mandatory)][string]$State,
        [Parameter(Mandatory)][string]$Arguments,
        [AllowEmptyString()][string]$WorkingDirectory,
        [AllowEmptyString()][string]$NextDispatch,
        [switch]$ValidateNextDispatch
    )

    if ($OperationId -cne 'd52-codex-app-server' -or
        (Test-IsZeroModelAppServerQualification -OperationId $OperationId -Phase $Phase)) {
        return
    }
    $policy = Get-AuthorizedProductionPhase -Phase $Phase
    $phaseRoot = Join-Path (Join-Path $script:PrivateCarrierRoot 'phases') $policy.DirectoryName
    foreach ($pair in @(
        @($Binding, (Join-Path $phaseRoot 'binding.json'), 'production binding'),
        @($Authority, (Join-Path $phaseRoot 'authority-snapshot.json'), 'production authority snapshot'),
        @($Carrier, (Join-Path $phaseRoot 'carrier-manifest.json'), 'production carrier manifest'),
        @($Frozen, (Join-Path $phaseRoot 'frozen-inputs.json'), 'production frozen inputs'),
        @($Receipt, (Join-Path $phaseRoot 'receipt.json'), 'production receipt'),
        @($State, (Join-Path $phaseRoot 'dispatch-state.json'), 'production dispatch state'),
        @($Arguments, (Join-Path $phaseRoot 'child-argv.json'), 'production child argv'),
        @($WorkingDirectory, $phaseRoot, 'production child working directory')
    )) {
        Assert-ExactPathIdentity -Actual ([string]$pair[0]) -Expected ([string]$pair[1]) -Purpose ([string]$pair[2])
    }
    if ($ValidateNextDispatch) {
        $expectedNext = if ([string]::IsNullOrEmpty($policy.NextPhase)) { '' } else {
            Join-Path $phaseRoot 'next-dispatch.json'
        }
        if ([string]::IsNullOrEmpty($expectedNext)) {
            if (-not [string]::IsNullOrWhiteSpace($NextDispatch)) {
                throw 'Terminal D54 production phase cannot declare a successor descriptor.'
            }
        }
        else {
            Assert-ExactPathIdentity -Actual $NextDispatch -Expected $expectedNext -Purpose 'production next descriptor'
        }
    }
}

function Assert-AuthorizedNextDispatch {
    param(
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$Phase,
        [AllowNull()][object]$Descriptor
    )

    if ($OperationId -cne 'd52-codex-app-server' -or
        (Test-IsZeroModelAppServerQualification -OperationId $OperationId -Phase $Phase)) {
        return
    }
    $policy = Get-AuthorizedProductionPhase -Phase $Phase
    if ([string]::IsNullOrEmpty($policy.NextPhase)) {
        if ($null -ne $Descriptor) {
            throw 'Terminal D54 production phase cannot provide a successor descriptor.'
        }
        return
    }
    if ($null -eq $Descriptor) {
        throw 'D54 production phase is missing its committed-policy successor descriptor.'
    }
    $nextPolicy = Get-AuthorizedProductionPhase -Phase $policy.NextPhase
    $nextRoot = Join-Path (Join-Path $script:PrivateCarrierRoot 'phases') $nextPolicy.DirectoryName
    foreach ($pair in @(
        @([string]$Descriptor.binding_path, (Join-Path $nextRoot 'binding.json'), 'next binding'),
        @([string]$Descriptor.authority_snapshot_path, (Join-Path $nextRoot 'authority-snapshot.json'), 'next authority snapshot'),
        @([string]$Descriptor.carrier_manifest_path, (Join-Path $nextRoot 'carrier-manifest.json'), 'next carrier manifest'),
        @([string]$Descriptor.frozen_inputs_path, (Join-Path $nextRoot 'frozen-inputs.json'), 'next frozen inputs'),
        @([string]$Descriptor.receipt_path, (Join-Path $nextRoot 'receipt.json'), 'next receipt'),
        @([string]$Descriptor.dispatch_state_path, (Join-Path $nextRoot 'dispatch-state.json'), 'next dispatch state'),
        @([string]$Descriptor.child_arguments_path, (Join-Path $nextRoot 'child-argv.json'), 'next child argv'),
        @([string]$Descriptor.child_working_directory, $nextRoot, 'next child working directory')
    )) {
        Assert-ExactPathIdentity -Actual ([string]$pair[0]) -Expected ([string]$pair[1]) -Purpose ([string]$pair[2])
    }
    $anchor = Get-TrustedExecutableAnchor -Id 'd52-codex-app-server-0.147.0-alpha.6.6'
    Assert-ExactPathIdentity -Actual ([string]$Descriptor.child_executable_path) -Expected $anchor.Path -Purpose 'next child executable'
    if ([string]$Descriptor.expected_phase -cne $nextPolicy.Phase -or
        [string]$Descriptor.child_operation_id -cne 'd52-codex-app-server' -or
        [string]$Descriptor.child_executable_anchor_id -cne
            'd52-codex-app-server-0.147.0-alpha.6.6') {
        throw 'Next descriptor route does not match the committed D54 production authorization policy.'
    }
    $expectedFollowing = if ([string]::IsNullOrEmpty($nextPolicy.NextPhase)) { '' } else {
        Join-Path $nextRoot 'next-dispatch.json'
    }
    if ([string]::IsNullOrEmpty($expectedFollowing)) {
        if (-not [string]::IsNullOrWhiteSpace([string]$Descriptor.next_dispatch_path)) {
            throw 'Next terminal phase cannot declare a following descriptor.'
        }
    }
    else {
        Assert-ExactPathIdentity -Actual ([string]$Descriptor.next_dispatch_path) -Expected $expectedFollowing -Purpose 'following descriptor'
    }
}

function Assert-CompleteProductionCarrier {
    param(
        [Parameter(Mandatory)][string]$RunnerPath,
        [Parameter(Mandatory)][string]$ExecutablePath,
        [Parameter(Mandatory)][string]$ExecutableAnchorId,
        [Parameter(Mandatory)][int]$MaxAgeSeconds,
        [Parameter(Mandatory)][string]$EntryPhase
    )

    $entryPolicy = Get-AuthorizedProductionPhase -Phase $EntryPhase
    foreach ($policy in @(
        Get-AuthorizedProductionPhases |
            Where-Object { $_.Segment -ceq $entryPolicy.Segment }
    )) {
        $phaseRoot = Join-Path (Join-Path $script:PrivateCarrierRoot 'phases') $policy.DirectoryName
        $bindingPath = Join-Path $phaseRoot 'binding.json'
        $authorityPath = Join-Path $phaseRoot 'authority-snapshot.json'
        $carrierPath = Join-Path $phaseRoot 'carrier-manifest.json'
        $frozenPath = Join-Path $phaseRoot 'frozen-inputs.json'
        $receiptPath = Join-Path $phaseRoot 'receipt.json'
        $statePath = Join-Path $phaseRoot 'dispatch-state.json'
        $argumentPath = Join-Path $phaseRoot 'child-argv.json'
        $nextPath = if ([string]::IsNullOrEmpty($policy.NextPhase)) { '' } else {
            Join-Path $phaseRoot 'next-dispatch.json'
        }
        foreach ($mustBeAbsent in @($receiptPath, $statePath, ($receiptPath + '.consumed'))) {
            if (Test-Path -LiteralPath $mustBeAbsent) {
                throw 'Fresh D54 production carrier contains preexisting receipt or dispatch state.'
            }
        }
        Assert-ProductionArtifactPaths `
            -OperationId 'd52-codex-app-server' `
            -Phase $policy.Phase `
            -Binding $bindingPath `
            -Authority $authorityPath `
            -Carrier $carrierPath `
            -Frozen $frozenPath `
            -Receipt $receiptPath `
            -State $statePath `
            -Arguments $argumentPath `
            -WorkingDirectory $phaseRoot `
            -NextDispatch $nextPath `
            -ValidateNextDispatch
        $bindingSnapshot = Read-JsonSnapshot -Path $bindingPath -Purpose 'production launch binding'
        $authoritySnapshot = Read-JsonSnapshot -Path $authorityPath -Purpose 'production authority snapshot'
        $carrierSnapshot = Read-JsonSnapshot -Path $carrierPath -Purpose 'production carrier manifest'
        $frozenSnapshot = Read-JsonSnapshot -Path $frozenPath -Purpose 'production frozen inputs'
        $argumentSnapshot = Read-ArgumentVectorSnapshot -Path $argumentPath -Purpose 'production child argv'
        Assert-Binding `
            -Binding $bindingSnapshot.Value `
            -LauncherSha256 (Get-FileSha256 -Path $RunnerPath) `
            -Phase $policy.Phase `
            -MaxAgeSeconds $MaxAgeSeconds
        Assert-EvidenceSnapshots `
            -Binding $bindingSnapshot.Value `
            -AuthoritySnapshot $authoritySnapshot `
            -CarrierSnapshot $carrierSnapshot `
            -FrozenSnapshot $frozenSnapshot `
            -OperationId 'd52-codex-app-server' `
            -Phase $policy.Phase
        Assert-ProductionRunnerIdentity `
            -RunnerPath $RunnerPath `
            -Binding $bindingSnapshot.Value `
            -Carrier $carrierSnapshot.Value `
            -OperationId 'd52-codex-app-server' `
            -Phase $policy.Phase
        Assert-ChildRouteBinding `
            -Binding $bindingSnapshot.Value `
            -ExecutablePath $ExecutablePath `
            -OperationId 'd52-codex-app-server' `
            -ExecutableAnchorId $ExecutableAnchorId `
            -Arguments $argumentSnapshot.Arguments `
            -ArgumentsSha256 $argumentSnapshot.Sha256 `
            -WorkingDirectory $phaseRoot
        $descriptorSnapshot = if ([string]::IsNullOrEmpty($nextPath)) { $null } else {
            Read-JsonSnapshot -Path $nextPath -Purpose 'production next descriptor'
        }
        Assert-AuthorizedNextDispatch `
            -OperationId 'd52-codex-app-server' `
            -Phase $policy.Phase `
            -Descriptor $(if ($null -eq $descriptorSnapshot) { $null } else { $descriptorSnapshot.Value })
        Assert-NextRouteBinding `
            -Binding $bindingSnapshot.Value `
            -DescriptorSha256 $(if ($null -eq $descriptorSnapshot) { $null } else { $descriptorSnapshot.Sha256 })
    }
}

function Assert-CompletedModelOuterDispatch {
    param(
        [Parameter(Mandatory)][string]$RunnerPath,
        [Parameter(Mandatory)][string]$PhaseRoot,
        [Parameter(Mandatory)][object]$Policy,
        [Parameter(Mandatory)][object]$ReceiptSnapshot,
        [Parameter(Mandatory)][object]$StateSnapshot,
        [Parameter(Mandatory)][string]$ExpectedConsumptionSha256,
        [Parameter(Mandatory)][int]$MaxAgeSeconds,
        [switch]$RequireLiveCampaignEvidence
    )

    if ([string]$Policy.Segment -notin @('canary', 'product', 'assessor')) {
        throw 'Action-provenance validation accepts only committed model phases.'
    }
    $bindingPath = Join-Path $PhaseRoot 'binding.json'
    $authorityPath = Join-Path $PhaseRoot 'authority-snapshot.json'
    $carrierPath = Join-Path $PhaseRoot 'carrier-manifest.json'
    $frozenPath = Join-Path $PhaseRoot 'frozen-inputs.json'
    $argumentPath = Join-Path $PhaseRoot 'child-argv.json'
    $nextPath = if ([string]::IsNullOrEmpty($Policy.NextPhase)) { '' } else {
        Join-Path $PhaseRoot 'next-dispatch.json'
    }
    $bindingSnapshot = Read-JsonSnapshot -Path $bindingPath -Purpose 'canary launch binding'
    $authoritySnapshot = Read-JsonSnapshot -Path $authorityPath -Purpose 'canary authority snapshot'
    $carrierSnapshot = Read-JsonSnapshot -Path $carrierPath -Purpose 'canary carrier manifest'
    $frozenSnapshot = Read-JsonSnapshot -Path $frozenPath -Purpose 'canary frozen inputs'
    $argumentSnapshot = Read-ArgumentVectorSnapshot -Path $argumentPath -Purpose 'canary child argv'
    $binding = $bindingSnapshot.Value
    $receipt = $ReceiptSnapshot.Value
    $state = $StateSnapshot.Value
    $consumptionSnapshot = Read-JsonSnapshot `
        -Path ($ReceiptSnapshot.FullName + '.consumed') `
        -Purpose 'canary inner-consumption claim'
    $consumption = $consumptionSnapshot.Value

    Assert-ProductionArtifactPaths `
        -OperationId 'd52-codex-app-server' `
        -Phase $Policy.Phase `
        -Binding $bindingPath `
        -Authority $authorityPath `
        -Carrier $carrierPath `
        -Frozen $frozenPath `
        -Receipt $ReceiptSnapshot.FullName `
        -State $StateSnapshot.FullName `
        -Arguments $argumentPath `
        -WorkingDirectory $PhaseRoot `
        -NextDispatch $nextPath `
        -ValidateNextDispatch
    Assert-Binding `
        -Binding $binding `
        -LauncherSha256 (Get-FileSha256 -Path $RunnerPath) `
        -Phase $Policy.Phase `
        -MaxAgeSeconds $MaxAgeSeconds
    Assert-EvidenceSnapshots `
        -Binding $binding `
        -AuthoritySnapshot $authoritySnapshot `
        -CarrierSnapshot $carrierSnapshot `
        -FrozenSnapshot $frozenSnapshot `
        -OperationId 'd52-codex-app-server' `
        -Phase $Policy.Phase `
        -SkipProductionLifecycleEvidence
    Assert-ProductionRunnerIdentity `
        -RunnerPath $RunnerPath `
        -Binding $binding `
        -Carrier $carrierSnapshot.Value `
        -OperationId 'd52-codex-app-server' `
        -Phase $Policy.Phase
    $anchor = Get-TrustedExecutableAnchor -Id 'd52-codex-app-server-0.147.0-alpha.6.6'
    Assert-ChildRouteBinding `
        -Binding $binding `
        -ExecutablePath $anchor.Path `
        -OperationId 'd52-codex-app-server' `
        -ExecutableAnchorId $anchor.Id `
        -Arguments $argumentSnapshot.Arguments `
        -ArgumentsSha256 $argumentSnapshot.Sha256 `
        -WorkingDirectory $PhaseRoot
    $descriptorSnapshot = if ([string]::IsNullOrEmpty($nextPath)) { $null } else {
        Read-JsonSnapshot -Path $nextPath -Purpose 'canary next descriptor'
    }
    Assert-AuthorizedNextDispatch `
        -OperationId 'd52-codex-app-server' `
        -Phase $Policy.Phase `
        -Descriptor $(if ($null -eq $descriptorSnapshot) { $null } else { $descriptorSnapshot.Value })
    Assert-NextRouteBinding `
        -Binding $binding `
        -DescriptorSha256 $(if ($null -eq $descriptorSnapshot) { $null } else { $descriptorSnapshot.Sha256 })

    if ([string]$receipt.schema_version -cne 'work-charter-d54-launch-receipt/v1' -or
        [string]$receipt.campaign_id -cne $script:CampaignId -or
        [string]$receipt.phase -cne $Policy.Phase -or
        [string]$receipt.status -cne 'consumed' -or
        [string]$receipt.binding_sha256 -cne $bindingSnapshot.Sha256 -or
        [string]$receipt.dispatch_id -cne [string]$state.dispatch_id -or
        [string]$receipt.outer_capability_id_sha256 -cnotmatch '^[0-9a-f]{64}$' -or
        [string]$state.schema_version -cne 'work-charter-d54-dispatch-state/v1' -or
        [string]$state.campaign_id -cne $script:CampaignId -or
        [string]$state.phase -cne $Policy.Phase -or
        [string]$state.status -cne 'completed' -or
        [long]$state.child_exit_code -ne 0 -or
        [long]$state.next_dispatch_count -ne
            $(if ([string]::IsNullOrEmpty($Policy.NextPhase)) { 0 } else { 1 }) -or
        [string]$consumption.schema_version -cne 'work-charter-d54-receipt-consumption/v1' -or
        [string]$consumption.dispatch_id -cne [string]$receipt.dispatch_id -or
        [string]$consumption.phase -cne $Policy.Phase -or
        $consumptionSnapshot.Sha256 -cne $ExpectedConsumptionSha256 -or
        $state.receipt_consumed -isnot [bool] -or
        -not [bool]$state.receipt_consumed) {
        throw 'Model-phase completion does not bind the genuine outer receipt to its launch binding and dispatch state.'
    }
    if ($RequireLiveCampaignEvidence) {
        Assert-LiveCampaignPhaseEvidence -Policy $Policy
    }
}

function Get-TrustedOperation {
    param([Parameter(Mandatory)][string]$Id)

    $noLogoPrefix = @('-NoLogo', '-NoProfile', '-NonInteractive')
    $protocolAdapterCommand = '$line=$null; while($null -ne ($line=[Console]::In.ReadLine())){$r=$line|ConvertFrom-Json; if($r.method -ceq ''initialize''){$o=[ordered]@{id=$r.id;result=[ordered]@{userAgent=''d52-sim''}}}elseif($r.method -ceq ''initialized''){continue}elseif($r.method -ceq ''thread/start''){$o=[ordered]@{id=$r.id;result=[ordered]@{thread=[ordered]@{id=''d52-sim-thread''}}}}elseif($r.method -ceq ''turn/start''){$turnId=''d52-sim-turn-''+[string]$r.id;$o=[ordered]@{id=$r.id;result=[ordered]@{turn=[ordered]@{id=$turnId;status=''inProgress''}}};[Console]::Out.WriteLine(($o|ConvertTo-Json -Depth 10 -Compress));$o=[ordered]@{method=''turn/completed'';params=[ordered]@{threadId=''d52-sim-thread'';turn=[ordered]@{id=$turnId;status=''completed'';items=@()}}}}else{exit 92};[Console]::Out.WriteLine(($o|ConvertTo-Json -Depth 10 -Compress))};exit 0'
    $failedProtocolAdapterCommand = $protocolAdapterCommand.Replace(
        "status='completed'",
        "status='failed'"
    )
    $definition = switch ($Id) {
        'd52-test-powershell-outer-positive' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command',
                    "[Console]::Out.Write('CHILD_OUT'); [Console]::Error.Write('CHILD_ERR'); exit 0"
                ))
            }
        }
        'd52-test-powershell-next-positive' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command', "[Console]::Out.Write('NEXT_OUT'); exit 0"
                ))
            }
        }
        'd52-test-powershell-nonzero' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command',
                    "[Console]::Out.Write('NONZERO_OUT'); [Console]::Error.Write('NONZERO_ERR'); exit 37"
                ))
            }
        }
        'd52-test-powershell-snapshot' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command',
                    "Start-Sleep -Milliseconds 150; [Console]::Out.Write('BOUND_ARG'); exit 0"
                ))
            }
        }
        'd52-test-powershell-unexpected' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command', "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
                ))
            }
        }
        { $_ -in @(
            'd52-test-receipt-absent',
            'd52-test-receipt-stale',
            'd52-test-receipt-wrong-phase',
            'd52-test-receipt-wrong-hash',
            'd52-test-receipt-reused'
        ) } {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command', "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
                ))
            }
        }
        'd52-test-production-runner-binding' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command', "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
                ))
            }
        }
        'd52-test-protocol-adapter' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command', $protocolAdapterCommand
                ))
            }
        }
        'd52-test-protocol-failed-completion' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @($noLogoPrefix + @(
                    '-Command', $failedProtocolAdapterCommand
                ))
            }
        }
        'd52-powershell-version' {
            [pscustomobject]@{
                AnchorId = 'd52-powershell-current'
                Arguments = @('-Version')
            }
        }
        'd52-windows-whoami' {
            [pscustomobject]@{
                AnchorId = 'd52-windows-whoami'
                Arguments = [string[]]@()
            }
        }
        'd52-codex-version' {
            [pscustomobject]@{
                AnchorId = 'd52-codex-app-server-0.147.0-alpha.6.6'
                Arguments = @('--version')
            }
        }
        'd52-codex-app-server' {
            [pscustomobject]@{
                AnchorId = 'd52-codex-app-server-0.147.0-alpha.6.6'
                Arguments = @('app-server', '--stdio')
            }
        }
        default {
            throw "Child operation is not present in the tracked D52 operation table: $Id"
        }
    }
    return [pscustomobject]@{
        Id = $Id
        AnchorId = [string]$definition.AnchorId
        Arguments = [string[]]@($definition.Arguments)
    }
}

function Assert-TrustedOperation {
    param(
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$ExecutableAnchorId,
        [Parameter(Mandatory)][string]$Phase,
        [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$Arguments
    )

    $operation = Get-TrustedOperation -Id $OperationId
    if ((Test-IsAuthorizedProductionPhase -Phase $Phase) -and
        $OperationId -cne 'd52-codex-app-server') {
        throw 'Test and qualification operations are excluded from the committed D54 production policy.'
    }
    if ($operation.AnchorId -cne $ExecutableAnchorId) {
        throw 'Child operation executable anchor does not match the tracked operation table.'
    }
    if ($operation.Arguments.Count -ne $Arguments.Count) {
        throw 'Child argv does not match the tracked operation table.'
    }
    for ($index = 0; $index -lt $operation.Arguments.Count; $index++) {
        if ($operation.Arguments[$index] -cne $Arguments[$index]) {
            throw 'Child argv does not match the tracked operation table.'
        }
    }
}

function Test-HexIdentity {
    param(
        [AllowNull()][object]$Value,
        [Parameter(Mandatory)][int]$Length
    )

    return $null -ne $Value -and
        ([string]$Value) -cmatch "^[0-9a-f]{$Length}$"
}

function Assert-Binding {
    param(
        [Parameter(Mandatory)][object]$Binding,
        [Parameter(Mandatory)][string]$LauncherSha256,
        [Parameter(Mandatory)][string]$Phase,
        [Parameter(Mandatory)][int]$MaxAgeSeconds
    )

    if ([string]$Binding.schema_version -cne 'work-charter-d54-launch-binding/v1') {
        throw 'Launch binding schema is not supported.'
    }
    if ([string]$Binding.campaign_id -cne $script:CampaignId) {
        throw 'Launch binding campaign_id does not match the authorized D54 Campaign.'
    }
    if ([string]$Binding.stable_subject -cne $script:StableSubject) {
        throw 'Launch binding stable_subject does not match the authorized D54 subject.'
    }
    if ([string]$Binding.candidate_commit -cne $script:CandidateCommit) {
        throw 'Launch binding candidate_commit does not match the authorized D54 candidate.'
    }
    if ([string]$Binding.candidate_manifest_sha256 -cne $script:CandidateManifestSha256) {
        throw 'Launch binding candidate manifest does not match the authorized D54 candidate.'
    }
    if ([string]::IsNullOrWhiteSpace([string]$Binding.phase)) {
        throw 'Launch binding field is missing: phase'
    }
    if ([string]::IsNullOrWhiteSpace([string]$Binding.child_operation_id)) {
        throw 'Launch binding field is missing: child_operation_id'
    }
    if ([string]$Binding.phase -cne $Phase) {
        throw 'Launch binding phase does not match the requested phase.'
    }
    Assert-AuthorizationLifecycleArtifact `
        -Artifact $Binding `
        -Phase $Phase `
        -Purpose 'Launch binding'
    foreach ($field in @(
        'candidate_manifest_sha256',
        'authority_snapshot_sha256',
        'authority_snapshot_path_sha256',
        'carrier_manifest_sha256',
        'carrier_manifest_path_sha256',
        'launcher_sha256',
        'campaign_contract_sha256',
        'ruleset_sha256',
        'frozen_inputs_sha256',
        'frozen_inputs_path_sha256',
        'child_executable_sha256',
        'child_arguments_sha256',
        'child_working_directory_sha256',
        'next_dispatch_sha256'
    )) {
        if (-not (Test-HexIdentity -Value $Binding.$field -Length 64)) {
            throw "Launch binding hash is malformed: $field"
        }
    }
    if ([string]$Binding.launcher_sha256 -cne $LauncherSha256) {
        throw 'Launch binding does not identify this tracked runner revision.'
    }
    foreach ($field in @('launcher_commit', 'launcher_blob_oid')) {
        if ([string]$Binding.$field -cnotmatch '^(?:[0-9a-f]{40}|[0-9a-f]{64})$') {
            throw "Launch binding committed runner identity is malformed: $field"
        }
    }
    if ($null -eq $Binding.remaining_budget) {
        throw 'Launch binding remaining_budget is missing.'
    }
    foreach ($field in @('model_contexts', 'turn_starts')) {
        $value = $Binding.remaining_budget.$field
        if ($null -eq $value -or $value -isnot [long] -or [long]$value -lt 0) {
            throw "Launch binding remaining budget is malformed: $field"
        }
    }
    if ([long]$Binding.remaining_budget.model_contexts -gt 16 -or
        [long]$Binding.remaining_budget.turn_starts -gt 18) {
        throw 'Launch binding remaining budget exceeds the authorized D54 ceiling.'
    }
    if ($Phase -ceq $script:ZeroModelQualificationPhase -and
        ([long]$Binding.remaining_budget.model_contexts -ne 0 -or
         [long]$Binding.remaining_budget.turn_starts -ne 0 -or
         [string]$Binding.child_operation_id -notin @(
            'd52-codex-app-server',
            'd52-test-protocol-adapter',
            'd52-test-protocol-failed-completion'
         ) -or
         [string]$Binding.next_dispatch_sha256 -cne ('0' * 64))) {
        throw 'Zero-model app-server qualification must have zero model/turn budget and no next dispatch.'
    }
    if ($null -eq $Binding.receipt_max_age_seconds -or
        $Binding.receipt_max_age_seconds -isnot [long] -or
        [long]$Binding.receipt_max_age_seconds -ne $MaxAgeSeconds) {
        throw 'Launch binding receipt_max_age_seconds does not match the runner.'
    }
}

function Read-ArgumentVectorSnapshot {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Purpose
    )

    $snapshot = Read-JsonSnapshot -Path $Path -Purpose $Purpose
    $value = $snapshot.Value
    if ($value -isnot [System.Array]) {
        throw "$Purpose must contain one JSON array."
    }
    $arguments = [System.Collections.Generic.List[string]]::new()
    foreach ($entry in $value) {
        if ($entry -isnot [string]) {
            throw "$Purpose contains a non-string argument."
        }
        $arguments.Add([string]$entry)
    }
    return [pscustomobject]@{
        FullName = $snapshot.FullName
        Sha256 = $snapshot.Sha256
        Arguments = $arguments.ToArray()
    }
}

function Get-EffectiveWorkingDirectory {
    param(
        [Parameter(Mandatory)][string]$ExecutablePath,
        [AllowEmptyString()][string]$WorkingDirectory
    )

    if ([string]::IsNullOrWhiteSpace($WorkingDirectory)) {
        $resolved = Split-Path -Parent (
            Get-RootedPath -Path $ExecutablePath -Purpose 'child executable'
        )
    }
    else {
        $resolved = Get-RootedPath -Path $WorkingDirectory -Purpose 'child working directory'
    }
    return (
        Get-OrdinaryDirectory -Path $resolved -Purpose 'child working directory'
    ).FullName
}

function Assert-ChildRouteBinding {
    param(
        [Parameter(Mandatory)][object]$Binding,
        [Parameter(Mandatory)][string]$ExecutablePath,
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$ExecutableAnchorId,
        [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$Arguments,
        [Parameter(Mandatory)][string]$ArgumentsSha256,
        [AllowEmptyString()][string]$WorkingDirectory
    )

    $effectiveWorking = Get-EffectiveWorkingDirectory `
        -ExecutablePath $ExecutablePath `
        -WorkingDirectory $WorkingDirectory
    if ([string]$Binding.child_operation_id -cne $OperationId) {
        throw 'Child operation does not match the frozen launch binding.'
    }
    Assert-TrustedOperation `
        -OperationId $OperationId `
        -ExecutableAnchorId $ExecutableAnchorId `
        -Phase ([string]$Binding.phase) `
        -Arguments $Arguments
    if ([string]$Binding.child_executable_anchor_id -cne $ExecutableAnchorId) {
        throw 'Child executable anchor does not match the frozen launch binding.'
    }
    $anchor = Get-TrustedExecutableAnchor -Id $ExecutableAnchorId
    $requestedExecutable = (
        Get-OrdinaryFile -Path $ExecutablePath -Purpose 'child executable'
    ).FullName
    if (-not [string]::Equals(
        $requestedExecutable,
        $anchor.Path,
        [System.StringComparison]::OrdinalIgnoreCase
    )) {
        throw 'Child executable path does not match its authenticated trust anchor.'
    }
    if ((Get-FileSha256 -Path $ExecutablePath) -cne [string]$Binding.child_executable_sha256) {
        throw 'Child executable hash does not match the frozen launch binding.'
    }
    if ([string]$Binding.child_executable_sha256 -cne $anchor.Sha256) {
        throw 'Child executable hash does not match its authenticated trust anchor.'
    }
    if ($ArgumentsSha256 -cne [string]$Binding.child_arguments_sha256) {
        throw 'Child argv hash does not match the frozen launch binding.'
    }
    if ((Get-TextSha256 -Text $effectiveWorking) -cne
        [string]$Binding.child_working_directory_sha256) {
        throw 'Child working-directory hash does not match the frozen launch binding.'
    }
}

function Assert-NextRouteBinding {
    param(
        [Parameter(Mandatory)][object]$Binding,
        [AllowEmptyString()][string]$DescriptorSha256
    )

    $actualHash = if ([string]::IsNullOrWhiteSpace($DescriptorSha256)) {
        '0' * 64
    }
    else {
        $DescriptorSha256
    }
    if ($actualHash -cne [string]$Binding.next_dispatch_sha256) {
        throw 'Next dispatch hash does not match the frozen launch binding.'
    }
}

function Invoke-ExactProcess {
    param(
        [Parameter(Mandatory)][string]$ExecutablePath,
        [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$Arguments,
        [Parameter(Mandatory)][string]$WorkingDirectory,
        [string]$TrustedAnchorId,
        [hashtable]$Environment = @{},
        [string[]]$RemoveEnvironmentNames = @()
    )

    $executable = Get-OrdinaryFile -Path $ExecutablePath -Purpose 'child executable'
    if (-not [string]::IsNullOrWhiteSpace($TrustedAnchorId)) {
        $anchor = Get-TrustedExecutableAnchor -Id $TrustedAnchorId
        if (-not [string]::Equals(
            $executable.FullName,
            $anchor.Path,
            [System.StringComparison]::OrdinalIgnoreCase
        ) -or (Get-FileSha256 -Path $executable.FullName) -cne $anchor.Sha256) {
            throw 'Child executable changed after trust-anchor validation.'
        }
    }
    $working = Get-OrdinaryDirectory -Path $WorkingDirectory -Purpose 'child working directory'
    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $executable.FullName
    $startInfo.WorkingDirectory = $working.FullName
    $startInfo.UseShellExecute = $false
    $startInfo.CreateNoWindow = $true
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    foreach ($argument in $Arguments) {
        [void]$startInfo.ArgumentList.Add($argument)
    }
    foreach ($name in $RemoveEnvironmentNames) {
        [void]$startInfo.Environment.Remove($name)
    }
    foreach ($name in $Environment.Keys) {
        $startInfo.Environment[[string]$name] = [string]$Environment[$name]
    }

    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    try {
        if (-not $process.Start()) {
            throw 'Child process did not start.'
        }
        $stdoutTask = $process.StandardOutput.ReadToEndAsync()
        $stderrTask = $process.StandardError.ReadToEndAsync()
        $process.WaitForExit()
        $stdout = $stdoutTask.GetAwaiter().GetResult()
        $stderr = $stderrTask.GetAwaiter().GetResult()
        return [pscustomobject]@{
            Stdout = [string]$stdout
            Stderr = [string]$stderr
            ExitCode = [int]$process.ExitCode
        }
    }
    finally {
        $process.Dispose()
    }
}

function Assert-ZeroModelQualificationInput {
    param(
        [Parameter(Mandatory)][string]$Line,
        [Parameter(Mandatory)][int]$LineNumber
    )

    if ($LineNumber -ne 1) {
        throw 'Zero-model qualification accepts exactly one initialize request.'
    }
    try {
        $request = $Line | ConvertFrom-Json -Depth 20 -ErrorAction Stop
    }
    catch {
        throw 'Zero-model qualification input is not valid JSON.'
    }
    if ($null -eq $request -or $request -is [System.Array] -or
        [string]$request.method -cne 'initialize' -or
        [long]$request.id -ne 0 -or
        [string]$request.params.clientInfo.name -cne 'work-charter-d52-zero-model-qualification' -or
        [string]$request.params.clientInfo.version -cne '1.0.0') {
        throw 'Zero-model qualification permits only the tracked initialize request.'
    }
}

function Assert-ProductionAppServerInput {
    param(
        [Parameter(Mandatory)][string]$Line,
        [Parameter(Mandatory)][int]$LineNumber,
        [Parameter(Mandatory)][object]$Policy,
        [Parameter(Mandatory)][hashtable]$State
    )

    try {
        $request = $Line | ConvertFrom-Json -Depth 100 -ErrorAction Stop
    }
    catch {
        throw 'Production app-server input is not valid JSON.'
    }
    if ($null -eq $request -or $request -is [System.Array]) {
        throw 'Production app-server input must be one request object with an id.'
    }
    if ($null -ne $request.PSObject.Properties['d52_control']) {
        if ([string]$request.d52_control -cne 'phase_complete' -or
            [string]$request.phase -cne [string]$Policy.Phase -or
            $State.InitializeCount -ne 1 -or
            $State.InitializeResponseCount -ne 1 -or
            -not $State.InitializedNotificationSent -or
            $State.ThreadStartCount -ne 1 -or
            $State.ThreadStartResponseCount -ne 1 -or
            $State.TurnStartCount -ne [long]$Policy.TurnStarts -or
            $State.TurnCompletedCount -ne [long]$Policy.TurnStarts) {
            throw 'Production phase-complete control arrived before the committed request and successful-response budget completed.'
        }
        $State.PhaseComplete = $true
        return $false
    }
    if ($null -eq $request.PSObject.Properties['id']) {
        throw 'Production app-server input must be one request object with an id.'
    }
    if ($LineNumber -eq 1) {
        if ([string]$request.method -cne 'initialize' -or
            [string]$request.params.clientInfo.name -cne 'work-charter-d54-carrier' -or
            [string]$request.params.clientInfo.version -cne '1.0.0') {
            throw 'Production app-server input must begin with the committed D54 initialize request.'
        }
        $State.InitializeCount++
        $State.CurrentRequest = $request
        $State.CurrentRequestKind = 'initialize'
        return $true
    }
    if ($LineNumber -eq 2) {
        if ([string]$request.method -cne 'thread/start' -or
            [string]$request.params.model -cne [string]$Policy.Model -or
            $null -eq $request.params.PSObject.Properties['allowProviderModelFallback'] -or
            $request.params.allowProviderModelFallback -isnot [bool] -or
            [bool]$request.params.allowProviderModelFallback -ne $false) {
            throw 'Production thread/start does not match the committed D54 model policy.'
        }
        $State.ThreadStartCount++
        $State.CurrentRequest = $request
        $State.CurrentRequestKind = 'thread-start'
        return $true
    }
    if ([string]$request.method -cne 'turn/start' -or
        [string]$request.params.threadId -cne [string]$State.ThreadId -or
        [string]$request.params.model -cne [string]$Policy.Model -or
        [string]$request.params.effort -cne [string]$Policy.Effort -or
        @($request.params.input).Count -eq 0) {
        throw 'Production turn/start does not match the committed D54 model, effort, or input policy.'
    }
    $State.TurnStartCount++
    if ([long]$State.TurnStartCount -gt [long]$Policy.TurnStarts) {
        throw 'Production app-server input exceeds the committed D54 turn budget for this phase.'
    }
    $State.CurrentRequest = $request
    $State.CurrentRequestKind = 'turn-start'
    return $true
}

function Complete-ProductionAppServerRequest {
    param(
        [Parameter(Mandatory)][System.Diagnostics.Process]$Process,
        [Parameter(Mandatory)][object]$Request,
        [Parameter(Mandatory)]
        [ValidateSet('initialize', 'thread-start', 'turn-start')]
        [string]$RequestKind,
        [Parameter(Mandatory)][hashtable]$State,
        [Parameter(Mandatory)][int]$TimeoutMilliseconds
    )

    $responseSeen = $false
    $turnId = $null
    while ($true) {
        $lineTask = $Process.StandardOutput.ReadLineAsync()
        if (-not $lineTask.Wait($TimeoutMilliseconds)) {
            throw "Timed out waiting for the app-server $RequestKind result."
        }
        $line = $lineTask.GetAwaiter().GetResult()
        if ($null -eq $line) {
            throw "App-server stdout ended before the $RequestKind result completed."
        }
        [Console]::Out.WriteLine($line)
        [Console]::Out.Flush()
        try {
            $message = $line | ConvertFrom-Json -Depth 100 -ErrorAction Stop
        }
        catch {
            throw 'App-server stdout emitted non-JSON data on the protocol stream.'
        }
        if ($null -eq $message -or $message -is [System.Array]) {
            throw 'App-server stdout emitted an invalid protocol message.'
        }

        $idProperty = $message.PSObject.Properties['id']
        if ($null -ne $idProperty) {
            if ($responseSeen -or
                [string]$message.id -cne [string]$Request.id -or
                $null -ne $message.PSObject.Properties['method']) {
                throw 'App-server returned an unexpected or duplicate request response.'
            }
            $errorProperty = $message.PSObject.Properties['error']
            if ($null -ne $errorProperty -and $null -ne $errorProperty.Value) {
                throw "App-server returned an error for the $RequestKind request."
            }
            if ($null -eq $message.PSObject.Properties['result']) {
                throw "App-server omitted the result for the $RequestKind request."
            }
            $responseSeen = $true
            switch ($RequestKind) {
                'initialize' {
                    $State.InitializeResponseCount++
                    return
                }
                'thread-start' {
                    $threadId = [string]$message.result.thread.id
                    if ([string]::IsNullOrWhiteSpace($threadId)) {
                        throw 'App-server thread/start response omitted the thread identity.'
                    }
                    $State.ThreadId = $threadId
                    $State.ThreadStartResponseCount++
                    return
                }
                'turn-start' {
                    $turnId = [string]$message.result.turn.id
                    if ([string]::IsNullOrWhiteSpace($turnId) -or
                        [string]$message.result.turn.status -cne 'inProgress') {
                        throw 'App-server turn/start response omitted an in-progress turn identity.'
                    }
                }
            }
            continue
        }

        if ([string]$message.method -ceq 'error') {
            throw 'App-server emitted an error notification before successful turn completion.'
        }
        if ([string]$message.method -cne 'turn/completed') {
            continue
        }
        if ($RequestKind -cne 'turn-start' -or -not $responseSeen -or
            [string]$message.params.threadId -cne [string]$State.ThreadId -or
            [string]$message.params.turn.id -cne $turnId) {
            throw 'App-server emitted a turn/completed notification for an unexpected request.'
        }
        if ([string]$message.params.turn.status -cne 'completed') {
            throw 'App-server turn did not complete successfully.'
        }
        $State.TurnCompletedCount++
        return
    }
}

function Invoke-BidirectionalProcess {
    param(
        [Parameter(Mandatory)][string]$ExecutablePath,
        [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$Arguments,
        [Parameter(Mandatory)][string]$WorkingDirectory,
        [string]$TrustedAnchorId,
        [hashtable]$Environment = @{},
        [string[]]$RemoveEnvironmentNames = @(),
        [switch]$ValidateZeroModelQualificationInput,
        [AllowNull()][object]$ProductionPolicy
    )

    $executable = Get-OrdinaryFile -Path $ExecutablePath -Purpose 'child executable'
    if (-not [string]::IsNullOrWhiteSpace($TrustedAnchorId)) {
        $anchor = Get-TrustedExecutableAnchor -Id $TrustedAnchorId
        if (-not [string]::Equals(
            $executable.FullName,
            $anchor.Path,
            [System.StringComparison]::OrdinalIgnoreCase
        ) -or (Get-FileSha256 -Path $executable.FullName) -cne $anchor.Sha256) {
            throw 'Child executable changed after trust-anchor validation.'
        }
    }
    $working = Get-OrdinaryDirectory -Path $WorkingDirectory -Purpose 'child working directory'
    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $executable.FullName
    $startInfo.WorkingDirectory = $working.FullName
    $startInfo.UseShellExecute = $false
    $startInfo.CreateNoWindow = $true
    $startInfo.RedirectStandardInput = $true
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    foreach ($argument in $Arguments) {
        [void]$startInfo.ArgumentList.Add($argument)
    }
    foreach ($name in $RemoveEnvironmentNames) {
        [void]$startInfo.Environment.Remove($name)
    }
    foreach ($name in $Environment.Keys) {
        $startInfo.Environment[[string]$name] = [string]$Environment[$name]
    }

    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    $started = $false
    try {
        if (-not $process.Start()) {
            throw 'Child process did not start.'
        }
        $started = $true
        $stdoutTask = if ($null -eq $ProductionPolicy) {
            $process.StandardOutput.BaseStream.CopyToAsync(
                [Console]::OpenStandardOutput()
            )
        }
        else { $null }
        $stderrTask = $process.StandardError.BaseStream.CopyToAsync(
            [Console]::OpenStandardError()
        )
        $lineNumber = 0
        $productionState = @{
            InitializeCount = 0
            InitializeResponseCount = 0
            InitializedNotificationSent = $false
            ThreadStartCount = 0
            ThreadStartResponseCount = 0
            TurnStartCount = 0
            TurnCompletedCount = 0
            ThreadId = ''
            CurrentRequest = $null
            CurrentRequestKind = ''
            PhaseComplete = $false
        }
        while ($null -ne ($line = $script:SegmentInputReader.ReadLine())) {
            $lineNumber++
            if ($ValidateZeroModelQualificationInput) {
                Assert-ZeroModelQualificationInput -Line $line -LineNumber $lineNumber
            }
            $forwardLine = $true
            if ($null -ne $ProductionPolicy) {
                $forwardLine = Assert-ProductionAppServerInput `
                    -Line $line `
                    -LineNumber $lineNumber `
                    -Policy $ProductionPolicy `
                    -State $productionState
            }
            if ($forwardLine) {
                $process.StandardInput.WriteLine($line)
                $process.StandardInput.Flush()
                if ($null -ne $ProductionPolicy) {
                    Complete-ProductionAppServerRequest `
                        -Process $process `
                        -Request $productionState.CurrentRequest `
                        -RequestKind $productionState.CurrentRequestKind `
                        -State $productionState `
                        -TimeoutMilliseconds 7200000
                    if ($productionState.CurrentRequestKind -ceq 'initialize') {
                        $process.StandardInput.WriteLine('{"method":"initialized","params":{}}')
                        $process.StandardInput.Flush()
                        $productionState.InitializedNotificationSent = $true
                    }
                    $productionState.CurrentRequest = $null
                    $productionState.CurrentRequestKind = ''
                }
            }
            if ($null -ne $ProductionPolicy -and $productionState.PhaseComplete) {
                break
            }
        }
        if ($ValidateZeroModelQualificationInput -and $lineNumber -ne 1) {
            throw 'Zero-model qualification requires exactly one initialize request.'
        }
        if ($null -ne $ProductionPolicy -and
            ($productionState.InitializeCount -ne 1 -or
             $productionState.InitializeResponseCount -ne 1 -or
             -not $productionState.InitializedNotificationSent -or
             $productionState.ThreadStartCount -ne 1 -or
             $productionState.ThreadStartResponseCount -ne 1 -or
             $productionState.TurnStartCount -ne [long]$ProductionPolicy.TurnStarts -or
             $productionState.TurnCompletedCount -ne [long]$ProductionPolicy.TurnStarts -or
             -not $productionState.PhaseComplete)) {
            throw 'Production app-server input did not consume the exact committed D54 request and successful-response budget.'
        }
        if ($null -ne $ProductionPolicy) {
            $stdoutTask = $process.StandardOutput.BaseStream.CopyToAsync(
                [Console]::OpenStandardOutput()
            )
        }
        $process.StandardInput.Close()
        $timeoutMilliseconds = if ($ValidateZeroModelQualificationInput) { 30000 } else { 7200000 }
        if (-not $process.WaitForExit($timeoutMilliseconds)) {
            $process.Kill($true)
            $process.WaitForExit()
            throw 'Bidirectional child exceeded its bounded runtime.'
        }
        $stdoutTask.GetAwaiter().GetResult()
        $stderrTask.GetAwaiter().GetResult()
        return [pscustomobject]@{
            Stdout = ''
            Stderr = ''
            ExitCode = [int]$process.ExitCode
        }
    }
    finally {
        if ($started -and -not $process.HasExited) {
            $process.Kill($true)
            $process.WaitForExit()
        }
        $process.Dispose()
    }
}

function Write-ProcessStreams {
    param([Parameter(Mandatory)][object]$Result)

    if (-not [string]::IsNullOrEmpty([string]$Result.Stdout)) {
        [Console]::Out.Write([string]$Result.Stdout)
    }
    if (-not [string]::IsNullOrEmpty([string]$Result.Stderr)) {
        [Console]::Error.Write([string]$Result.Stderr)
    }
}

function Invoke-TestReceiptMutation {
    param(
        [Parameter(Mandatory)][string]$OperationId,
        [Parameter(Mandatory)][string]$ReceiptPath,
        [Parameter(Mandatory)][string]$StatePath
    )

    if ($OperationId -notlike 'd52-test-receipt-*') {
        return
    }
    $receipt = Read-JsonFile -Path $ReceiptPath -Purpose 'test launch receipt'
    switch ($OperationId) {
        'd52-test-receipt-absent' {
            Remove-Item -LiteralPath $ReceiptPath -Force
        }
        'd52-test-receipt-stale' {
            $receipt.issued_at_utc = [datetimeoffset]::UtcNow.AddHours(-1).ToString('O')
            Write-ExistingJsonFile -Path $ReceiptPath -Value $receipt -Purpose 'test launch receipt'
        }
        'd52-test-receipt-wrong-phase' {
            $receipt.phase = 'wrong-phase'
            Write-ExistingJsonFile -Path $ReceiptPath -Value $receipt -Purpose 'test launch receipt'
        }
        'd52-test-receipt-wrong-hash' {
            $receipt.binding_sha256 = '0' * 64
            Write-ExistingJsonFile -Path $ReceiptPath -Value $receipt -Purpose 'test launch receipt'
        }
        'd52-test-receipt-reused' {
            $receipt.status = 'consumed'
            $receipt.consumed_at_utc = [datetimeoffset]::UtcNow.ToString('O')
            Write-ExistingJsonFile -Path $ReceiptPath -Value $receipt -Purpose 'test launch receipt'
        }
    }
}

function Invoke-Inner {
    param([AllowNull()][object]$OuterCapability)

    if ($null -eq $OuterCapability -or
        $null -eq $script:OuterInnerCapability -or
        -not [object]::ReferenceEquals($OuterCapability, $script:OuterInnerCapability)) {
        throw 'Direct inner invocation is forbidden: no live outer object capability is present.'
    }
    $runnerPath = (Get-OrdinaryFile -Path $PSCommandPath -Purpose 'tracked runner').FullName
    Assert-ProductionArtifactPaths `
        -OperationId $ChildOperationId -Phase $ExpectedPhase `
        -Binding $BindingPath -Authority $AuthoritySnapshotPath `
        -Carrier $CarrierManifestPath -Frozen $FrozenInputsPath `
        -Receipt $ReceiptPath -State $DispatchStatePath `
        -Arguments $ChildArgumentsPath -WorkingDirectory $ChildWorkingDirectory `
        -NextDispatch $NextDispatchPath
    Assert-ProductionRoutePaths -OperationId $ChildOperationId -Phase $ExpectedPhase -Paths @(
        $BindingPath, $AuthoritySnapshotPath, $CarrierManifestPath,
        $FrozenInputsPath, $ReceiptPath, $DispatchStatePath, $ChildArgumentsPath
    )
    $launcherSha256 = Get-FileSha256 -Path $runnerPath
    $bindingSnapshot = Read-JsonSnapshot -Path $BindingPath -Purpose 'launch binding'
    $binding = $bindingSnapshot.Value
    $authoritySnapshot = Read-JsonSnapshot -Path $AuthoritySnapshotPath -Purpose 'authority snapshot'
    $carrierSnapshot = Read-JsonSnapshot -Path $CarrierManifestPath -Purpose 'carrier manifest'
    $frozenSnapshot = Read-JsonSnapshot -Path $FrozenInputsPath -Purpose 'frozen inputs'
    $childArgumentSnapshot = Read-ArgumentVectorSnapshot `
        -Path $ChildArgumentsPath `
        -Purpose 'child argv'
    Assert-Binding `
        -Binding $binding `
        -LauncherSha256 $launcherSha256 `
        -Phase $ExpectedPhase `
        -MaxAgeSeconds $ReceiptMaxAgeSeconds
    Assert-EvidenceSnapshots `
        -Binding $binding `
        -AuthoritySnapshot $authoritySnapshot `
        -CarrierSnapshot $carrierSnapshot `
        -FrozenSnapshot $frozenSnapshot `
        -OperationId $ChildOperationId `
        -Phase $ExpectedPhase
    Assert-ProductionRunnerIdentity `
        -RunnerPath $runnerPath `
        -Binding $binding `
        -Carrier $carrierSnapshot.Value `
        -OperationId $ChildOperationId `
        -Phase $ExpectedPhase
    Assert-ChildRouteBinding `
        -Binding $binding `
        -ExecutablePath $ChildExecutablePath `
        -OperationId $ChildOperationId `
        -ExecutableAnchorId $ChildExecutableAnchorId `
        -Arguments $childArgumentSnapshot.Arguments `
        -ArgumentsSha256 $childArgumentSnapshot.Sha256 `
        -WorkingDirectory $ChildWorkingDirectory

    $stateSnapshot = Read-JsonSnapshot -Path $DispatchStatePath -Purpose 'dispatch state'
    $state = $stateSnapshot.Value
    if ([string]$state.schema_version -cne 'work-charter-d54-dispatch-state/v1' -or
        [string]$state.status -cne 'receipt_issued' -or
        [string]$state.campaign_id -cne [string]$binding.campaign_id -or
        [string]$state.phase -cne $ExpectedPhase) {
        throw 'Dispatch state does not authorize this inner launch.'
    }

    $receiptSnapshot = Read-JsonSnapshot -Path $ReceiptPath -Purpose 'launch receipt'
    $receipt = $receiptSnapshot.Value
    if ([string]$receipt.schema_version -cne 'work-charter-d54-launch-receipt/v1' -or
        [string]$receipt.status -cne 'issued' -or
        [string]$receipt.campaign_id -cne [string]$binding.campaign_id) {
        throw 'Launch receipt is absent from the issued state or was already consumed.'
    }
    if ([string]$receipt.dispatch_id -cne [string]$state.dispatch_id -or
        [string]$receipt.phase -cne $ExpectedPhase) {
        throw 'Launch receipt dispatch or phase is mismatched.'
    }
    $bindingSha256 = $bindingSnapshot.Sha256
    if ([string]$receipt.binding_sha256 -cne $bindingSha256) {
        throw 'Launch receipt binding hash is mismatched.'
    }
    $issuedAt = [datetimeoffset]::MinValue
    if (-not [datetimeoffset]::TryParseExact(
        [string]$receipt.issued_at_utc,
        'O',
        [System.Globalization.CultureInfo]::InvariantCulture,
        [System.Globalization.DateTimeStyles]::RoundtripKind,
        [ref]$issuedAt
    )) {
        throw 'Launch receipt timestamp is malformed.'
    }
    $age = [datetimeoffset]::UtcNow - $issuedAt.ToUniversalTime()
    if ($age.TotalSeconds -lt -5 -or $age.TotalSeconds -gt $ReceiptMaxAgeSeconds) {
        throw 'Launch receipt is stale or from the future.'
    }

    if ((Get-TextSha256 -Text ([string]$OuterCapability.Id)) -cne
        [string]$receipt.outer_capability_id_sha256) {
        throw 'Outer object capability does not match the one-shot launch receipt.'
    }

    $consumeLockPath = (Get-RootedPath -Path $ReceiptPath -Purpose 'launch receipt') + '.consumed'
    Write-NewJsonFile -Path $consumeLockPath -Purpose 'receipt consumption claim' -Value ([ordered]@{
        schema_version = 'work-charter-d54-receipt-consumption/v1'
        dispatch_id = [string]$receipt.dispatch_id
        phase = $ExpectedPhase
        consumed_at_utc = [datetimeoffset]::UtcNow.ToString('O')
    })
    $receipt.status = 'consumed'
    $receipt.consumed_at_utc = [datetimeoffset]::UtcNow.ToString('O')
    Write-ExistingJsonFile -Path $ReceiptPath -Value $receipt -Purpose 'launch receipt'
    $state.status = 'inner_started'
    $state.receipt_consumed = $true
    Write-ExistingJsonFile -Path $DispatchStatePath -Value $state -Purpose 'dispatch state'

    $childArguments = $childArgumentSnapshot.Arguments
    $childWorking = Get-EffectiveWorkingDirectory `
        -ExecutablePath $ChildExecutablePath `
        -WorkingDirectory $ChildWorkingDirectory
    $childEnvironment = @{
            WORK_CHARTER_D52_VALIDATED_RECEIPT_PATH = (Get-RootedPath $ReceiptPath 'launch receipt')
            WORK_CHARTER_D52_DISPATCH_ID = [string]$receipt.dispatch_id
            WORK_CHARTER_D52_PHASE = $ExpectedPhase
            WORK_CHARTER_D52_BINDING_SHA256 = $bindingSha256
    }
    $productionPolicy = if ($ChildOperationId -in @(
        'd52-test-protocol-adapter',
        'd52-test-protocol-failed-completion'
    )) {
        if (Test-IsProtocolQualificationPhase -Phase $ExpectedPhase) {
            Get-ProtocolQualificationPhase -Phase $ExpectedPhase
        }
        else {
            Get-AuthorizedProductionPhase -Phase 'assessor-terra-high'
        }
    }
    elseif (Test-RequiresProductionAuthorization `
        -OperationId $ChildOperationId `
        -Phase $ExpectedPhase) {
        Get-AuthorizedProductionPhase -Phase $ExpectedPhase
    }
    else { $null }
    $childResult = if (Test-IsAppServerOperation -OperationId $ChildOperationId) {
        Invoke-BidirectionalProcess `
            -ExecutablePath $ChildExecutablePath `
            -Arguments $childArguments `
            -WorkingDirectory $childWorking `
            -TrustedAnchorId $ChildExecutableAnchorId `
            -Environment $childEnvironment `
            -ProductionPolicy $productionPolicy `
            -ValidateZeroModelQualificationInput:(
                Test-IsZeroModelAppServerQualification `
                    -OperationId $ChildOperationId `
                    -Phase $ExpectedPhase
            )
    }
    else {
        Invoke-ExactProcess `
            -ExecutablePath $ChildExecutablePath `
            -Arguments $childArguments `
            -WorkingDirectory $childWorking `
            -TrustedAnchorId $ChildExecutableAnchorId `
            -Environment $childEnvironment
    }
    Write-ProcessStreams -Result $childResult
    return [int]$childResult.ExitCode
}

function Invoke-Outer {
    $runnerPath = (Get-OrdinaryFile -Path $PSCommandPath -Purpose 'tracked runner').FullName
    if ($ChildOperationId -ceq 'd52-codex-app-server' -and
        -not (Test-IsZeroModelAppServerQualification -OperationId $ChildOperationId -Phase $ExpectedPhase)) {
        $policy = Get-AuthorizedProductionPhase -Phase $ExpectedPhase
        Assert-LiveCampaignDispatchAuthorization -Policy $policy
        if ($script:ProductionDispatchDepth -eq 0) {
            if ($policy.SegmentOrdinal -ne 1) {
                throw 'A top-level D54 dispatch must begin with the first phase of its lifecycle segment.'
            }
            Assert-CompleteProductionCarrier `
                -RunnerPath $runnerPath `
                -ExecutablePath $ChildExecutablePath `
                -ExecutableAnchorId $ChildExecutableAnchorId `
                -MaxAgeSeconds $ReceiptMaxAgeSeconds `
                -EntryPhase $ExpectedPhase
        }
    }
    Assert-ProductionArtifactPaths `
        -OperationId $ChildOperationId -Phase $ExpectedPhase `
        -Binding $BindingPath -Authority $AuthoritySnapshotPath `
        -Carrier $CarrierManifestPath -Frozen $FrozenInputsPath `
        -Receipt $ReceiptPath -State $DispatchStatePath `
        -Arguments $ChildArgumentsPath -WorkingDirectory $ChildWorkingDirectory `
        -NextDispatch $NextDispatchPath -ValidateNextDispatch
    Assert-ProductionRoutePaths -OperationId $ChildOperationId -Phase $ExpectedPhase -Paths @(
        $BindingPath, $AuthoritySnapshotPath, $CarrierManifestPath,
        $FrozenInputsPath, $ReceiptPath, $DispatchStatePath,
        $ChildArgumentsPath, $NextDispatchPath
    )
    if (Test-Path -LiteralPath (Get-RootedPath -Path $DispatchStatePath -Purpose 'dispatch state')) {
        throw 'Duplicate dispatch is forbidden: dispatch state already exists.'
    }
    if (Test-Path -LiteralPath (Get-RootedPath -Path $ReceiptPath -Purpose 'launch receipt')) {
        throw 'Launch receipt path must be absent before outer dispatch.'
    }

    $launcherSha256 = Get-FileSha256 -Path $runnerPath
    $bindingSnapshot = Read-JsonSnapshot -Path $BindingPath -Purpose 'launch binding'
    $binding = $bindingSnapshot.Value
    $authoritySnapshot = Read-JsonSnapshot -Path $AuthoritySnapshotPath -Purpose 'authority snapshot'
    $carrierSnapshot = Read-JsonSnapshot -Path $CarrierManifestPath -Purpose 'carrier manifest'
    $frozenSnapshot = Read-JsonSnapshot -Path $FrozenInputsPath -Purpose 'frozen inputs'
    $childArgumentSnapshot = Read-ArgumentVectorSnapshot `
        -Path $ChildArgumentsPath `
        -Purpose 'child argv'
    Assert-Binding `
        -Binding $binding `
        -LauncherSha256 $launcherSha256 `
        -Phase $ExpectedPhase `
        -MaxAgeSeconds $ReceiptMaxAgeSeconds
    Assert-EvidenceSnapshots `
        -Binding $binding `
        -AuthoritySnapshot $authoritySnapshot `
        -CarrierSnapshot $carrierSnapshot `
        -FrozenSnapshot $frozenSnapshot `
        -OperationId $ChildOperationId `
        -Phase $ExpectedPhase
    Assert-ProductionRunnerIdentity `
        -RunnerPath $runnerPath `
        -Binding $binding `
        -Carrier $carrierSnapshot.Value `
        -OperationId $ChildOperationId `
        -Phase $ExpectedPhase
    [void](Get-OrdinaryFile -Path $ChildExecutablePath -Purpose 'child executable')
    Assert-ChildRouteBinding `
        -Binding $binding `
        -ExecutablePath $ChildExecutablePath `
        -OperationId $ChildOperationId `
        -ExecutableAnchorId $ChildExecutableAnchorId `
        -Arguments $childArgumentSnapshot.Arguments `
        -ArgumentsSha256 $childArgumentSnapshot.Sha256 `
        -WorkingDirectory $ChildWorkingDirectory

    $nextConfigured = -not [string]::IsNullOrWhiteSpace($NextDispatchPath)
    $nextDispatch = $null
    $nextDispatchSnapshot = $null
    if ($nextConfigured) {
        $nextDispatchSnapshot = Read-JsonSnapshot `
            -Path $NextDispatchPath `
            -Purpose 'next dispatch descriptor'
        $nextDispatch = $nextDispatchSnapshot.Value
        if ([string]$nextDispatch.schema_version -cne 'work-charter-d54-next-dispatch/v1') {
            throw 'Next dispatch descriptor schema is not supported.'
        }
        foreach ($field in @(
            'binding_path',
            'authority_snapshot_path',
            'carrier_manifest_path',
            'frozen_inputs_path',
            'receipt_path',
            'dispatch_state_path',
            'expected_phase',
            'child_executable_path',
            'child_operation_id',
            'child_executable_anchor_id',
            'child_arguments_path'
        )) {
            if ([string]::IsNullOrWhiteSpace([string]$nextDispatch.$field)) {
                throw "Next dispatch descriptor field is missing: $field"
            }
        }
    }
    Assert-AuthorizedNextDispatch `
        -OperationId $ChildOperationId `
        -Phase $ExpectedPhase `
        -Descriptor $nextDispatch
    Assert-NextRouteBinding `
        -Binding $binding `
        -DescriptorSha256 $(if ($nextConfigured) { $nextDispatchSnapshot.Sha256 } else { $null })

    $dispatchId = [guid]::NewGuid().ToString('D')
    $outerCapability = [pscustomobject]@{
        Id = [System.Convert]::ToBase64String(
            [System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32)
        )
    }
    $issuedAt = [datetimeoffset]::UtcNow.ToString('O')
    $state = [ordered]@{
        schema_version = 'work-charter-d54-dispatch-state/v1'
        dispatch_id = $dispatchId
        campaign_id = [string]$binding.campaign_id
        phase = $ExpectedPhase
        status = 'claimed'
        receipt_consumed = $false
        child_exit_code = $null
        next_dispatch_count = 0
        next_exit_code = $null
    }
    Write-NewJsonFile -Path $DispatchStatePath -Value $state -Purpose 'dispatch state'
    $receipt = [ordered]@{
        schema_version = 'work-charter-d54-launch-receipt/v1'
        dispatch_id = $dispatchId
        campaign_id = [string]$binding.campaign_id
        phase = $ExpectedPhase
        binding_sha256 = $bindingSnapshot.Sha256
        outer_capability_id_sha256 = Get-TextSha256 -Text ([string]$outerCapability.Id)
        issued_at_utc = $issuedAt
        status = 'issued'
        consumed_at_utc = $null
    }
    Write-NewJsonFile -Path $ReceiptPath -Value $receipt -Purpose 'launch receipt'
    $state.status = 'receipt_issued'
    Write-ExistingJsonFile -Path $DispatchStatePath -Value $state -Purpose 'dispatch state'
    Invoke-TestReceiptMutation `
        -OperationId $ChildOperationId `
        -ReceiptPath $ReceiptPath `
        -StatePath $DispatchStatePath

    $previousCapability = $script:OuterInnerCapability
    $script:OuterInnerCapability = $outerCapability
    try {
        $innerExitCode = [int](Invoke-Inner -OuterCapability $outerCapability)
    }
    finally {
        $script:OuterInnerCapability = $previousCapability
    }
    $innerResult = [pscustomobject]@{ Stdout = ''; Stderr = ''; ExitCode = $innerExitCode }

    $state = Read-JsonFile -Path $DispatchStatePath -Purpose 'dispatch state'
    $state.child_exit_code = [int]$innerResult.ExitCode
    if ($innerResult.ExitCode -ne 0) {
        $state.status = 'child_failed'
        Write-ExistingJsonFile -Path $DispatchStatePath -Value $state -Purpose 'dispatch state'
        return [int]$innerResult.ExitCode
    }

    if ($nextConfigured) {
        if ([int]$state.next_dispatch_count -ne 0) {
            throw 'Exactly-once next-phase dispatch was already consumed.'
        }
        $state.next_dispatch_count = 1
        $state.status = 'next_started'
        Write-ExistingJsonFile -Path $DispatchStatePath -Value $state -Purpose 'dispatch state'
        $nextArguments = [System.Collections.Generic.List[string]]::new()
        foreach ($argument in @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-File', $runnerPath,
            '-Mode', 'Outer',
            '-BindingPath', (Get-RootedPath ([string]$nextDispatch.binding_path) 'next binding'),
            '-AuthoritySnapshotPath', (Get-RootedPath ([string]$nextDispatch.authority_snapshot_path) 'next authority snapshot'),
            '-CarrierManifestPath', (Get-RootedPath ([string]$nextDispatch.carrier_manifest_path) 'next carrier manifest'),
            '-FrozenInputsPath', (Get-RootedPath ([string]$nextDispatch.frozen_inputs_path) 'next frozen inputs'),
            '-ReceiptPath', (Get-RootedPath ([string]$nextDispatch.receipt_path) 'next receipt'),
            '-DispatchStatePath', (Get-RootedPath ([string]$nextDispatch.dispatch_state_path) 'next dispatch state'),
            '-ExpectedPhase', [string]$nextDispatch.expected_phase,
            '-ChildExecutablePath', (Get-RootedPath ([string]$nextDispatch.child_executable_path) 'next child executable'),
            '-ChildOperationId', [string]$nextDispatch.child_operation_id,
            '-ChildExecutableAnchorId', [string]$nextDispatch.child_executable_anchor_id,
            '-ChildArgumentsPath', (Get-RootedPath ([string]$nextDispatch.child_arguments_path) 'next child argv'),
            '-ReceiptMaxAgeSeconds', [string]$ReceiptMaxAgeSeconds
        )) {
            $nextArguments.Add([string]$argument)
        }
        if (-not [string]::IsNullOrWhiteSpace([string]$nextDispatch.child_working_directory)) {
            $nextArguments.Add('-ChildWorkingDirectory')
            $nextArguments.Add((Get-RootedPath ([string]$nextDispatch.child_working_directory) 'next child working directory'))
        }
        if (-not [string]::IsNullOrWhiteSpace([string]$nextDispatch.next_dispatch_path)) {
            $nextArguments.Add('-NextDispatchPath')
            $nextArguments.Add((Get-RootedPath ([string]$nextDispatch.next_dispatch_path) 'following dispatch descriptor'))
        }
        foreach ($argument in @(
            '-RootContractPath', $script:RootContractPath,
            '-RootContractSha256', $script:RootContractSha256,
            '-RepositoryRoot', $script:RepositoryRoot,
            '-CampaignRoot', $script:CampaignRoot,
            '-CarrierRoot', $script:PrivateCarrierRoot,
            '-SourceBundleRoot', $script:SourceBundleRoot,
            '-EvidenceRoot', $script:EvidenceRoot,
            '-D53PredecessorRoot', [string]$script:PredecessorRoots[0],
            '-D49PredecessorRoot', [string]$script:PredecessorRoots[1]
        )) {
            $nextArguments.Add([string]$argument)
        }
        $nextResult = if ($ChildOperationId -in @(
            'd52-codex-app-server',
            'd52-test-protocol-adapter'
        )) {
            $nextExitCode = & {
                param(
                    $BindingPath, $AuthoritySnapshotPath, $CarrierManifestPath,
                    $FrozenInputsPath, $ReceiptPath, $DispatchStatePath,
                    $ExpectedPhase, $ChildExecutablePath, $ChildOperationId,
                    $ChildExecutableAnchorId, $ChildArgumentsPath,
                    $ChildWorkingDirectory, $NextDispatchPath
                )
                $script:ProductionDispatchDepth++
                try {
                    return [int](Invoke-Outer)
                }
                finally {
                    $script:ProductionDispatchDepth--
                }
            } `
                (Get-RootedPath ([string]$nextDispatch.binding_path) 'next binding') `
                (Get-RootedPath ([string]$nextDispatch.authority_snapshot_path) 'next authority snapshot') `
                (Get-RootedPath ([string]$nextDispatch.carrier_manifest_path) 'next carrier manifest') `
                (Get-RootedPath ([string]$nextDispatch.frozen_inputs_path) 'next frozen inputs') `
                (Get-RootedPath ([string]$nextDispatch.receipt_path) 'next receipt') `
                (Get-RootedPath ([string]$nextDispatch.dispatch_state_path) 'next dispatch state') `
                ([string]$nextDispatch.expected_phase) `
                (Get-RootedPath ([string]$nextDispatch.child_executable_path) 'next child executable') `
                ([string]$nextDispatch.child_operation_id) `
                ([string]$nextDispatch.child_executable_anchor_id) `
                (Get-RootedPath ([string]$nextDispatch.child_arguments_path) 'next child argv') `
                (Get-RootedPath ([string]$nextDispatch.child_working_directory) 'next child working directory') `
                $(if ([string]::IsNullOrWhiteSpace([string]$nextDispatch.next_dispatch_path)) {
                    ''
                }
                else {
                    Get-RootedPath ([string]$nextDispatch.next_dispatch_path) 'following dispatch descriptor'
                })
            [pscustomobject]@{ Stdout = ''; Stderr = ''; ExitCode = [int]$nextExitCode }
        }
        else {
            $powershellAnchor = Get-TrustedExecutableAnchor -Id 'd52-powershell-current'
            Invoke-ExactProcess `
                -ExecutablePath $powershellAnchor.Path `
                -Arguments $nextArguments.ToArray() `
                -WorkingDirectory (Split-Path -Parent $runnerPath) `
                -TrustedAnchorId 'd52-powershell-current'
        }
        if ($ChildOperationId -cne 'd52-codex-app-server') {
            Write-ProcessStreams -Result $nextResult
        }
        $state = Read-JsonFile -Path $DispatchStatePath -Purpose 'dispatch state'
        $state.next_exit_code = [int]$nextResult.ExitCode
        $state.status = if ($nextResult.ExitCode -eq 0) { 'completed' } else { 'next_failed' }
        Write-ExistingJsonFile -Path $DispatchStatePath -Value $state -Purpose 'dispatch state'
        return [int]$nextResult.ExitCode
    }

    $state.status = 'completed'
    Write-ExistingJsonFile -Path $DispatchStatePath -Value $state -Purpose 'dispatch state'
    return 0
}

function Complete-LiveCampaignSegment {
    param([Parameter(Mandatory)][ValidateSet('canary', 'product', 'assessor')][string]$Segment)

    $controller = Get-LiveCampaignController
    if ([string]$controller.CurrentSegment -cne $Segment -or
        [string]$controller.NextSegment -cne $Segment -or
        $controller.CompletedSegments.Contains($Segment)) {
        throw 'Live Campaign segment completion is duplicated or out of order.'
    }
    $runnerPath = (Get-OrdinaryFile -Path $PSCommandPath -Purpose 'tracked runner').FullName
    foreach ($policy in @(Get-AuthorizedProductionPhases | Where-Object {
        $_.Segment -ceq $Segment
    })) {
        $phaseRoot = Get-ProductionPhaseRoot -Policy $policy
        $receiptSnapshot = Read-JsonSnapshot `
            -Path (Join-Path $phaseRoot 'receipt.json') `
            -Purpose 'live segment outer receipt'
        $stateSnapshot = Read-JsonSnapshot `
            -Path (Join-Path $phaseRoot 'dispatch-state.json') `
            -Purpose 'live segment dispatch state'
        $consumptionSha256 = Get-FileSha256 `
            -Path ((Join-Path $phaseRoot 'receipt.json') + '.consumed')
        Assert-CompletedModelOuterDispatch `
            -RunnerPath $runnerPath `
            -PhaseRoot $phaseRoot `
            -Policy $policy `
            -ReceiptSnapshot $receiptSnapshot `
            -StateSnapshot $stateSnapshot `
            -ExpectedConsumptionSha256 $consumptionSha256 `
            -MaxAgeSeconds $ReceiptMaxAgeSeconds `
            -RequireLiveCampaignEvidence:$false
        $controller.PhaseEvidence.Add(
            [string]$policy.Phase,
            (Get-LiveCampaignPhaseFingerprint -Policy $policy)
        )
    }
    if (-not $controller.CompletedSegments.Add($Segment)) {
        throw 'Live Campaign segment completion could not be claimed exactly once.'
    }
    $controller.NextSegment = switch ($Segment) {
        'canary' { 'product' }
        'product' { 'assessor' }
        'assessor' { 'terminal' }
    }
}

function Invoke-LiveCampaignSegment {
    param([Parameter(Mandatory)][ValidateSet('canary', 'product', 'assessor')][string]$Segment)

    $policy = @(
        Get-AuthorizedProductionPhases | Where-Object {
            $_.Segment -ceq $Segment -and $_.SegmentOrdinal -eq 1
        }
    )
    if ($policy.Count -ne 1) {
        throw "Live Campaign segment has no exact first phase: $Segment"
    }
    $policy = $policy[0]
    $phaseRoot = Get-ProductionPhaseRoot -Policy $policy
    $anchor = Get-TrustedExecutableAnchor -Id 'd52-codex-app-server-0.147.0-alpha.6.6'
    $nextPath = if ([string]::IsNullOrEmpty([string]$policy.NextPhase)) { '' } else {
        Join-Path $phaseRoot 'next-dispatch.json'
    }
    return [int](& {
        param(
            $BindingPath, $AuthoritySnapshotPath, $CarrierManifestPath,
            $FrozenInputsPath, $ReceiptPath, $DispatchStatePath,
            $ExpectedPhase, $ChildExecutablePath, $ChildOperationId,
            $ChildExecutableAnchorId, $ChildArgumentsPath,
            $ChildWorkingDirectory, $NextDispatchPath
        )
        return [int](Invoke-Outer)
    } `
        (Join-Path $phaseRoot 'binding.json') `
        (Join-Path $phaseRoot 'authority-snapshot.json') `
        (Join-Path $phaseRoot 'carrier-manifest.json') `
        (Join-Path $phaseRoot 'frozen-inputs.json') `
        (Join-Path $phaseRoot 'receipt.json') `
        (Join-Path $phaseRoot 'dispatch-state.json') `
        ([string]$policy.Phase) `
        ([string]$anchor.Path) `
        'd52-codex-app-server' `
        ([string]$anchor.Id) `
        (Join-Path $phaseRoot 'child-argv.json') `
        $phaseRoot `
        $nextPath)
}

function Read-LiveCampaignCommand {
    $line = $script:SegmentInputReader.ReadLine()
    if ($null -eq $line) {
        throw 'Live Campaign controller input ended before a terminal command.'
    }
    try {
        $command = $line | ConvertFrom-Json -Depth 20 -DateKind String -NoEnumerate
    }
    catch {
        throw "Live Campaign command is not strict JSON: $($_.Exception.Message)"
    }
    if ([string]$command.schema_version -cne 'work-charter-d54-campaign-command/v1' -or
        [string]$command.command -notin @('dispatch_segment', 'validate_terminal')) {
        throw 'Live Campaign command schema or operation is not supported.'
    }
    $propertyNames = @($command.PSObject.Properties.Name)
    $expectedNames = if ([string]$command.command -ceq 'dispatch_segment') {
        @('schema_version', 'command', 'segment')
    }
    else { @('schema_version', 'command') }
    if ($propertyNames.Count -ne $expectedNames.Count -or
        @(Compare-Object -ReferenceObject $expectedNames -DifferenceObject $propertyNames).Count -ne 0) {
        throw 'Live Campaign command fields are not exact.'
    }
    if ([string]$command.command -ceq 'dispatch_segment' -and
        [string]$command.segment -notin @('canary', 'product', 'assessor')) {
        throw 'Live Campaign segment command is not authorized.'
    }
    return $command
}

function Write-LiveCampaignControlResult {
    param(
        [Parameter(Mandatory)][string]$Event,
        [AllowEmptyString()][string]$Segment = '',
        [int]$ExitCode = 0
    )

    [ordered]@{
        schema_version = 'work-charter-d54-campaign-control-result/v1'
        event = $Event
        segment = $Segment
        exit_code = $ExitCode
    } | ConvertTo-Json -Depth 10 -Compress | ForEach-Object {
        [Console]::Out.WriteLine($_)
    }
}

function Assert-LiveCampaignFailureTerminal {
    $controller = Get-LiveCampaignController
    if ([string]::IsNullOrEmpty([string]$controller.FailedSegment)) {
        return
    }
    $terminal = Read-JsonFile `
        -Path (Join-Path $script:EvidenceRoot 'd54-terminal.json') `
        -Purpose 'live failed-segment terminal receipt'
    $expected = switch ([string]$controller.FailedSegment) {
        'canary' {
            [pscustomobject]@{
                PreviousState = 'CANARY_AUTHORIZED_AFTER_QUALIFICATION'
                Disposition = 'CANARY_FAILED / PRODUCT_UNKNOWN'
            }
        }
        'product' {
            [pscustomobject]@{
                PreviousState = 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
                Disposition = 'PRODUCT_FAILED / NOT_ACCEPTED'
            }
        }
        'assessor' {
            [pscustomobject]@{
                PreviousState = 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
                Disposition = 'ASSESSOR_FAILED / NOT_ACCEPTED'
            }
        }
    }
    if ($null -eq $expected -or
        [string]$terminal.previous_state -cne [string]$expected.PreviousState -or
        [string]$terminal.terminal_disposition -cne [string]$expected.Disposition) {
        throw 'D54 terminal receipt does not match the live failed Campaign segment.'
    }
}

function Invoke-CampaignController {
    $controller = [pscustomobject]@{
        Guard = [object]::new()
        Active = $true
        CurrentSegment = ''
        NextSegment = 'canary'
        CompletedSegments = [System.Collections.Generic.HashSet[string]]::new(
            [System.StringComparer]::Ordinal
        )
        PhaseEvidence = [System.Collections.Generic.Dictionary[string,string]]::new(
            [System.StringComparer]::Ordinal
        )
        FailedSegment = ''
        FailedExitCode = $null
    }
    if ($null -ne $script:ActiveCampaignController) {
        throw 'A live D54 Campaign controller already exists in this process.'
    }
    $script:ActiveCampaignController = $controller
    try {
        while ($true) {
            $command = Read-LiveCampaignCommand
            if ([string]$command.command -ceq 'validate_terminal') {
                if ([string]$controller.NextSegment -cne 'terminal') {
                    throw 'Live Campaign terminal validation requires a recorded segment failure or all segments completed.'
                }
                Assert-LifecycleTransitionEvidence `
                    -EvidenceRoot $script:EvidenceRoot `
                    -State 'TERMINAL' `
                    -RunnerPath $PSCommandPath `
                    -RequireActionProvenance
                Assert-LiveCampaignFailureTerminal
                $terminalExitCode = 0
                if (-not [string]::IsNullOrEmpty([string]$controller.FailedSegment)) {
                    if ($controller.FailedExitCode -isnot [int] -or
                        [int]$controller.FailedExitCode -eq 0) {
                        throw 'Live Campaign failed segment has no typed nonzero child exit.'
                    }
                    $terminalExitCode = [int]$controller.FailedExitCode
                }
                Write-LiveCampaignControlResult `
                    -Event 'terminal_validated' `
                    -ExitCode $terminalExitCode
                return $terminalExitCode
            }
            $segment = [string]$command.segment
            if ([string]$controller.NextSegment -cne $segment) {
                throw "Live Campaign segment order requires $($controller.NextSegment), not $segment."
            }
            $controller.CurrentSegment = $segment
            try {
                $exitCode = Invoke-LiveCampaignSegment -Segment $segment
                if ($exitCode -eq 0) {
                    Complete-LiveCampaignSegment -Segment $segment
                }
            }
            finally {
                $controller.CurrentSegment = ''
            }
            if ($exitCode -ne 0) {
                if (-not [string]::IsNullOrEmpty([string]$controller.FailedSegment)) {
                    throw 'Live Campaign cannot record more than one failed segment.'
                }
                $controller.FailedSegment = $segment
                $controller.FailedExitCode = [int]$exitCode
                $controller.NextSegment = 'terminal'
                Write-LiveCampaignControlResult `
                    -Event 'segment_failed' `
                    -Segment $segment `
                    -ExitCode ([int]$exitCode)
                continue
            }
            Write-LiveCampaignControlResult -Event 'segment_completed' -Segment $segment
        }
    }
    finally {
        $controller.Active = $false
        $script:ActiveCampaignController = $null
    }
}

try {
    Initialize-D54ExplicitRootContract
    if ($Mode -ceq 'Campaign') {
        Assert-CampaignParameters
        exit ([int](Invoke-CampaignController))
    }
    if ($Mode -ceq 'DescribeLifecycle') {
        Get-AuthorizationLifecycleEnvelope -Phase $ExpectedPhase | ConvertTo-Json -Depth 100
        exit 0
    }
    if ($Mode -ceq 'ValidateLifecycle') {
        if ([string]::IsNullOrWhiteSpace($LifecycleEvidenceRoot) -or
            [string]::IsNullOrWhiteSpace($ExpectedLifecycleState)) {
            throw 'ValidateLifecycle requires LifecycleEvidenceRoot and ExpectedLifecycleState.'
        }
        Assert-LifecycleTransitionEvidence `
            -EvidenceRoot $LifecycleEvidenceRoot `
            -State $ExpectedLifecycleState `
            -RunnerPath $PSCommandPath `
            -RequireActionProvenance:$RequireActionProvenance
        if ($ExpectedPhase -ceq 'assessor-terra-high') {
            Assert-AssessorEligibility -EvidenceRoot $LifecycleEvidenceRoot
        }
        [ordered]@{
            schema_version = 'work-charter-d54-lifecycle-validation/v1'
            campaign_id = $script:CampaignId
            state = $ExpectedLifecycleState
            authorization_lifecycle_policy_sha256 = Get-AuthorizationLifecyclePolicySha256
            action_authority = $false
            verdict = 'PASS'
        } | ConvertTo-Json -Depth 10
        exit 0
    }
    Assert-ExecutionParameters
    $exitCode = if ($Mode -ceq 'Inner') { Invoke-Inner } else { Invoke-Outer }
    exit ([int]$exitCode)
}
catch {
    [Console]::Error.WriteLine("D54_RUNNER_REJECTED: $($_.Exception.Message)")
    exit $script:RunnerFailureExitCode
}
