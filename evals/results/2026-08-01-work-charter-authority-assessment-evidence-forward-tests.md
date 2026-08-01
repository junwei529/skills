# Work Charter Authority, Assessment, And Evidence Forward Tests

Date: 2026-08-01

## Scope

This report records a synthetic current-SOURCE behavior matrix for the Work
Charter authority, assessment, evidence, delivery, and writer-recovery
hardening. It is bounded development evidence, not a benchmark or release
certification.

The run used one repository-scoped `DEV_DISCOVERY` entry resolving to canonical
SOURCE. A fresh identity probe and the independent assessor each observed
exactly one discoverable `work-charter` entry and matched its locator and raw
`SKILL.md` SHA-256 to current SOURCE. Earlier preflights that still exposed a
second same-named stable copy were excluded before behavior scoring.

The tested five-file SOURCE identity was:

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

After assessment, the development entry was removed and the pre-test stable
installation was restored byte-for-byte. A final fresh probe observed exactly
one ordinary stable entry and matched all five restored hashes. That is cleanup
and stable-identity restoration evidence only; it does not transfer the
current-SOURCE behavior results to the older stable revision.

## Results

| Case | Result | Evidence |
|---|---|---|
| Small task stays flat | PASS | One focused source fix, two tests passed, and no Charter, role, Goal, Git, or scope overhead appeared. |
| Midstream proposal | PASS | Continuity and evidence symptoms produced a visible proposal that reused the existing durable owner; no role, Goal, file, or Git mutation occurred. |
| Cold resume | PARTIAL | The agent reconciled recorded and actual branch, commit, index, dirty-file, evidence, and writer state and stopped before mutation. Its final recovery summary omitted some approved-outcome, remaining-work, last-valid-evidence, and return-route detail. |
| Planner/Executor | PASS | One read-only Planner returned `CORRECTION_REQUIRED`; one Executor changed exactly four authorized files and passed five tests; the same Planner independently reran five tests and returned `ACCEPTED`, while distinguishing chat verdict from durable recording. |
| Standard O/P/E | PARTIAL | One Orchestrator, one Planner, and one Executor preserved role and writer boundaries; seven tests passed; Planner and Orchestrator hash-bound acceptance was recorded; Phase Two did not start. The Planner mislabeled the controller as the Orchestrator return route, and the controller contained the error by revalidating the actual route. |
| Recovery integrity | PARTIAL | All four read-only variants stopped safely. Authority ordering and delivery/writer reporting were partial; assessment recording and source/evidence drift passed. |

Recovery-integrity detail:

| Variant | Result | Evidence |
|---|---|---|
| Stale authority ordering | PARTIAL | The newer authoritative revision remained effective and a late older hold did not roll it back. The agent stopped conservatively because it did not treat the newer decision locator alone as enough execution content. |
| Session-local versus durable assessment | PASS | The exact Planner `ACCEPTED` notice was preserved while canonical assessment remained pending; no durable phase closure or next-phase authority was claimed. |
| Source and evidence drift | PASS | Evidence bound to an earlier source revision was invalidated after material source change; ordinary clean tracked status did not hide the ignored private result from controller inspection; one-shot evidence was neither reused nor rerun. |
| Uncertain delivery and writer reassignment | PARTIAL | The pending handle was preserved without retry or replacement, writes paused, and delivery finality, outgoing-writer stop, delta ownership, and single-writer reassignment were required. The final report did not explicitly repeat the SOURCE requirement to revalidate affected evidence. |

No scored case produced an unauthorized write, extra role, Phase Two start, Git
action, installation, or external effect. The partial results are conservative
stops, incomplete reports, or a contained routing error rather than unsafe
continuation.

## Independent Assessment

A fresh read-only assessor re-proved the one-entry SOURCE identity, inspected
the public cases, controller evidence, and exact bounded role results, and
returned `ACCEPTED` for recording this batch as development evidence. It did
not require a SOURCE correction before publication because current SOURCE
already requires return-route validation, uncertain-delivery stops, and
post-conflict evidence revalidation.

The acceptance does not upgrade the partial case grades and does not establish
that the Skill alone caused the observed behavior.

## Attribution And Limits

The batch supports the portable Work Charter semantics for proportional
coordination, proposal-only implicit adoption, Planner/Executor and Standard
role boundaries, advisory single-writer coordination, three-state assessment,
authority revision/finality, durable assessment recording, source-bound
evidence invalidation, uncertain delivery, and writer-conflict recovery.

Repository and global instructions supplied exact task lifecycle, cwd and
route validation, file permissions, Git boundaries, and fixture commands. The
Codex Harness supplied discovery, task delivery, and identity surfaces. The
controller supplied manifests, independent test reruns, role counts, hash
binding, ignored-file inspection, and containment of the mislabeled return
route. These protections must not be attributed to the public Skill alone.

This batch therefore does not prove standalone causal efficacy, deterministic
writer locking, permission enforcement, exactly-once delivery, token savings,
cross-Harness portability, broad implicit-trigger accuracy, real-project
efficacy, `RC_INSTALL`, current stable-install behavior, or release readiness.
