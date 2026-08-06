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
$projectDocsChecks = Get-Content -Raw -Encoding UTF8 (
    Join-Path $projectDocs 'docs\CHECKS.md'
)
$projectDocsNow = Get-Content -Raw -Encoding UTF8 (
    Join-Path $projectDocs 'docs\NOW.md'
)
$projectDocsContinue = Get-Content -Raw -Encoding UTF8 (
    Join-Path $projectDocs 'docs\CONTINUE.md'
)
Add-Check `
    -Name 'project-docs baseline' `
    -Passed (
        $projectDocsExit -eq 0 -and
        $projectDocsText -match 'test_normalizes_spacing_and_case' -and
        $projectDocsText -match 'Ran 1 test' -and
        $projectDocsText -notmatch '(?m)^(?:FAILED|ERROR)' -and
        $projectDocsChecks -match 'Current evidence owner: `UNKNOWN`' -and
        $projectDocsChecks -match 'frozen observation' -and
        $projectDocsNow -match 'competing\s+recovery claim' -and
        $projectDocsContinue -match 'No such\s+authorization is recorded'
    ) `
    -Expectation 'partial test passes while current evidence, recovery, and authorization remain unresolved'

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
$continuityAnchorRecovery = [regex]::Match(
    $continuityRules,
    'Resume interrupted work from `([^`]+)`\.'
)
$continuityStateRecovery = [regex]::Match(
    $continuityState,
    '(?m)^- Recovery target: `([^`]+)`$'
)
Add-Check `
    -Name 'project-docs continuity baseline' `
    -Passed (
        $continuityExit -eq 0 -and
        $continuityText -match 'test_normalizes_slug' -and
        $continuityText -match 'Ran 1 test' -and
        $continuityText -notmatch '(?m)^(?:FAILED|ERROR)' -and
        $continuityState -match 'planned but not implemented' -and
        $continuityState -match 'Current writer: none recorded' -and
        $continuityState -match 'Current gate:' -and
        $continuityAnchorRecovery.Success -and
        $continuityStateRecovery.Success -and
        $continuityAnchorRecovery.Groups[1].Value -eq
            $continuityStateRecovery.Groups[1].Value -and
        $continuityState -match '## Frozen Historical Checkpoint' -and
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
$releaseSnapshot = Get-Content -Raw -Encoding UTF8 (
    Join-Path $serviceDocs 'docs\RELEASE-0.0.1.md'
)
Add-Check `
    -Name 'project-docs safety boundaries baseline' `
    -Passed (
        (Test-Path -LiteralPath (Join-Path $serviceDocs 'AGENTS.md')) -and
        (Test-Path -LiteralPath (Join-Path $serviceDocs 'schema\openapi.yaml')) -and
        $generatedApi -match 'Generated from \.\./schema/openapi\.yaml' -and
        $writerState -match '(?m)^State: active$' -and
        $serviceProject -match '外部 Wiki' -and
        $serviceProject -match '`UNKNOWN`' -and
        $releaseSnapshot -match 'Immutable Historical Release Snapshot' -and
        $releaseSnapshot -match 'Do not modify or reinterpret'
    ) `
    -Expectation 'nearest scope exposes generated, external, language, writer, and immutable-history boundaries'

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
    $setupRecord = ($setupOutput | Out-String) | ConvertFrom-Json

    $actualBranch = & git -C $coldResumeRunFull branch --show-current
    $branchExit = $LASTEXITCODE
    $actualHead = & git -C $coldResumeRunFull rev-parse --verify HEAD 2>&1
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
        $setupRecord.Fixture -eq 'cold-resume' -and
        $setupRecord.Branch -eq 'phase/retry-delay' -and
        $branchExit -eq 0 -and
        ($actualBranch | Out-String).Trim() -eq 'phase/retry-delay' -and
        $headExit -eq 0 -and
        ($actualHead | Out-String).Trim() -eq $setupRecord.BaselineCommit -and
        $statusExit -eq 0 -and
        $indexExit -eq 0 -and
        $coldResumeStatus -contains ' M src/retry_policy.py' -and
        @($coldResumeIndex).Count -eq 0 -and
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
    -Expectation 'out-of-root setup is rejected and the approved branch plus owned dirty implementation are reproducible'

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
        $workCharterProject -match '## Approved Standing Policy' -and
        $workCharterProject -match 'Policy revision 2 applies only' -and
        $workCharterProject -match 'Reuse must remain visible' -and
        $workCharterProject -match 'This phase is unapproved'
    ) `
    -Expectation 'Standard fixture starts with an approved bounded policy, active Phase One contract, and unapproved Phase Two'

$workCharterEntry = Join-Path $repoRoot 'evals\fixtures\work-charter-entry'
$entryExistingReadme = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterEntry 'existing-owner\README.md'
)
$entryExistingOwner = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterEntry 'existing-owner\PROJECT.md'
)
$entryNoOwner = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterEntry 'no-owner\README.md'
)
Add-Check `
    -Name 'work-charter entry variants' `
    -Passed (
        $entryExistingReadme -match 'PROJECT\.md#work-coordination-and-recovery' -and
        $entryExistingOwner -match 'Workstream: release-cleanup only' -and
        $entryExistingOwner -match 'must survive one planned session handoff' -and
        $entryExistingOwner -match 'No Work Charter has been\s+adopted yet' -and
        $entryNoOwner -match 'completed in the\s+current reliable task' -and
        $entryNoOwner -match 'no planned handoff' -and
        $entryNoOwner -match 'durable project-document owner'
    ) `
    -Expectation 'entry fixture exposes one clean existing-owner variant and one current-task no-owner variant'

$workCharterIntegrity = Join-Path $repoRoot 'evals\fixtures\work-charter-recovery-integrity'
$integrityAuthority = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterIntegrity 'authority-ordering\SNAPSHOT.md'
)
$integrityAssessment = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterIntegrity 'assessment-recording\SNAPSHOT.md'
)
$integrityEvidence = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterIntegrity 'evidence-drift\SNAPSHOT.md'
)
$integrityDelivery = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterIntegrity 'delivery-and-writer\SNAPSHOT.md'
)
$integrityRevision = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterIntegrity 'charter-revision\SNAPSHOT.md'
)
$integrityWorktrees = Get-Content -Raw -Encoding UTF8 (
    Join-Path $workCharterIntegrity 'multi-worktree-carrier\SNAPSHOT.md'
)
$integrityEvidenceVariant = Join-Path $workCharterIntegrity 'evidence-drift'
$integrityRun = Join-Path $runRoot (
    'fixture-check-integrity-' + [guid]::NewGuid().ToString('N')
)
$integrityRunFull = [System.IO.Path]::GetFullPath($integrityRun)
if (
    -not $integrityRunFull.StartsWith(
        $runRootFull + [System.IO.Path]::DirectorySeparatorChar,
        $pathComparison
    )
) {
    throw 'Recovery-integrity check destination escaped the ignored run root.'
}
$integrityIgnoredReady = $false
try {
    Copy-Item -LiteralPath $integrityEvidenceVariant -Destination $integrityRunFull -Recurse
    & git -C $integrityRunFull init -b main | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw 'Failed to initialize the recovery-integrity fixture repository.'
    }
    & git -C $integrityRunFull -c 'core.autocrlf=false' add .
    if ($LASTEXITCODE -ne 0) {
        throw 'Failed to stage the recovery-integrity fixture baseline.'
    }
    & git -C $integrityRunFull `
        -c 'user.name=Fixture Check' `
        -c 'user.email=fixture@example.invalid' `
        -c 'commit.gpgSign=false' `
        commit -m 'fixture baseline' | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw 'Failed to commit the recovery-integrity fixture baseline.'
    }

    $integrityPrivateDirectory = Join-Path $integrityRunFull 'private-results'
    $integrityPrivateResult = Join-Path $integrityPrivateDirectory 'qualification.txt'
    New-Item -ItemType Directory -Path $integrityPrivateDirectory -Force | Out-Null
    Copy-Item -LiteralPath (
        Join-Path $integrityRunFull 'qualification-result.txt'
    ) -Destination $integrityPrivateResult

    $integrityOrdinaryStatus = & git -C $integrityRunFull status --short
    $integrityOrdinaryExit = $LASTEXITCODE
    $integrityIgnoredStatus = & git -C $integrityRunFull status --short --ignored
    $integrityIgnoredExit = $LASTEXITCODE
    $integrityIgnoredReady = (
        $integrityOrdinaryExit -eq 0 -and
        @($integrityOrdinaryStatus).Count -eq 0 -and
        $integrityIgnoredExit -eq 0 -and
        (($integrityIgnoredStatus | Out-String) -match 'private-results') -and
        (Test-Path -LiteralPath $integrityPrivateResult -PathType Leaf)
    )
}
finally {
    if (Test-Path -LiteralPath $integrityRunFull) {
        Remove-Item -LiteralPath $integrityRunFull -Recurse -Force
    }
}
Add-Check `
    -Name 'work-charter recovery-integrity baseline' `
    -Passed (
        $integrityAuthority -match 'Authoritative revision: `2`' -and
        $integrityAuthority -match 'Later arrival: decision revision `1`' -and
        $integrityAssessment -match 'Phase One assessment: `pending`' -and
        $integrityAssessment -match 'Verdict: `ACCEPTED`' -and
        $integrityAssessment -match 'Durable recording: not performed' -and
        $integrityEvidence -match 'Source revision: `2`' -and
        $integrityEvidence -match 'Bound source revision: `1`' -and
        $integrityEvidence -match 'Remaining authorized attempts: `0`' -and
        $integrityEvidence -match 'completed `CORRECTION_REQUIRED` round `1`' -and
        $integrityEvidence -match 'Declared evidence consumption point: `qualification/start`' -and
        $integrityEvidence -match 'failed before `qualification/start`' -and
        $integrityEvidence -match 'Qualification `q1`: emitted `qualification/start`' -and
        $integrityEvidence -match 'Delivery/transport retries consumed: `1`' -and
        $integrityEvidence -match 'Native-review rounds consumed: `2`' -and
        $integrityEvidence -match 'Tracked Git status: clean' -and
        $integrityIgnoredReady -and
        $integrityDelivery -match 'Addressable role: unproved' -and
        $integrityDelivery -match 'Replacement authority: none' -and
        $integrityDelivery -match 'Delta owner: unknown' -and
        $integrityRevision -match 'Revision: `4`' -and
        $integrityRevision -match 'Requested scope: active and archived customers' -and
        $integrityRevision -match 'Authority for the scope or acceptance change: not yet granted' -and
        $integrityRevision -match 'Completed Work Charter corrections: `1`' -and
        $integrityRevision -match 'Consumed one-shot evidence: `archive-write-04`' -and
        $integrityRevision -match 'Current task, root, and attempt labels are not identity fields' -and
        $integrityWorktrees -match 'Worktree A: `WORK_CHARTER\.md`, revision `5`' -and
        $integrityWorktrees -match 'Worktree B: `WORK_CHARTER\.md`, revision `6`' -and
        $integrityWorktrees -match 'Common control location: `UNKNOWN`' -and
        $integrityWorktrees -match 'Dirty ownership: incomparable'
    ) `
    -Expectation 'six read-only integrity variants expose resume, successor history, pending recording, consumption-aware hidden evidence drift, delivery/writer ambiguity, and divergent worktree carriers'

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

$controllerCheck = Join-Path $repoRoot 'evals\check-codex-evidence-controller.ps1'
$controllerOutput = & pwsh -NoProfile -File $controllerCheck 2>&1
$controllerExit = $LASTEXITCODE
$controllerRecord = $null
if ($controllerExit -eq 0) {
    try {
        $controllerRecord = ($controllerOutput | Out-String) | ConvertFrom-Json
    }
    catch {
        $controllerRecord = $null
    }
}
$realReparseGuard = @(
    $controllerRecord.sealed_locator_guards.identities |
        Where-Object { [string]$_.id -ceq 'real-reparse-component' }
)
$expectedReparsePrimitive = if ($IsWindows) { 'Junction' } else { 'SymbolicLink' }
$expectedUnexecutedBranch = if ($IsWindows) {
    'non-Windows/SymbolicLink:UNKNOWN'
}
else {
    'Windows/Junction:UNKNOWN'
}
Add-Check `
    -Name 'Codex evidence controller regression' `
    -Passed (
        $controllerExit -eq 0 -and
        $null -ne $controllerRecord -and
        $controllerRecord.verdict -eq 'PASS' -and
        $controllerRecord.historical.passed -eq 11 -and
        $controllerRecord.historical.total -eq 11 -and
        @($controllerRecord.historical.generated_contracts).Count -eq 11 -and
        $controllerRecord.negative.passed -eq 30 -and
        $controllerRecord.negative.total -eq 30 -and
        $controllerRecord.metamorphic.passed -eq 4 -and
        $controllerRecord.metamorphic.total -eq 4 -and
        $controllerRecord.historical_source_bindings.passed -eq 11 -and
        $controllerRecord.historical_source_bindings.total -eq 11 -and
        $controllerRecord.historical_binding_guards.passed -eq 4 -and
        $controllerRecord.historical_binding_guards.total -eq 4 -and
        $controllerRecord.historical_generated_contract_guards.passed -eq 3 -and
        $controllerRecord.historical_generated_contract_guards.total -eq 3 -and
        $controllerRecord.package_manifests.passed -eq 2 -and
        $controllerRecord.package_manifests.total -eq 2 -and
        $controllerRecord.package_manifest_hash_guards.passed -eq 2 -and
        $controllerRecord.package_manifest_hash_guards.total -eq 2 -and
        $controllerRecord.sealed_locator_guards.passed -eq 4 -and
        $controllerRecord.sealed_locator_guards.total -eq 4 -and
        $realReparseGuard.Count -eq 1 -and
        $realReparseGuard[0].selected_primitive -ceq $expectedReparsePrimitive -and
        $realReparseGuard[0].selected_link_type -ceq $expectedReparsePrimitive -and
        $realReparseGuard[0].target_retained -eq $true -and
        $realReparseGuard[0].unexecuted_platform_branch -ceq $expectedUnexecutedBranch -and
        $controllerRecord.sealed_byte_capture_guards.passed -eq 1 -and
        $controllerRecord.sealed_byte_capture_guards.total -eq 1 -and
        $controllerRecord.scratch_topology_guards.passed -eq 2 -and
        $controllerRecord.scratch_topology_guards.total -eq 2 -and
        $controllerRecord.threat_model.id -ceq 'quiescent-offline-single-writer/v1' -and
        $controllerRecord.threat_model.concurrent_path_swap_resistance -ceq 'UNSUPPORTED' -and
        $controllerRecord.threat_model.observable_pre_post_topology_drift -ceq 'fail_closed' -and
        $controllerRecord.scratch_lifecycle.pre_cleanup -ceq 'validated' -and
        $controllerRecord.scratch_lifecycle.scratch_absent -eq $true -and
        $controllerRecord.scratch_lifecycle.run_root_post_cleanup -ceq 'ordinary_non_reparse' -and
        $controllerRecord.scratch_lifecycle.residue -ceq 'none' -and
        $controllerRecord.external_input_type_guards.passed -eq 3 -and
        $controllerRecord.external_input_type_guards.total -eq 3 -and
        $controllerRecord.git_read_safety_guards.passed -eq 8 -and
        $controllerRecord.git_read_safety_guards.total -eq 8 -and
        $controllerRecord.canonical_ordinal_guards.passed -eq 1 -and
        $controllerRecord.canonical_ordinal_guards.total -eq 1 -and
        $controllerRecord.command_resolution_guards.passed -eq 8 -and
        $controllerRecord.command_resolution_guards.total -eq 8 -and
        $controllerRecord.content_proof_identity_guards.passed -eq 6 -and
        $controllerRecord.content_proof_identity_guards.total -eq 6 -and
        $controllerRecord.record_cardinality_and_exit_guards.passed -eq 3 -and
        $controllerRecord.record_cardinality_and_exit_guards.total -eq 3 -and
        $controllerRecord.output_no_clobber_guards.passed -eq 1 -and
        $controllerRecord.output_no_clobber_guards.total -eq 1 -and
        $controllerRecord.narrow_git_context_check -eq $true -and
        $controllerRecord.canonical_repeat.equal -eq $true
    ) `
    -Expectation 'tracked controller binds generated historical contracts, captures sealed bytes once, rejects real reparse and scratch-topology drift, safely cleans validated scratch, and passes historical, negative, metamorphic, and repeatability checks without recursive self-invocation'

$checks | Format-Table -AutoSize

$failed = @($checks | Where-Object { -not $_.Passed })
if ($failed.Count -gt 0) {
    exit 1
}

exit 0
