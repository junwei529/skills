[CmdletBinding()]
param(
    [ValidateSet('Outer', 'Inner')]
    [string]$Mode = 'Outer',

    [Parameter(Mandatory)]
    [string]$BindingPath,

    [Parameter(Mandatory)]
    [string]$AuthoritySnapshotPath,

    [Parameter(Mandatory)]
    [string]$CarrierManifestPath,

    [Parameter(Mandatory)]
    [string]$FrozenInputsPath,

    [Parameter(Mandatory)]
    [string]$ReceiptPath,

    [Parameter(Mandatory)]
    [string]$DispatchStatePath,

    [Parameter(Mandatory)]
    [string]$ExpectedPhase,

    [Parameter(Mandatory)]
    [string]$ChildExecutablePath,

    [Parameter(Mandatory)]
    [string]$ChildOperationId,

    [Parameter(Mandatory)]
    [ValidateSet(
        'd52-powershell-current',
        'd52-windows-whoami',
        'd52-codex-app-server-0.147.0-alpha.6.6',
        'd52-git-2.54.0.windows.1'
    )]
    [string]$ChildExecutableAnchorId,

    [Parameter(Mandatory)]
    [string]$ChildArgumentsPath,

    [string]$ChildWorkingDirectory,

    [string]$NextDispatchPath,

    [ValidateRange(1, 3600)]
    [int]$ReceiptMaxAgeSeconds = 300
)

$ErrorActionPreference = 'Stop'
$script:RunnerFailureExitCode = 86
$script:StrictUtf8 = [System.Text.UTF8Encoding]::new($false, $true)
$script:CampaignId = 'WC-AR-D52-TRACKED-OUTER-DISPATCH'
$script:StableSubject = 'Work Charter v0.2.0 exact candidate'
$script:CandidateCommit = 'c4810057c3f28cca9f12004ca2018784cd21f449'
$script:CandidateManifestSha256 = '04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44'
$script:RepositoryRoot = Split-Path -Parent $PSScriptRoot
$script:UserProfileRoot = $env:USERPROFILE
$script:CampaignContractPath = Join-Path $script:RepositoryRoot `
    'docs\decisions\0018-work-charter-adoption-levels-and-reentry-checkpoint.md'
$script:PrivateCarrierRoot = Join-Path $script:RepositoryRoot `
    '.eval-runs\work-charter-v0.2-c481005-gate2-d52-single-entry'
$script:RunnerRepositoryPath = 'evals/invoke-work-charter-gate2.ps1'
$script:ZeroModelQualificationPhase = 'runner-zero-model-qualification'
$script:ProductionDispatchDepth = 0
$script:OuterInnerCapability = $null
$script:RulesetSources = @(
    [pscustomobject]@{
        Locator = '~/.codex/AGENTS.md'
        Path = Join-Path $script:UserProfileRoot '.codex\AGENTS.md'
        Sha256 = 'fefaad2225dfefc0a4e8048c1fe9ba744035ab101c11851954bcf432b1691be1'
    },
    [pscustomobject]@{
        Locator = 'AGENTS.md'
        Path = Join-Path $script:RepositoryRoot 'AGENTS.md'
        Sha256 = '3e045e9bdc3e07f200b9080ffee0198ae5c5829fd325585046c779bfff7a96d5'
    },
    [pscustomobject]@{
        Locator = '~/.codex/skills/work-charter/SKILL.md'
        Path = Join-Path $script:UserProfileRoot '.codex\skills\work-charter\SKILL.md'
        Sha256 = 'd0c86e80d6f8eec0d91c25f4f0c687d60b1e0821ac823e28cf62777bb1badda2'
    },
    [pscustomobject]@{
        Locator = '~/.codex/skills/work-charter/references/coordination-and-recovery.md'
        Path = Join-Path $script:UserProfileRoot `
            '.codex\skills\work-charter\references\coordination-and-recovery.md'
        Sha256 = '8c944b3434e14e70dea705a8b877b70b497c6f512db8681ff0000f418a270483'
    },
    [pscustomobject]@{
        Locator = '~/.codex/reference/codex-usage-guidance.md'
        Path = Join-Path $script:UserProfileRoot '.codex\reference\codex-usage-guidance.md'
        Sha256 = '8139fa6765e0fe7a2972b84a8cb370df386e28736d16228a07780625f7888383'
    }
)

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
        @('canary-sol-high', 'gpt-5.6-sol', 'high', 1),
        @('canary-sol-xhigh', 'gpt-5.6-sol', 'xhigh', 1),
        @('canary-terra-high', 'gpt-5.6-terra', 'high', 1),
        @('candidate-calibration', 'gpt-5.6-sol', 'high', 2),
        @('released-control-a18', 'gpt-5.6-sol', 'high', 2),
        @('candidate-a19', 'gpt-5.6-sol', 'high', 1),
        @('candidate-a20', 'gpt-5.6-sol', 'high', 1),
        @('candidate-b01', 'gpt-5.6-sol', 'xhigh', 1),
        @('candidate-b02', 'gpt-5.6-sol', 'xhigh', 1),
        @('candidate-b03', 'gpt-5.6-sol', 'xhigh', 1),
        @('candidate-b04', 'gpt-5.6-sol', 'xhigh', 1),
        @('candidate-c01', 'gpt-5.6-terra', 'high', 1),
        @('candidate-c02', 'gpt-5.6-terra', 'high', 1),
        @('candidate-c03', 'gpt-5.6-terra', 'high', 1),
        @('candidate-c04', 'gpt-5.6-terra', 'high', 1),
        @('assessor-terra-high', 'gpt-5.6-terra', 'high', 1)
    )
    $remainingContexts = 16
    $remainingTurns = 18
    $result = [System.Collections.Generic.List[object]]::new()
    for ($index = 0; $index -lt $definitions.Count; $index++) {
        $definition = $definitions[$index]
        $phase = [string]$definition[0]
        $nextPhase = if ($index + 1 -lt $definitions.Count) {
            [string]$definitions[$index + 1][0]
        }
        else { '' }
        $result.Add([pscustomobject]@{
            Ordinal = $index + 1
            Phase = $phase
            Model = [string]$definition[1]
            Effort = [string]$definition[2]
            TurnStarts = [int]$definition[3]
            RemainingContexts = $remainingContexts
            RemainingTurns = $remainingTurns
            NextPhase = $nextPhase
            DirectoryName = ('{0:d2}-{1}' -f ($index + 1), $phase)
        })
        $remainingContexts--
        $remainingTurns -= [int]$definition[3]
    }
    return $result.ToArray()
}

function Get-ProductionPolicySha256 {
    $rows = @(
        Get-AuthorizedProductionPhases | ForEach-Object {
            @(
                $_.Ordinal, $_.Phase, $_.Model, $_.Effort, $_.TurnStarts,
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
        throw 'Phase is not present in the committed D52 production authorization policy.'
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

    if ([string]$Snapshot.schema_version -cne 'work-charter-d52-authority-snapshot/v1' -or
        [string]$Snapshot.campaign_id -cne $script:CampaignId -or
        [string]$Snapshot.stable_subject -cne $script:StableSubject -or
        [string]$Snapshot.candidate_commit -cne $script:CandidateCommit -or
        [string]$Snapshot.candidate_manifest_sha256 -cne $script:CandidateManifestSha256) {
        throw 'Authority snapshot does not identify the authorized D52 subject.'
    }
    $contractPath = (Get-OrdinaryFile `
        -Path ([string]$Snapshot.campaign_contract_path) `
        -Purpose 'Campaign contract').FullName
    if (-not [string]::Equals(
        $contractPath,
        $script:CampaignContractPath,
        [StringComparison]::OrdinalIgnoreCase
    )) {
        throw 'Authority snapshot does not identify the tracked D52 Campaign contract.'
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
        throw 'Launch binding ruleset aggregate is not the authenticated D52 ruleset.'
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
        [Parameter(Mandatory)][string]$Phase
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
    if ([string]$frozen.schema_version -cne 'work-charter-d52-frozen-inputs/v1' -or
        [string]$frozen.campaign_id -cne $script:CampaignId -or
        [string]$frozen.candidate_commit -cne $script:CandidateCommit -or
        [string]$frozen.candidate_manifest_sha256 -cne $script:CandidateManifestSha256 -or
        [string]$frozen.authority_snapshot_sha256 -cne $authoritySha256 -or
        [string]$frozen.phase -cne [string]$Binding.phase) {
        throw 'Frozen-input manifest does not bind the authorized D52 phase.'
    }
    $carrier = $CarrierSnapshot.Value
    if ([string]$carrier.schema_version -cne 'work-charter-d52-carrier-manifest/v1' -or
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
        throw 'Carrier manifest does not bind the authenticated D52 authority and frozen phase.'
    }
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
        -Phase ([string]$Binding.phase)
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
        [Parameter(Mandatory)][string]$Phase
    )

    if (-not (Test-RequiresProductionAuthorization -OperationId $OperationId -Phase $Phase)) {
        return
    }
    $policy = Get-AuthorizedProductionPhase -Phase $Phase
    $policySha256 = Get-ProductionPolicySha256
    foreach ($artifact in @($Binding, $Carrier, $Frozen)) {
        if ([string]$artifact.authorization_policy_sha256 -cne $policySha256 -or
            [long]$artifact.phase_ordinal -ne [long]$policy.Ordinal -or
            [string]$artifact.phase -cne $policy.Phase -or
            [string]$artifact.model -cne $policy.Model -or
            [string]$artifact.reasoning_effort -cne $policy.Effort -or
            [long]$artifact.phase_turn_starts -ne [long]$policy.TurnStarts -or
            [string]$artifact.successor_phase -cne $policy.NextPhase) {
            throw 'Production artifact does not match the committed D52 phase authorization policy.'
        }
    }
    if ([long]$Binding.remaining_budget.model_contexts -ne [long]$policy.RemainingContexts -or
        [long]$Binding.remaining_budget.turn_starts -ne [long]$policy.RemainingTurns -or
        [string]$Binding.child_operation_id -cne 'd52-codex-app-server' -or
        [string]$Binding.child_executable_anchor_id -cne
            'd52-codex-app-server-0.147.0-alpha.6.6') {
        throw 'Production binding route or budget does not match the committed D52 phase authorization policy.'
    }
    $expectsSuccessor = -not [string]::IsNullOrEmpty($policy.NextPhase)
    if (($expectsSuccessor -and [string]$Binding.next_dispatch_sha256 -ceq ('0' * 64)) -or
        (-not $expectsSuccessor -and [string]$Binding.next_dispatch_sha256 -cne ('0' * 64))) {
        throw 'Production successor binding does not match the committed D52 phase authorization policy.'
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
        throw "$Purpose does not match the committed D52 production path policy."
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
                throw 'Terminal D52 production phase cannot declare a successor descriptor.'
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
            throw 'Terminal D52 production phase cannot provide a successor descriptor.'
        }
        return
    }
    if ($null -eq $Descriptor) {
        throw 'D52 production phase is missing its committed-policy successor descriptor.'
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
        throw 'Next descriptor route does not match the committed D52 production authorization policy.'
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
        [Parameter(Mandatory)][int]$MaxAgeSeconds
    )

    foreach ($policy in Get-AuthorizedProductionPhases) {
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
                throw 'Fresh D52 production carrier contains preexisting receipt or dispatch state.'
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
        throw 'Test and qualification operations are excluded from the committed D52 production policy.'
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

    if ([string]$Binding.schema_version -cne 'work-charter-d52-launch-binding/v1') {
        throw 'Launch binding schema is not supported.'
    }
    if ([string]$Binding.campaign_id -cne $script:CampaignId) {
        throw 'Launch binding campaign_id does not match the authorized D52 Campaign.'
    }
    if ([string]$Binding.stable_subject -cne $script:StableSubject) {
        throw 'Launch binding stable_subject does not match the authorized D52 subject.'
    }
    if ([string]$Binding.candidate_commit -cne $script:CandidateCommit) {
        throw 'Launch binding candidate_commit does not match the authorized D52 candidate.'
    }
    if ([string]$Binding.candidate_manifest_sha256 -cne $script:CandidateManifestSha256) {
        throw 'Launch binding candidate manifest does not match the authorized D52 candidate.'
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
        throw 'Launch binding remaining budget exceeds the authorized D52 ceiling.'
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
            [string]$request.params.clientInfo.name -cne 'work-charter-d52-carrier' -or
            [string]$request.params.clientInfo.version -cne '1.0.0') {
            throw 'Production app-server input must begin with the committed D52 initialize request.'
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
            throw 'Production thread/start does not match the committed D52 model policy.'
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
        throw 'Production turn/start does not match the committed D52 model, effort, or input policy.'
    }
    $State.TurnStartCount++
    if ([long]$State.TurnStartCount -gt [long]$Policy.TurnStarts) {
        throw 'Production app-server input exceeds the committed D52 turn budget for this phase.'
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
        while ($null -ne ($line = [Console]::In.ReadLine())) {
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
            throw 'Production app-server input did not consume the exact committed D52 request and successful-response budget.'
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
    if ([string]$state.schema_version -cne 'work-charter-d52-dispatch-state/v1' -or
        [string]$state.status -cne 'receipt_issued' -or
        [string]$state.campaign_id -cne [string]$binding.campaign_id -or
        [string]$state.phase -cne $ExpectedPhase) {
        throw 'Dispatch state does not authorize this inner launch.'
    }

    $receiptSnapshot = Read-JsonSnapshot -Path $ReceiptPath -Purpose 'launch receipt'
    $receipt = $receiptSnapshot.Value
    if ([string]$receipt.schema_version -cne 'work-charter-d52-launch-receipt/v1' -or
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
        schema_version = 'work-charter-d52-receipt-consumption/v1'
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
        Get-AuthorizedProductionPhase -Phase 'assessor-terra-high'
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
        if ($script:ProductionDispatchDepth -eq 0) {
            if ($policy.Ordinal -ne 1) {
                throw 'A top-level D52 production dispatch must begin with the first committed canary phase.'
            }
            Assert-CompleteProductionCarrier `
                -RunnerPath $runnerPath `
                -ExecutablePath $ChildExecutablePath `
                -ExecutableAnchorId $ChildExecutableAnchorId `
                -MaxAgeSeconds $ReceiptMaxAgeSeconds
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
        if ([string]$nextDispatch.schema_version -cne 'work-charter-d52-next-dispatch/v1') {
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
        schema_version = 'work-charter-d52-dispatch-state/v1'
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
        schema_version = 'work-charter-d52-launch-receipt/v1'
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
        $nextResult = if ($ChildOperationId -ceq 'd52-codex-app-server') {
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

try {
    $exitCode = if ($Mode -ceq 'Inner') { Invoke-Inner } else { Invoke-Outer }
    exit ([int]$exitCode)
}
catch {
    [Console]::Error.WriteLine("D52_RUNNER_REJECTED: $($_.Exception.Message)")
    exit $script:RunnerFailureExitCode
}
