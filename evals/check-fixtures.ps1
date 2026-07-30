[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$pathComparison = if ($IsWindows) {
    [System.StringComparison]::OrdinalIgnoreCase
}
else {
    [System.StringComparison]::Ordinal
}
$env:PYTHONDONTWRITEBYTECODE = '1'
$checks = [System.Collections.Generic.List[object]]::new()

function Add-Check {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [bool]$Passed,

        [Parameter(Mandatory)]
        [string]$Expectation
    )

    $checks.Add([pscustomobject]@{
        Check = $Name
        Passed = $Passed
        Expectation = $Expectation
    })
}

$projectDocs = Join-Path $repoRoot 'evals\fixtures\project-docs-conflict'
Push-Location $projectDocs
try {
    $projectDocsOutput = & python -m unittest discover -s tests -v 2>&1
    $projectDocsExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
$projectDocsText = $projectDocsOutput | Out-String
Add-Check `
    -Name 'project-docs baseline' `
    -Passed (
        $projectDocsExit -eq 0 -and
        $projectDocsText -match 'test_normalizes_spacing_and_case' -and
        $projectDocsText -match 'Ran 1 test' -and
        $projectDocsText -notmatch '(?m)^(?:FAILED|ERROR)'
    ) `
    -Expectation 'existing label-normalization test passes'

$matureDocs = Join-Path $repoRoot 'evals\fixtures\project-docs-mature-noop'
Push-Location $matureDocs
try {
    $matureDocsOutput = & python -m unittest discover -s tests -v 2>&1
    $matureDocsExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
$matureDocsText = $matureDocsOutput | Out-String
$matureGuide = Get-Content -Raw -Encoding UTF8 (
    Join-Path $matureDocs 'PROJECT_GUIDE.md'
)
Add-Check `
    -Name 'project-docs mature NOOP baseline' `
    -Passed (
        $matureDocsExit -eq 0 -and
        $matureDocsText -match 'test_sums_inclusive_range' -and
        $matureDocsText -match 'Ran 1 test' -and
        $matureDocsText -notmatch '(?m)^(?:FAILED|ERROR)' -and
        $matureGuide -match '## Purpose And Scope' -and
        $matureGuide -match '## Work And Verification' -and
        $matureGuide -match '## Authority And Write Routing' -and
        $matureGuide -match '## Current State And Evidence' -and
        $matureGuide -match '## Next Action And Recovery' -and
        -not (Test-Path -LiteralPath (Join-Path $matureDocs 'docs'))
    ) `
    -Expectation 'one nonstandard document covers all five responsibilities'

$adoptDocs = Join-Path $repoRoot 'evals\fixtures\project-docs-adopt'
Push-Location $adoptDocs
try {
    $adoptDocsOutput = & python -m unittest discover -s tests -v 2>&1
    $adoptDocsExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
$adoptDocsText = $adoptDocsOutput | Out-String
$adoptMarkdown = @(
    Get-ChildItem -LiteralPath $adoptDocs -Filter '*.md' -File |
    ForEach-Object { $_.Name }
)
Add-Check `
    -Name 'project-docs adoption baseline' `
    -Passed (
        $adoptDocsExit -eq 0 -and
        $adoptDocsText -match 'test_normalizes_ascii_label' -and
        $adoptDocsText -match 'Ran 1 test' -and
        $adoptDocsText -notmatch '(?m)^(?:FAILED|ERROR)' -and
        $adoptMarkdown.Count -eq 2 -and
        $adoptMarkdown -contains 'AGENTS.md' -and
        $adoptMarkdown -contains 'README.md' -and
        -not (Test-Path -LiteralPath (Join-Path $adoptDocs 'docs'))
    ) `
    -Expectation 'purpose exists but persistent governance is initially missing'

$continuityDocs = Join-Path $repoRoot 'evals\fixtures\project-docs-continuity'
Push-Location $continuityDocs
try {
    $continuityOutput = & python -m unittest discover -s tests -v 2>&1
    $continuityExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
$continuityText = $continuityOutput | Out-String
$continuityState = Get-Content -Raw -Encoding UTF8 (
    Join-Path $continuityDocs 'PROJECT_STATE.md'
)
$continuityRules = Get-Content -Raw -Encoding UTF8 (
    Join-Path $continuityDocs 'AGENTS.md'
)
Add-Check `
    -Name 'project-docs continuity baseline' `
    -Passed (
        $continuityExit -eq 0 -and
        $continuityText -match 'test_normalizes_slug' -and
        $continuityText -match 'Ran 1 test' -and
        $continuityText -notmatch '(?m)^(?:FAILED|ERROR)' -and
        $continuityState -match 'planned but not implemented' -and
        $continuityRules -match '## Project Documentation Continuity' -and
        $continuityRules -match 'PROJECT_STATE\.md#next-action-and-recovery' -and
        $continuityRules -match '\$manage-project-docs' -and
        $continuityRules -match 'neither an invocation'
    ) `
    -Expectation 'ordinary updates stay routed while broken governance requests explicit Skill invocation'

$safetyDocs = Join-Path $repoRoot 'evals\fixtures\project-docs-safety-boundaries'
$serviceDocs = Join-Path $safetyDocs 'apps\service'
$generatedApi = Get-Content -Raw -Encoding UTF8 (
    Join-Path $serviceDocs 'docs\API.md'
)
$writerState = Get-Content -Raw -Encoding UTF8 (
    Join-Path $serviceDocs 'docs\WRITER.md'
)
$serviceProject = Get-Content -Raw -Encoding UTF8 (
    Join-Path $serviceDocs 'PROJECT.zh-CN.md'
)
Add-Check `
    -Name 'project-docs safety boundaries baseline' `
    -Passed (
        (Test-Path -LiteralPath (Join-Path $serviceDocs 'AGENTS.md')) -and
        (Test-Path -LiteralPath (Join-Path $serviceDocs 'schema\openapi.yaml')) -and
        $generatedApi -match 'Generated from \.\./schema/openapi\.yaml' -and
        $writerState -match '(?m)^State: active$' -and
        $serviceProject -match '外部 Wiki' -and
        $serviceProject -match '`UNKNOWN`'
    ) `
    -Expectation 'nearest scope exposes generated, external, language, and writer stops'

$projectDocsRunRoot = Join-Path $repoRoot '.eval-runs'
$projectDocsRunRootFull = [System.IO.Path]::GetFullPath($projectDocsRunRoot)
$projectDocsRun = Join-Path (
    $projectDocsRunRoot
) ('fixture-check-project-docs-' + [guid]::NewGuid().ToString('N'))
$projectDocsRunFull = [System.IO.Path]::GetFullPath($projectDocsRun)

if (
    -not $projectDocsRunFull.StartsWith(
        $projectDocsRunRootFull + [System.IO.Path]::DirectorySeparatorChar,
        [System.StringComparison]::OrdinalIgnoreCase
    )
) {
    throw 'Project Docs check destination escaped the ignored run root.'
}

$projectDocsRunReady = $false
try {
    [void](New-Item -ItemType Directory -Path $projectDocsRunRootFull -Force)
    $projectDocsSetup = Join-Path $repoRoot 'evals\setup-project-docs.ps1'
    $projectDocsInspect = Join-Path $repoRoot 'evals\inspect-project-docs-run.ps1'

    $setupOutput = & pwsh `
        -NoProfile `
        -File $projectDocsSetup `
        -Case project-docs-conflict `
        -Destination $projectDocsRunFull
    $setupExit = $LASTEXITCODE
    $setupRecord = ($setupOutput | Out-String) | ConvertFrom-Json

    $beforeOutput = & pwsh `
        -NoProfile `
        -File $projectDocsInspect `
        -Destination $projectDocsRunFull
    $beforeExit = $LASTEXITCODE
    $beforeRecord = ($beforeOutput | Out-String) | ConvertFrom-Json

    $cacheDirectory = Join-Path $projectDocsRunFull 'src\__pycache__'
    [void](New-Item -ItemType Directory -Path $cacheDirectory -Force)
    $cachePath = Join-Path $cacheDirectory 'eval-probe.pyc'
    [System.IO.File]::WriteAllBytes($cachePath, [byte[]](0x50, 0x59, 0x43))

    $afterOutput = & pwsh `
        -NoProfile `
        -File $projectDocsInspect `
        -Destination $projectDocsRunFull
    $afterExit = $LASTEXITCODE
    $afterRecord = ($afterOutput | Out-String) | ConvertFrom-Json
    $addedPaths = @(
        $afterRecord.ManifestDelta.Added |
        ForEach-Object { $_.Path }
    )

    $projectDocsRunReady = (
        $setupExit -eq 0 -and
        $beforeExit -eq 0 -and
        $afterExit -eq 0 -and
        $setupRecord.Case -eq 'project-docs-conflict' -and
        $setupRecord.BaselineCommit -eq $beforeRecord.BaselineCommit -and
        $beforeRecord.BaselineCommit -eq $beforeRecord.HeadCommit -and
        @($beforeRecord.InitialGitStatus) -contains ' M src/user_notes.py' -and
        @($beforeRecord.ManifestDelta.Added).Count -eq 0 -and
        @($beforeRecord.ManifestDelta.Modified).Count -eq 0 -and
        @($beforeRecord.ManifestDelta.Removed).Count -eq 0 -and
        $addedPaths -contains 'src/__pycache__/eval-probe.pyc' -and
        (($afterRecord.CurrentGitStatus | Out-String) -match '__pycache__')
    )
}
finally {
    if (Test-Path -LiteralPath $projectDocsRunFull) {
        Remove-Item -LiteralPath $projectDocsRunFull -Recurse -Force
    }
}

Add-Check `
    -Name 'project-docs isolated Git and manifest' `
    -Passed $projectDocsRunReady `
    -Expectation 'synthetic dirty state is reproducible and ignored artifacts remain visible'

$reparseTarget = Join-Path (
    $projectDocsRunRoot
) ('fixture-check-reparse-target-' + [guid]::NewGuid().ToString('N'))
$reparseLink = Join-Path (
    $projectDocsRunRoot
) ('fixture-check-reparse-link-' + [guid]::NewGuid().ToString('N'))
$reparseTargetFull = [System.IO.Path]::GetFullPath($reparseTarget)
$reparseLinkFull = [System.IO.Path]::GetFullPath($reparseLink)

foreach ($probePath in @($reparseTargetFull, $reparseLinkFull)) {
    if (
        -not $probePath.StartsWith(
            $projectDocsRunRootFull + [System.IO.Path]::DirectorySeparatorChar,
            $pathComparison
        )
    ) {
        throw 'Reparse-point probe escaped the ignored run root.'
    }
}

$reparseSetupProjectRejected = $false
$reparseSetupColdRejected = $false
$reparseInspectorRejected = $false
$reparseDirectSetupReady = $false
try {
    [void](New-Item -ItemType Directory -Path $projectDocsRunRootFull -Force)
    [void](New-Item -ItemType Directory -Path $reparseTargetFull -Force)
    $reparseItemType = if ($IsWindows) { 'Junction' } else { 'SymbolicLink' }
    [void](New-Item `
        -ItemType $reparseItemType `
        -Path $reparseLinkFull `
        -Target $reparseTargetFull)

    $reparseItem = Get-Item -LiteralPath $reparseLinkFull -Force
    if (
        ($reparseItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -eq 0
    ) {
        throw 'Reparse-point probe did not create a reparse point.'
    }

    $projectDocsSetup = Join-Path $repoRoot 'evals\setup-project-docs.ps1'
    $projectDocsInspect = Join-Path $repoRoot 'evals\inspect-project-docs-run.ps1'
    $coldResumeSetup = Join-Path $repoRoot 'evals\setup-cold-resume.ps1'
    $blockedProjectDocs = Join-Path $reparseLinkFull 'blocked-project-docs'
    $blockedColdResume = Join-Path $reparseLinkFull 'blocked-cold-resume'
    $directProjectDocs = Join-Path $reparseTargetFull 'direct-project-docs'
    $linkedProjectDocs = Join-Path $reparseLinkFull 'direct-project-docs'

    $blockedProjectOutput = & pwsh `
        -NoProfile `
        -File $projectDocsSetup `
        -Case project-docs-conflict `
        -Destination $blockedProjectDocs 2>&1
    $blockedProjectExit = $LASTEXITCODE
    $reparseSetupProjectRejected = (
        $blockedProjectExit -ne 0 -and
        -not (Test-Path -LiteralPath (
            Join-Path $reparseTargetFull 'blocked-project-docs'
        )) -and
        (($blockedProjectOutput | Out-String).Contains(
            'Destination path must not contain an existing reparse point'
        ))
    )

    $blockedColdOutput = & pwsh `
        -NoProfile `
        -File $coldResumeSetup `
        -Destination $blockedColdResume 2>&1
    $blockedColdExit = $LASTEXITCODE
    $reparseSetupColdRejected = (
        $blockedColdExit -ne 0 -and
        -not (Test-Path -LiteralPath (
            Join-Path $reparseTargetFull 'blocked-cold-resume'
        )) -and
        (($blockedColdOutput | Out-String).Contains(
            'Destination path must not contain an existing reparse point'
        ))
    )

    $directSetupOutput = & pwsh `
        -NoProfile `
        -File $projectDocsSetup `
        -Case project-docs-conflict `
        -Destination $directProjectDocs
    $directSetupExit = $LASTEXITCODE
    $reparseDirectSetupReady = (
        $directSetupExit -eq 0 -and
        (Test-Path -LiteralPath $directProjectDocs -PathType Container)
    )

    $linkedInspectOutput = & pwsh `
        -NoProfile `
        -File $projectDocsInspect `
        -Destination $linkedProjectDocs 2>&1
    $linkedInspectExit = $LASTEXITCODE
    $reparseInspectorRejected = (
        $linkedInspectExit -ne 0 -and
        (($linkedInspectOutput | Out-String).Contains(
            'Destination path must not contain an existing reparse point'
        ))
    )
}
finally {
    if (Test-Path -LiteralPath $reparseLinkFull) {
        $reparseItem = Get-Item -LiteralPath $reparseLinkFull -Force
        if (
            ($reparseItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -eq 0
        ) {
            throw 'Refusing to remove a reparse probe that is no longer a link.'
        }
        Remove-Item -LiteralPath $reparseLinkFull -Force
    }
    if (Test-Path -LiteralPath $reparseTargetFull) {
        Remove-Item -LiteralPath $reparseTargetFull -Recurse -Force
    }
}

Add-Check `
    -Name 'eval helper reparse containment' `
    -Passed (
        $reparseSetupProjectRejected -and
        $reparseSetupColdRejected -and
        $reparseDirectSetupReady -and
        $reparseInspectorRejected
    ) `
    -Expectation 'setup and inspection reject junction or symlink path components'

$smallTask = Join-Path $repoRoot 'evals\fixtures\small-task-stays-flat'
Push-Location $smallTask
try {
    $smallTaskOutput = & python -m unittest discover -s tests -v 2>&1
    $smallTaskExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
$smallTaskText = $smallTaskOutput | Out-String
Add-Check `
    -Name 'small-task baseline' `
    -Passed (
        $smallTaskExit -ne 0 -and
        $smallTaskText -match 'test_counts_both_endpoints' -and
        $smallTaskText -match 'test_empty_when_end_precedes_start' -and
        $smallTaskText -match 'Ran 2 tests' -and
        $smallTaskText -match 'AssertionError: 2 != 3' -and
        $smallTaskText -match '(?m)^FAILED \(failures=1\)' -and
        $smallTaskText -notmatch '(?m)^ERROR'
    ) `
    -Expectation 'off-by-one test fails before the task is solved'

$coldResume = Join-Path $repoRoot 'evals\fixtures\cold-resume'
Push-Location $coldResume
try {
    $coldResumeOutput = & python -m unittest discover -s tests -v 2>&1
    $coldResumeExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
$coldResumeText = $coldResumeOutput | Out-String
$runRoot = Join-Path $repoRoot '.eval-runs'
$runRootFull = [System.IO.Path]::GetFullPath($runRoot)
$coldResumeRun = Join-Path $runRoot ('fixture-check-' + [guid]::NewGuid().ToString('N'))
$coldResumeRunFull = [System.IO.Path]::GetFullPath($coldResumeRun)
$coldResumeOutsideName = 'fixture-check-cold-resume-outside-' + [guid]::NewGuid().ToString('N')
$coldResumeOutside = Join-Path $repoRoot $coldResumeOutsideName
$coldResumeOutsideFull = [System.IO.Path]::GetFullPath($coldResumeOutside)

if (
    -not $coldResumeRunFull.StartsWith(
        $runRootFull + [System.IO.Path]::DirectorySeparatorChar,
        $pathComparison
    )
) {
    throw 'Cold-resume check destination escaped the ignored run root.'
}

if (
    -not $coldResumeOutsideFull.StartsWith(
        [System.IO.Path]::GetFullPath($repoRoot) +
        [System.IO.Path]::DirectorySeparatorChar,
        $pathComparison
    ) -or
    $coldResumeOutsideFull.StartsWith(
        $runRootFull + [System.IO.Path]::DirectorySeparatorChar,
        $pathComparison
    )
) {
    throw 'Cold-resume rejection probe is outside its intended repository boundary.'
}

$coldResumeGitReady = $false
$coldResumeOutsideRejected = $false
try {
    $setupScript = Join-Path $repoRoot 'evals\setup-cold-resume.ps1'
    $outsideOutput = & pwsh `
        -NoProfile `
        -File $setupScript `
        -Destination $coldResumeOutsideFull 2>&1
    $outsideExit = $LASTEXITCODE
    $coldResumeOutsideRejected = (
        $outsideExit -ne 0 -and
        -not (Test-Path -LiteralPath $coldResumeOutsideFull) -and
        (($outsideOutput | Out-String).Contains(
            'Destination must be a child of the repository .eval-runs directory.'
        ))
    )

    [void](New-Item -ItemType Directory -Path $runRootFull -Force)
    $setupOutput = & pwsh -NoProfile -File $setupScript -Destination $coldResumeRunFull 2>&1
    $setupExit = $LASTEXITCODE

    $actualBranch = & git -C $coldResumeRunFull branch --show-current
    $branchExit = $LASTEXITCODE
    $null = & git -C $coldResumeRunFull rev-parse --verify HEAD 2>&1
    $headExit = $LASTEXITCODE
    $coldResumeStatus = & git -C $coldResumeRunFull status --porcelain=v1
    $statusExit = $LASTEXITCODE
    $coldResumeIndex = & git -C $coldResumeRunFull diff --cached --name-only
    $indexExit = $LASTEXITCODE
    $stagedInterpreterArtifacts = @(
        $coldResumeIndex |
        Where-Object { $_ -match '(^|/)__pycache__(/|$)|\.py[co]$' }
    )

    $coldResumeGitReady = (
        $setupExit -eq 0 -and
        $branchExit -eq 0 -and
        ($actualBranch | Out-String).Trim() -eq 'main' -and
        $headExit -ne 0 -and
        $statusExit -eq 0 -and
        $indexExit -eq 0 -and
        $coldResumeStatus -contains 'AM src/retry_policy.py' -and
        ($coldResumeStatus | Out-String) -notmatch '(?m)^\?\?' -and
        $stagedInterpreterArtifacts.Count -eq 0
    )
}
finally {
    if (Test-Path -LiteralPath $coldResumeRunFull) {
        Remove-Item -LiteralPath $coldResumeRunFull -Recurse -Force
    }
    if (Test-Path -LiteralPath $coldResumeOutsideFull) {
        Remove-Item -LiteralPath $coldResumeOutsideFull -Recurse -Force
    }
}

Add-Check `
    -Name 'cold-resume baseline' `
    -Passed (
        $coldResumeExit -eq 0 -and
        $coldResumeText -match 'test_enabled' -and
        $coldResumeText -match 'test_name' -and
        $coldResumeText -match 'Ran 2 tests' -and
        $coldResumeText -notmatch '(?m)^(?:FAILED|ERROR)' -and
        $coldResumeOutsideRejected -and
        $coldResumeGitReady
    ) `
    -Expectation 'out-of-root setup is rejected and the deliberate Git drift is reproducible'

$workCharterLoop = Join-Path $repoRoot 'evals\fixtures\work-charter-loop'
Push-Location $workCharterLoop
try {
    $workCharterLoopOutput = & python -B -m unittest discover -s tests -v 2>&1
    $workCharterLoopExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
$workCharterLoopText = $workCharterLoopOutput | Out-String
$workCharterLoopContract = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterLoop 'WORK.md'
)
Add-Check `
    -Name 'work-charter shared loop baseline' `
    -Passed (
        $workCharterLoopExit -ne 0 -and
        $workCharterLoopText -match 'test_complete_batches' -and
        $workCharterLoopText -match 'test_empty_input' -and
        $workCharterLoopText -match 'test_keeps_final_partial_batch' -and
        $workCharterLoopText -match 'Ran 3 tests' -and
        $workCharterLoopText -match '(?m)^FAILED \(failures=1\)' -and
        $workCharterLoopText -notmatch '(?m)^ERROR' -and
        $workCharterLoopContract -match 'Contract state: `approved`' -and
        $workCharterLoopContract -match 'Independent assessment is required'
    ) `
    -Expectation 'shared midstream and Planner/Executor fixture exposes one bounded stale-evidence gap'

$workCharterStandard = Join-Path $repoRoot 'evals\fixtures\work-charter-standard'
Push-Location $workCharterStandard
try {
    $workCharterStandardOutput = & python -B -m unittest discover -s tests -v 2>&1
    $workCharterStandardExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
$workCharterStandardText = $workCharterStandardOutput | Out-String
$workCharterProject = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterStandard 'PROJECT.md'
)
Add-Check `
    -Name 'work-charter Standard baseline' `
    -Passed (
        $workCharterStandardExit -eq 0 -and
        $workCharterStandardText -match 'test_empty_input' -and
        $workCharterStandardText -match 'Ran 1 test' -and
        $workCharterStandardText -notmatch '(?m)^(?:FAILED|ERROR)' -and
        $workCharterProject -match '## Proposed Standing Policy' -and
        $workCharterProject -match 'This proposal has no effect until the user approves it' -and
        $workCharterProject -match 'This phase is unapproved'
    ) `
    -Expectation 'Standard fixture starts with a proposed policy, active Phase One contract, and unapproved Phase Two'

$powerShell = Join-Path $repoRoot 'evals\fixtures\powershell-boundary'
$jsonPath = Join-Path $powerShell 'data\input file.json'
$verifierPath = Join-Path $powerShell 'tools\verify_json.py'
$wrapperPath = Join-Path $powerShell 'tools\run-verifier.ps1'

$directOutput = & python $verifierPath --input $jsonPath 2>&1
$directExit = $LASTEXITCODE
Add-Check `
    -Name 'PowerShell direct invocation' `
    -Passed ($directExit -eq 0 -and (($directOutput | Out-String) -match '(?m)^valid\s*$')) `
    -Expectation 'argument-preserving invocation accepts the UTF-8 JSON'

$wrapperOutput = & pwsh -NoProfile -File $wrapperPath 2>&1
$wrapperExit = $LASTEXITCODE
Add-Check `
    -Name 'PowerShell broken wrapper' `
    -Passed (
        $wrapperExit -ne 0 -and
        (($wrapperOutput | Out-String) -match 'unrecognized arguments: .*file\.json')
    ) `
    -Expectation 'nested command string splits the path containing a space'

$jsonBytes = [System.IO.File]::ReadAllBytes($jsonPath)
$hasBom = (
    $jsonBytes.Length -ge 3 -and
    $jsonBytes[0] -eq 0xEF -and
    $jsonBytes[1] -eq 0xBB -and
    $jsonBytes[2] -eq 0xBF
)
Add-Check `
    -Name 'PowerShell JSON encoding' `
    -Passed (-not $hasBom) `
    -Expectation 'fixture input is UTF-8 without BOM'

$checks | Format-Table -AutoSize

$failed = @($checks | Where-Object { -not $_.Passed })
if ($failed.Count -gt 0) {
    exit 1
}

exit 0
