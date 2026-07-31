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

    $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
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
