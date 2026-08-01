# Work Charter Verification

Last updated: 2026-08-01

## Claim Ledger

| Claim | Status |
|---|---|
| `work-charter` is the sole current five-file package | verified structurally for current SOURCE |
| Small bounded work stays flat | tested pre-review DEV_DISCOVERY/SOURCE behavior pass |
| Midstream implicit behavior is proposal-only | tested pre-review DEV_DISCOVERY/SOURCE behavior pass |
| Cold recovery reconciles durable and workspace state | tested pre-review DEV_DISCOVERY/SOURCE safe stop, partial recovery-summary completeness |
| Planner/Executor correction and independent assessment | tested pre-review DEV_DISCOVERY/SOURCE behavior pass |
| Standard O/P/E under an approved policy | tested pre-review DEV_DISCOVERY/SOURCE partial: role, writer, recording, and Phase stop pass; one contained return-route mislabel |
| Authority ordering, assessment recording, evidence invalidation, and delivery/writer degradation | tested pre-review recovery variants are partial, pass, pass, and partial respectively; no unsafe continuation observed |
| Current Standard recording sequence | deterministic and commit-gate semantic-review evidence; fresh-context rerun unverified |
| Exact-commit RC and stable loaded-copy identity | verified |
| Broad implicit telemetry, deterministic delivery/locking, real-project efficacy, token savings, or cross-Harness parity | unverified |

## Current SOURCE Identity

The five files exercised by the 2026-08-01 fresh-context batch had these raw
SHA-256 identities:

```text
SKILL.md
  d0c86e80d6f8eec0d91c25f4f0c687d60b1e0821ac823e28cf62777bb1badda2
agents/openai.yaml
  fbc47a69d6eab89492c40d2a9e37718f5c31a5d84f0bb207cdf606279d1efb89
references/coordination-and-recovery.md
  8c944b3434e14e70dea705a8b877b70b497c6f512db8681ff0000f418a270483
references/standard-ope.md
  5a813ce43f334c7e06db69f4c1cdd676bbb8708850a052dbc46887ed0298e0cc
assets/work-charter.md
  1b61f20852a545fb1660a999622e9d85bfbb0521f91945867fd65a98021e5c95
```

During the local commit gate, native semantic review found that the Standard
operating path placed Orchestrator assessment before durable Planner-verdict
recording. The corrected current `references/standard-ope.md` raw SHA-256 is:

```text
09882cbc00de9ace0691471f426eae6abb08e01238cfd36a356ce8d30d837597
```

The other four current hashes remain as listed above. The ordering correction
has deterministic checks and commit-gate semantic-review coverage, but no new
fresh-context behavior rerun. The batch below therefore remains exact evidence
for the pre-review hash rather than exact-current behavior proof.

## Development Behavior History

### 2026-08-01 — Authority, assessment, and evidence matrix

One repository-scoped development entry exposed the tested five-file SOURCE
as the only discoverable same-named Skill. A fresh identity probe and a later
independent assessor each matched the presented entry and raw `SKILL.md` hash
to the identities above. Preflights with a second same-named copy were excluded
before behavior scoring.

The six behavior groups produced three full passes and three partial results.
Small work stayed Flat, midstream symptoms produced only a proposal, and the
Planner/Executor loop passed. Cold recovery stopped safely but returned an
incomplete recovery summary. Standard O/P/E preserved the three roles, sole
writer, two acceptance layers, and the Phase Two stop, but one Planner
mislabeled its return route; the controller revalidated and contained the
error. The four recovery variants scored authority ordering partial,
assessment recording pass, source/evidence drift pass, and uncertain
delivery/writer recovery partial. No variant continued unsafely.

A fresh read-only assessor independently rechecked the bounded artifacts and
returned `ACCEPTED` for recording the tested batch without a SOURCE correction
at that hash. The
[sanitized result](../../../evals/results/2026-08-01-work-charter-authority-assessment-evidence-forward-tests.md)
preserves every partial grade and the attribution limits.

After the batch, the temporary development entry was removed, the pre-test
stable installation was restored byte-for-byte, and a fresh probe observed
only that ordinary stable entry with all five historical stable hashes. This
is restoration evidence, not current-SOURCE stable behavior.

This establishes tested `SOURCE` plus controlled `DEV_DISCOVERY` behavior
evidence only. Repository/global rules and the Harness supplied task routing,
permission, lifecycle, and controller enforcement, so the run is not
standalone causal proof. It is not current `RC_INSTALL`, stable-install,
real-project, cross-Harness, token, deterministic-lock, or release evidence.

### 2026-07-31 — Authority, assessment, and evidence hardening

[Decision 0016](../../decisions/0016-work-charter-authority-assessment-and-evidence-integrity.md)
accepts portable rules for comparable authority revisions, uncertain
non-idempotent delivery, assessment recording, actual-result-surface evidence,
source-bound invalidation, and advisory writer-conflict recovery. Current
SOURCE implements those rules without adding a package file, trigger, role,
verdict, lock, or lifecycle identity.

The new
[recovery-integrity case](../../../evals/cases/work-charter-recovery-integrity.md)
contains four independent read-only variants. Its deterministic precondition
proves the intended stale/new authority pair, pending durable assessment,
revision-bound one-shot evidence, an ignored result omitted from ordinary Git
status but visible to controller inspection, uncertain delivery, and unknown
writer delta. Existing Planner/Executor and Standard cases now require the
assessment recording boundary.

The current Skill validator, repository checker, and all fifteen fixture
checks pass. This is implementation, structural, and fixture-precondition
evidence only. No fresh-context agent has yet exercised the new behavior, so
the earlier behavior, DEV, RC, and stable results remain historical evidence
for their exact recorded revisions rather than proof for current SOURCE.

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
