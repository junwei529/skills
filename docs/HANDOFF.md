# Handoff

Last updated: 2026-07-29

## Snapshot

- Project: Agent Workflow Skills
- Workspace: repository root
- Branch: `main`
- Commit: the first local candidate exists only when actual `HEAD` resolves to
  the reviewed root commit
- Remote: none
- Active gate: Project Docs M1R, Work Charter M2R, and PowerShell are accepted
  for candidate inclusion; the Release Custodian owns the user-authorized
  coherent-scope, staging, cumulative native-review, and one-local-commit
  window as sole repository writer
- Candidate boundary: the complete 139-file public baseline; retired
  `manage-large-tasks` and superseded Project Docs files are absent, current
  `work-charter` and current eval/evidence files are present, and discovery,
  installation, cache, ignored run, and interpreter-cache paths are excluded
- Index boundary: before commit the index must exactly match that candidate;
  after a successful root commit the working tree must be clean

## Authoritative Pointers

- Work Charter contract:
  [Decision 0012](decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
- Independent-Skills boundary:
  [Decision 0007](decisions/0007-independent-skills-and-optional-recipes.md)
- Stable requirements and ownership:
  [`docs/SPEC.md`](SPEC.md) and
  [`docs/ARCHITECTURE.md`](ARCHITECTURE.md)
- Current state and evidence:
  [`docs/STATUS.md`](STATUS.md) and
  [`docs/VERIFICATION.md`](VERIFICATION.md)
- Lifecycle procedures:
  [`docs/RUNBOOK.md`](RUNBOOK.md)

## Current M2R State

The superseded `manage-large-tasks` SOURCE is retired without an alias.
`skills/work-charter/` is the sole Work Charter SOURCE and has exactly:

- `SKILL.md`
- `agents/openai.yaml`
- `references/coordination-and-recovery.md`
- `references/standard-ope.md`
- `assets/work-charter.md`

The public eval contract has five Work Charter cases and two shared fixtures.
Correction rounds 1 and 2 now:

- separately authorizes exact Planner/Executor or O/P/E delivery, profile
  selection, and bounded write scope in positive cases;
- labels direct canonical reads as SOURCE-assisted evidence, not native
  selection or trigger telemetry;
- describes the small-task result as flat behavior without Charter or role
  overhead, not as a native load-state observation;
- reserves loaded-copy identity claims for separately authorized lifecycle
  surfaces; and
- removes duplicated milestone and historical ledgers from current-state
  documents.

Tranche 1 was accepted after correction round 2. Tranche 2 then ran five fresh
SOURCE-assisted behavior groups plus two controlled negative variants with
fresh role contexts:

- small work stayed flat and passed two focused tests;
- midstream adoption remained a non-mutating proposal using the existing
  durable owner;
- cold recovery classified branch/commit/index drift and stopped before write;
- separate Planner/Executor completed one bounded correction and independent
  `ACCEPTED`, with five focused tests passing;
- separate Standard O/P/E completed one bounded correction, independent
  Planner `ACCEPTED`, and an Orchestrator transition that stopped before Phase
  Two; and
- stricter standing-policy selection and unavailable/uncertain role delivery
  degraded visibly without silent Standard activation.

The sanitized
[Work Charter M2R report](../evals/results/2026-07-29-work-charter-m2r-forward-tests.md)
owns source hashes, role settings, manifests, tests, cleanup, and limitations.
The independent Planner recomputed all five normalized SOURCE identities,
reran the required checks, and returned `ACCEPTED`. The unique ignored run root
was removed after evidence capture. This acceptance is exact-hash development
behavior evidence, not native selection, installed-copy, candidate, or release
proof. The M2R writer has relinquished.

## Current Project Docs M1R State

Five new `gpt-5.6-sol` contexts at medium reasoning reran the explicit mature,
adoption, continuity, authority-conflict, and safety-boundary cases against the
current six-file canonical SOURCE package. Every context independently
reproduced the same normalized UTF-8/LF hashes. The outcomes were `NOOP`,
`UPDATE`, `UPDATE`, `PROPOSE`, and `REPORT`; no canonical SOURCE correction was
required.

The
[Project Docs M1R report](../evals/results/2026-07-29-project-docs-m1r-forward-tests.md)
preserves the old-hash matrix as historical evidence, records the current
six-file identities and complete manifests, and explains the supersession
boundary. The task-specific ignored run root was removed without touching the
two older run roots. This is current exact-hash SOURCE-assisted behavior
evidence, not native explicit-only selection, trigger telemetry, loaded-copy,
candidate, or release proof. The Project Docs evidence writer has
relinquished.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, Decisions 0006, 0007, and 0012.
2. Read `docs/SPEC.md`, `docs/ARCHITECTURE.md`, `docs/STATUS.md`, and
   `docs/VERIFICATION.md`.
3. Inspect `git status --short --branch`; preserve the inherited index and all
   unrelated dirty ownership.
4. Read the six current Project Docs SOURCE files, five current Work Charter
   SOURCE files, and their public cases.
5. Read `docs/RUNBOOK.md` before any discovery, installation, candidate,
   version, or release action.

## Immediate Next Action

If `git rev-parse HEAD` remains unresolved, finish the authorized stable-diff
and cumulative native-review gate and create the one local root commit only
when material coverage is clean. If `HEAD` resolves and the working tree is
clean, stop: remote/push and isolated `RC_INSTALL` are separate user gates.
Explicit-only Project Docs selection and actual loaded-copy proof belong to
that later isolated candidate window.

## Material Risks

- Treating SOURCE-assisted reads as native selection or installed-copy proof.
- Treating the current Project Docs rerun as explicit-only native selection.
- Letting profile or standing-policy selection imply role delivery, write
  authority, execution, acceptance, or lifecycle authorization.
- Recreating the retired `manage-large-tasks` path as an alias.
- Editing discovery, installed, cached, candidate, or stable copies instead of
  canonical SOURCE.
- Treating the Tranche 2 results as native-selection, installed-copy,
  candidate, real-Harness outage, or release evidence.
- Disturbing inherited staged or unrelated dirty ownership.

## Prohibited Without Separate User Authorization

- Discovery mapping, installation, update, rollback, or user configuration.
- Any additional commit or amend beyond the one authorized local root commit.
- Remote, push, `RC_INSTALL`, tag, stable installation, release, or cleanup.
- Plugin, MCP, cross-Harness package, or other deferred product surface.
- Any additional eval run or lifecycle progression not separately authorized.
