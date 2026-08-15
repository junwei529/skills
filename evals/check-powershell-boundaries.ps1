[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($env:OS -ne 'Windows_NT') {
    throw 'This deterministic check requires Windows.'
}

$script:CheckCount = 0

function Assert-True {
    param(
        [Parameter(Mandatory = $true)]
        [bool]$Condition,

        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    if (-not $Condition) {
        throw $Message
    }
    $script:CheckCount++
}

function Resolve-WithOneBase {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Base
    )

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return [System.IO.Path]::GetFullPath($Path)
    }

    return [System.IO.Path]::GetFullPath((Join-Path -Path $Base -ChildPath $Path))
}

function Get-ParseErrors {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source
    )

    $tokens = $null
    $parseErrors = $null
    [void][System.Management.Automation.Language.Parser]::ParseInput(
        $Source,
        [ref]$tokens,
        [ref]$parseErrors
    )
    return @($parseErrors)
}

function Invoke-ChildPowerShell {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Executable,

        [Parameter(Mandatory = $true)]
        [string]$ScriptPath,

        [Parameter(Mandatory = $true)]
        [string[]]$ScriptArguments,

        [Parameter(Mandatory = $true)]
        [string]$OutputPath,

        [Parameter(Mandatory = $true)]
        [string]$ErrorPath
    )

    $arguments = @(
        '-NoLogo'
        '-NoProfile'
        '-NonInteractive'
        '-File'
        $ScriptPath
    ) + $ScriptArguments

    $priorPreference = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        & $Executable @arguments 1> $OutputPath 2> $ErrorPath
        $exitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $priorPreference
    }

    return [pscustomobject]@{
        ExitCode = $exitCode
        Stdout = [System.IO.File]::ReadAllText($OutputPath)
        Stderr = [System.IO.File]::ReadAllText($ErrorPath)
    }
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillPath = Join-Path $repoRoot 'skills\use-powershell-safely\SKILL.md'
$casePath = Join-Path $repoRoot 'evals\cases\powershell-boundary.md'
$nativeReferencePath = Join-Path $repoRoot (
    'skills\use-powershell-safely\references\native-process-boundaries.md'
)
$readinessPath = Join-Path $repoRoot (
    'evals\fixtures\powershell-boundary\command-readiness-cases.json'
)

$skillText = [System.IO.File]::ReadAllText($skillPath)
$caseText = [System.IO.File]::ReadAllText($casePath)
$nativeReferenceText = [System.IO.File]::ReadAllText($nativeReferencePath)
$frontmatterMatch = [regex]::Match(
    $skillText,
    '(?s)\A---\r?\n(.*?)\r?\n---\r?\n'
)
Assert-True $frontmatterMatch.Success `
    'Skill metadata frontmatter could not be isolated.'
$metadataText = $frontmatterMatch.Groups[1].Value
$selectionMarkers = @(
    '.ps1'
    'pwsh'
    'powershell.exe'
    'non-trivial PowerShell'
    'before the first relevant command'
)
Assert-True (
    @($selectionMarkers | Where-Object { $metadataText -notmatch [regex]::Escape($_) }).Count -eq 0
) 'Skill metadata is missing a required pre-error selection marker.'
Assert-True (
    $metadataText -match 'ordinary version-independent cmdlets' -and
    $metadataText -match 'POSIX-only work'
) 'Skill metadata lost the ordinary-cmdlet or POSIX-only negative selection.'
Assert-True (
    $caseText -match '## Pre-Error Selection Contract' -and
    $caseText -match [regex]::Escape('.ps1') -and
    $caseText -match [regex]::Escape('pwsh') -and
    $caseText -match [regex]::Escape('powershell.exe') -and
    $caseText -match 'non-trivial PowerShell' -and
    $caseText -match [regex]::Escape('Get-Date') -and
    $caseText -match 'POSIX-only'
) 'The eval case does not preserve positive and near-neighbor selection contracts.'
Assert-True (
    $nativeReferenceText -match 'same exact\s+PowerShell executable and version' -and
    $nativeReferenceText -match 'PowerShell 7 parse does not qualify a later Windows PowerShell 5\.1 run'
) 'Parse-only guidance is not bound to the target PowerShell runtime.'

$readiness = [System.IO.File]::ReadAllText($readinessPath) | ConvertFrom-Json
Assert-True (
    $readiness.schema -eq 'powershell-command-readiness/v1' -and
    $readiness.parameter_contract.cmdlet -eq 'New-Item' -and
    $readiness.parameter_contract.unsupported_parameter -eq 'LiteralPath' -and
    $readiness.parameter_contract.supported_parameter -eq 'Path' -and
    $readiness.error_contract.cmdlet -eq 'Copy-Item' -and
    @($readiness.parser_pairs).Count -eq 3 -and
    @($readiness.runtime_pairs).Count -eq 1
) 'The command-readiness fixture schema or pair cardinality changed.'

foreach ($pair in @($readiness.parser_pairs)) {
    $invalidErrors = @(Get-ParseErrors -Source $pair.invalid)
    $validErrors = @(Get-ParseErrors -Source $pair.valid)
    Assert-True ($invalidErrors.Count -gt 0) `
        "The invalid parser pair '$($pair.id)' unexpectedly parsed."
    Assert-True ($validErrors.Count -eq 0) `
        "The valid parser pair '$($pair.id)' did not parse."
    $validOutput = (& ([scriptblock]::Create($pair.valid)) | Out-String).Trim()
    Assert-True ($validOutput -eq $pair.valid_expected) `
        "The valid parser pair '$($pair.id)' produced the wrong result."
}

foreach ($pair in @($readiness.runtime_pairs)) {
    Assert-True (
        @(Get-ParseErrors -Source $pair.invalid).Count -eq 0 -and
        @(Get-ParseErrors -Source $pair.valid).Count -eq 0
    ) "The runtime pair '$($pair.id)' must be syntactically valid."
    $invalidOutput = (& ([scriptblock]::Create($pair.invalid)) | Out-String).Trim()
    Assert-True ($invalidOutput -eq $pair.invalid_expected) `
        "The invalid runtime pair '$($pair.id)' did not expose the collision."
    $validOutput = (& ([scriptblock]::Create($pair.valid)) | Out-String).Trim()
    Assert-True ($validOutput -eq $pair.valid_expected) `
        "The valid runtime pair '$($pair.id)' did not preserve application state."
}

$tempBase = [System.IO.Path]::GetFullPath(
    [System.IO.Path]::GetTempPath()
).TrimEnd(
    [System.IO.Path]::DirectorySeparatorChar,
    [System.IO.Path]::AltDirectorySeparatorChar
)
$testRoot = [System.IO.Path]::Combine(
    $tempBase,
    "eddie-skills-powershell-boundaries-$PID-$([guid]::NewGuid().ToString('N'))"
)
$testRoot = [System.IO.Path]::GetFullPath($testRoot)
$requiredPrefix = $tempBase + [System.IO.Path]::DirectorySeparatorChar

Assert-True (
    $testRoot.StartsWith(
        $requiredPrefix,
        [System.StringComparison]::OrdinalIgnoreCase
    )
) 'The temporary test root is not contained by the system temporary directory.'

$originalPath = $env:PATH
$junctionPath = $null

try {
    [void][System.IO.Directory]::CreateDirectory($testRoot)

    $newItemParameters = (Get-Command New-Item -CommandType Cmdlet).Parameters
    Assert-True (-not $newItemParameters.ContainsKey('LiteralPath')) `
        'New-Item unexpectedly exposes LiteralPath; requalify the fixture contract.'

    $unsupportedPath = Join-Path $testRoot 'unsupported-literal-path'
    $unsupportedRejected = $false
    try {
        New-Item -ItemType Directory -LiteralPath $unsupportedPath `
            -ErrorAction Stop | Out-Null
    }
    catch {
        $unsupportedRejected = $true
    }
    Assert-True (
        $unsupportedRejected -and
        -not (Test-Path -LiteralPath $unsupportedPath)
    ) 'New-Item -LiteralPath was not rejected without creating the target.'

    $supportedPath = Join-Path $testRoot 'supported-path'
    New-Item -ItemType Directory -Path $supportedPath `
        -ErrorAction Stop | Out-Null
    Assert-True (Test-Path -LiteralPath $supportedPath -PathType Container) `
        'New-Item -Path did not create the expected directory.'

    $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
    $nonTerminatingScript = Join-Path $testRoot 'cmdlet-nonterminating.ps1'
    $failClosedScript = Join-Path $testRoot 'cmdlet-failclosed.ps1'
    [System.IO.File]::WriteAllText(
        $nonTerminatingScript,
        @'
param([string]$SourcePath, [string]$DestinationPath)
$copyErrors = @()
Copy-Item -LiteralPath $SourcePath -Destination $DestinationPath -ErrorAction Continue -ErrorVariable +copyErrors
if ($copyErrors.Count -gt 0) {
    [Console]::Error.WriteLine('EXPECTED_NONTERMINATING_CMDLET_ERROR')
}
'continued' | Out-Null
'@,
        $utf8NoBom
    )
    [System.IO.File]::WriteAllText(
        $failClosedScript,
        @'
param([string]$SourcePath, [string]$DestinationPath)
try {
    Copy-Item -LiteralPath $SourcePath -Destination $DestinationPath -ErrorAction Stop
    if (-not (Test-Path -LiteralPath $DestinationPath -PathType Leaf)) {
        throw 'The expected artifact was not produced.'
    }
}
catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    exit 7
}
'@,
        $utf8NoBom
    )

    $currentPowerShell = [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
    $missingSource = Join-Path $testRoot 'missing-source.txt'
    $greenArtifact = Join-Path $testRoot 'green-artifact.txt'
    $greenResult = Invoke-ChildPowerShell `
        -Executable $currentPowerShell `
        -ScriptPath $nonTerminatingScript `
        -ScriptArguments @($missingSource, $greenArtifact) `
        -OutputPath (Join-Path $testRoot 'green.stdout.txt') `
        -ErrorPath (Join-Path $testRoot 'green.stderr.txt')
    Assert-True (
        $greenResult.ExitCode -eq $readiness.error_contract.green_exit -and
        $greenResult.Stderr -match 'EXPECTED_NONTERMINATING_CMDLET_ERROR'
    ) 'The non-terminating cmdlet-error control did not prove an error record plus outer exit zero.'
    Assert-True (-not (Test-Path -LiteralPath $greenArtifact)) `
        'The non-terminating cmdlet-error control unexpectedly produced an artifact.'

    $closedArtifact = Join-Path $testRoot 'closed-artifact.txt'
    $closedResult = Invoke-ChildPowerShell `
        -Executable $currentPowerShell `
        -ScriptPath $failClosedScript `
        -ScriptArguments @($missingSource, $closedArtifact) `
        -OutputPath (Join-Path $testRoot 'closed.stdout.txt') `
        -ErrorPath (Join-Path $testRoot 'closed.stderr.txt')
    Assert-True (
        $closedResult.ExitCode -eq $readiness.error_contract.fail_closed_exit -and
        -not (Test-Path -LiteralPath $closedArtifact)
    ) 'The corrected cmdlet shape did not fail closed on a missing source.'

    $existingSource = Join-Path $testRoot 'existing-source.txt'
    $verifiedArtifact = Join-Path $testRoot 'verified-artifact.txt'
    [System.IO.File]::WriteAllText(
        $existingSource,
        $readiness.error_contract.artifact_content,
        [System.Text.Encoding]::ASCII
    )
    $verifiedResult = Invoke-ChildPowerShell `
        -Executable $currentPowerShell `
        -ScriptPath $failClosedScript `
        -ScriptArguments @($existingSource, $verifiedArtifact) `
        -OutputPath (Join-Path $testRoot 'verified.stdout.txt') `
        -ErrorPath (Join-Path $testRoot 'verified.stderr.txt')
    Assert-True ($verifiedResult.ExitCode -eq 0) `
        'The corrected cmdlet shape did not return success for a valid source.'
    Assert-True (
        (Test-Path -LiteralPath $verifiedArtifact -PathType Leaf) -and
        [System.IO.File]::ReadAllText($verifiedArtifact) -eq
            $readiness.error_contract.artifact_content
    ) 'The corrected cmdlet shape did not verify the expected artifact.'

    $commandName = "shape-probe-$([guid]::NewGuid().ToString('N')).cmd"
    $commandDirectoryOne = Join-Path $testRoot 'command-one'
    $commandDirectoryTwo = Join-Path $testRoot 'command-two'
    [void][System.IO.Directory]::CreateDirectory($commandDirectoryOne)
    [void][System.IO.Directory]::CreateDirectory($commandDirectoryTwo)
    [System.IO.File]::WriteAllText(
        (Join-Path $commandDirectoryOne $commandName),
        "@echo off`r`n",
        [System.Text.Encoding]::ASCII
    )
    [System.IO.File]::WriteAllText(
        (Join-Path $commandDirectoryTwo $commandName),
        "@echo off`r`n",
        [System.Text.Encoding]::ASCII
    )
    $env:PATH = "$commandDirectoryOne;$commandDirectoryTwo;$originalPath"

    $candidates = @(
        Get-Command $commandName -CommandType Application -All `
            -ErrorAction SilentlyContinue
    )
    Assert-True ($candidates.Count -eq 2) `
        'Executable discovery did not preserve both application candidates.'
    Assert-True (
        @($candidates | Where-Object CommandType -ne 'Application').Count -eq 0
    ) 'Executable discovery returned a non-application candidate.'

    $scalarPath = $candidates[0].Path
    Assert-True (@($scalarPath).Count -eq 1) `
        'A scalar path was not normalized to a one-item collection.'
    Assert-True ($scalarPath[0] -ne $scalarPath) `
        'The scalar-string indexing control did not select a single character.'

    $lfBytes = $utf8NoBom.GetBytes("alpha`nbeta`n")
    Assert-True (
        -not (
            $lfBytes.Length -ge 3 -and
            $lfBytes[0] -eq 0xEF -and
            $lfBytes[1] -eq 0xBB -and
            $lfBytes[2] -eq 0xBF
        )
    ) 'The LF payload unexpectedly contains a UTF-8 BOM.'
    Assert-True (-not ($lfBytes -contains 0x0D)) `
        'The LF payload unexpectedly contains a carriage return.'
    Assert-True ($lfBytes[$lfBytes.Length - 1] -eq 0x0A) `
        'The LF payload does not end with the required final LF.'

    $crlfBytes = $utf8NoBom.GetBytes("alpha`r`nbeta`r`n")
    $firstConsumerLine = $utf8NoBom.GetString($crlfBytes).Split([char]0x0A)[0]
    Assert-True ($firstConsumerLine.EndsWith([char]0x0D)) `
        'The CRLF control did not expose the trailing carriage return.'

    $pathBase = Join-Path $testRoot 'path-base'
    [void][System.IO.Directory]::CreateDirectory($pathBase)
    $relativePath = Join-Path 'nested' 'item.txt'
    $resolvedRelative = Resolve-WithOneBase -Path $relativePath -Base $pathBase
    $resolvedRooted = Resolve-WithOneBase -Path $resolvedRelative -Base $testRoot
    Assert-True ($resolvedRelative -eq $resolvedRooted) `
        'A rooted path changed when resolved with the one-base rule.'
    Assert-True (
        $resolvedRelative.StartsWith(
            $pathBase + [System.IO.Path]::DirectorySeparatorChar,
            [System.StringComparison]::OrdinalIgnoreCase
        )
    ) 'The relative path did not resolve beneath its declared base.'

    $sourcePath = Join-Path $testRoot 'retained-source'
    $junctionPath = Join-Path $testRoot 'disposable-junction'
    [void][System.IO.Directory]::CreateDirectory($sourcePath)
    $sentinelPath = Join-Path $sourcePath 'sentinel.txt'
    [System.IO.File]::WriteAllText(
        $sentinelPath,
        'retain',
        [System.Text.Encoding]::ASCII
    )
    [void](New-Item -ItemType Junction -Path $junctionPath -Target $sourcePath)

    $junction = Get-Item -LiteralPath $junctionPath -Force
    Assert-True (
        ($junction.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0
    ) 'The disposable link is not a reparse point.'
    Assert-True ($junction.LinkType -eq 'Junction') `
        'The disposable link is not identified as a Junction.'

    [System.IO.Directory]::Delete($junctionPath, $false)
    Assert-True (-not (Test-Path -LiteralPath $junctionPath)) `
        'The Junction still exists after nonrecursive link removal.'
    Assert-True (Test-Path -LiteralPath $sentinelPath -PathType Leaf) `
        'The retained target sentinel was removed with the Junction.'
    $junctionPath = $null
}
finally {
    $env:PATH = $originalPath

    if ($null -ne $junctionPath -and (Test-Path -LiteralPath $junctionPath)) {
        $cleanupItem = Get-Item -LiteralPath $junctionPath -Force
        if (
            ($cleanupItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -eq 0
        ) {
            throw 'Cleanup refused a non-reparse item at the Junction path.'
        }
        [System.IO.Directory]::Delete($junctionPath, $false)
    }

    if ([System.IO.Directory]::Exists($testRoot)) {
        [System.IO.Directory]::Delete($testRoot, $true)
    }
}

Write-Output "$script:CheckCount PowerShell boundary checks passed."
