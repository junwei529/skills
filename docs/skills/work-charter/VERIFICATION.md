# Work Charter Verification

Last updated: 2026-07-31

## Claim Ledger

| Claim | Status |
|---|---|
| `work-charter` is the sole current five-file package | verified structurally |
| Small bounded work stays flat | SOURCE-assisted and stable explicit smoke pass |
| Midstream implicit behavior is proposal-only | SOURCE-assisted controlled variant passes |
| Cold recovery reconciles durable and workspace state | SOURCE-assisted and RC canaries pass |
| Planner/Executor correction and independent assessment | controlled SOURCE and DEV_DISCOVERY runs pass |
| Standard O/P/E under an approved policy | controlled DEV_DISCOVERY run passes |
| Exact-commit RC and stable loaded-copy identity | verified |
| Broad implicit telemetry, deterministic delivery/locking, real-project efficacy, token savings, or cross-Harness parity | unverified |

## Current SOURCE Identity

The accepted five files have these recorded raw SHA-256 identities:

```text
SKILL.md
  ce6d65dccee281558154febfa18e8d1dba83780d52cb1043bcb402ae60403d34
agents/openai.yaml
  fbc47a69d6eab89492c40d2a9e37718f5c31a5d84f0bb207cdf606279d1efb89
references/coordination-and-recovery.md
  78f2f041c84dae57d7cfc9d811683ac9463c37ca855c876d6d3b3941ef6e1568
references/standard-ope.md
  f10be9f83bd8cbac1271ed49df0851d271861dcafc66147da28d4e9ca7f9fd3d
assets/work-charter.md
  bc3581e4138bc2dbd8b310fc20b8bf796c7ce8843c0c2dc4e62fd99d22536cab
```

## Development Behavior History

### 2026-07-29 — M2R SOURCE-assisted matrix and acceptance

Five groups plus two controlled negative variants ran in fresh contexts:

- small work stayed flat and passed two focused tests;
- midstream adoption remained a non-mutating proposal using an existing
  durable owner;
- cold recovery classified branch, commit, index, evidence, and writer drift
  and stopped before write;
- separate Planner/Executor completed one bounded correction, five tests, and
  independent `ACCEPTED`;
- Standard O/P/E completed one bounded correction, four tests, independent
  Planner `ACCEPTED`, dormant Orchestrator behavior, and a stop before
  unapproved Phase Two; and
- stricter-policy and unavailable-delivery variants degraded visibly without
  silently activating Standard.

Controller manifests found only intended fixture deltas and removed the unique
ignored run root. An independent Planner recomputed all five normalized hashes,
reran the deterministic checks, and returned `ACCEPTED`. This proves
SOURCE-assisted behavior only, not native selection or loaded-copy identity.
The [M2R result](../../../evals/results/2026-07-29-work-charter-m2r-forward-tests.md)
owns the exact prompts' sanitized boundaries, manifests, tests, and
limitations.

### 2026-07-30 — Native DEV_DISCOVERY P/E and Standard

Two explicit canaries used the sole repository-scoped development entry
resolving to canonical SOURCE. Every role selection record identified the same
five files, and a controller independently resolved and rehashed the target.

The P/E run used one read-only Planner and one sole-writer Executor, changed
exactly four allowed fixture files, passed five tests at Executor, Planner, and
controller layers, and ended `ACCEPTED` without correction. The Standard run
used one Orchestrator, Planner, and Executor, changed exactly four allowed
files, passed four tests at all three layers, kept the Orchestrator dormant
during implementation, and stopped before Phase Two.

Task-specific discovery and fixture copies were removed; SOURCE and repository
Git state remained unchanged. This establishes controlled explicit
DEV_DISCOVERY selection and role delivery, not implicit telemetry, installed
identity, deterministic permissions, or general Harness routing.

## Candidate And Stable Evidence

At public commit
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`, `$skill-installer`
materialized an ordinary five-file `RC_INSTALL` that matched Git blobs and the
recorded hashes and was the only same-named Skill in scope.

An uncontaminated positive canary did not name Work Charter or an expected
profile. Continuity and recovery symptoms implicitly selected the RC entry and
only the recovery reference, proposed P/E cold recovery, and stopped before
roles or writes. A flat arithmetic canary returned `703` without loading the
Skill.

Two attempts were excluded: a network-blocked launch produced no semantic
result; a name-contaminated, agent-side-hash attempt loaded the candidate but
could not support implicit-trigger or cost claims. Controller-side identity,
not role names or self-hashing, owns the counted revision proof.

The coherent `v0.1.1` candidate
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42` repeated exact-commit identity.
Immutable tag `v0.1.1` resolved to that commit, and the tag-pinned stable entry
was explicitly loaded in a fresh read-only process and chose Flat for a small
task. Standard behavior was not rerun at RC or stable layers.

Repository-level shared candidate, tag, installation, and release evidence is
owned by [root Verification](../../VERIFICATION.md).

## Required Checks

```text
python -B <skill-creator>/scripts/quick_validate.py skills/work-charter
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
PowerShell parser check across evals/**/*.ps1
git diff --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

Role separation is not loaded-copy identity. SOURCE-assisted,
DEV_DISCOVERY, RC_INSTALL, and STABLE_INSTALL evidence must remain distinct.
