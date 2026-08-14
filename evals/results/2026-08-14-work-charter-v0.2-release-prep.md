# Work Charter v0.2.0 Prerelease Candidate Preparation

Date: 2026-08-14

## Scope And Disposition

This bounded release-prep change constructs one coherent Work-Charter-only
`v0.2.0` prerelease candidate from task-owned branch
`codex/work-charter-v0.2-release-prep`. It authorizes exactly one local commit
after deterministic verification and native review. It does not authorize or
claim `RC_INSTALL`, stable installation or loaded-copy evidence, push, PR,
merge, tag, GitHub Release, cleanup, or any external publication.

The public Skill release set is:

| Skill | Release-set class | Exact package identity | Evidence boundary |
|---|---|---|---|
| Work Charter | `changed` | five files byte-identical to `c4810057c3f28cca9f12004ca2018784cd21f449`; canonical manifest `04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44` | source bytes only; no new product run, install, loaded-copy, tag, or release evidence |
| Project Docs | `unchanged` | six files byte-identical to `v0.1.2` / `ceed607152849775b981c54add74bfa30d858e4d` | the later Decision 0019 development remains in Git history and is intentionally excluded from this candidate |
| PowerShell | `unchanged` | five files byte-identical to `v0.1.2` / `ceed607152849775b981c54add74bfa30d858e4d` | no package byte or evidence claim changes |

`git hash-object` equality must hold for every package file against its named
commit. Work Charter's manifest is recomputed from the five path-sorted
`path`/`length`/`sha256` rows using the repository canonical-JSON contract.

## Factual Evidence Map

Twelve allowlisted factual inputs were read from the dirty source root only
after its exact `main@8c952abb5161c3082fb4d9a09e49a0a183b84ab0`, empty index,
14-path dirty set, and user-supplied raw SHA-256 values all matched. Ten
existing documentation/result-index files and two untracked sanitized reports
were migrated through `apply_patch` and first reproduced those source hashes
exactly before release-prep wording changed.

The source root's dirty
`evals/check-work-charter-gate2-runner.ps1` and
`evals/invoke-work-charter-gate2.ps1` were excluded: their contents were not
read, migrated, staged, or committed. The task-owned checkout retains the
committed `8c952abb...` versions of those paths unchanged.

Historical D31-D55 evidence remains cumulative. D55 consumed C16/C17 and is
sealed `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`; the exact failure mechanism
remains `UNKNOWN`, and it supplies no formal, canary, product, assessor,
acceptance, or D56 evidence. The separate 2026-08-14 minimal evaluation admits
only sealed exact-candidate D45-D49 cells and returns `ACCEPT` for C1-C5 with
zero fresh product starts and one read-only assessor. It does not become A20,
full 28-cell Gate 2, cross-model, real-project, deterministic-lock/router,
installation, stable loaded-copy, tag, or release proof.

## Documentation-Impact Closure

| Consumer class | Disposition | Paths or reason |
|---|---|---|
| Public Skill package | `UPDATE` | only the six Project Docs package paths are materialized to exact `ceed607...`; Work Charter and PowerShell package bytes are checked, not edited |
| Work Charter factual owners | `UPDATE` | Decision 0018; Work Charter State/Verification; root Status/Roadmap/Index/Verification/Handoff; `evals/README.md`; result index; D55 and minimal-eval reports |
| Project Docs factual owners | `UPDATE` | Project Docs Design/State/Verification distinguish the exact `v0.1.2` explicit-only package in this release set from preserved Decision 0019 development history and its excluded M1R contract |
| Release-prep verification infrastructure | `UPDATE` | `evals/check-fixtures.ps1` accepts only the exact v0.1.2 expected exclusion for the frozen Decision 0019 fixture and the exact unchanged historical runner's missing declared private carrier; it creates no product acceptance |
| Release-prep evidence | `UPDATE` | this sanitized report owns release-set identity, bounded acceptance, verification, and no-effect claims |
| Root and Project Docs README English/Chinese pairs | `UPDATE` | public invocation guidance matches the exact `v0.1.2` explicit-only package while retaining stable release identity and reciprocal navigation |
| Authority, SPEC, Architecture, Runbook, Provenance, Decisions 0017/0020, Work Charter Design | `CHECKED_NO_CHANGE` | existing ownership, lifecycle, evidence, and release procedures remain sufficient |
| Work Charter SOURCE; PowerShell SOURCE; cases, fixtures, matrix, rubric, scorer, controller; committed D55 runner/checker | `NOT_APPLICABLE` | frozen or unchanged by this release-prep commit |
| Discovery, install/update, `RC_INSTALL`, stable loaded copy, push, PR, merge, tag, release, cleanup, external publication | `NOT_APPLICABLE` | explicitly outside authority and not performed |

The intended tracked set contains 27 paths: the six Project Docs package files,
the twelve migrated factual paths, Project Docs Design/State/Verification, and
this report, the user-authorized revision-aware fixture checker, and the root
plus Project Docs README English/Chinese pairs. The Design and README additions
dispose native review P1 findings; any further path requires a new decision.

## Verification Record

The final verification record is populated only after the intended diff is
stable. Required producers run before consumers. The gate includes all three
Skill validators, repository and fixture checks, applicable tracked runner and
PowerShell parser checks, exact package identity and Work Charter manifest
checks, link/encoding/publication-safety checks, `git diff --check`, and native
Codex review over the complete uncommitted diff.

Deterministic status: `PASS`.

- 12/12 allowlisted factual-source raw SHA-256 values match;
- Work Charter 5/5 Git blobs, Project Docs 6/6 Git blobs, and PowerShell 5/5
  Git blobs match their exact target commits, and Work Charter recomputes the
  required canonical manifest;
- all three Skill validators pass;
- PowerShell 7 and Windows PowerShell 5.1 each pass 15/15 boundary checks;
- the controller returns `PASS`, all ten tracked PowerShell scripts/module
  files parse, and the revision-aware fixture checker passes 18/18;
- the repository checker passes at 218 text files / 14 cases / 12 fixtures;
- targeted Gitleaks scanning passes for all 27 intended public paths without
  reading ignored private carriers; and
- `git diff --check` passes.

The fixture check classifies two exact pre-qualification exclusions: the
frozen Decision 0019 continuity fixture is not behavior supplied by the exact
`v0.1.2` explicit-only package, and the unchanged release-prep runner cannot
qualify without its declared ignored D50 private carrier. Neither is a product
failure, runner pass, behavior rerun, or acceptance result. Native review is
reported only in the external completion packet because this report is itself
part of the review target.

## Commit And Effect Boundary

The final local commit hash and native-review finding packet are completion
evidence outside these self-referential bytes. Commit success alone does not
authorize push, integration, installation, tag, release, or cleanup. The
release-prep writer becomes `RELINQUISHED` only after that one commit, clean
task index/worktree, and exact reconciliation of every registered worktree and
the source root's original dirty ownership.
