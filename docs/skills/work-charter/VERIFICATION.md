# Work Charter Verification

Last updated: 2026-08-03

## Claim Ledger

| Claim | Status |
|---|---|
| `work-charter` is the sole current five-file package | verified structurally for current SOURCE |
| Gate 1 protection, re-entry, convergence, and two-stage lazy-entry contract | implemented in dirty current SOURCE; offline structural and fixture-precondition checks pass, fresh behavior unverified |
| Gate 1 evaluation definitions | 14 exact cases and 12 exact fixtures pass repository-shape checks; one existing selection context adds a confirmation turn without a new fresh run or matrix lane |
| First `v0.2.0` exact candidate Gate 2 | `206c497...` stopped incomplete and is superseded for acceptance; its completed correction and consumed events remain historical |
| Successor `v0.2.0` exact candidate Gate 2 | `92a8c045...` passed qualification and consumed A01-A04; A04 hard-stopped on an unproved selected/loaded claim, so no candidate acceptance or later cell exists |
| Small bounded work stays flat | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE behavior pass |
| Midstream implicit behavior is proposal-only | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE behavior pass |
| Cold recovery reconciles durable and workspace state | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE safe stop, partial recovery-summary completeness |
| Planner/Executor correction and independent assessment | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE behavior pass |
| Standard O/P/E under an approved policy | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE partial: role, writer, recording, and Phase stop pass; one contained return-route mislabel |
| Authority ordering, assessment recording, evidence invalidation, and delivery/writer degradation | historical exact pre-Gate-1 recovery variants are partial, pass, pass, and partial respectively; no unsafe continuation observed |
| Released-control Standard recording sequence | historical exact-commit `c42eef3...` full synthetic Phase One pass |
| Released-control exact-commit RC loaded-copy identity | verified historically at public `c42eef3...` |
| Stable loaded-copy identity and narrow recovery behavior | tag-pinned `v0.1.2` five-file identity, flat non-loading, and fail-closed recovery canary pass |
| Broad implicit telemetry, deterministic delivery/locking, real-project efficacy, token savings, or cross-Harness parity | unverified |

## Gate 1 SOURCE And Definition Evidence

The superseded exact candidate `206c497...` retained exactly five public files
with these raw SHA-256 identities:

```text
SKILL.md
  f9b79c2dfb910d45d114aece1f14d0c983bfe6c2d754a6702691239e67fef560
agents/openai.yaml
  f0032475e213d75ed17eb41c3424007ebc46c0ddb6739138c9908185beefdad6
assets/work-charter.md
  4420e9faa5a6090e5fc54680e26b2dedddbb8c60c7c3891aa88da824dd881b72
references/coordination-and-recovery.md
  338e462b2412d221c89e17c195f3f0ebf44370ace34384c277a71a180c29f760
references/standard-ope.md
  a85f03815313beaf3b399c8cf712904a402ae197518d8a5489281cff389698df
```

Pushed successor candidate
`92a8c04554e4021ad3c998c97fd733f6554e048f` changes only the existing
`coordination-and-recovery.md` package file relative to `206c497...`. Its five
raw SHA-256 identities are:

```text
SKILL.md
  f9b79c2dfb910d45d114aece1f14d0c983bfe6c2d754a6702691239e67fef560
agents/openai.yaml
  f0032475e213d75ed17eb41c3424007ebc46c0ddb6739138c9908185beefdad6
assets/work-charter.md
  4420e9faa5a6090e5fc54680e26b2dedddbb8c60c7c3891aa88da824dd881b72
references/coordination-and-recovery.md
  436d6ada3288fb7374445ce2a7bfd51501fd218def8f50755f7cbbdae3bd65f7
references/standard-ope.md
  a85f03815313beaf3b399c8cf712904a402ae197518d8a5489281cff389698df
```

The current dirty two-stage lazy-entry revision changes only `SKILL.md` inside
that five-file package. Its five raw SHA-256 identities are:

```text
SKILL.md
  cde5047a7f0f17f51762be16753db88cb1c6e57e000ccb787ff702e907e9af88
agents/openai.yaml
  f0032475e213d75ed17eb41c3424007ebc46c0ddb6739138c9908185beefdad6
assets/work-charter.md
  4420e9faa5a6090e5fc54680e26b2dedddbb8c60c7c3891aa88da824dd881b72
references/coordination-and-recovery.md
  436d6ada3288fb7374445ce2a7bfd51501fd218def8f50755f7cbbdae3bd65f7
references/standard-ope.md
  a85f03815313beaf3b399c8cf712904a402ae197518d8a5489281cff389698df
```

The Skill validator passes. The repository checker reports 191 text files,
14 exact cases, and 12 exact fixtures. The fixture checker passes all 16
preconditions, including consumption-aware evidence drift and retained
successor history inside the existing six recovery-integrity variants.
PowerShell 7.6.3 parses all six eval scripts, `git diff --check` passes, and the
exact five-file strict UTF-8/LF/no-BOM/final-newline/non-reparse audit passes.
A Gitleaks scan of all 18 changed tracked publication files passes. The latest
separate whole-worktree directory scan is not green: it reports 17 findings
inside retained ignored Gate 2 runtime artifacts, which are outside the
tracked diff and lack cleanup authority. No finding value was printed or
copied into the repository.

Native commit-review cycle 1 used `gpt-5.6-terra` with `high` reasoning and
materially covered the intended 16-path diff. It returned one P2,
`WC-NR-001`: the root bilingual entry guides still described the old direct-
read-approval flow. The user approved expanding the same attempt only to those
two existing files. Their synchronized fix now states that indirect intent
first receives an unloaded metadata proposal and asks whether to activate;
confirmation loads the Skill, while project-read approval remains separate.
Skill validation, the 191/14/12 repository check, `git diff --check`, and the
18-file Gitleaks scan pass after the fix. Because the fix changed the diff, a
later completed native review is still required. The reviewer's ancillary
regex failure while excluding ignored `.eval-runs` content did not block
material diff or relevant-source inspection.

The first current fixture-check launch was excluded before fixture setup when
the default sandbox denied creation under the worktree's ignored `.eval-runs`
directory. The same command reran under the already authorized task-worktree
write boundary and passed all 16 preconditions. This was a shell permission
boundary, not a SOURCE repair or an additional behavior attempt.

These are implementation, structural, byte-format, definition, fixture-
precondition, and commit-review finding observations for dirty current SOURCE
only. Review 1 does not satisfy the gate after its approved fix changed the
diff. No commit, native baseline, catalog-selection, exact-candidate behavior,
exact-control comparison, behavior model/reasoning cell, independent behavior
assessment, new `RC_INSTALL`, or stable update was performed for these bytes.
The accepted 19/23/27 staged matrix remains future Gate 2 work for a new exact
candidate; two-stage entry behavior is `UNVERIFIED`.

### 2026-08-03 — Two Incomplete Gate 2 Candidates And Entry Correction

Exact candidate `206c497...` completed controller qualification and crossed
four declared reference-cell consumption points before a convergence ambiguity
stopped the batch. One completed independent `CORRECTION_REQUIRED` round and
those four consumption events remain historical. Pre-consumption controller
activity remains qualification rather than model evidence, and no task, root,
epoch, attempt, or candidate label resets either history.

The user accepted a release-blocking same-contract convergence correction
instead of candidate acceptance. That correction became pushed successor
`92a8c045...`; predecessor history was preserved rather than reset.

The successor passed isolated candidate/control catalog qualification, all
offline checks, freeze, and two prestart probes. Its `Sol/high` reference then
consumed exactly four turns:

- A01 and A02 completed without a hard failure;
- A03 directly named Work Charter in ordinary language and controller events
  observed the exact candidate `SKILL.md` load; and
- A04 used an indirect installed-Skills request, performed no command or
  project read, and returned a safe bounded proposal, but it said "Selected
  skill: Work Charter" without any controller-observed candidate `SKILL.md`
  read.

A04 therefore hard-stopped on unproved selected/loaded identity. A05 through
C04, both contrasts, and the independent assessor did not start. The four
successor turns remain consumed separately from the predecessor's correction
and evidence history. This proves catalog-level intent recognition and the
need to distinguish it from full invocation; it does not prove two-stage
entry, candidate acceptance, or behavior for the current dirty bytes.

The user accepted a material contract revision: indirect intent now produces
an honest metadata proposal, confirmation triggers exact full-Skill loading,
and project inspection still needs an approved scope. No stopped result can be
relabeled for that revision. A future candidate requires native review and
commit authority first, then a separately approved Gate 2 for its exact SHA.

## v0.1.2 Stable And Control SOURCE Identity

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

The other four v0.1.2 control hashes remain as listed above. The ordering correction
was not rerun through the complete fresh-context development matrix, so the
batch below remains exact evidence for the pre-review hash. The later
`d781240...` RC section separately provides exact identity for that revision plus narrow
recording-order and flat non-loading canaries; it does not replace that full
matrix.

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

### 2026-08-01 — `v0.1.2` stable installed-copy proof

The immutable repository tag `v0.1.2` resolved publicly to
`ceed607152849775b981c54add74bfa30d858e4d`. `$skill-installer` materialized
all three packages from that exact tag into an isolated staging root before
the approved stable update. The Work Charter candidate contained exactly five
ordinary non-reparse files; every file matched its tag Git blob, decoded as
strict UTF-8 without BOM, and used LF with one final newline. The installed
stable package repeated the same identity and passed the Skill validator.

An isolated repository-scoped `.agents/skills/work-charter` entry resolved to
the verified stable target. A fresh read-only recovery process selected that
sole same-named entry, and native events recorded reads of the stable
`SKILL.md`, `references/coordination-and-recovery.md`, and
`references/standard-ope.md`. It allowed only durable Planner-verdict recording
and verification, kept Orchestrator reliance blocked, and stopped before Phase
Two. The shared flat negative exposed all three stable entries but executed no
Skill or reference read. Controller-side discovery-target and Git-blob checks,
rather than model-reported hashes, own revision identity.

The prior `v0.1.1` stable package was preserved as an exact rollback copy.
Persistent Codex configuration, SOURCE, and tracked repository state did not
change during installation or canaries. This proves current stable identity,
flat non-loading, and one narrow fail-closed recovery boundary; it does not
rerun complete Standard role delivery at the stable layer or prove broad
implicit telemetry, deterministic delivery or locking, real-project efficacy,
or cross-Harness parity. Repository tag, stable-set, and GitHub Release
evidence is recorded in [root Verification](../../VERIFICATION.md).

### 2026-08-01 — Current `c42eef3` full Standard RC

`$skill-installer` materialized the five-file package from public exact commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`. Every candidate file matched its
Git blob and current raw hash, decoded as strict UTF-8 without BOM, and was an
ordinary non-reparse file. The candidate validator passed, and the only
same-named entry in the counted native scope resolved to that RC.

One flat negative did not load Work Charter. The positive path used one
Orchestrator, one Planner, and one sole-writer Executor. The Executor changed
exactly four authorized fixture files and passed seven focused tests. The
Planner independently returned `ACCEPTED`; the Executor durably recorded and
verified that verdict before the Orchestrator relied on it. The Orchestrator
then returned `ACCEPTED`, and the Executor durably recorded and verified that
assessment. Phase One closed and Phase Two did not start. The controller passed
seven final assertions with no extra writer, role, file, Git, installation, or
external action.

Read-only capability stops, controller calibration probes, and several
pre-behavior helper or transport errors were excluded. Temporary process trust
blocks and the sole discovery Junction were removed under explicit cleanup
authority, only the task-owned ignored root was removed, and sibling ignored
roots remained unchanged. Stable `v0.1.1`, SOURCE, tracked repository state,
and release refs did not change during the run.

Verdict: `READY_FOR_RELEASE_CANDIDATE` for exact commit `c42eef3...`, bounded
flat non-loading, and one complete synthetic Standard Phase One with ordered
durable Planner and Orchestrator assessment recording. Earlier partial grades
remain valid. This does not prove deterministic delivery or writer locks,
and at that checkpoint did not prove current stable behavior, broad triggers,
real-project efficacy, cost or token
improvement, cross-Harness parity, tag, or release. The
[sanitized result](../../../evals/results/2026-08-01-work-charter-c42eef3-full-standard-rc.md)
owns the detailed attempts and limits.

### 2026-08-01 — Current `d781240` exact-commit RC

Public commit `d7812408fc55a3fad79ae02a8d31665a2255b99c` was cleanly
materialized through `$skill-installer` into a new ignored Work Charter-only
`RC_INSTALL`. Controller checks proved the exact five-file package, Git-blob
equality, the current raw hashes above, strict UTF-8 without BOM, zero internal
reparse points, and a passing candidate validator.

A clean nested synthetic scope exposed one candidate-backed repository entry.
The known user-level stable copy was disabled only for each ephemeral process
through an exact-path override; no persistent configuration changed. Native
events directly observed the positive canary reading the candidate entry and
current Standard reference.

The explicit read-only canary correctly stopped both Orchestrator reliance and
Phase Two while durable Planner-verdict recording was pending, and limited the
next action to the authorized governance recording plus verification. A flat
negative canary returned `703` without a command execution or Skill load. Both
counted processes exited `0`; the synthetic workspace stayed clean.

One TOML-quoting transport attempt failed before Codex execution and is
excluded. Candidate files, editable SOURCE, repository Git state, and the
complete earlier `v0.1.1` stable manifest remained unchanged. The
[sanitized result](../../../evals/results/2026-08-01-work-charter-d781240-exact-commit-rc.md)
owns the exact identity, behavior, exclusion, and limitation record.

This verifies the then-current exact-commit RC identity and a narrow Standard
behavior boundary. It does not prove implicit Standard selection, full role
delivery, stable behavior for this revision, broad telemetry, deterministic
locking, real-project efficacy, cross-Harness behavior, tag readiness, or
release readiness.

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
