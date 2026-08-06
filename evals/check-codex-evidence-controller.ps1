[CmdletBinding()]
param(
    [switch]$VerifyLocalSealedEvidence,

    [string]$LocalSealedEvidenceManifestPath,

    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$modulePath = Join-Path $PSScriptRoot 'codex-evidence-controller.psm1'
$casesPath = Join-Path $PSScriptRoot 'codex-evidence-controller-cases.json'
Import-Module -Name $modulePath -Force

$cases = Get-Content -Raw -Encoding UTF8 -LiteralPath $casesPath |
    ConvertFrom-Json -Depth 100
$externalProcessLedger = [System.Collections.Generic.List[object]]::new()
$localSealedInputs = @()

$runRoot = Join-Path $repoRoot '.eval-runs'
$runRootFull = [System.IO.Path]::GetFullPath($runRoot)
$scratch = Join-Path $runRoot (
    'fixture-check-codex-evidence-controller-' + [guid]::NewGuid().ToString('N')
)
$scratchFull = [System.IO.Path]::GetFullPath($scratch)
$comparison = if ($IsWindows) {
    [System.StringComparison]::OrdinalIgnoreCase
}
else {
    [System.StringComparison]::Ordinal
}
if (-not $scratchFull.StartsWith(
    $runRootFull + [System.IO.Path]::DirectorySeparatorChar,
    $comparison
)) {
    throw 'Controller scratch path escaped the ignored run root.'
}

function Copy-ControllerValue {
    param([Parameter(Mandatory)][object]$Value)
    return ($Value | ConvertTo-Json -Depth 100 | ConvertFrom-Json -Depth 100)
}

function Write-ControllerOutputNewFile {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Text
    )

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    $parent = Split-Path -Parent $fullPath
    if ($parent) {
        [void](New-Item -ItemType Directory -Path $parent -Force)
    }
    $bytes = [System.Text.UTF8Encoding]::new($false).GetBytes($Text + "`n")
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

function Get-CandidateIdentity {
    param([Parameter(Mandatory)][string]$Name)
    $property = $cases.candidate_identities.PSObject.Properties[$Name]
    if ($null -eq $property) {
        throw "Unknown candidate identity: $Name"
    }
    return $property.Value
}

function Get-PackageManifest {
    param([Parameter(Mandatory)][string]$Name)
    $property = $cases.package_manifests.PSObject.Properties[$Name]
    if ($null -eq $property) {
        throw "Unknown package manifest: $Name"
    }
    return $property.Value
}

function Get-CandidateFileRows {
    param([Parameter(Mandatory)][string]$Candidate)
    $manifest = Get-PackageManifest -Name $Candidate
    $wanted = @{}
    foreach ($path in @($manifest.content_output_paths)) {
        if ($wanted.ContainsKey([string]$path)) {
            throw "Duplicate content-output path in package manifest: $path"
        }
        $wanted[[string]$path] = $true
    }
    $rows = @($manifest.files | Where-Object { $wanted.ContainsKey([string]$_.path) } |
        ForEach-Object {
            [pscustomobject]@{
                root = 'candidate'
                path = [string]$_.path
                length = [int64]$_.length
                sha256 = ([string]$_.sha256).ToLowerInvariant()
            }
        } | Sort-Object path)
    if ($rows.Count -ne $wanted.Count) {
        throw "Package manifest content-output set is incomplete for $Candidate"
    }
    return $rows
}

function Get-WorkspaceFileRows {
    return @(
        [pscustomobject]@{ root = 'workspace'; path = 'WORK.md'; length = 101; sha256 = ('1' * 64) },
        [pscustomobject]@{ root = 'workspace'; path = 'STATUS.md'; length = 102; sha256 = ('2' * 64) },
        [pscustomobject]@{ root = 'workspace'; path = 'EVIDENCE.md'; length = 103; sha256 = ('3' * 64) },
        [pscustomobject]@{ root = 'workspace'; path = 'SNAPSHOT.md'; length = 104; sha256 = ('4' * 64) },
        [pscustomobject]@{ root = 'workspace'; path = 'AGENTS.md'; length = 105; sha256 = ('5' * 64) },
        [pscustomobject]@{ root = 'workspace'; path = 'README.md'; length = 106; sha256 = ('6' * 64) }
    )
}

function New-BaseControllerInput {
    param(
        [Parameter(Mandatory)][string]$Candidate,
        [Parameter(Mandatory)][string]$CaseRoot
    )

    $identity = Get-CandidateIdentity -Name $Candidate
    $candidateRoot = Join-Path $CaseRoot 'candidate\catalog\work-charter'
    $workspaceRoot = Join-Path $CaseRoot 'workspace'
    $roots = [ordered]@{
        candidate = $candidateRoot
        workspace = $workspaceRoot
        control = (Join-Path $CaseRoot 'control\catalog\work-charter')
        source = (Join-Path $CaseRoot 'source\skills\work-charter')
        protected = (Join-Path $CaseRoot 'protected\work-charter')
        unexpected = (Join-Path $CaseRoot 'unexpected\work-charter')
    }
    foreach ($root in $roots.Values) {
        [void](New-Item -ItemType Directory -Path $root -Force)
    }

    $allowed = @((Get-CandidateFileRows -Candidate $Candidate) + (Get-WorkspaceFileRows))
    return [pscustomobject]@{
        policy = [pscustomobject]@{
            expected_candidate = [pscustomobject]@{
                stable_subject = $cases.stable_subject
                candidate_sha = $identity.candidate_sha
                package_manifest_sha256 = $identity.package_manifest_sha256
                relative_package_path = $identity.relative_package_path
                content_output_sha256 = $identity.content_output_sha256
            }
            roots = [pscustomobject]$roots
            allowed_files = $allowed
            required_reads = @()
            git = 'read-only'
            maximum_nested_turns = 0
            trusted_command_identities = @(
                [pscustomobject]@{
                    family = 'git-native'
                    kind = 'native-application'
                    sha256 = ('7' * 64)
                    resolved_path = (Join-Path $roots.control 'trusted-tools\git.exe')
                },
                [pscustomobject]@{
                    family = 'powershell-management'
                    kind = 'powershell-module'
                    sha256 = ('8' * 64)
                    source_name = 'Microsoft.PowerShell.Management'
                    commands = @(
                        'get-content', 'get-childitem', 'get-item', 'test-path',
                        'resolve-path', 'select-object', 'sort-object',
                        'format-table', 'format-list', 'write-output', 'out-string',
                        'set-content', 'add-content', 'clear-content', 'out-file',
                        'new-item', 'remove-item', 'copy-item', 'move-item',
                        'rename-item', 'set-item', 'set-itemproperty',
                        'new-itemproperty', 'remove-itemproperty'
                    )
                }
            )
        }
        evidence = [pscustomobject]@{
            candidate_identity = [pscustomobject]@{
                stable_subject = $cases.stable_subject
                candidate_sha = $identity.candidate_sha
                package_manifest_sha256 = $identity.package_manifest_sha256
                relative_package_path = $identity.relative_package_path
                content_output_sha256 = $identity.content_output_sha256
                locator = 'successor-local-catalog'
            }
            commands = @()
            inventory_comparisons = @()
            construction_events = @()
            role_deliveries = @()
            nested_turn_count = 0
            free_text = @()
            assessor_requested = $false
        }
    }
}

function Get-SyntheticResolvedCommandIdentity {
    param(
        [Parameter(Mandatory)][object]$InputObject,
        [Parameter(Mandatory)][string]$Family
    )

    $matches = @($InputObject.policy.trusted_command_identities | Where-Object {
        [string]$_.family -ceq $Family
    })
    if ($matches.Count -ne 1) {
        throw "Synthetic trusted command identity must resolve once: $Family"
    }
    return Copy-ControllerValue -Value $matches[0]
}

function Get-SyntheticPowerShellWrapperIdentity {
    param([Parameter(Mandatory)][object]$InputObject)

    $family = 'powershell-wrapper'
    $matches = @($InputObject.policy.trusted_command_identities | Where-Object {
        [string]$_.family -ceq $family
    })
    if ($matches.Count -eq 0) {
        $identity = [pscustomobject]@{
            family = $family
            kind = 'native-application'
            sha256 = ('6' * 64)
            resolved_path = (Join-Path `
                ([string]$InputObject.policy.roots.control) `
                'trusted-tools\pwsh.exe')
        }
        $InputObject.policy.trusted_command_identities = @(
            $InputObject.policy.trusted_command_identities
        ) + @($identity)
        return Copy-ControllerValue -Value $identity
    }
    if ($matches.Count -ne 1) {
        throw "Synthetic trusted wrapper identity must resolve once: $family"
    }
    return Copy-ControllerValue -Value $matches[0]
}

function Get-AllowedFile {
    param(
        [Parameter(Mandatory)][object]$InputObject,
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][string]$Path
    )

    return @($InputObject.policy.allowed_files | Where-Object {
        $_.root -eq $Root -and $_.path -eq $Path
    })[0]
}

function New-ReadRecord {
    param(
        [Parameter(Mandatory)][object]$InputObject,
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][string]$RelativePath,
        [string]$CwdRoot = 'workspace',
        [ValidateSet('literal-path-first', 'raw-first', 'positional', 'total-count')]
        [string]$Shape = 'literal-path-first',
        [string]$ActionType = 'read',
        [ValidateSet('completed', 'declined', 'failed')]
        [string]$Status = 'completed',
        [switch]$UseRelativePath,
        [switch]$OmitActions,
        [string]$ProofSha256
    )

    $cwd = [string]$InputObject.policy.roots.$CwdRoot
    $targetRoot = [string]$InputObject.policy.roots.$Root
    $pathText = if ($UseRelativePath) {
        $targetFull = [System.IO.Path]::GetFullPath((Join-Path $targetRoot $RelativePath))
        [System.IO.Path]::GetRelativePath($cwd, $targetFull)
    }
    else {
        Join-Path $targetRoot $RelativePath
    }
    $inner = switch ($Shape) {
        'raw-first' { "Get-Content -Raw -LiteralPath '$pathText'" }
        'positional' { "Get-Content '$pathText' -Raw" }
        'total-count' { "Get-Content -LiteralPath '$pathText' -TotalCount 1" }
        default { "Get-Content -LiteralPath '$pathText' -Raw" }
    }
    $wrapperIdentity = Get-SyntheticPowerShellWrapperIdentity -InputObject $InputObject
    $wrapperPath = ([string]$wrapperIdentity.resolved_path).Replace("'", "''")
    $escapedInner = $inner.Replace('"', '`"')
    $outer = "& '$wrapperPath' -NoProfile -Command `"$escapedInner`""
    $allowed = Get-AllowedFile -InputObject $InputObject -Root $Root -Path $RelativePath
    $proof = if ($null -ne $allowed) {
        [pscustomobject]@{
            root = $Root
            path = $RelativePath
            length = $allowed.length
            sha256 = if ($ProofSha256) { $ProofSha256 } else { $allowed.sha256 }
        }
    }
    else {
        [pscustomobject]@{
            root = $Root
            path = $RelativePath
            length = 1
            sha256 = if ($ProofSha256) { $ProofSha256 } else { ('9' * 64) }
        }
    }
    $actions = if ($OmitActions) {
        @()
    }
    else {
        @([pscustomobject]@{
            type = $ActionType
            command = $inner
            file_proofs = @($proof)
        })
    }
    return [pscustomobject]@{
        status = $Status
        exit_code = if ($Status -eq 'completed') { 0 } else { -1 }
        cwd = $cwd
        command = $outer
        resolved_command_identity = Get-SyntheticResolvedCommandIdentity `
            -InputObject $InputObject `
            -Family 'powershell-management'
        resolved_wrapper_identity = $wrapperIdentity
        command_actions = $actions
    }
}

function New-ScriptRecord {
    param(
        [Parameter(Mandatory)][object]$InputObject,
        [Parameter(Mandatory)][string]$Script,
        [ValidateSet('completed', 'declined', 'failed')]
        [string]$Status = 'completed',
        [string]$CwdRoot = 'workspace'
    )

    $family = if ($Script -match '(?i)(^|[;\s])git(?:\.exe)?([;\s]|$)') {
        'git-native'
    }
    else {
        'powershell-management'
    }
    $resolvedIdentity = Get-SyntheticResolvedCommandIdentity `
        -InputObject $InputObject `
        -Family $family
    $recordedScript = $Script
    if ($family -eq 'git-native') {
        $gitPath = ([string]$resolvedIdentity.resolved_path).Replace("'", "''")
        $recordedScript = [regex]::Replace(
            $Script,
            '(?i)(?<![\w./\\-])git(?:\.exe)?(?=(?:\s|$))',
            "& '$gitPath'"
        )
    }
    return [pscustomobject]@{
        status = $Status
        exit_code = if ($Status -eq 'completed') { 0 } else { -1 }
        cwd = [string]$InputObject.policy.roots.$CwdRoot
        command = $recordedScript
        resolved_command_identity = $resolvedIdentity
        command_actions = @([pscustomobject]@{
            type = 'unknown'
            command = $recordedScript
            file_proofs = @()
        })
    }
}

function Add-RequiredRead {
    param(
        [Parameter(Mandatory)][object]$InputObject,
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][string]$Path
    )
    $InputObject.policy.required_reads = @($InputObject.policy.required_reads) + @(
        [pscustomobject]@{ root = $Root; path = $Path }
    )
}

function Get-DeclaredSealedInputKey {
    param([Parameter(Mandatory)][string]$Key)
    $matches = @($cases.sealed_input_keys | Where-Object { [string]$_ -ceq $Key })
    if ($matches.Count -ne 1) {
        throw "Sealed input key must resolve exactly once: $Key"
    }
    return [string]$matches[0]
}

function Get-LocalSealedInputByKey {
    param([Parameter(Mandatory)][string]$Key)
    $matches = @($localSealedInputs | Where-Object { [string]$_.key -ceq $Key })
    if ($matches.Count -ne 1) {
        throw "Local sealed input key must resolve exactly once: $Key"
    }
    return $matches[0]
}

function Test-ReparseFreeAttributes {
    param([Parameter(Mandatory)][System.IO.FileAttributes]$Attributes)
    return (($Attributes -band [System.IO.FileAttributes]::ReparsePoint) -eq 0)
}

function Assert-ControllerRunRoot {
    param(
        [Parameter(Mandatory)][string]$RepositoryRoot,
        [Parameter(Mandatory)][string]$RunRoot,
        [switch]$CreateIfMissing
    )

    $repositoryFull = [System.IO.Path]::GetFullPath($RepositoryRoot)
    $expectedFull = [System.IO.Path]::GetFullPath((Join-Path $repositoryFull '.eval-runs'))
    $actualFull = [System.IO.Path]::GetFullPath($RunRoot)
    $actualParent = [System.IO.Path]::GetFullPath((Split-Path -Parent $actualFull))
    if (-not $actualFull.Equals($expectedFull, $comparison) -or
        -not $actualParent.Equals($repositoryFull, $comparison) -or
        (Split-Path -Leaf $actualFull) -cne '.eval-runs') {
        throw 'controller_run_root_is_not_exact_repo_child'
    }

    if (-not (Test-Path -LiteralPath $actualFull)) {
        if (-not $CreateIfMissing) {
            throw 'controller_run_root_missing'
        }
        [void][System.IO.Directory]::CreateDirectory($actualFull)
    }
    $item = Get-Item -LiteralPath $actualFull -Force
    if (-not $item.PSIsContainer) {
        throw 'controller_run_root_not_directory'
    }
    if (-not (Test-ReparseFreeAttributes -Attributes $item.Attributes)) {
        throw 'controller_run_root_is_reparse'
    }
    if (-not ([System.IO.Path]::GetFullPath($item.FullName)).Equals($actualFull, $comparison)) {
        throw 'controller_run_root_identity_mismatch'
    }
    return $actualFull
}

function Assert-ControllerScratchRoot {
    param(
        [Parameter(Mandatory)][string]$RunRoot,
        [Parameter(Mandatory)][string]$ScratchRoot,
        [switch]$CreateIfMissing
    )

    $runFull = [System.IO.Path]::GetFullPath($RunRoot)
    $scratchRootFull = [System.IO.Path]::GetFullPath($ScratchRoot)
    $scratchParent = [System.IO.Path]::GetFullPath((Split-Path -Parent $scratchRootFull))
    $leaf = Split-Path -Leaf $scratchRootFull
    $leafPrefix = 'fixture-check-codex-evidence-controller-'
    $parsedGuid = [guid]::Empty
    $guidText = if ($leaf.StartsWith($leafPrefix, [System.StringComparison]::Ordinal)) {
        $leaf.Substring($leafPrefix.Length)
    }
    else {
        ''
    }
    if (-not $scratchParent.Equals($runFull, $comparison) -or
        -not [guid]::TryParseExact($guidText, 'N', [ref]$parsedGuid)) {
        throw 'controller_scratch_not_exact_guid_child'
    }

    if (-not (Test-Path -LiteralPath $scratchRootFull)) {
        if (-not $CreateIfMissing) {
            throw 'controller_scratch_missing'
        }
        [void][System.IO.Directory]::CreateDirectory($scratchRootFull)
    }
    elseif ($CreateIfMissing) {
        throw 'controller_scratch_preexisting'
    }
    $item = Get-Item -LiteralPath $scratchRootFull -Force
    if (-not $item.PSIsContainer) {
        throw 'controller_scratch_not_directory'
    }
    if (-not (Test-ReparseFreeAttributes -Attributes $item.Attributes)) {
        throw 'controller_scratch_is_reparse'
    }
    if (-not ([System.IO.Path]::GetFullPath($item.FullName)).Equals($scratchRootFull, $comparison)) {
        throw 'controller_scratch_identity_mismatch'
    }
    return $scratchRootFull
}

function Get-ControllerScratchCleanupDisposition {
    param(
        [Parameter(Mandatory)][string]$RepositoryRoot,
        [Parameter(Mandatory)][string]$RunRoot,
        [Parameter(Mandatory)][string]$ScratchRoot
    )

    try {
        [void](Assert-ControllerRunRoot -RepositoryRoot $RepositoryRoot -RunRoot $RunRoot)
        [void](Assert-ControllerScratchRoot -RunRoot $RunRoot -ScratchRoot $ScratchRoot)
        $reparseDescendants = @(Get-ChildItem -LiteralPath $ScratchRoot -Force -Recurse | Where-Object {
            -not (Test-ReparseFreeAttributes -Attributes $_.Attributes)
        })
        if ($reparseDescendants.Count -gt 0) {
            return [ordered]@{
                safe = $false
                reason = 'scratch_descendant_reparse'
                residue = 'retained_for_manual_disposition'
            }
        }
        return [ordered]@{
            safe = $true
            reason = 'validated_ordinary_contained_scratch'
            residue = 'none'
        }
    }
    catch {
        return [ordered]@{
            safe = $false
            reason = [string]$_.Exception.Message
            residue = 'retained_for_manual_disposition'
        }
    }
}

function Remove-ControllerScratchSafely {
    param(
        [Parameter(Mandatory)][string]$RepositoryRoot,
        [Parameter(Mandatory)][string]$RunRoot,
        [Parameter(Mandatory)][string]$ScratchRoot
    )

    $disposition = Get-ControllerScratchCleanupDisposition `
        -RepositoryRoot $RepositoryRoot `
        -RunRoot $RunRoot `
        -ScratchRoot $ScratchRoot
    if (-not $disposition.safe) {
        throw "scratch_cleanup_refused_residue_retained:$($disposition.reason)"
    }
    Remove-Item -LiteralPath $ScratchRoot -Recurse -Force
    if (Test-Path -LiteralPath $ScratchRoot) {
        throw 'scratch_cleanup_incomplete_manual_disposition_required'
    }
    [void](Assert-ControllerRunRoot -RepositoryRoot $RepositoryRoot -RunRoot $RunRoot)
    return [ordered]@{
        pre_cleanup = 'validated'
        scratch_absent = $true
        run_root_post_cleanup = 'ordinary_non_reparse'
        residue = 'none'
    }
}

function Resolve-ContainedSealedLocator {
    param([Parameter(Mandatory)][object]$Entry)

    $locator = [string]$Entry.relative_locator
    if ([string]::IsNullOrWhiteSpace($locator) -or [System.IO.Path]::IsPathRooted($locator)) {
        throw 'sealed_locator_must_be_relative'
    }
    $segments = @($locator -split '[\\/]' | Where-Object { $_.Length -gt 0 })
    if ($segments.Count -eq 0 -or @($segments | Where-Object {
        $_ -in @('.', '..') -or ($IsWindows -and $_.Contains(':'))
    }).Count -gt 0) {
        throw 'sealed_locator_has_unsafe_segment'
    }
    $normalized = [string]::Join([System.IO.Path]::DirectorySeparatorChar, $segments)
    $resolved = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $normalized))
    $sealedPrefix = $runRootFull + [System.IO.Path]::DirectorySeparatorChar
    if (-not $resolved.StartsWith($sealedPrefix, $comparison)) {
        throw 'sealed_locator_outside_authorized_root'
    }

    $runRootItem = Get-Item -LiteralPath $runRootFull -Force
    if (-not (Test-ReparseFreeAttributes -Attributes $runRootItem.Attributes)) {
        throw 'sealed_root_is_reparse'
    }
    $relative = [System.IO.Path]::GetRelativePath($runRootFull, $resolved)
    $current = $runRootFull
    foreach ($segment in @($relative -split '[\\/]')) {
        $current = Join-Path $current $segment
        if (-not (Test-Path -LiteralPath $current)) {
            throw 'sealed_locator_missing_component'
        }
        $item = Get-Item -LiteralPath $current -Force
        if (-not (Test-ReparseFreeAttributes -Attributes $item.Attributes)) {
            throw 'sealed_locator_reparse_component'
        }
    }
    $leaf = Get-Item -LiteralPath $resolved -Force
    if ($leaf.PSIsContainer) {
        throw 'sealed_locator_not_ordinary_file'
    }
    return $leaf.FullName
}

function Read-ContainedSealedCapture {
    param([Parameter(Mandatory)][object]$Entry)

    $resolved = Resolve-ContainedSealedLocator -Entry $Entry
    $stream = [System.IO.FileStream]::new(
        $resolved,
        [System.IO.FileMode]::Open,
        [System.IO.FileAccess]::Read,
        [System.IO.FileShare]::Read,
        4096,
        [System.IO.FileOptions]::SequentialScan
    )
    try {
        $handleAttributes = [System.IO.File]::GetAttributes($stream.SafeFileHandle)
        if (-not (Test-ReparseFreeAttributes -Attributes $handleAttributes) -or
            (($handleAttributes -band [System.IO.FileAttributes]::Directory) -ne 0)) {
            throw 'sealed_handle_not_ordinary_file'
        }

        $resolvedAgain = Resolve-ContainedSealedLocator -Entry $Entry
        if (-not $resolved.Equals($resolvedAgain, $comparison)) {
            throw 'sealed_path_identity_changed_while_open'
        }
        $pathItem = Get-Item -LiteralPath $resolvedAgain -Force
        if ($pathItem.PSIsContainer -or
            -not (Test-ReparseFreeAttributes -Attributes $pathItem.Attributes) -or
            $pathItem.Length -ne $stream.Length -or
            [System.IO.File]::GetCreationTimeUtc($stream.SafeFileHandle) -ne
                [System.IO.File]::GetCreationTimeUtc($resolvedAgain) -or
            [System.IO.File]::GetLastWriteTimeUtc($stream.SafeFileHandle) -ne
                [System.IO.File]::GetLastWriteTimeUtc($resolvedAgain)) {
            throw 'sealed_handle_path_identity_mismatch'
        }

        $memory = [System.IO.MemoryStream]::new()
        try {
            $stream.Position = 0
            $stream.CopyTo($memory)
            [byte[]]$bytes = $memory.ToArray()
        }
        finally {
            $memory.Dispose()
        }
        if ($bytes.LongLength -ne $stream.Length) {
            throw 'sealed_capture_length_mismatch'
        }
        $strictUtf8 = [System.Text.UTF8Encoding]::new($false, $true)
        $text = $strictUtf8.GetString($bytes)
        return [pscustomobject]@{
            path = $resolved
            length = [int64]$bytes.LongLength
            sha256 = Get-Sha256HexFromBytes -Bytes $bytes
            text = $text
            bytes = $bytes
            stable_handle = $true
        }
    }
    finally {
        $stream.Dispose()
    }
}

function Initialize-LocalSealedInputs {
    param([Parameter(Mandatory)][string]$ManifestPath)

    if ([string]::IsNullOrWhiteSpace($ManifestPath)) {
        throw 'local_sealed_evidence_manifest_required'
    }
    $manifestCapture = Read-ContainedSealedCapture -Entry ([pscustomobject]@{
        relative_locator = $ManifestPath
    })
    $manifest = $manifestCapture.text | ConvertFrom-Json -Depth 100
    if ([string]$manifest.schema_version -cne 'codex-evidence-private-sealed-manifest/v1') {
        throw 'local_sealed_evidence_manifest_schema_invalid'
    }

    $declaredKeys = @($cases.sealed_input_keys | ForEach-Object { [string]$_ })
    $rows = @($manifest.sealed_inputs)
    if ($declaredKeys.Count -eq 0 -or
        @($declaredKeys | Select-Object -Unique).Count -ne $declaredKeys.Count -or
        $rows.Count -ne $declaredKeys.Count) {
        throw 'local_sealed_evidence_manifest_key_set_invalid'
    }

    $validated = [System.Collections.Generic.List[object]]::new()
    foreach ($row in $rows) {
        $properties = @($row.PSObject.Properties.Name)
        $missingProperties = @(
            @('key', 'relative_locator', 'length', 'sha256') |
                Where-Object { $_ -notin $properties }
        )
        if ($null -eq $row -or $missingProperties.Count -gt 0) {
            throw 'local_sealed_evidence_manifest_row_invalid'
        }
        $key = [string]$row.key
        $locator = [string]$row.relative_locator
        $hash = ([string]$row.sha256).ToLowerInvariant()
        if ([string]::IsNullOrWhiteSpace($key) -or
            [string]::IsNullOrWhiteSpace($locator) -or
            $row.length -isnot [int64] -or [int64]$row.length -lt 0 -or
            $hash -notmatch '^[0-9a-f]{64}$') {
            throw 'local_sealed_evidence_manifest_row_invalid'
        }
        $validated.Add([pscustomobject]@{
            key = $key
            relative_locator = $locator
            length = [int64]$row.length
            sha256 = $hash
        })
    }
    $actualKeys = @($validated | ForEach-Object { [string]$_.key })
    if (@($actualKeys | Select-Object -Unique).Count -ne $actualKeys.Count -or
        (ConvertTo-CodexCanonicalJson -InputObject @($actualKeys | Sort-Object)) -cne
            (ConvertTo-CodexCanonicalJson -InputObject @($declaredKeys | Sort-Object))) {
        throw 'local_sealed_evidence_manifest_key_set_invalid'
    }
    $script:localSealedInputs = @($validated)
}

function Get-HistoricalBindingById {
    param([Parameter(Mandatory)][string]$Id)
    $matches = @($cases.historical_source_bindings | Where-Object { [string]$_.id -ceq $Id })
    if ($matches.Count -ne 1) {
        throw "Historical source binding must resolve exactly once: $Id"
    }
    return $matches[0]
}

function Get-HistoricalCaseById {
    param([Parameter(Mandatory)][string]$Id)
    $matches = @($cases.historical_cases | Where-Object { [string]$_.id -ceq $Id })
    if ($matches.Count -ne 1) {
        throw "Historical case must resolve exactly once: $Id"
    }
    return $matches[0]
}

function Get-HistoricalBindingDeclaration {
    param([Parameter(Mandatory)][object]$Binding)

    $sourceKeys = @($Binding.source_keys | ForEach-Object { [string]$_ })
    $selectors = @($Binding.selectors | ForEach-Object { [string]$_ })
    if ($sourceKeys.Count -ne 1 -or @($sourceKeys | Select-Object -Unique).Count -ne 1) {
        throw 'historical_binding_requires_one_unique_source'
    }
    if ($selectors.Count -eq 0 -or @($selectors | Select-Object -Unique).Count -ne $selectors.Count -or
        @($selectors | Where-Object { -not $_.StartsWith('/', [System.StringComparison]::Ordinal) }).Count -gt 0) {
        throw 'historical_binding_selectors_invalid'
    }
    if ([string]::IsNullOrWhiteSpace([string]$Binding.input_spec.candidate) -or
        [string]::IsNullOrWhiteSpace([string]$Binding.input_spec.scenario)) {
        throw 'historical_binding_input_spec_invalid'
    }
    $historicalCase = Get-HistoricalCaseById -Id ([string]$Binding.id)
    $generatedContractHash = ([string]$historicalCase.generated_contract_sha256).ToLowerInvariant()
    if ($generatedContractHash -notmatch '^[0-9a-f]{64}$') {
        throw 'historical_generated_contract_hash_invalid'
    }
    $sourceIdentities = @($sourceKeys | ForEach-Object {
        $key = Get-DeclaredSealedInputKey -Key $_
        [ordered]@{
            key = $key
        }
    })
    $material = [ordered]@{
        id = [string]$Binding.id
        source_identities = $sourceIdentities
        selectors = $selectors
        projection_sha256 = ([string]$Binding.projection_sha256).ToLowerInvariant()
        input_spec = [ordered]@{
            candidate = [string]$Binding.input_spec.candidate
            scenario = [string]$Binding.input_spec.scenario
        }
        generated_contract_sha256 = $generatedContractHash
    }
    $actualHash = Get-CodexCanonicalHash -InputObject $material
    return [pscustomobject]@{
        valid = ($actualHash -ceq ([string]$Binding.binding_sha256).ToLowerInvariant())
        actual_hash = $actualHash
        declared_hash = ([string]$Binding.binding_sha256).ToLowerInvariant()
        material = $material
    }
}

function ConvertTo-StableHistoricalValue {
    param(
        [AllowNull()][object]$Value,
        [Parameter(Mandatory)][object[]]$RootReplacements
    )

    if ($null -eq $Value) {
        return $null
    }
    if ($Value -is [string]) {
        $stable = [string]$Value
        foreach ($replacement in $RootReplacements) {
            $stable = [regex]::Replace(
                $stable,
                [regex]::Escape([string]$replacement.path),
                [string]$replacement.token,
                [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
                    [System.Text.RegularExpressions.RegexOptions]::CultureInvariant
            )
        }
        return $stable
    }
    if ($Value -is [System.Collections.IDictionary]) {
        $stable = [ordered]@{}
        foreach ($key in @($Value.Keys | ForEach-Object { [string]$_ } | Sort-Object)) {
            $stable[$key] = ConvertTo-StableHistoricalValue -Value $Value[$key] -RootReplacements $RootReplacements
        }
        return $stable
    }
    if ($Value -is [System.Management.Automation.PSCustomObject]) {
        $stable = [ordered]@{}
        foreach ($property in @($Value.PSObject.Properties | Sort-Object Name)) {
            $stable[$property.Name] = ConvertTo-StableHistoricalValue -Value $property.Value -RootReplacements $RootReplacements
        }
        return $stable
    }
    if ($Value -is [System.Collections.IEnumerable]) {
        $stable = [System.Collections.Generic.List[object]]::new()
        foreach ($item in $Value) {
            $stable.Add((ConvertTo-StableHistoricalValue -Value $item -RootReplacements $RootReplacements))
        }
        return ,$stable.ToArray()
    }
    return $Value
}

function Get-HistoricalGeneratedContract {
    param(
        [Parameter(Mandatory)][object]$HistoricalCase,
        [Parameter(Mandatory)][object]$InputObject
    )

    $rootReplacements = @($InputObject.policy.roots.PSObject.Properties | ForEach-Object {
        [pscustomobject]@{
            role = [string]$_.Name
            path = [System.IO.Path]::GetFullPath([string]$_.Value)
            token = "<ROOT:$([string]$_.Name)>"
        }
    } | Sort-Object @{ Expression = { $_.path.Length }; Descending = $true }, role)
    $normalizedInput = ConvertTo-StableHistoricalValue -Value $InputObject -RootReplacements $rootReplacements
    [string[]]$expectedViolations = @(
        $HistoricalCase.expected_violations | ForEach-Object { [string]$_ } | Sort-Object
    )
    $contract = [ordered]@{
        schema_version = 'codex-evidence-generated-contract/v1'
        case_id = [string]$HistoricalCase.id
        binding_id = [string]$HistoricalCase.binding_id
        input = $normalizedInput
        expected = [ordered]@{
            verdict = [string]$HistoricalCase.expected_verdict
            semantic_disposition = [string]$HistoricalCase.expected_semantic
            violations = @($expectedViolations)
        }
    }
    return [pscustomobject]@{
        material = $contract
        sha256 = Get-CodexCanonicalHash -InputObject $contract
    }
}

function Get-ProjectionRecord {
    param(
        [Parameter(Mandatory)][object]$Document,
        [Parameter(Mandatory)][string]$Pointer
    )

    $current = $Document
    foreach ($encoded in @($Pointer.TrimStart('/').Split('/'))) {
        $segment = $encoded.Replace('~1', '/').Replace('~0', '~')
        $property = $current.PSObject.Properties[$segment]
        if ($null -eq $property) {
            throw "historical_projection_pointer_missing:$Pointer"
        }
        $current = $property.Value
    }
    $type = if ($null -eq $current) {
        'null'
    }
    elseif ($current -is [string]) {
        'string'
    }
    elseif ($current -is [bool]) {
        'boolean'
    }
    elseif ($current -is [System.Array] -or $current -is [System.Collections.IList]) {
        'array'
    }
    elseif ($current -is [pscustomobject] -or $current -is [System.Collections.IDictionary]) {
        'object'
    }
    else {
        'number'
    }
    $count = if ($type -eq 'array') {
        @($current).Count
    }
    elseif ($type -eq 'object') {
        @($current.PSObject.Properties).Count
    }
    else {
        1
    }
    return [ordered]@{
        pointer = $Pointer
        type = $type
        count = $count
        sha256 = Get-CodexCanonicalHash -InputObject ([ordered]@{ value = $current })
    }
}

function Test-HistoricalSourceProjection {
    param([Parameter(Mandatory)][object]$Binding)

    $declaration = Get-HistoricalBindingDeclaration -Binding $Binding
    if (-not $declaration.valid) {
        return $false
    }
    $entry = Get-LocalSealedInputByKey -Key ([string]$Binding.source_keys[0])
    $capture = Read-ContainedSealedCapture -Entry $entry
    if ($capture.length -ne [int64]$entry.length -or
        $capture.sha256 -cne ([string]$entry.sha256).ToLowerInvariant()) {
        return $false
    }
    $document = $capture.text | ConvertFrom-Json -Depth 100
    $projection = @($Binding.selectors | ForEach-Object {
        Get-ProjectionRecord -Document $document -Pointer ([string]$_)
    })
    return (Get-CodexCanonicalHash -InputObject $projection) -ceq
        ([string]$Binding.projection_sha256).ToLowerInvariant()
}

function Test-SealedLocatorGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $tests = [System.Collections.Generic.List[object]]::new()
    foreach ($case in @(
        [ordered]@{ id = 'traversal'; locator = '.eval-runs/../README.md' },
        [ordered]@{ id = 'rooted'; locator = (Join-Path $repoRoot 'README.md') },
        [ordered]@{ id = 'alternate-root'; locator = 'evals/README.md' }
    )) {
        $rejected = $false
        try {
            [void](Resolve-ContainedSealedLocator -Entry ([pscustomobject]@{
                relative_locator = $case.locator
            }))
        }
        catch {
            $rejected = $true
        }
        $tests.Add([ordered]@{ id = $case.id; passed = $rejected })
    }
    $guardFull = [System.IO.Path]::GetFullPath($GuardRoot)
    $scratchPrefix = $scratchFull + [System.IO.Path]::DirectorySeparatorChar
    if (-not $guardFull.StartsWith($scratchPrefix, $comparison)) {
        throw 'reparse_guard_outside_controller_scratch'
    }
    [void](New-Item -ItemType Directory -Path $guardFull -Force)
    $targetFull = [System.IO.Path]::GetFullPath((Join-Path $guardFull 'retained-target'))
    $linkFull = [System.IO.Path]::GetFullPath((Join-Path $guardFull 'sealed-link'))
    [void](New-Item -ItemType Directory -Path $targetFull -Force)
    $sentinel = Join-Path $targetFull 'sentinel.json'
    [byte[]]$sentinelBytes = [System.Text.UTF8Encoding]::new($false).GetBytes('{"retained":true}')
    [System.IO.File]::WriteAllBytes($sentinel, $sentinelBytes)
    $sentinelHash = Get-Sha256HexFromBytes -Bytes $sentinelBytes
    $linkItemType = if ($IsWindows) { 'Junction' } else { 'SymbolicLink' }
    $currentPlatform = if ($IsWindows) { 'Windows' } else { 'non-Windows' }
    $unexecutedPlatformBranch = if ($IsWindows) {
        'non-Windows/SymbolicLink:UNKNOWN'
    }
    else {
        'Windows/Junction:UNKNOWN'
    }
    $guardPrefix = $guardFull + [System.IO.Path]::DirectorySeparatorChar
    $linkCreated = $false
    $observedLinkType = 'NOT_CREATED'
    $rejected = $false
    try {
        [void](New-Item -ItemType $linkItemType -Path $linkFull -Target $targetFull)
        $linkCreated = $true
        $linkItem = Get-Item -LiteralPath $linkFull -Force
        $observedLinkType = [string]$linkItem.LinkType
        $linkTargets = @($linkItem.Target)
        $targetIdentity = if ($linkTargets.Count -eq 1) {
            $targetText = [string]$linkTargets[0]
            if ([System.IO.Path]::IsPathRooted($targetText)) {
                [System.IO.Path]::GetFullPath($targetText)
            }
            else {
                [System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $linkFull) $targetText))
            }
        }
        else {
            ''
        }
        if (-not (Test-ReparseFreeAttributes -Attributes $linkItem.Attributes) -and
            $observedLinkType -ceq $linkItemType -and
            $linkFull.StartsWith($guardPrefix, $comparison) -and
            $targetFull.StartsWith($guardPrefix, $comparison) -and
            $targetIdentity.Equals($targetFull, $comparison)) {
            $throughLink = Join-Path $linkFull 'sentinel.json'
            $locator = [System.IO.Path]::GetRelativePath($repoRoot, $throughLink)
            try {
                [void](Resolve-ContainedSealedLocator -Entry ([pscustomobject]@{
                    relative_locator = $locator
                }))
            }
            catch {
                $rejected = $_.Exception.Message -like '*sealed_locator_reparse_component*'
            }
        }
    }
    finally {
        if ($linkCreated -and (Test-Path -LiteralPath $linkFull)) {
            $linkItem = Get-Item -LiteralPath $linkFull -Force
            $linkTargets = @($linkItem.Target)
            $targetIdentity = if ($linkTargets.Count -eq 1) {
                $targetText = [string]$linkTargets[0]
                if ([System.IO.Path]::IsPathRooted($targetText)) {
                    [System.IO.Path]::GetFullPath($targetText)
                }
                else {
                    [System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $linkFull) $targetText))
                }
            }
            else {
                ''
            }
            if ((Test-ReparseFreeAttributes -Attributes $linkItem.Attributes) -or
                [string]$linkItem.LinkType -cne $observedLinkType -or
                $observedLinkType -cne $linkItemType -or
                -not $targetIdentity.Equals($targetFull, $comparison) -or
                -not $linkFull.StartsWith($guardPrefix, $comparison) -or
                -not $targetFull.StartsWith($guardPrefix, $comparison)) {
                throw 'refusing_to_remove_unconfirmed_scratch_directory_link'
            }
            [System.IO.Directory]::Delete($linkFull, $false)
        }
    }
    $targetRetained = (
        -not (Test-Path -LiteralPath $linkFull) -and
        (Test-Path -LiteralPath $targetFull -PathType Container) -and
        (Test-Path -LiteralPath $sentinel -PathType Leaf) -and
        (Get-FileHash -LiteralPath $sentinel -Algorithm SHA256).Hash.ToLowerInvariant() -ceq $sentinelHash
    )
    $tests.Add([ordered]@{
        id = 'real-reparse-component'
        passed = ($rejected -and $targetRetained)
        current_platform = $currentPlatform
        selected_primitive = $linkItemType
        selected_link_type = $observedLinkType
        target_retained = $targetRetained
        unexecuted_platform_branch = $unexecutedPlatformBranch
    })
    return @($tests)
}

function Get-DirectoryLinkTargetIdentity {
    param(
        [Parameter(Mandatory)][string]$LinkPath,
        [Parameter(Mandatory)][object]$LinkItem
    )

    $targets = @($LinkItem.Target)
    if ($targets.Count -ne 1) {
        return ''
    }
    $targetText = [string]$targets[0]
    if ([System.IO.Path]::IsPathRooted($targetText)) {
        return [System.IO.Path]::GetFullPath($targetText)
    }
    return [System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $LinkPath) $targetText))
}

function Remove-ConfirmedScratchDirectoryLink {
    param(
        [Parameter(Mandatory)][string]$LinkPath,
        [Parameter(Mandatory)][string]$TargetPath,
        [Parameter(Mandatory)][string]$AllowedRoot,
        [Parameter(Mandatory)][string]$ExpectedLinkType,
        [Parameter(Mandatory)][string]$SentinelPath,
        [Parameter(Mandatory)][string]$SentinelSha256
    )

    $linkFull = [System.IO.Path]::GetFullPath($LinkPath)
    $targetFull = [System.IO.Path]::GetFullPath($TargetPath)
    $allowedFull = [System.IO.Path]::GetFullPath($AllowedRoot)
    $allowedPrefix = $allowedFull + [System.IO.Path]::DirectorySeparatorChar
    if (-not $linkFull.StartsWith($allowedPrefix, $comparison) -or
        -not $targetFull.StartsWith($allowedPrefix, $comparison)) {
        throw 'refusing_to_remove_link_outside_scratch_guard'
    }
    $linkItem = Get-Item -LiteralPath $linkFull -Force
    $targetIdentity = Get-DirectoryLinkTargetIdentity -LinkPath $linkFull -LinkItem $linkItem
    if ((Test-ReparseFreeAttributes -Attributes $linkItem.Attributes) -or
        [string]$linkItem.LinkType -cne $ExpectedLinkType -or
        -not $targetIdentity.Equals($targetFull, $comparison)) {
        throw 'refusing_to_remove_unconfirmed_scratch_guard_link'
    }
    [System.IO.Directory]::Delete($linkFull, $false)
    if ((Test-Path -LiteralPath $linkFull) -or
        -not (Test-Path -LiteralPath $targetFull -PathType Container) -or
        -not (Test-Path -LiteralPath $SentinelPath -PathType Leaf) -or
        (Get-FileHash -LiteralPath $SentinelPath -Algorithm SHA256).Hash.ToLowerInvariant() -cne
            $SentinelSha256) {
        throw 'scratch_guard_target_not_retained_after_link_removal'
    }
}

function Test-ScratchTopologyGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $guardFull = [System.IO.Path]::GetFullPath($GuardRoot)
    $scratchPrefix = $scratchFull + [System.IO.Path]::DirectorySeparatorChar
    if (-not $guardFull.StartsWith($scratchPrefix, $comparison)) {
        throw 'scratch_topology_guard_outside_controller_scratch'
    }
    [void][System.IO.Directory]::CreateDirectory($guardFull)
    $linkItemType = if ($IsWindows) { 'Junction' } else { 'SymbolicLink' }
    $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
    $tests = [System.Collections.Generic.List[object]]::new()

    $preexistingRootCase = Join-Path $guardFull 'preexisting-run-root-reparse'
    $preexistingRepo = Join-Path $preexistingRootCase 'repo'
    $preexistingTarget = Join-Path $preexistingRootCase 'retained-target'
    [void][System.IO.Directory]::CreateDirectory($preexistingRepo)
    [void][System.IO.Directory]::CreateDirectory($preexistingTarget)
    $preexistingSentinel = Join-Path $preexistingTarget 'sentinel.json'
    [byte[]]$preexistingBytes = $utf8NoBom.GetBytes('{"retained":"preexisting-root"}')
    [System.IO.File]::WriteAllBytes($preexistingSentinel, $preexistingBytes)
    $preexistingHash = Get-Sha256HexFromBytes -Bytes $preexistingBytes
    $preexistingLink = Join-Path $preexistingRepo '.eval-runs'
    [void](New-Item -ItemType $linkItemType -Path $preexistingLink -Target $preexistingTarget)
    $preexistingRejected = $false
    $preexistingReason = ''
    try {
        try {
            [void](Assert-ControllerRunRoot `
                -RepositoryRoot $preexistingRepo `
                -RunRoot $preexistingLink `
                -CreateIfMissing)
        }
        catch {
            $preexistingReason = [string]$_.Exception.Message
            $preexistingRejected = $preexistingReason -ceq 'controller_run_root_is_reparse'
        }
    }
    finally {
        Remove-ConfirmedScratchDirectoryLink `
            -LinkPath $preexistingLink `
            -TargetPath $preexistingTarget `
            -AllowedRoot $preexistingRootCase `
            -ExpectedLinkType $linkItemType `
            -SentinelPath $preexistingSentinel `
            -SentinelSha256 $preexistingHash
    }
    $tests.Add([ordered]@{
        id = 'preexisting-run-root-reparse-refused'
        passed = $preexistingRejected
        reason = $preexistingReason
        target_retained = (Test-Path -LiteralPath $preexistingSentinel -PathType Leaf)
    })

    $cleanupRootCase = Join-Path $guardFull 'cleanup-run-root-drift'
    $cleanupRootRepo = Join-Path $cleanupRootCase 'repo'
    $cleanupRootTarget = Join-Path $cleanupRootCase 'retained-target'
    $cleanupRootScratchLeaf = 'fixture-check-codex-evidence-controller-' +
        [guid]::NewGuid().ToString('N')
    $cleanupRootTargetScratch = Join-Path $cleanupRootTarget $cleanupRootScratchLeaf
    [void][System.IO.Directory]::CreateDirectory($cleanupRootRepo)
    [void][System.IO.Directory]::CreateDirectory($cleanupRootTargetScratch)
    $cleanupRootSentinel = Join-Path $cleanupRootTargetScratch 'sentinel.json'
    [byte[]]$cleanupRootBytes = $utf8NoBom.GetBytes('{"retained":"cleanup-root-drift"}')
    [System.IO.File]::WriteAllBytes($cleanupRootSentinel, $cleanupRootBytes)
    $cleanupRootHash = Get-Sha256HexFromBytes -Bytes $cleanupRootBytes
    $cleanupRootLink = Join-Path $cleanupRootRepo '.eval-runs'
    [void](New-Item -ItemType $linkItemType -Path $cleanupRootLink -Target $cleanupRootTarget)
    $cleanupRootScratch = Join-Path $cleanupRootLink $cleanupRootScratchLeaf
    try {
        $cleanupRootDisposition = Get-ControllerScratchCleanupDisposition `
            -RepositoryRoot $cleanupRootRepo `
            -RunRoot $cleanupRootLink `
            -ScratchRoot $cleanupRootScratch
    }
    finally {
        Remove-ConfirmedScratchDirectoryLink `
            -LinkPath $cleanupRootLink `
            -TargetPath $cleanupRootTarget `
            -AllowedRoot $cleanupRootCase `
            -ExpectedLinkType $linkItemType `
            -SentinelPath $cleanupRootSentinel `
            -SentinelSha256 $cleanupRootHash
    }

    $cleanupScratchCase = Join-Path $guardFull 'cleanup-scratch-drift'
    $cleanupScratchRepo = Join-Path $cleanupScratchCase 'repo'
    $cleanupScratchRunRoot = Join-Path $cleanupScratchRepo '.eval-runs'
    $cleanupScratchTarget = Join-Path $cleanupScratchCase 'retained-target'
    $cleanupScratchLeaf = 'fixture-check-codex-evidence-controller-' +
        [guid]::NewGuid().ToString('N')
    $cleanupScratchLink = Join-Path $cleanupScratchRunRoot $cleanupScratchLeaf
    [void][System.IO.Directory]::CreateDirectory($cleanupScratchRepo)
    [void](Assert-ControllerRunRoot `
        -RepositoryRoot $cleanupScratchRepo `
        -RunRoot $cleanupScratchRunRoot `
        -CreateIfMissing)
    [void][System.IO.Directory]::CreateDirectory($cleanupScratchTarget)
    $cleanupScratchSentinel = Join-Path $cleanupScratchTarget 'sentinel.json'
    [byte[]]$cleanupScratchBytes = $utf8NoBom.GetBytes('{"retained":"cleanup-scratch-drift"}')
    [System.IO.File]::WriteAllBytes($cleanupScratchSentinel, $cleanupScratchBytes)
    $cleanupScratchHash = Get-Sha256HexFromBytes -Bytes $cleanupScratchBytes
    [void](New-Item -ItemType $linkItemType -Path $cleanupScratchLink -Target $cleanupScratchTarget)
    try {
        $cleanupScratchDisposition = Get-ControllerScratchCleanupDisposition `
            -RepositoryRoot $cleanupScratchRepo `
            -RunRoot $cleanupScratchRunRoot `
            -ScratchRoot $cleanupScratchLink
    }
    finally {
        Remove-ConfirmedScratchDirectoryLink `
            -LinkPath $cleanupScratchLink `
            -TargetPath $cleanupScratchTarget `
            -AllowedRoot $cleanupScratchCase `
            -ExpectedLinkType $linkItemType `
            -SentinelPath $cleanupScratchSentinel `
            -SentinelSha256 $cleanupScratchHash
    }
    [void](Assert-ControllerRunRoot `
        -RepositoryRoot $cleanupScratchRepo `
        -RunRoot $cleanupScratchRunRoot)
    $cleanupDriftPassed = (
        -not $cleanupRootDisposition.safe -and
        $cleanupRootDisposition.residue -ceq 'retained_for_manual_disposition' -and
        $cleanupRootDisposition.reason -ceq 'controller_run_root_is_reparse' -and
        -not $cleanupScratchDisposition.safe -and
        $cleanupScratchDisposition.residue -ceq 'retained_for_manual_disposition' -and
        $cleanupScratchDisposition.reason -ceq 'controller_scratch_is_reparse' -and
        (Test-Path -LiteralPath $cleanupRootSentinel -PathType Leaf) -and
        (Test-Path -LiteralPath $cleanupScratchSentinel -PathType Leaf)
    )
    $tests.Add([ordered]@{
        id = 'cleanup-time-root-and-scratch-drift-retains-residue'
        passed = $cleanupDriftPassed
        run_root_reason = [string]$cleanupRootDisposition.reason
        scratch_reason = [string]$cleanupScratchDisposition.reason
        recursive_cleanup_performed = $false
    })
    return @($tests)
}

function Test-SealedByteCaptureGuard {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $guardFull = [System.IO.Path]::GetFullPath($GuardRoot)
    if (-not $guardFull.StartsWith($scratchFull + [System.IO.Path]::DirectorySeparatorChar, $comparison)) {
        throw 'sealed_capture_guard_outside_controller_scratch'
    }
    [void](New-Item -ItemType Directory -Path $guardFull -Force)
    $path = Join-Path $guardFull 'captured.json'
    [byte[]]$originalBytes = [System.Text.UTF8Encoding]::new($false).GetBytes('{"projection":{"value":"original"}}')
    [System.IO.File]::WriteAllBytes($path, $originalBytes)
    $entry = [pscustomobject]@{
        relative_locator = [System.IO.Path]::GetRelativePath($repoRoot, $path)
    }
    $capture = Read-ContainedSealedCapture -Entry $entry
    [byte[]]$replacementBytes = [System.Text.UTF8Encoding]::new($false).GetBytes('{"projection":{"value":"replacement"}}')
    [System.IO.File]::WriteAllBytes($path, $replacementBytes)
    $parsed = $capture.text | ConvertFrom-Json -Depth 10
    $passed = (
        $capture.stable_handle -and
        $capture.length -eq $originalBytes.LongLength -and
        $capture.sha256 -ceq (Get-Sha256HexFromBytes -Bytes $originalBytes) -and
        [string]$parsed.projection.value -ceq 'original' -and
        (Get-Sha256HexFromBytes -Bytes ([System.IO.File]::ReadAllBytes($path))) -cne $capture.sha256
    )
    return @([ordered]@{ id = 'same-captured-bytes-for-hash-and-parse'; passed = $passed })
}

function Test-HistoricalBindingGuards {
    $tests = [System.Collections.Generic.List[object]]::new()
    $original = Get-HistoricalBindingById -Id 'R01'

    $unknown = Copy-ControllerValue -Value $original
    $unknown.source_keys = @('UNKNOWN_SOURCE')
    $rejected = $false
    try { [void](Get-HistoricalBindingDeclaration -Binding $unknown) } catch { $rejected = $true }
    $tests.Add([ordered]@{ id = 'unknown-source'; passed = $rejected })

    $unrelated = Copy-ControllerValue -Value $original
    $unrelated.source_keys = @('S72_A13')
    $unrelatedDeclaration = Get-HistoricalBindingDeclaration -Binding $unrelated
    $tests.Add([ordered]@{ id = 'unrelated-source'; passed = -not $unrelatedDeclaration.valid })

    $missing = $false
    try { [void](Get-HistoricalBindingById -Id 'MISSING_BINDING') } catch { $missing = $true }
    $tests.Add([ordered]@{ id = 'missing-binding'; passed = $missing })

    $changed = Copy-ControllerValue -Value $original
    $changed.input_spec.scenario = 'changed-scenario'
    $changedDeclaration = Get-HistoricalBindingDeclaration -Binding $changed
    $tests.Add([ordered]@{ id = 'changed-mapping'; passed = -not $changedDeclaration.valid })

    return @($tests)
}

function Test-HistoricalGeneratedContractGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $tests = [System.Collections.Generic.List[object]]::new()
    $binding = Get-HistoricalBindingById -Id 'R02'
    $historicalCase = Get-HistoricalCaseById -Id 'R02'
    $baseInput = New-HistoricalInput -Binding $binding -CaseRoot (Join-Path $GuardRoot 'base')
    $baseContract = Get-HistoricalGeneratedContract -HistoricalCase $historicalCase -InputObject $baseInput
    $baseMatches = (
        (Get-HistoricalBindingDeclaration -Binding $binding).valid -and
        $baseContract.sha256 -ceq ([string]$historicalCase.generated_contract_sha256).ToLowerInvariant()
    )

    $commandDrift = Copy-ControllerValue -Value $baseInput
    $commandDrift.evidence.commands[0].command = [string]$commandDrift.evidence.commands[0].command + ' # changed'
    $commandContract = Get-HistoricalGeneratedContract -HistoricalCase $historicalCase -InputObject $commandDrift
    $tests.Add([ordered]@{
        id = 'generated-command-drift'
        passed = ($baseMatches -and $commandContract.sha256 -cne $baseContract.sha256)
    })

    $effectDrift = Copy-ControllerValue -Value $baseInput
    $effectDrift.evidence.commands[0].command_actions[0].type = 'write'
    $effectContract = Get-HistoricalGeneratedContract -HistoricalCase $historicalCase -InputObject $effectDrift
    $tests.Add([ordered]@{
        id = 'generated-effect-drift'
        passed = ($baseMatches -and $effectContract.sha256 -cne $baseContract.sha256)
    })

    $expectedDrift = Copy-ControllerValue -Value $historicalCase
    $expectedDrift.expected_verdict = 'CONTROLLER_UNKNOWN'
    $expectedContract = Get-HistoricalGeneratedContract -HistoricalCase $expectedDrift -InputObject $baseInput
    $tests.Add([ordered]@{
        id = 'generated-expected-result-drift'
        passed = ($baseMatches -and $expectedContract.sha256 -cne $baseContract.sha256)
    })

    return @($tests)
}

function New-HistoricalInput {
    param(
        [Parameter(Mandatory)][object]$Binding,
        [Parameter(Mandatory)][string]$CaseRoot
    )

    $inputObject = New-BaseControllerInput -Candidate $Binding.input_spec.candidate -CaseRoot $CaseRoot
    switch ([string]$Binding.input_spec.scenario) {
        'unknown-action-exact-candidate-read' {
            Add-RequiredRead -InputObject $inputObject -Root candidate -Path 'SKILL.md'
            Add-RequiredRead -InputObject $inputObject -Root candidate -Path 'references/coordination-and-recovery.md'
            $inputObject.evidence.commands = @(
                (New-ReadRecord -InputObject $inputObject -Root candidate -RelativePath 'SKILL.md' -ActionType unknown),
                (New-ReadRecord -InputObject $inputObject -Root candidate -RelativePath 'references/coordination-and-recovery.md' -ActionType unknown)
            )
        }
        'authorized-project-reads-and-git' {
            foreach ($path in @('WORK.md', 'STATUS.md', 'EVIDENCE.md')) {
                Add-RequiredRead -InputObject $inputObject -Root workspace -Path $path
            }
            $inputObject.evidence.commands = @(
                (New-ReadRecord -InputObject $inputObject -Root workspace -RelativePath 'WORK.md' -UseRelativePath),
                (New-ReadRecord -InputObject $inputObject -Root workspace -RelativePath 'STATUS.md' -UseRelativePath),
                (New-ReadRecord -InputObject $inputObject -Root workspace -RelativePath 'EVIDENCE.md' -UseRelativePath),
                (New-ScriptRecord -InputObject $inputObject -Script 'git -c core.fsmonitor=false --no-pager --no-optional-locks status --short --branch; git --no-pager rev-parse HEAD')
            )
        }
        'equivalent-natural-language' {
            $inputObject.evidence.free_text = @([pscustomobject]@{
                protocol = 'natural-language'
                text = 'The response states the same authority and recovery boundary in ordinary language.'
            })
        }
        'compound-read-only-git' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script 'git --no-pager rev-parse --show-toplevel; git --no-pager branch --show-current; git -c core.fsmonitor=false --no-pager --no-optional-locks status --short --branch; git --no-pager worktree list --porcelain')
            )
        }
        'skill-reference-from-command-cwd' {
            Add-RequiredRead -InputObject $inputObject -Root candidate -Path 'references/coordination-and-recovery.md'
            $inputObject.evidence.commands = @(
                (New-ReadRecord -InputObject $inputObject -Root candidate -RelativePath 'references/coordination-and-recovery.md' -CwdRoot candidate -UseRelativePath)
            )
        }
        'equivalent-role-wording-with-real-structural-violations' {
            $inputObject.evidence.free_text = @(
                [pscustomobject]@{ protocol = 'natural-language'; text = 'Top, Planner, and Executor describe equivalent bounded responsibilities without fixed marker phrases.' }
            )
            $inputObject.evidence.role_deliveries = @(
                [pscustomobject]@{ role = 'Orchestrator'; authorized = $false }
            )
            $inputObject.evidence.nested_turn_count = 1
        }
        'authorized-snapshot-read' {
            Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'SNAPSHOT.md'
            $inputObject.evidence.commands = @(
                (New-ReadRecord -InputObject $inputObject -Root workspace -RelativePath 'SNAPSHOT.md' -UseRelativePath)
            )
        }
        'directory-before-manifest-and-reconcile-before-seal' {
            $inputObject.evidence.construction_events = @(
                [pscustomobject]@{ event = 'directory-created' },
                [pscustomobject]@{ event = 'manifest-written' },
                [pscustomobject]@{ event = 'reconciliation-complete' },
                [pscustomobject]@{ event = 'sealed' }
            )
        }
        'inventory-order-independent' {
            $inputObject.evidence.inventory_comparisons = @(
                [pscustomobject]@{
                    name = 'successor-inventory'
                    left = @(
                        [pscustomobject]@{ path = 'b.txt'; length = 2; sha256 = ('b' * 64) },
                        [pscustomobject]@{ path = 'a.txt'; length = 1; sha256 = ('a' * 64) }
                    )
                    right = @(
                        [pscustomobject]@{ path = 'a.txt'; length = 1; sha256 = ('a' * 64) },
                        [pscustomobject]@{ path = 'b.txt'; length = 2; sha256 = ('b' * 64) }
                    )
                }
            )
        }
        'positional-read-and-declined-diagnostic' {
            Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
            $inputObject.evidence.commands = @(
                (New-ReadRecord -InputObject $inputObject -Root workspace -RelativePath 'WORK.md' -Shape positional -UseRelativePath),
                (New-ScriptRecord -InputObject $inputObject -Script 'git status --short --branch; git worktree list --porcelain' -Status declined)
            )
        }
        'same-logical-candidate-different-successor-locator' {
            $inputObject.evidence.candidate_identity.locator = 'different-successor-root'
        }
        default { throw "Unhandled historical scenario: $($Binding.input_spec.scenario)" }
    }
    return $inputObject
}

function New-NegativeInput {
    param(
        [Parameter(Mandatory)][object]$Case,
        [Parameter(Mandatory)][string]$CaseRoot
    )

    $inputObject = New-BaseControllerInput -Candidate b965102 -CaseRoot $CaseRoot
    switch ($Case.scenario) {
        'wrong-candidate-sha' {
            $inputObject.evidence.candidate_identity.candidate_sha = ('0' * 40)
        }
        'wrong-content-hash' {
            $inputObject.evidence.candidate_identity.content_output_sha256 = ('0' * 64)
            $inputObject.evidence.commands = @(
                (New-ReadRecord -InputObject $inputObject -Root candidate -RelativePath 'SKILL.md' -ProofSha256 ('0' * 64))
            )
        }
        'path-traversal' {
            $cwd = [string]$inputObject.policy.roots.workspace
            $script = "Get-Content -LiteralPath '..\\outside.md' -Raw"
            $inputObject.evidence.commands = @([pscustomobject]@{
                status = 'completed'; exit_code = 0; cwd = $cwd; command = $script
                resolved_command_identity = Get-SyntheticResolvedCommandIdentity `
                    -InputObject $inputObject `
                    -Family 'powershell-management'
                command_actions = @([pscustomobject]@{
                    type = 'unknown'; command = $script; file_proofs = @()
                })
            })
        }
        'unauthorized-read' {
            $cwd = [string]$inputObject.policy.roots.workspace
            $target = Join-Path ([string]$inputObject.policy.roots.unexpected) 'SKILL.md'
            $script = "Get-Content -LiteralPath '$target' -Raw"
            $inputObject.evidence.commands = @([pscustomobject]@{
                status = 'completed'; exit_code = 0; cwd = $cwd; command = $script
                resolved_command_identity = Get-SyntheticResolvedCommandIdentity `
                    -InputObject $inputObject `
                    -Family 'powershell-management'
                command_actions = @([pscustomobject]@{
                    type = 'unknown'; command = $script; file_proofs = @(
                        [pscustomobject]@{ root = 'unexpected'; path = 'SKILL.md'; length = 1; sha256 = ('9' * 64) }
                    )
                })
            })
        }
        'completed-write' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script "Set-Content -LiteralPath '.\\WORK.md' -Value 'changed'")
            )
        }
        'git-mutation' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script 'git checkout -b unsafe-branch')
            )
        }
        'same-locator-different-subject' {
            $inputObject.evidence.candidate_identity.stable_subject = 'different logical work subject'
        }
        'assessor-requested-on-unknown' {
            $record = New-ReadRecord -InputObject $inputObject -Root candidate -RelativePath 'SKILL.md' -OmitActions
            $inputObject.evidence.commands = @($record)
            $inputObject.evidence.assessor_requested = $true
        }
        'failed-write-execution' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script "Set-Content -LiteralPath '.\WORK.md' -Value 'changed'" -Status failed)
            )
        }
        'git-diff-output' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script 'git --no-pager diff --no-textconv --output=probe.patch')
            )
        }
        'git-outside-root-cwd' {
            $outside = Join-Path (Split-Path -Parent $CaseRoot) 'outside-git-root'
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script "git -c core.fsmonitor=false -C '$outside' --no-pager --no-optional-locks status --short")
            )
        }
        'git-config-injection' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script 'git -c core.fsmonitor=true status --short')
            )
        }
        'partial-get-content' {
            Add-RequiredRead -InputObject $inputObject -Root candidate -Path 'SKILL.md'
            $inputObject.evidence.commands = @(
                (New-ReadRecord -InputObject $inputObject -Root candidate -RelativePath 'SKILL.md' -Shape total-count)
            )
        }
        'git-log-show-signature' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script 'git log --show-signature -1')
            )
        }
        'git-show-show-signature' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script 'git show --show-signature HEAD')
            )
        }
        'git-cat-file-filters' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script 'git --no-pager cat-file --filters --path=WORK.md HEAD:WORK.md')
            )
        }
        'manifest-after-reconciliation' {
            $inputObject.evidence.construction_events = @(
                [pscustomobject]@{ event = 'directory-created' },
                [pscustomobject]@{ event = 'reconciliation-complete' },
                [pscustomobject]@{ event = 'manifest-written' },
                [pscustomobject]@{ event = 'sealed' }
            )
        }
        'powershell-wrapper-working-directory' {
            Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script (
                    'pwsh -WorkingDirectory other-root -Command "Get-Content WORK.md"'
                ))
            )
        }
        'powershell-wrapper-file-mode' {
            Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script (
                    'pwsh -File untrusted.ps1 -Command "Get-Content WORK.md"'
                ))
            )
        }
        'post-seal-manifest-rewrite' {
            $inputObject.evidence.construction_events = @(
                [pscustomobject]@{ event = 'directory-created' },
                [pscustomobject]@{ event = 'manifest-written' },
                [pscustomobject]@{ event = 'reconciliation-complete' },
                [pscustomobject]@{ event = 'sealed' },
                [pscustomobject]@{ event = 'manifest-written' }
            )
        }
        'unclassified-dotnet-expression' {
            Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
            $record = New-ReadRecord `
                -InputObject $inputObject `
                -Root workspace `
                -RelativePath 'WORK.md'
            $script = "Get-Content WORK.md; [System.IO.File]::WriteAllText('other.txt','x')"
            $record.command = $script
            $record.command_actions[0].command = $script
            $inputObject.evidence.commands = @($record)
        }
        'powershell-wrapper-redirection' {
            Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
            $record = New-ReadRecord `
                -InputObject $inputObject `
                -Root workspace `
                -RelativePath 'WORK.md'
            $script = 'pwsh -NoProfile -Command "Get-Content WORK.md" > redirected.txt'
            $record.command = $script
            $record.command_actions[0].command = $script
            $inputObject.evidence.commands = @($record)
        }
        'git-diff-without-no-textconv' {
            $inputObject.evidence.commands = @(
                (New-ScriptRecord -InputObject $inputObject -Script 'git --no-pager diff --stat')
            )
        }
        'untrusted-powershell-wrapper' {
            Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
            $record = New-ReadRecord `
                -InputObject $inputObject `
                -Root workspace `
                -RelativePath 'WORK.md'
            $trustedWrapperPath = [string]$record.resolved_wrapper_identity.resolved_path
            $shadowWrapperPath = Join-Path $inputObject.policy.roots.unexpected 'pwsh.exe'
            $record.command = $record.command.Replace(
                $trustedWrapperPath,
                $shadowWrapperPath
            )
            $inputObject.evidence.commands = @($record)
        }
        'powershell-wrapper-outer-side-effect' {
            Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
            $record = New-ReadRecord `
                -InputObject $inputObject `
                -Root workspace `
                -RelativePath 'WORK.md'
            $script = "[System.IO.File]::WriteAllText('other.txt','x'); $($record.command)"
            $record.command = $script
            $record.command_actions[0].command = $script
            $inputObject.evidence.commands = @($record)
        }
        'policy-roots-missing' {
            $inputObject.evidence.commands = @(
                (New-ReadRecord `
                    -InputObject $inputObject `
                    -Root workspace `
                    -RelativePath 'WORK.md')
            )
            $inputObject.policy.PSObject.Properties.Remove('roots')
        }
        'required-read-missing-root' {
            $inputObject.policy.required_reads = @(
                [pscustomobject]@{ path = 'SKILL.md' }
            )
        }
        'inventory-comparison-missing-side' {
            $inputObject.evidence.inventory_comparisons = @(
                [pscustomobject]@{ name = 'missing-right'; left = @() }
            )
        }
        'construction-event-missing-event' {
            $inputObject.evidence.construction_events = @(
                [pscustomobject]@{}
            )
        }
        'shadowed-git-executable-path' {
            $shadowGit = Join-Path $inputObject.policy.roots.unexpected 'git.exe'
            $script = "& '$shadowGit' --no-pager rev-parse HEAD"
            $record = New-ScriptRecord -InputObject $inputObject -Script 'git --no-pager rev-parse HEAD'
            $record.command = $script
            $record.command_actions[0].command = $script
            $inputObject.evidence.commands = @($record)
        }
        default { throw "Unhandled negative scenario: $($Case.scenario)" }
    }
    return $inputObject
}

function Get-MetamorphicInputs {
    param(
        [Parameter(Mandatory)][object]$Case,
        [Parameter(Mandatory)][string]$CaseRoot
    )

    $left = New-BaseControllerInput -Candidate b965102 -CaseRoot (Join-Path $CaseRoot 'left')
    $right = New-BaseControllerInput -Candidate b965102 -CaseRoot (Join-Path $CaseRoot 'right')
    switch ($Case.scenario) {
        'get-content-parameter-order' {
            $left.evidence.commands = @(
                (New-ReadRecord -InputObject $left -Root candidate -RelativePath 'SKILL.md' -Shape literal-path-first)
            )
            $right.evidence.commands = @(
                (New-ReadRecord -InputObject $right -Root candidate -RelativePath 'SKILL.md' -Shape raw-first)
            )
        }
        'relative-versus-absolute-read' {
            $left.evidence.commands = @(
                (New-ReadRecord -InputObject $left -Root workspace -RelativePath 'WORK.md' -UseRelativePath)
            )
            $right.evidence.commands = @(
                (New-ReadRecord -InputObject $right -Root workspace -RelativePath 'WORK.md')
            )
        }
        'split-versus-compound-git' {
            $left.evidence.commands = @(
                (New-ScriptRecord -InputObject $left -Script 'git -c core.fsmonitor=false --no-pager --no-optional-locks status --short --branch'),
                (New-ScriptRecord -InputObject $left -Script 'git --no-pager rev-parse HEAD')
            )
            $right.evidence.commands = @(
                (New-ScriptRecord -InputObject $right -Script 'git -c core.fsmonitor=false --no-pager --no-optional-locks status --short --branch; git --no-pager rev-parse HEAD')
            )
        }
        'same-candidate-different-successor-roots' {
            $left.evidence.candidate_identity.locator = 'successor-a'
            $right.evidence.candidate_identity.locator = 'successor-b'
        }
        default { throw "Unhandled metamorphic scenario: $($Case.scenario)" }
    }
    return @($left, $right)
}

function Invoke-Suite {
    param([Parameter(Mandatory)][string]$SuiteRoot)

    $historical = [System.Collections.Generic.List[object]]::new()
    foreach ($case in @($cases.historical_cases)) {
        $binding = Get-HistoricalBindingById -Id ([string]$case.binding_id)
        $inputObject = New-HistoricalInput -Binding $binding -CaseRoot (Join-Path $SuiteRoot $case.id)
        $declaration = Get-HistoricalBindingDeclaration -Binding $binding
        $generatedContract = Get-HistoricalGeneratedContract -HistoricalCase $case -InputObject $inputObject
        $generatedMatches = $generatedContract.sha256 -ceq
            ([string]$case.generated_contract_sha256).ToLowerInvariant()
        $result = if ($declaration.valid -and $generatedMatches) {
            Invoke-CodexEvidenceController -Mode historical-import -InputObject $inputObject
        }
        else {
            $null
        }
        $expectedViolations = @(
            $case.expected_violations | ForEach-Object { [string]$_ } | Sort-Object
        )
        $actualViolations = @()
        if ($null -ne $result) {
            $actualViolations = @(
                $result.adjudication.violations | ForEach-Object { [string]$_ } | Sort-Object
            )
        }
        $violationsMatch = $expectedViolations.Count -eq $actualViolations.Count
        if ($violationsMatch) {
            for ($index = 0; $index -lt $expectedViolations.Count; $index++) {
                if ($expectedViolations[$index] -cne $actualViolations[$index]) {
                    $violationsMatch = $false
                    break
                }
            }
        }
        $passed = (
            $null -ne $result -and
            $result.adjudication.verdict -eq $case.expected_verdict -and
            $result.adjudication.semantic_disposition -eq $case.expected_semantic -and
            $violationsMatch
        )
        $historical.Add([ordered]@{
            id = $case.id
            passed = $passed
            verdict = if ($null -ne $result) { $result.adjudication.verdict } else { 'NOT_INVOKED' }
            semantic_disposition = if ($null -ne $result) { $result.adjudication.semantic_disposition } else { 'NOT_INVOKED' }
            source_binding_sha256 = ([string]$binding.binding_sha256).ToLowerInvariant()
            generated_contract_sha256 = $generatedContract.sha256
            generated_contract_verified = $generatedMatches
            expected_violations = @($expectedViolations)
            actual_violations = @($actualViolations)
            hash = if ($null -ne $result) {
                Get-CodexCanonicalHash -InputObject $result.adjudication
            }
            else {
                Get-CodexCanonicalHash -InputObject $generatedContract.material
            }
        })
    }

    $negative = [System.Collections.Generic.List[object]]::new()
    foreach ($case in @($cases.negative_cases)) {
        $inputObject = New-NegativeInput -Case $case -CaseRoot (Join-Path $SuiteRoot $case.id)
        $result = Invoke-CodexEvidenceController -Mode runtime -InputObject $inputObject
        $passed = ($result.adjudication.verdict -eq $case.expected_verdict)
        if ($case.id -eq 'N02') {
            $passed = $passed -and
                @($result.adjudication.violations) -contains 'logical_candidate_content_output_sha256_mismatch' -and
                @($result.adjudication.violations) -contains 'read_content_identity_mismatch'
        }
        elseif ($case.id -eq 'N09') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'failed_execution' -and
                @($result.adjudication.unknowns) -contains 'failed_attempted_write' -and
                @($result.adjudication.failed_diagnostics[0].outer_effects.kind) -contains 'write'
        }
        elseif ($case.id -eq 'N10') {
            $passed = $passed -and
                @($result.adjudication.violations) -contains 'completed_write'
        }
        elseif ($case.id -eq 'N11') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'git_cwd_not_authorized'
        }
        elseif ($case.id -eq 'N12') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'git_config_injection_not_admissible'
        }
        elseif ($case.id -eq 'N13') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'unsupported_get_content_parameter' -and
                @($result.adjudication.unknowns) -contains 'required_read_not_proven'
        }
        elseif ($case.id -in @('N14', 'N15')) {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'git_signature_verification_not_admissible'
        }
        elseif ($case.id -in @('N18', 'N19')) {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'powershell_wrapper_parameter_not_admissible'
        }
        elseif ($case.id -eq 'N20') {
            $passed = $passed -and
                @($result.adjudication.violations) -contains 'construction_order_violation'
        }
        elseif ($case.id -eq 'N21') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'unsupported_control_or_expansion_shape'
        }
        elseif ($case.id -eq 'N22') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'powershell_wrapper_redirection_not_admissible'
        }
        elseif ($case.id -eq 'N23') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'git_diff_requires_no_textconv'
        }
        elseif ($case.id -eq 'N24') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'resolved_wrapper_invocation_not_trusted'
        }
        elseif ($case.id -eq 'N25') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'powershell_wrapper_outer_shape_not_admissible'
        }
        elseif ($case.id -eq 'N30') {
            $passed = $passed -and
                @($result.adjudication.unknowns) -contains 'resolved_command_invocation_not_trusted'
        }
        $negative.Add([ordered]@{
            id = $case.id
            passed = $passed
            verdict = $result.adjudication.verdict
            hash = Get-CodexCanonicalHash -InputObject $result.adjudication
        })
    }

    $metamorphic = [System.Collections.Generic.List[object]]::new()
    foreach ($case in @($cases.metamorphic_pairs)) {
        $pair = Get-MetamorphicInputs -Case $case -CaseRoot (Join-Path $SuiteRoot $case.id)
        $left = Invoke-CodexEvidenceController -Mode runtime -InputObject $pair[0]
        $right = Invoke-CodexEvidenceController -Mode runtime -InputObject $pair[1]
        $leftJson = ConvertTo-CodexCanonicalJson -InputObject $left.adjudication
        $rightJson = ConvertTo-CodexCanonicalJson -InputObject $right.adjudication
        $metamorphic.Add([ordered]@{
            id = $case.id
            passed = ($leftJson -ceq $rightJson)
            hash = Get-CodexCanonicalHash -InputObject $left.adjudication
        })
    }

    $modeInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (Join-Path $SuiteRoot 'modes')
    $modeInput.evidence.free_text = @([pscustomobject]@{
        protocol = 'natural-language'
        text = 'This response requires independent semantic assessment.'
    })
    $modeHashes = [System.Collections.Generic.List[string]]::new()
    foreach ($mode in @('preflight', 'runtime', 'historical-import', 'terminal-stage')) {
        $modeResult = Invoke-CodexEvidenceController -Mode $mode -InputObject $modeInput
        $modeHashes.Add((Get-CodexCanonicalHash -InputObject $modeResult.adjudication))
    }

    $exactInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (Join-Path $SuiteRoot 'exact')
    $exactInput.evidence.free_text = @([pscustomobject]@{
        protocol = 'exact-response'
        text = 'READY'
        expected = 'READY'
    })
    $exactResult = Invoke-CodexEvidenceController -Mode preflight -InputObject $exactInput

    $gitContextInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (Join-Path $SuiteRoot 'git-context')
    $gitRoot = [string]$gitContextInput.policy.roots.workspace
    $gitContextInput.evidence.commands = @(
        (New-ScriptRecord -InputObject $gitContextInput -Script (
            "git -c 'safe.directory=$gitRoot' -c core.fsmonitor=false -C '$gitRoot' --no-pager --no-optional-locks status --short"
        ))
    )
    $gitContextResult = Invoke-CodexEvidenceController -Mode preflight -InputObject $gitContextInput

    return [ordered]@{
        schema_version = 'codex-evidence-controller-regression/v1'
        historical = @($historical)
        negative = @($negative)
        metamorphic = @($metamorphic)
        all_entry_modes_share_core = (@($modeHashes | Select-Object -Unique).Count -eq 1)
        exact_response_check = (
            $exactResult.adjudication.verdict -eq 'ADMISSIBLE' -and
            $exactResult.adjudication.semantic_disposition -eq 'EXACT_RESPONSE_CHECKED'
        )
        narrow_git_context_check = (
            $gitContextResult.adjudication.verdict -eq 'ADMISSIBLE' -and
            @($gitContextResult.adjudication.completed_effects).Count -eq 1 -and
            [string]$gitContextResult.adjudication.completed_effects[0].kind -eq 'git-read' -and
            [string]$gitContextResult.adjudication.completed_effects[0].root -eq 'workspace'
        )
        external_process_ledger = @()
        forbidden_invocation_count = 0
    }
}

function Test-PackageIdentity {
    $expectedRows = @($cases.entry_baseline.work_charter_files)
    $expected = @{}
    foreach ($row in $expectedRows) {
        if ($expected.ContainsKey([string]$row.path)) {
            return $false
        }
        $expected[[string]$row.path] = $row
    }
    $root = Join-Path $repoRoot 'skills\work-charter'
    $actual = @(Get-ChildItem -LiteralPath $root -Recurse -File | ForEach-Object {
        $_.FullName.Substring($root.Length + 1).Replace('\', '/')
    } | Sort-Object)
    if ((ConvertTo-CodexCanonicalJson $actual) -cne
        (ConvertTo-CodexCanonicalJson @($expected.Keys | Sort-Object))) {
        return $false
    }
    foreach ($path in $expected.Keys) {
        $item = Get-Item -LiteralPath (Join-Path $root $path)
        $hash = (Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($item.Length -ne [int64]$expected[$path].length -or
            $hash -cne ([string]$expected[$path].sha256).ToLowerInvariant()) {
            return $false
        }
    }
    return $true
}

function Get-Sha256HexFromBytes {
    param([Parameter(Mandatory)][byte[]]$Bytes)
    return [System.Convert]::ToHexString(
        [System.Security.Cryptography.SHA256]::HashData($Bytes)
    ).ToLowerInvariant()
}

function Invoke-ReadOnlyGitBytes {
    param(
        [Parameter(Mandatory)][string[]]$Arguments,
        [Parameter(Mandatory)][string]$Purpose
    )

    $gitCommand = Get-Command git -CommandType Application -ErrorAction Stop |
        Select-Object -First 1
    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $gitCommand.Source
    $startInfo.WorkingDirectory = $repoRoot
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    [void]$startInfo.ArgumentList.Add('--no-replace-objects')
    [void]$startInfo.ArgumentList.Add('-c')
    [void]$startInfo.ArgumentList.Add("safe.directory=$repoRoot")
    [void]$startInfo.ArgumentList.Add('-C')
    [void]$startInfo.ArgumentList.Add($repoRoot)
    foreach ($argument in $Arguments) {
        [void]$startInfo.ArgumentList.Add($argument)
    }

    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    $stdout = [System.IO.MemoryStream]::new()
    try {
        if (-not $process.Start()) {
            throw "Read-only Git process did not start: $Purpose"
        }
        $copyTask = $process.StandardOutput.BaseStream.CopyToAsync($stdout)
        $stderrTask = $process.StandardError.ReadToEndAsync()
        $process.WaitForExit()
        [void]$copyTask.GetAwaiter().GetResult()
        [void]$stderrTask.GetAwaiter().GetResult()
        $exitCode = $process.ExitCode
        $externalProcessLedger.Add([ordered]@{
            executable = 'git'
            purpose = $Purpose
            exit_code = $exitCode
            forbidden = $false
        })
        if ($exitCode -ne 0) {
            throw "Read-only Git process failed: $Purpose"
        }
        return $stdout.ToArray()
    }
    finally {
        $stdout.Dispose()
        $process.Dispose()
    }
}

function Get-GitPackageProof {
    param([Parameter(Mandatory)][string]$Name)

    $manifest = Get-PackageManifest -Name $Name
    $revision = [string]$manifest.revision
    $packagePath = [string]$manifest.relative_package_path
    $strictUtf8 = [System.Text.UTF8Encoding]::new($false, $true)

    $treeBytes = Invoke-ReadOnlyGitBytes -Arguments @(
        'rev-parse', "${revision}:$packagePath"
    ) -Purpose "package-tree-$Name"
    $tree = $strictUtf8.GetString($treeBytes).Trim()
    if ($tree -notmatch '^[0-9a-f]{40}$') {
        throw "Package tree identity is malformed: $Name"
    }

    $listingBytes = Invoke-ReadOnlyGitBytes -Arguments @(
        'ls-tree', '-r', '-z', $revision, '--', $packagePath
    ) -Purpose "package-list-$Name"
    $listing = $strictUtf8.GetString($listingBytes)
    $rows = [System.Collections.Generic.List[object]]::new()
    $seen = @{}
    foreach ($record in @($listing.Split([char]0, [System.StringSplitOptions]::RemoveEmptyEntries))) {
        if ($record -notmatch '^(?<mode>[0-9]{6}) blob (?<oid>[0-9a-f]{40})\t(?<path>.+)$') {
            throw "Package tree contains a non-ordinary or malformed entry: $Name"
        }
        $fullPath = [string]$Matches.path
        $prefix = $packagePath.TrimEnd('/') + '/'
        if (-not $fullPath.StartsWith($prefix, [System.StringComparison]::Ordinal)) {
            throw "Package entry escaped its declared tree: $Name"
        }
        $relativePath = $fullPath.Substring($prefix.Length)
        if ([string]$Matches.mode -cne '100644' -or [string]::IsNullOrWhiteSpace($relativePath) -or
            $relativePath.Contains('\') -or $relativePath.Split('/') -contains '..' -or
            $seen.ContainsKey($relativePath)) {
            throw "Package entry is not one unique ordinary file: $Name"
        }
        $seen[$relativePath] = $true
        $blobBytes = Invoke-ReadOnlyGitBytes -Arguments @(
            'cat-file', 'blob', [string]$Matches.oid
        ) -Purpose "package-blob-$Name-$relativePath"
        $rows.Add([ordered]@{
            path = $relativePath
            length = [int64]$blobBytes.LongLength
            sha256 = Get-Sha256HexFromBytes -Bytes $blobBytes
        })
    }
    return [pscustomobject]@{
        tree = $tree
        files = @($rows | Sort-Object path)
    }
}

function Test-PackageManifestDeclaredHash {
    param([Parameter(Mandatory)][object]$Manifest)
    $rows = @($Manifest.files | ForEach-Object {
        [ordered]@{
            path = [string]$_.path
            length = [int64]$_.length
            sha256 = ([string]$_.sha256).ToLowerInvariant()
        }
    } | Sort-Object path)
    return (
        $rows.Count -eq 5 -and
        @($rows.path | Select-Object -Unique).Count -eq $rows.Count -and
        (Get-CodexCanonicalHash -InputObject $rows) -ceq
            ([string]$Manifest.package_manifest_sha256).ToLowerInvariant()
    )
}

function Test-PackageManifestHashGuards {
    $checks = [System.Collections.Generic.List[object]]::new()
    foreach ($name in @('72db7e9', 'b965102')) {
        $changed = Copy-ControllerValue -Value (Get-PackageManifest -Name $name)
        $changed.package_manifest_sha256 = ('0' * 64)
        $checks.Add([ordered]@{
            id = "stale-hash-$name"
            passed = -not (Test-PackageManifestDeclaredHash -Manifest $changed)
        })
    }
    return @($checks)
}

function Get-PackageManifestChecks {
    $checks = [System.Collections.Generic.List[object]]::new()
    foreach ($name in @('72db7e9', 'b965102')) {
        $manifest = Get-PackageManifest -Name $name
        $identity = Get-CandidateIdentity -Name $name
        $declaredRows = @($manifest.files | ForEach-Object {
            [ordered]@{
                path = [string]$_.path
                length = [int64]$_.length
                sha256 = ([string]$_.sha256).ToLowerInvariant()
            }
        } | Sort-Object path)
        $uniquePaths = @($declaredRows.path | Select-Object -Unique).Count -eq $declaredRows.Count
        $declaredHash = Get-CodexCanonicalHash -InputObject $declaredRows
        $proof = Get-GitPackageProof -Name $name
        $actualHash = Get-CodexCanonicalHash -InputObject $proof.files
        $contentRows = @($declaredRows | Where-Object {
            [string]$_.path -cin @($manifest.content_output_paths)
        } | Sort-Object path)
        $entryBaselineMatch = $true
        if ($name -eq 'b965102') {
            $entryRows = @($cases.entry_baseline.work_charter_files | ForEach-Object {
                [ordered]@{
                    path = [string]$_.path
                    length = [int64]$_.length
                    sha256 = ([string]$_.sha256).ToLowerInvariant()
                }
            } | Sort-Object path)
            $entryBaselineMatch = (ConvertTo-CodexCanonicalJson -InputObject $entryRows) -ceq
                (ConvertTo-CodexCanonicalJson -InputObject $declaredRows)
        }
        $passed = (
            [string]$manifest.canonicalization -ceq 'canonical-json/path-sorted-five-file-rows/v1' -and
            (Test-PackageManifestDeclaredHash -Manifest $manifest) -and
            $declaredRows.Count -eq 5 -and $uniquePaths -and
            [string]$manifest.revision -ceq [string]$identity.candidate_sha -and
            [string]$manifest.relative_package_path -ceq [string]$identity.relative_package_path -and
            $declaredHash -ceq ([string]$manifest.package_manifest_sha256).ToLowerInvariant() -and
            $declaredHash -ceq ([string]$identity.package_manifest_sha256).ToLowerInvariant() -and
            [string]$proof.tree -ceq [string]$manifest.tree -and
            $actualHash -ceq $declaredHash -and
            (ConvertTo-CodexCanonicalJson -InputObject $proof.files) -ceq
                (ConvertTo-CodexCanonicalJson -InputObject $declaredRows) -and
            (Get-CodexCanonicalHash -InputObject $contentRows) -ceq
                ([string]$identity.content_output_sha256).ToLowerInvariant() -and
            $entryBaselineMatch
        )
        $checks.Add([ordered]@{
            id = $name
            passed = $passed
            package_manifest_sha256 = $declaredHash
            file_count = $declaredRows.Count
        })
    }
    return @($checks)
}

function Test-CandidateContentOutputs {
    foreach ($name in @('72db7e9', 'b965102')) {
        $identity = Get-CandidateIdentity -Name $name
        $manifest = Get-PackageManifest -Name $name
        $rows = @($manifest.files | Where-Object {
            [string]$_.path -cin @($manifest.content_output_paths)
        } | ForEach-Object {
            [ordered]@{
                path = [string]$_.path
                length = [int64]$_.length
                sha256 = ([string]$_.sha256).ToLowerInvariant()
            }
        } | Sort-Object path)
        if ((Get-CodexCanonicalHash -InputObject $rows) -cne
            ([string]$identity.content_output_sha256).ToLowerInvariant()) {
            return $false
        }
    }
    return $true
}

function Test-EntryBaseline {
    $baselineHash = Get-CodexCanonicalHash -InputObject $cases.entry_baseline
    $sealedKeyHash = Get-CodexCanonicalHash -InputObject @($cases.sealed_input_keys)
    return (
        $baselineHash -ceq [string]$cases.entry_baseline_sha256 -and
        $sealedKeyHash -ceq [string]$cases.entry_baseline.sealed_input_names_sha256 -and
        [string]$cases.entry_baseline.head -ceq 'b965102ea58f9cc1ef3c73e8dea515731fec12a6' -and
        [string]$cases.entry_baseline.upstream -ceq 'b965102ea58f9cc1ef3c73e8dea515731fec12a6' -and
        [string]$cases.entry_baseline.work_charter_package_tree -ceq '9111aba4cc141f52545f4ddfcf8d03db1e8f3189'
    )
}

function Get-HistoricalBindingChecks {
    $checks = [System.Collections.Generic.List[object]]::new()
    $caseIds = @($cases.historical_cases | ForEach-Object { [string]$_.id })
    $bindingIds = @($cases.historical_source_bindings | ForEach-Object { [string]$_.id })
    $setsMatch = (
        @($caseIds | Select-Object -Unique).Count -eq $caseIds.Count -and
        @($bindingIds | Select-Object -Unique).Count -eq $bindingIds.Count -and
        (ConvertTo-CodexCanonicalJson -InputObject @($caseIds | Sort-Object)) -ceq
            (ConvertTo-CodexCanonicalJson -InputObject @($bindingIds | Sort-Object))
    )
    foreach ($case in @($cases.historical_cases)) {
        $binding = Get-HistoricalBindingById -Id ([string]$case.binding_id)
        $declaration = Get-HistoricalBindingDeclaration -Binding $binding
        $inputObject = New-HistoricalInput -Binding $binding -CaseRoot (
            Join-Path $scratchFull ("binding-check-" + [string]$case.id)
        )
        $generatedContract = Get-HistoricalGeneratedContract -HistoricalCase $case -InputObject $inputObject
        $generatedContractVerified = $generatedContract.sha256 -ceq
            ([string]$case.generated_contract_sha256).ToLowerInvariant()
        $sourceVerified = if ($VerifyLocalSealedEvidence) {
            Test-HistoricalSourceProjection -Binding $binding
        }
        else {
            $null
        }
        $passed = (
            $setsMatch -and
            [string]$case.id -ceq [string]$case.binding_id -and
            [string]$case.id -ceq [string]$binding.id -and
            $declaration.valid -and
            $generatedContractVerified -and
            (-not $VerifyLocalSealedEvidence -or $sourceVerified)
        )
        $checks.Add([ordered]@{
            id = [string]$case.id
            passed = $passed
            declaration_sha256 = $declaration.actual_hash
            generated_contract_sha256 = $generatedContract.sha256
            source_projection = if ($VerifyLocalSealedEvidence) {
                if ($sourceVerified) { 'hash-exact' } else { 'DRIFT' }
            }
            else {
                'private-manifest-not-read'
            }
        })
    }
    return @($checks)
}

function Test-SealedInputs {
    $rows = [System.Collections.Generic.List[object]]::new()
    foreach ($entry in @($localSealedInputs)) {
        $contained = $false
        $capture = $null
        try {
            $capture = Read-ContainedSealedCapture -Entry $entry
            $contained = $true
        }
        catch {
            $contained = $false
        }
        $exists = $contained -and $null -ne $capture
        $match = $false
        if ($exists) {
            $match = (
                $capture.stable_handle -and
                $capture.length -eq [int64]$entry.length -and
                $capture.sha256 -ceq ([string]$entry.sha256).ToLowerInvariant()
            )
        }
        $rows.Add([ordered]@{
            key = $entry.key
            contained = $contained
            present = $exists
            hash_and_length_match = $match
        })
    }
    return @($rows)
}

function Test-ExternalInputTypeGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $checks = [System.Collections.Generic.List[object]]::new()

    $roleInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'role-authorization'
    )
    $roleInput.evidence.role_deliveries = @(
        [pscustomobject]@{ role = 'Executor'; authorized = 'false' }
    )
    $roleResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $roleInput
    $checks.Add([ordered]@{
        id = 'string-role-authorization-fails-closed'
        passed = (
            $roleResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($roleResult.adjudication.unknowns) -contains 'role_delivery_authorized_type_invalid'
        )
    })

    $countInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'nested-turn-counts'
    )
    $countInput.evidence.nested_turn_count = 'unknown'
    $countInput.policy.maximum_nested_turns = 'unknown'
    $countResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $countInput
    $checks.Add([ordered]@{
        id = 'invalid-nested-turn-counts-fail-closed'
        passed = (
            $countResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($countResult.adjudication.unknowns) -contains 'nested_turn_count_type_invalid' -and
            @($countResult.adjudication.unknowns) -contains 'maximum_nested_turns_type_invalid'
        )
    })

    $assessorInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'assessor-requested-type'
    )
    $assessorInput.evidence.assessor_requested = 'false'
    $assessorInput.evidence.commands = @(
        (New-ScriptRecord -InputObject $assessorInput -Script 'unknown-command')
    )
    $assessorResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $assessorInput
    $checks.Add([ordered]@{
        id = 'string-assessor-request-fails-closed-without-violation-escalation'
        passed = (
            $assessorResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($assessorResult.adjudication.unknowns) -contains 'assessor_requested_type_invalid' -and
            @($assessorResult.adjudication.violations) -notcontains 'assessor_requested_without_admissible_controller_result'
        )
    })

    return @($checks)
}

function Test-GitReadSafetyGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $checks = [System.Collections.Generic.List[object]]::new()
    $readShapes = @(
        [pscustomobject]@{ id = 'rev-parse'; unsafe = 'git rev-parse HEAD'; safe = 'git --no-pager rev-parse HEAD' },
        [pscustomobject]@{ id = 'status'; unsafe = 'git status --short'; safe = 'git -c core.fsmonitor=false --no-pager --no-optional-locks status --short' },
        [pscustomobject]@{ id = 'log'; unsafe = 'git log -1'; safe = 'git -c log.showSignature=false --no-pager log --no-textconv -1' },
        [pscustomobject]@{ id = 'show'; unsafe = 'git show HEAD'; safe = 'git -c log.showSignature=false --no-pager show --no-textconv HEAD' },
        [pscustomobject]@{ id = 'diff'; unsafe = 'git diff --stat'; safe = 'git --no-pager diff --no-textconv --stat' },
        [pscustomobject]@{ id = 'ls-files'; unsafe = 'git ls-files'; safe = 'git --no-pager ls-files' },
        [pscustomobject]@{ id = 'ls-tree'; unsafe = 'git ls-tree HEAD'; safe = 'git --no-pager ls-tree HEAD' },
        [pscustomobject]@{ id = 'cat-file'; unsafe = 'git cat-file -t HEAD'; safe = 'git --no-pager cat-file -t HEAD' },
        [pscustomobject]@{ id = 'grep'; unsafe = 'git grep needle'; safe = 'git --no-pager grep needle' },
        [pscustomobject]@{ id = 'worktree-list'; unsafe = 'git worktree list'; safe = 'git --no-pager worktree list' },
        [pscustomobject]@{ id = 'branch-show-current'; unsafe = 'git branch --show-current'; safe = 'git --no-pager branch --show-current' },
        [pscustomobject]@{ id = 'tag-list'; unsafe = 'git tag --list'; safe = 'git --no-pager tag --list' },
        [pscustomobject]@{ id = 'remote-list'; unsafe = 'git remote -v'; safe = 'git --no-pager remote -v' }
    )

    $unsafePassed = $true
    $safePassed = $true
    foreach ($shape in $readShapes) {
        $unsafeInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
            Join-Path $GuardRoot ("unsafe-" + [string]$shape.id)
        )
        $unsafeInput.evidence.commands = @(
            (New-ScriptRecord -InputObject $unsafeInput -Script ([string]$shape.unsafe))
        )
        $unsafeResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $unsafeInput
        $unsafePassed = $unsafePassed -and (
            $unsafeResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($unsafeResult.adjudication.unknowns) -contains 'git_read_requires_no_pager'
        )

        $safeInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
            Join-Path $GuardRoot ("safe-" + [string]$shape.id)
        )
        $safeInput.evidence.commands = @(
            (New-ScriptRecord -InputObject $safeInput -Script ([string]$shape.safe))
        )
        $safeResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $safeInput
        $safePassed = $safePassed -and (
            $safeResult.adjudication.verdict -eq 'ADMISSIBLE' -and
            @($safeResult.adjudication.completed_effects).Count -eq 1 -and
            [string]$safeResult.adjudication.completed_effects[0].kind -eq 'git-read'
        )
    }
    $checks.Add([ordered]@{
        id = 'git-reads-without-no-pager-fail-closed'
        passed = $unsafePassed
    })
    $checks.Add([ordered]@{
        id = 'bounded-git-read-shapes-remain-admissible'
        passed = $safePassed
    })

    $statusInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'status-with-optional-locks'
    )
    $statusInput.evidence.commands = @(
        (New-ScriptRecord -InputObject $statusInput -Script 'git -c core.fsmonitor=false --no-pager status --short')
    )
    $statusResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $statusInput
    $checks.Add([ordered]@{
        id = 'git-status-without-no-optional-locks-fails-closed'
        passed = (
            $statusResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($statusResult.adjudication.unknowns) -contains 'git_status_requires_no_optional_locks'
        )
    })

    $fsMonitorInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'status-with-fsmonitor-enabled'
    )
    $fsMonitorInput.evidence.commands = @(
        (New-ScriptRecord -InputObject $fsMonitorInput -Script 'git --no-pager --no-optional-locks status --short')
    )
    $fsMonitorResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $fsMonitorInput
    $checks.Add([ordered]@{
        id = 'git-status-without-fsmonitor-disable-fails-closed'
        passed = (
            $fsMonitorResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($fsMonitorResult.adjudication.unknowns) -contains 'git_status_requires_fsmonitor_disabled'
        )
    })

    $remoteMutationInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'remote-verbose-with-mutating-subcommand'
    )
    $remoteMutationInput.evidence.commands = @(
        (New-ScriptRecord -InputObject $remoteMutationInput -Script (
            'git --no-pager remote -v set-url origin https://example.invalid/repository.git'
        ))
    )
    $remoteMutationResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $remoteMutationInput
    $checks.Add([ordered]@{
        id = 'git-remote-verbose-with-extra-subcommand-fails-closed'
        passed = (
            $remoteMutationResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($remoteMutationResult.adjudication.unknowns) -contains 'git_remote_shape_not_admissible'
        )
    })

    $branchMutationInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'branch-read-with-delete'
    )
    $branchMutationInput.evidence.commands = @(
        (New-ScriptRecord -InputObject $branchMutationInput -Script (
            'git --no-pager branch --show-current -D unsafe-branch'
        ))
    )
    $branchMutationResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $branchMutationInput
    $checks.Add([ordered]@{
        id = 'git-branch-read-shape-with-delete-fails-closed'
        passed = (
            $branchMutationResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($branchMutationResult.adjudication.unknowns) -contains 'git_branch_shape_not_admissible'
        )
    })

    $signatureConfigPassed = $true
    foreach ($shape in @(
        [pscustomobject]@{ id = 'log'; script = 'git --no-pager log --no-textconv -1' },
        [pscustomobject]@{ id = 'show'; script = 'git --no-pager show --no-textconv HEAD' }
    )) {
        $signatureInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
            Join-Path $GuardRoot ("signature-config-" + [string]$shape.id)
        )
        $signatureInput.evidence.commands = @(
            (New-ScriptRecord -InputObject $signatureInput -Script ([string]$shape.script))
        )
        $signatureResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $signatureInput
        $signatureConfigPassed = $signatureConfigPassed -and (
            $signatureResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($signatureResult.adjudication.unknowns) -contains 'git_log_show_requires_signature_display_disabled'
        )
    }
    $checks.Add([ordered]@{
        id = 'git-log-show-require-signature-display-disabled'
        passed = $signatureConfigPassed
    })

    $textconvDisablePassed = $true
    foreach ($shape in @(
        [pscustomobject]@{ id = 'log'; script = 'git -c log.showSignature=false --no-pager log -1' },
        [pscustomobject]@{ id = 'show'; script = 'git -c log.showSignature=false --no-pager show HEAD' },
        [pscustomobject]@{ id = 'diff'; script = 'git --no-pager diff --stat' }
    )) {
        $textconvInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
            Join-Path $GuardRoot ("textconv-disable-" + [string]$shape.id)
        )
        $textconvInput.evidence.commands = @(
            (New-ScriptRecord -InputObject $textconvInput -Script ([string]$shape.script))
        )
        $textconvResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $textconvInput
        $textconvDisablePassed = $textconvDisablePassed -and (
            $textconvResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($textconvResult.adjudication.unknowns) -contains 'git_diff_requires_no_textconv'
        )
    }
    $checks.Add([ordered]@{
        id = 'git-diff-capable-reads-require-no-textconv'
        passed = $textconvDisablePassed
    })

    return @($checks)
}

function Test-CanonicalOrdinalGuards {
    $checks = [System.Collections.Generic.List[object]]::new()
    $originalCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
    $originalUICulture = [System.Threading.Thread]::CurrentThread.CurrentUICulture
    try {
        $dictionary = [ordered]@{ z = 1; a = 2; b = 3; 'ä' = 4; 'å' = 5; 'ö' = 6 }
        $customObject = [pscustomobject]$dictionary
        $dictionaryJson = [System.Collections.Generic.List[string]]::new()
        $customObjectJson = [System.Collections.Generic.List[string]]::new()
        foreach ($cultureName in @('en-US', 'sv-SE', 'tr-TR')) {
            $culture = [System.Globalization.CultureInfo]::GetCultureInfo($cultureName)
            [System.Threading.Thread]::CurrentThread.CurrentCulture = $culture
            [System.Threading.Thread]::CurrentThread.CurrentUICulture = $culture
            $dictionaryJson.Add((ConvertTo-CodexCanonicalJson -InputObject $dictionary))
            $customObjectJson.Add((ConvertTo-CodexCanonicalJson -InputObject $customObject))
        }
        $expected = '{"a":2,"b":3,"z":1,"ä":4,"å":5,"ö":6}'
        $checks.Add([ordered]@{
            id = 'canonical-json-key-order-is-ordinal-and-culture-invariant'
            passed = (
                @($dictionaryJson | Sort-Object -Unique).Count -eq 1 -and
                @($customObjectJson | Sort-Object -Unique).Count -eq 1 -and
                $dictionaryJson[0] -ceq $expected -and
                $customObjectJson[0] -ceq $expected
            )
        })
    }
    finally {
        [System.Threading.Thread]::CurrentThread.CurrentCulture = $originalCulture
        [System.Threading.Thread]::CurrentThread.CurrentUICulture = $originalUICulture
    }
    return @($checks)
}

function Test-CommandResolutionGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $checks = [System.Collections.Generic.List[object]]::new()
    $newInput = {
        param([Parameter(Mandatory)][string]$Name)
        New-BaseControllerInput -Candidate b965102 -CaseRoot (Join-Path $GuardRoot $Name)
    }

    $missingInput = & $newInput 'missing-identity'
    $missingInput.evidence.commands = @(
        (New-ReadRecord -InputObject $missingInput -Root workspace -RelativePath 'WORK.md')
    )
    [void]$missingInput.evidence.commands[0].PSObject.Properties.Remove('resolved_command_identity')
    $missingResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $missingInput
    $checks.Add([ordered]@{
        id = 'resolved-command-identity-is-required'
        passed = (
            $missingResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($missingResult.adjudication.unknowns) -contains 'resolved_command_identity_missing_or_invalid'
        )
    })

    $shadowInput = & $newInput 'shadowed-command'
    $shadowInput.evidence.commands = @(
        (New-ReadRecord -InputObject $shadowInput -Root workspace -RelativePath 'WORK.md')
    )
    $shadowInput.evidence.commands[0].resolved_command_identity.kind = 'powershell-function'
    $shadowResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $shadowInput
    $checks.Add([ordered]@{
        id = 'shadowed-command-identity-fails-closed'
        passed = (
            $shadowResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($shadowResult.adjudication.unknowns) -contains 'resolved_command_identity_not_trusted'
        )
    })

    foreach ($bareName in @('git', 'git.cmd')) {
        $bareInput = & $newInput "bare-$($bareName.Replace('.', '-'))"
        $bareInput.evidence.commands = @(
            (New-ScriptRecord -InputObject $bareInput -Script 'git --no-pager rev-parse HEAD')
        )
        $bareScript = "$bareName --no-pager rev-parse HEAD"
        $bareInput.evidence.commands[0].command = $bareScript
        $bareInput.evidence.commands[0].command_actions[0].command = $bareScript
        $bareResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $bareInput
        $checks.Add([ordered]@{
            id = "bare-$bareName-native-invocation-fails-closed"
            passed = (
                $bareResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
                (
                    @($bareResult.adjudication.unknowns) -contains 'resolved_command_invocation_not_trusted' -or
                    @($bareResult.adjudication.unknowns) -contains 'command_kind_unknown'
                )
            )
        })
    }

    $missingWrapperInput = & $newInput 'missing-wrapper-identity'
    $missingWrapperInput.evidence.commands = @(
        (New-ReadRecord -InputObject $missingWrapperInput -Root workspace -RelativePath 'WORK.md')
    )
    [void]$missingWrapperInput.evidence.commands[0].PSObject.Properties.Remove(
        'resolved_wrapper_identity'
    )
    $missingWrapperResult = Invoke-CodexEvidenceController `
        -Mode runtime `
        -InputObject $missingWrapperInput
    $checks.Add([ordered]@{
        id = 'resolved-wrapper-identity-is-required'
        passed = (
            $missingWrapperResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($missingWrapperResult.adjudication.unknowns) -contains 'resolved_wrapper_identity_missing_or_invalid'
        )
    })

    $shadowWrapperInput = & $newInput 'shadowed-wrapper'
    $shadowWrapperInput.evidence.commands = @(
        (New-ReadRecord -InputObject $shadowWrapperInput -Root workspace -RelativePath 'WORK.md')
    )
    $shadowWrapperInput.evidence.commands[0].resolved_wrapper_identity.sha256 = ('0' * 64)
    $shadowWrapperResult = Invoke-CodexEvidenceController `
        -Mode runtime `
        -InputObject $shadowWrapperInput
    $checks.Add([ordered]@{
        id = 'shadowed-wrapper-identity-fails-closed'
        passed = (
            $shadowWrapperResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($shadowWrapperResult.adjudication.unknowns) -contains 'resolved_wrapper_identity_not_trusted'
        )
    })

    $bareWrapperInput = & $newInput 'bare-wrapper'
    $bareWrapperInput.evidence.commands = @(
        (New-ReadRecord -InputObject $bareWrapperInput -Root workspace -RelativePath 'WORK.md')
    )
    $bareWrapperScript = 'pwsh -NoProfile -Command "Get-Content WORK.md"'
    $bareWrapperInput.evidence.commands[0].command = $bareWrapperScript
    $bareWrapperResult = Invoke-CodexEvidenceController `
        -Mode runtime `
        -InputObject $bareWrapperInput
    $checks.Add([ordered]@{
        id = 'bare-wrapper-invocation-fails-closed'
        passed = (
            $bareWrapperResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($bareWrapperResult.adjudication.unknowns) -contains 'resolved_wrapper_invocation_not_trusted'
        )
    })

    $trustedInput = & $newInput 'trusted-command'
    $trustedInput.evidence.commands = @(
        (New-ReadRecord -InputObject $trustedInput -Root workspace -RelativePath 'WORK.md')
    )
    $trustedResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $trustedInput
    $checks.Add([ordered]@{
        id = 'trusted-path-bound-command-remains-admissible'
        passed = $trustedResult.adjudication.verdict -eq 'ADMISSIBLE'
    })

    return @($checks)
}

function Test-ContentProofIdentityGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $checks = [System.Collections.Generic.List[object]]::new()
    $newInput = {
        param([Parameter(Mandatory)][string]$Name)

        $inputObject = New-BaseControllerInput -Candidate b965102 -CaseRoot (
            Join-Path $GuardRoot $Name
        )
        Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
        $inputObject.evidence.commands = @(
            (New-ReadRecord -InputObject $inputObject -Root workspace -RelativePath 'WORK.md')
        )
        return $inputObject
    }

    $allowedPassed = $true
    foreach ($variant in @(
        [pscustomobject]@{ id = 'sha'; field = 'sha256'; value = 'not-a-sha' },
        [pscustomobject]@{ id = 'string-length'; field = 'length'; value = 'not-a-length' },
        [pscustomobject]@{ id = 'negative-length'; field = 'length'; value = -1 }
    )) {
        $inputObject = & $newInput ("allowed-" + [string]$variant.id)
        $allowed = Get-AllowedFile -InputObject $inputObject -Root workspace -Path 'WORK.md'
        $allowed.([string]$variant.field) = $variant.value
        $result = Invoke-CodexEvidenceController -Mode runtime -InputObject $inputObject
        $allowedPassed = $allowedPassed -and (
            $result.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($result.adjudication.unknowns) -contains 'allowed_file_content_identity_invalid'
        )
    }
    $unusedAllowedInput = & $newInput 'allowed-unused-malformed'
    $unusedAllowedInput.policy.allowed_files = @(
        $unusedAllowedInput.policy.allowed_files
    ) + @([pscustomobject]@{
        root = 'workspace'; path = 'UNUSED.md'; length = 'not-a-length'; sha256 = ('a' * 64)
    })
    $unusedAllowedResult = Invoke-CodexEvidenceController `
        -Mode runtime `
        -InputObject $unusedAllowedInput
    $allowedPassed = $allowedPassed -and (
        $unusedAllowedResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
        @($unusedAllowedResult.adjudication.unknowns) -contains 'allowed_file_content_identity_invalid'
    )
    $checks.Add([ordered]@{
        id = 'malformed-allowed-content-identities-fail-closed'
        passed = $allowedPassed
    })

    $proofPassed = $true
    foreach ($variant in @(
        [pscustomobject]@{ id = 'sha'; field = 'sha256'; value = 'not-a-sha' },
        [pscustomobject]@{ id = 'string-length'; field = 'length'; value = 'not-a-length' },
        [pscustomobject]@{ id = 'negative-length'; field = 'length'; value = -1 }
    )) {
        $inputObject = & $newInput ("proof-" + [string]$variant.id)
        $proof = $inputObject.evidence.commands[0].command_actions[0].file_proofs[0]
        $proof.([string]$variant.field) = $variant.value
        $result = Invoke-CodexEvidenceController -Mode runtime -InputObject $inputObject
        $proofPassed = $proofPassed -and (
            $result.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($result.adjudication.unknowns) -contains 'read_content_proof_identity_invalid'
        )
    }
    $unusedProofInput = & $newInput 'proof-unused-malformed'
    $unusedProofInput.evidence.commands[0].command_actions[0].file_proofs = @(
        $unusedProofInput.evidence.commands[0].command_actions[0].file_proofs
    ) + @([pscustomobject]@{
        root = 'workspace'; path = 'UNUSED.md'; length = 1; sha256 = 'not-a-sha'
    })
    $unusedProofResult = Invoke-CodexEvidenceController `
        -Mode runtime `
        -InputObject $unusedProofInput
    $proofPassed = $proofPassed -and (
        $unusedProofResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
        @($unusedProofResult.adjudication.unknowns) -contains 'read_content_proof_identity_invalid'
    )
    $checks.Add([ordered]@{
        id = 'malformed-read-proofs-fail-closed'
        passed = $proofPassed
    })

    $matchingInput = & $newInput 'matching-malformed-sha'
    $matchingAllowed = Get-AllowedFile -InputObject $matchingInput -Root workspace -Path 'WORK.md'
    $matchingProof = $matchingInput.evidence.commands[0].command_actions[0].file_proofs[0]
    $matchingAllowed.sha256 = 'matching-invalid-sha'
    $matchingProof.sha256 = 'matching-invalid-sha'
    $matchingResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $matchingInput
    $checks.Add([ordered]@{
        id = 'matching-malformed-content-identities-fail-closed'
        passed = (
            $matchingResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($matchingResult.adjudication.unknowns) -contains 'allowed_file_content_identity_invalid' -and
            @($matchingResult.adjudication.unknowns) -contains 'read_content_proof_identity_invalid'
        )
    })

    $malformedAllowedInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'malformed-allowed-row'
    )
    $malformedAllowedInput.policy.allowed_files = @('malformed-row')
    $malformedAllowedResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $malformedAllowedInput
    $checks.Add([ordered]@{
        id = 'malformed-allowed-file-rows-fail-closed'
        passed = (
            $malformedAllowedResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($malformedAllowedResult.adjudication.unknowns) -contains 'allowed_file_shape_invalid'
        )
    })

    $malformedProofInput = & $newInput 'malformed-proof-row'
    $malformedProofInput.evidence.commands[0].command_actions[0].file_proofs = @('malformed-row')
    $malformedProofResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $malformedProofInput
    $checks.Add([ordered]@{
        id = 'malformed-file-proof-rows-fail-closed'
        passed = (
            $malformedProofResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($malformedProofResult.adjudication.unknowns) -contains 'file_proof_shape_invalid'
        )
    })

    $inventoryPassed = $true
    foreach ($variant in @(
        [pscustomobject]@{ id = 'path'; field = 'path'; value = '../outside.txt' },
        [pscustomobject]@{ id = 'length'; field = 'length'; value = 'not-a-length' },
        [pscustomobject]@{ id = 'sha'; field = 'sha256'; value = 'not-a-sha' }
    )) {
        $inventoryInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
            Join-Path $GuardRoot ("inventory-" + [string]$variant.id)
        )
        $row = [pscustomobject]@{ path = 'WORK.md'; length = 1; sha256 = ('a' * 64) }
        $row.([string]$variant.field) = $variant.value
        $inventoryInput.evidence.inventory_comparisons = @([pscustomobject]@{
            name = 'matching-malformed-inventory'
            left = @($row)
            right = @($row.PSObject.Copy())
        })
        $inventoryResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $inventoryInput
        $inventoryPassed = $inventoryPassed -and (
            $inventoryResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($inventoryResult.adjudication.unknowns) -contains 'inventory_row_identity_invalid'
        )
    }
    $checks.Add([ordered]@{
        id = 'matching-malformed-inventory-identities-fail-closed'
        passed = $inventoryPassed
    })

    return @($checks)
}

function Test-RecordCardinalityAndExitGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $checks = [System.Collections.Generic.List[object]]::new()
    $newInput = {
        param([Parameter(Mandatory)][string]$Name)

        $inputObject = New-BaseControllerInput -Candidate b965102 -CaseRoot (
            Join-Path $GuardRoot $Name
        )
        Add-RequiredRead -InputObject $inputObject -Root workspace -Path 'WORK.md'
        $inputObject.evidence.commands = @(
            (New-ReadRecord -InputObject $inputObject -Root workspace -RelativePath 'WORK.md')
        )
        return $inputObject
    }

    $allowedInput = & $newInput 'duplicate-allowed-file'
    $allowed = Get-AllowedFile -InputObject $allowedInput -Root workspace -Path 'WORK.md'
    $allowedInput.policy.allowed_files = @($allowedInput.policy.allowed_files) + @(
        [pscustomobject]@{
            root = [string]$allowed.root
            path = [string]$allowed.path
            length = [int64]$allowed.length + 1
            sha256 = ('d' * 64)
        }
    )
    $allowedResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $allowedInput
    $checks.Add([ordered]@{
        id = 'duplicate-allowed-file-keys-fail-closed'
        passed = (
            $allowedResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($allowedResult.adjudication.unknowns) -contains 'duplicate_allowed_file_key'
        )
    })

    $proofInput = & $newInput 'duplicate-file-proof'
    $proof = $proofInput.evidence.commands[0].command_actions[0].file_proofs[0]
    $proofInput.evidence.commands[0].command_actions[0].file_proofs = @($proof) + @(
        [pscustomobject]@{
            root = [string]$proof.root
            path = [string]$proof.path
            length = [int64]$proof.length + 1
            sha256 = ('e' * 64)
        }
    )
    $proofResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $proofInput
    $checks.Add([ordered]@{
        id = 'duplicate-file-proof-keys-fail-closed'
        passed = (
            $proofResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($proofResult.adjudication.unknowns) -contains 'duplicate_file_proof_key'
        )
    })

    $stringExitInput = & $newInput 'string-zero-exit'
    $stringExitInput.evidence.commands[0].exit_code = '0'
    $stringExitResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $stringExitInput
    $positiveExitInput = & $newInput 'positive-exit'
    $positiveExitInput.evidence.commands[0].exit_code = 1
    $positiveExitResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $positiveExitInput
    $negativeExitInput = & $newInput 'negative-exit'
    $negativeExitInput.evidence.commands[0].exit_code = -1
    $negativeExitResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $negativeExitInput
    $zeroExitInput = & $newInput 'numeric-zero-exit'
    $zeroExitResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $zeroExitInput
    $checks.Add([ordered]@{
        id = 'completed-exit-code-requires-integral-zero'
        passed = (
            $stringExitResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($stringExitResult.adjudication.unknowns) -contains 'completed_command_exit_code_type_invalid' -and
            $positiveExitResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($positiveExitResult.adjudication.unknowns) -contains 'completed_command_exit_is_not_zero' -and
            $negativeExitResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($negativeExitResult.adjudication.unknowns) -contains 'completed_command_exit_is_not_zero' -and
            $zeroExitResult.adjudication.verdict -eq 'ADMISSIBLE'
        )
    })

    return @($checks)
}

function Test-LogicalCandidateIdentityGuards {
    param([Parameter(Mandatory)][string]$GuardRoot)

    $checks = [System.Collections.Generic.List[object]]::new()

    $blankInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'blank-identities'
    )
    foreach ($field in @(
        'stable_subject', 'candidate_sha', 'package_manifest_sha256',
        'relative_package_path', 'content_output_sha256'
    )) {
        $blankInput.policy.expected_candidate.$field = ''
        $blankInput.evidence.candidate_identity.$field = ''
    }
    $blankResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $blankInput
    $checks.Add([ordered]@{
        id = 'blank-identities-fail-closed'
        passed = (
            $blankResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($blankResult.adjudication.unknowns) -contains 'expected_logical_candidate_identity_invalid' -and
            @($blankResult.adjudication.unknowns) -contains 'observed_logical_candidate_identity_invalid'
        )
    })

    $observedInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'malformed-observed'
    )
    $observedInput.evidence.candidate_identity.candidate_sha = 'not-a-sha'
    $observedInput.evidence.candidate_identity.relative_package_path = '../work-charter'
    $observedResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $observedInput
    $checks.Add([ordered]@{
        id = 'malformed-observed-identity-fails-closed'
        passed = (
            $observedResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($observedResult.adjudication.unknowns) -contains 'observed_logical_candidate_identity_invalid'
        )
    })

    $expectedInput = New-BaseControllerInput -Candidate b965102 -CaseRoot (
        Join-Path $GuardRoot 'malformed-expected'
    )
    $expectedInput.policy.expected_candidate.package_manifest_sha256 = 'not-a-hash'
    $expectedInput.policy.expected_candidate.relative_package_path = 'work-charter/../escape'
    $expectedResult = Invoke-CodexEvidenceController -Mode runtime -InputObject $expectedInput
    $checks.Add([ordered]@{
        id = 'malformed-expected-identity-fails-closed'
        passed = (
            $expectedResult.adjudication.verdict -eq 'CONTROLLER_UNKNOWN' -and
            @($expectedResult.adjudication.unknowns) -contains 'expected_logical_candidate_identity_invalid'
        )
    })

    return @($checks)
}

$final = $null
$runRootReady = $false
$scratchReady = $false
$cleanupRecord = $null
try {
    [void](Assert-ControllerRunRoot `
        -RepositoryRoot $repoRoot `
        -RunRoot $runRootFull `
        -CreateIfMissing)
    $runRootReady = $true
    [void](Assert-ControllerScratchRoot `
        -RunRoot $runRootFull `
        -ScratchRoot $scratchFull `
        -CreateIfMissing)
    $scratchReady = $true
    $noClobberPath = Join-Path $scratchFull 'output-no-clobber-sentinel.json'
    $sentinelBytes = [System.Text.UTF8Encoding]::new($false).GetBytes('sealed-sentinel')
    [System.IO.File]::WriteAllBytes($noClobberPath, $sentinelBytes)
    $noClobberBlocked = $false
    try {
        Write-ControllerOutputNewFile -Path $noClobberPath -Text '{"replacement":true}'
    }
    catch [System.IO.IOException] {
        $noClobberBlocked = $true
    }
    $sentinelAfter = [System.IO.File]::ReadAllBytes($noClobberPath)
    $outputNoClobberGuards = @([ordered]@{
        id = 'existing-output-is-never-overwritten'
        passed = (
            $noClobberBlocked -and
            [Convert]::ToBase64String($sentinelAfter) -ceq
                [Convert]::ToBase64String($sentinelBytes)
        )
    })
    if ($VerifyLocalSealedEvidence) {
        Initialize-LocalSealedInputs -ManifestPath $LocalSealedEvidenceManifestPath
    }
    elseif (-not [string]::IsNullOrWhiteSpace($LocalSealedEvidenceManifestPath)) {
        throw 'local_sealed_evidence_manifest_requires_verification'
    }
    $runOne = Invoke-Suite -SuiteRoot (Join-Path $scratchFull 'run-1')
    $runTwo = Invoke-Suite -SuiteRoot (Join-Path $scratchFull 'run-2')
    $runOneJson = ConvertTo-CodexCanonicalJson -InputObject $runOne
    $runTwoJson = ConvertTo-CodexCanonicalJson -InputObject $runTwo
    $historicalBindings = Get-HistoricalBindingChecks
    $historicalBindingGuards = Test-HistoricalBindingGuards
    $historicalGeneratedContractGuards = Test-HistoricalGeneratedContractGuards -GuardRoot (
        Join-Path $scratchFull 'generated-contract-guards'
    )
    $packageManifests = Get-PackageManifestChecks
    $packageManifestGuards = Test-PackageManifestHashGuards
    $sealedLocatorGuards = Test-SealedLocatorGuards -GuardRoot (Join-Path $scratchFull 'reparse-guard')
    $sealedByteCaptureGuards = Test-SealedByteCaptureGuard -GuardRoot (Join-Path $scratchFull 'capture-guard')
    $scratchTopologyGuards = Test-ScratchTopologyGuards -GuardRoot (
        Join-Path $scratchFull 'scratch-topology-guards'
    )
    $externalInputTypeGuards = Test-ExternalInputTypeGuards -GuardRoot (
        Join-Path $scratchFull 'external-input-type-guards'
    )
    $gitReadSafetyGuards = Test-GitReadSafetyGuards -GuardRoot (
        Join-Path $scratchFull 'git-read-safety-guards'
    )
    $canonicalOrdinalGuards = Test-CanonicalOrdinalGuards
    $commandResolutionGuards = Test-CommandResolutionGuards -GuardRoot (
        Join-Path $scratchFull 'command-resolution-guards'
    )
    $contentProofIdentityGuards = Test-ContentProofIdentityGuards -GuardRoot (
        Join-Path $scratchFull 'content-proof-identity-guards'
    )
    $recordCardinalityAndExitGuards = Test-RecordCardinalityAndExitGuards -GuardRoot (
        Join-Path $scratchFull 'record-cardinality-and-exit-guards'
    )
    $logicalCandidateIdentityGuards = Test-LogicalCandidateIdentityGuards -GuardRoot (
        Join-Path $scratchFull 'logical-candidate-identity-guards'
    )
    $runOneRoundTrip = $runOneJson | ConvertFrom-Json -Depth 100
    $historicalOutputShapeGuards = @([ordered]@{
        id = 'historical-violation-arrays-preserve-empty-shape'
        passed = @(
            $runOneRoundTrip.historical | Where-Object {
                $_.actual_violations -isnot [System.Array] -or
                @($_.actual_violations).Count -ne @($_.expected_violations).Count
            }
        ).Count -eq 0
    })
    $sealed = if ($VerifyLocalSealedEvidence) { Test-SealedInputs } else { @() }
    $allHistorical = @($runOne.historical | Where-Object { -not $_.passed }).Count -eq 0
    $allNegative = @($runOne.negative | Where-Object { -not $_.passed }).Count -eq 0
    $allMetamorphic = @($runOne.metamorphic | Where-Object { -not $_.passed }).Count -eq 0
    $allHistoricalBindings = @($historicalBindings | Where-Object { -not $_.passed }).Count -eq 0
    $allHistoricalBindingGuards = @($historicalBindingGuards | Where-Object { -not $_.passed }).Count -eq 0
    $allHistoricalGeneratedContractGuards = @(
        $historicalGeneratedContractGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allPackageManifests = @($packageManifests | Where-Object { -not $_.passed }).Count -eq 0
    $allPackageManifestGuards = @($packageManifestGuards | Where-Object { -not $_.passed }).Count -eq 0
    $allSealedLocatorGuards = @($sealedLocatorGuards | Where-Object { -not $_.passed }).Count -eq 0
    $allSealedByteCaptureGuards = @($sealedByteCaptureGuards | Where-Object { -not $_.passed }).Count -eq 0
    $allScratchTopologyGuards = @($scratchTopologyGuards | Where-Object { -not $_.passed }).Count -eq 0
    $allExternalInputTypeGuards = @(
        $externalInputTypeGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allGitReadSafetyGuards = @(
        $gitReadSafetyGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allCanonicalOrdinalGuards = @(
        $canonicalOrdinalGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allCommandResolutionGuards = @(
        $commandResolutionGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allContentProofIdentityGuards = @(
        $contentProofIdentityGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allRecordCardinalityAndExitGuards = @(
        $recordCardinalityAndExitGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allLogicalCandidateIdentityGuards = @(
        $logicalCandidateIdentityGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allHistoricalOutputShapeGuards = @(
        $historicalOutputShapeGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $allOutputNoClobberGuards = @(
        $outputNoClobberGuards | Where-Object { -not $_.passed }
    ).Count -eq 0
    $sealedPass = -not $VerifyLocalSealedEvidence -or
        @($sealed | Where-Object { -not $_.contained -or -not $_.hash_and_length_match }).Count -eq 0
    $canonicalRepeatPass = $runOneJson -ceq $runTwoJson
    $entryBaselinePass = Test-EntryBaseline
    $candidateContentOutputsPass = Test-CandidateContentOutputs
    $packageIdentityPass = Test-PackageIdentity
    $passed = (
        $allHistorical -and
        $allNegative -and
        $allMetamorphic -and
        $allHistoricalBindings -and
        $allHistoricalBindingGuards -and
        $allHistoricalGeneratedContractGuards -and
        $allPackageManifests -and
        $allPackageManifestGuards -and
        $allSealedLocatorGuards -and
        $allSealedByteCaptureGuards -and
        $allScratchTopologyGuards -and
        $allExternalInputTypeGuards -and
        $allGitReadSafetyGuards -and
        $allCanonicalOrdinalGuards -and
        $allCommandResolutionGuards -and
        $allContentProofIdentityGuards -and
        $allRecordCardinalityAndExitGuards -and
        $allLogicalCandidateIdentityGuards -and
        $allHistoricalOutputShapeGuards -and
        $allOutputNoClobberGuards -and
        $runOne.all_entry_modes_share_core -and
        $runOne.exact_response_check -and
        $runOne.narrow_git_context_check -and
        $canonicalRepeatPass -and
        $entryBaselinePass -and
        $candidateContentOutputsPass -and
        $packageIdentityPass -and
        $sealedPass
    )
    $failures = @(
        @($runOne.historical | Where-Object { -not $_.passed } | ForEach-Object { $_.id }) +
        @($runOne.negative | Where-Object { -not $_.passed } | ForEach-Object { $_.id }) +
        @($runOne.metamorphic | Where-Object { -not $_.passed } | ForEach-Object { $_.id }) +
        @($historicalBindings | Where-Object { -not $_.passed } | ForEach-Object { "binding:$($_.id)" }) +
        @($historicalBindingGuards | Where-Object { -not $_.passed } | ForEach-Object { "binding-guard:$($_.id)" }) +
        @($historicalGeneratedContractGuards | Where-Object { -not $_.passed } | ForEach-Object { "generated-contract-guard:$($_.id)" }) +
        @($packageManifests | Where-Object { -not $_.passed } | ForEach-Object { "package:$($_.id)" }) +
        @($packageManifestGuards | Where-Object { -not $_.passed } | ForEach-Object { "package-guard:$($_.id)" }) +
        @($sealedLocatorGuards | Where-Object { -not $_.passed } | ForEach-Object { "locator-guard:$($_.id)" }) +
        @($sealedByteCaptureGuards | Where-Object { -not $_.passed } | ForEach-Object { "capture-guard:$($_.id)" }) +
        @($scratchTopologyGuards | Where-Object { -not $_.passed } | ForEach-Object { "scratch-topology-guard:$($_.id)" }) +
        @($externalInputTypeGuards | Where-Object { -not $_.passed } | ForEach-Object { "external-input-type-guard:$($_.id)" }) +
        @($gitReadSafetyGuards | Where-Object { -not $_.passed } | ForEach-Object { "git-read-safety-guard:$($_.id)" }) +
        @($canonicalOrdinalGuards | Where-Object { -not $_.passed } | ForEach-Object { "canonical-ordinal-guard:$($_.id)" }) +
        @($commandResolutionGuards | Where-Object { -not $_.passed } | ForEach-Object { "command-resolution-guard:$($_.id)" }) +
        @($contentProofIdentityGuards | Where-Object { -not $_.passed } | ForEach-Object { "content-proof-identity-guard:$($_.id)" }) +
        @($recordCardinalityAndExitGuards | Where-Object { -not $_.passed } | ForEach-Object { "record-cardinality-and-exit-guard:$($_.id)" }) +
        @($logicalCandidateIdentityGuards | Where-Object { -not $_.passed } | ForEach-Object { "logical-candidate-identity-guard:$($_.id)" }) +
        @($historicalOutputShapeGuards | Where-Object { -not $_.passed } | ForEach-Object { "historical-output-shape-guard:$($_.id)" }) +
        @($outputNoClobberGuards | Where-Object { -not $_.passed } | ForEach-Object { "output-no-clobber-guard:$($_.id)" })
    )
    if (-not $runOne.all_entry_modes_share_core) { $failures += 'all-entry-modes-share-core' }
    if (-not $runOne.exact_response_check) { $failures += 'exact-response-check' }
    if (-not $runOne.narrow_git_context_check) { $failures += 'narrow-git-context-check' }
    if (-not $canonicalRepeatPass) { $failures += 'canonical-repeat' }
    if (-not $entryBaselinePass) { $failures += 'entry-baseline' }
    if (-not $candidateContentOutputsPass) { $failures += 'candidate-content-outputs' }
    if (-not $packageIdentityPass) { $failures += 'package-identity' }
    if (-not $sealedPass) {
        $sealedFailures = @(
            $sealed |
                Where-Object { -not $_.contained -or -not $_.hash_and_length_match } |
                ForEach-Object { "sealed-input:$($_.key)" }
        )
        $failures += if ($sealedFailures.Count -gt 0) { $sealedFailures } else { 'sealed-inputs' }
    }
    $final = [ordered]@{
        schema_version = 'codex-evidence-controller-check/v1'
        verdict = if ($passed) { 'PASS' } else { 'FAIL' }
        threat_model = [ordered]@{
            id = 'quiescent-offline-single-writer/v1'
            concurrent_path_swap_resistance = 'UNSUPPORTED'
            observable_pre_post_topology_drift = 'fail_closed'
        }
        historical = [ordered]@{
            passed = @($runOne.historical | Where-Object passed).Count
            total = @($runOne.historical).Count
            generated_contracts = @($runOne.historical | ForEach-Object {
                [ordered]@{
                    id = [string]$_.id
                    sha256 = [string]$_.generated_contract_sha256
                }
            })
            results = @($runOne.historical)
        }
        negative = [ordered]@{
            passed = @($runOne.negative | Where-Object passed).Count
            total = @($runOne.negative).Count
        }
        metamorphic = [ordered]@{
            passed = @($runOne.metamorphic | Where-Object passed).Count
            total = @($runOne.metamorphic).Count
        }
        historical_source_bindings = [ordered]@{
            passed = @($historicalBindings | Where-Object passed).Count
            total = @($historicalBindings).Count
            local_projection_verification = [bool]$VerifyLocalSealedEvidence
            identities = @($historicalBindings | ForEach-Object {
                [ordered]@{
                    id = [string]$_.id
                    declaration_sha256 = [string]$_.declaration_sha256
                    generated_contract_sha256 = [string]$_.generated_contract_sha256
                }
            })
        }
        historical_binding_guards = [ordered]@{
            passed = @($historicalBindingGuards | Where-Object passed).Count
            total = @($historicalBindingGuards).Count
        }
        historical_generated_contract_guards = [ordered]@{
            passed = @($historicalGeneratedContractGuards | Where-Object passed).Count
            total = @($historicalGeneratedContractGuards).Count
        }
        package_manifests = [ordered]@{
            passed = @($packageManifests | Where-Object passed).Count
            total = @($packageManifests).Count
            identities = @($packageManifests)
        }
        package_manifest_hash_guards = [ordered]@{
            passed = @($packageManifestGuards | Where-Object passed).Count
            total = @($packageManifestGuards).Count
        }
        sealed_locator_guards = [ordered]@{
            passed = @($sealedLocatorGuards | Where-Object passed).Count
            total = @($sealedLocatorGuards).Count
            identities = @($sealedLocatorGuards)
        }
        sealed_byte_capture_guards = [ordered]@{
            passed = @($sealedByteCaptureGuards | Where-Object passed).Count
            total = @($sealedByteCaptureGuards).Count
        }
        scratch_topology_guards = [ordered]@{
            passed = @($scratchTopologyGuards | Where-Object passed).Count
            total = @($scratchTopologyGuards).Count
            identities = @($scratchTopologyGuards)
        }
        external_input_type_guards = [ordered]@{
            passed = @($externalInputTypeGuards | Where-Object passed).Count
            total = @($externalInputTypeGuards).Count
            identities = @($externalInputTypeGuards)
        }
        git_read_safety_guards = [ordered]@{
            passed = @($gitReadSafetyGuards | Where-Object passed).Count
            total = @($gitReadSafetyGuards).Count
            identities = @($gitReadSafetyGuards)
        }
        canonical_ordinal_guards = [ordered]@{
            passed = @($canonicalOrdinalGuards | Where-Object passed).Count
            total = @($canonicalOrdinalGuards).Count
            identities = @($canonicalOrdinalGuards)
        }
        command_resolution_guards = [ordered]@{
            passed = @($commandResolutionGuards | Where-Object passed).Count
            total = @($commandResolutionGuards).Count
            identities = @($commandResolutionGuards)
        }
        content_proof_identity_guards = [ordered]@{
            passed = @($contentProofIdentityGuards | Where-Object passed).Count
            total = @($contentProofIdentityGuards).Count
            identities = @($contentProofIdentityGuards)
        }
        record_cardinality_and_exit_guards = [ordered]@{
            passed = @($recordCardinalityAndExitGuards | Where-Object passed).Count
            total = @($recordCardinalityAndExitGuards).Count
            identities = @($recordCardinalityAndExitGuards)
        }
        logical_candidate_identity_guards = [ordered]@{
            passed = @($logicalCandidateIdentityGuards | Where-Object passed).Count
            total = @($logicalCandidateIdentityGuards).Count
            identities = @($logicalCandidateIdentityGuards)
        }
        historical_output_shape_guards = [ordered]@{
            passed = @($historicalOutputShapeGuards | Where-Object passed).Count
            total = @($historicalOutputShapeGuards).Count
            identities = @($historicalOutputShapeGuards)
        }
        output_no_clobber_guards = [ordered]@{
            passed = @($outputNoClobberGuards | Where-Object passed).Count
            total = @($outputNoClobberGuards).Count
            identities = @($outputNoClobberGuards)
        }
        canonical_repeat = [ordered]@{
            equal = $canonicalRepeatPass
            hash = Get-CodexCanonicalHash -InputObject $runOne
        }
        all_entry_modes_share_core = $runOne.all_entry_modes_share_core
        exact_response_check = $runOne.exact_response_check
        narrow_git_context_check = $runOne.narrow_git_context_check
        entry_baseline = if ($entryBaselinePass) { 'hash-exact' } else { 'DRIFT' }
        candidate_content_outputs = if ($candidateContentOutputsPass) { 'hash-exact' } else { 'DRIFT' }
        package_identity = if ($packageIdentityPass) { 'b965102-five-file-exact' } else { 'DRIFT' }
        sealed_inputs = [ordered]@{
            required = [bool]$VerifyLocalSealedEvidence
            contained = @($sealed | Where-Object contained).Count
            matched = @($sealed | Where-Object hash_and_length_match).Count
            total = @($sealed).Count
        }
        read_only_git_processes = [ordered]@{
            count = $externalProcessLedger.Count
            failed = @($externalProcessLedger | Where-Object { $_.exit_code -ne 0 }).Count
        }
        zero_external_model_or_assessor_calls = $true
        failures = @($failures)
    }
}
finally {
    if ($scratchReady) {
        $cleanupRecord = Remove-ControllerScratchSafely `
            -RepositoryRoot $repoRoot `
            -RunRoot $runRootFull `
            -ScratchRoot $scratchFull
    }
    elseif (Test-Path -LiteralPath $scratchFull) {
        throw 'scratch_setup_failed_residue_retained_for_manual_disposition'
    }
    elseif ($runRootReady) {
        [void](Assert-ControllerRunRoot -RepositoryRoot $repoRoot -RunRoot $runRootFull)
    }
}

if ($null -eq $final) {
    throw 'controller_check_did_not_produce_terminal_result'
}
$final['scratch_lifecycle'] = $cleanupRecord

$json = ConvertTo-CodexCanonicalJson -InputObject $final
if (-not [string]::IsNullOrWhiteSpace($OutputPath)) {
    Write-ControllerOutputNewFile -Path $OutputPath -Text $json
}
$json
if ($final.verdict -ne 'PASS') {
    exit 1
}
exit 0
