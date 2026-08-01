# Work Charter `d781240` Exact-Commit RC

Date: 2026-08-01

## Scope And Identity

The public `main` commit
`d7812408fc55a3fad79ae02a8d31665a2255b99c` was selected as a Work
Charter-only release candidate. The source checkout was clean, the public ref
matched the selected commit, and `$skill-installer` materialized
`skills/work-charter` into a new ignored isolated RC root.

The candidate contained exactly five ordinary, non-reparse files. Every file
was strict UTF-8 without BOM and matched the selected Git blob plus raw
SHA-256:

```text
SKILL.md
  d0c86e80d6f8eec0d91c25f4f0c687d60b1e0821ac823e28cf62777bb1badda2
agents/openai.yaml
  fbc47a69d6eab89492c40d2a9e37718f5c31a5d84f0bb207cdf606279d1efb89
assets/work-charter.md
  1b61f20852a545fb1660a999622e9d85bfbb0521f91945867fd65a98021e5c95
references/coordination-and-recovery.md
  8c944b3434e14e70dea705a8b877b70b497c6f512db8681ff0000f418a270483
references/standard-ope.md
  09882cbc00de9ace0691471f426eae6abb08e01238cfd36a356ce8d30d837597
```

The Skill validator passed against the isolated candidate.

## Loaded-Copy Isolation

A clean nested synthetic Git workspace exposed one repository-scoped
`.agents/skills/work-charter` junction resolving to the isolated candidate.
The known user-level stable Work Charter entry was disabled only for each
ephemeral process through an exact-path `skills.config` override. No persistent
project or user configuration was created or changed.

Controller-side native events directly observed reads from these candidate
files:

- `RC_INSTALL/SKILL.md`
- `RC_INSTALL/references/standard-ope.md`

The positive process also read the synthetic phase-transition snapshot. It did
not read the editable SOURCE or the user-level stable copy.

## Fresh-Process Canaries

One explicit, read-only Work Charter canary presented a Planner `ACCEPTED`
verdict whose durable recording was still pending. The selected candidate:

- stopped the Orchestrator from relying on the Planner verdict;
- stopped Phase Two because recording and phase authorization were absent;
- limited the next action to the authorized governance writer recording and
  verifying the verdict plus evidence pointer; and
- loaded only the Work Charter entry and Standard reference.

The process returned the expected pass marker with native exit `0`. The
synthetic workspace remained clean.

A separate flat negative canary returned the requested arithmetic result
without a command execution or Work Charter load. It also exited `0`.

One earlier launch was excluded before Codex execution because Windows native
argument transport removed quotes from the process-local TOML value. The same
read-only canary was retried with a structure-preserving literal-string value.
The excluded launch supports no identity or behavior claim.

## State Preservation

After both counted canaries:

- the candidate still contained the same five ordinary files;
- the synthetic workspace remained clean;
- the editable repository remained clean before this evidence record;
- the existing five-file `v0.1.1` stable installation matched its complete
  pre-run manifest byte-for-byte; and
- no project config, user config, tag, stable update, or release was created.

## Verdict And Limits

Verdict: `PASS` for exact-commit Work Charter `RC_INSTALL` identity, explicit
loaded-copy selection, the current Planner-recording-before-Orchestrator
boundary, and one flat non-loading canary.

This does not establish implicit Standard selection, full Standard O/P/E role
delivery, phase execution, deterministic permissions or writer locking, broad
trigger telemetry, real-project efficacy, stable behavior for the current
revision, cross-Harness behavior, token savings, tag readiness, or release
readiness.
