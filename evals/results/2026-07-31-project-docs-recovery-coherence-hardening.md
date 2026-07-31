# Project Docs Recovery-Coherence Hardening

Date: 2026-07-31

## Scope

This dirty-SOURCE development gate hardened five previously observed public
semantics without adding an outcome, role, state machine, required product
file, reference, or asset:

1. readers, active sessions, and the current writer are different facts;
2. persistent writes recheck writer ownership and authorization immediately
   before mutation;
3. current state, writer, gate, next action, and recovery target describe one
   verified checkpoint;
4. audits distinguish current, historical, superseded, and time-bound evidence,
   verify the current result index and authorization gate, and fail closed when
   no unique recovery entry exists; and
5. immutable historical artifacts remain unchanged while a current owner or
   later revision carries corrections.

The change kept `SKILL.md` concise, placed recovery coherence in
`maintain-and-recover.md`, placed audit/history/index rules in
`audit-and-adopt.md`, left both assets and metadata unchanged, and strengthened
the existing continuity, conflict, and safety cases.

## Current SOURCE Identity

Normalized UTF-8/LF SHA-256:

| File | SHA-256 |
|---|---|
| `SKILL.md` | `cc536a35c7bbba6f293193849b98db85923de8fe0d73c106feed405bfc4b448b` |
| `agents/openai.yaml` | `50fa3c3799caeca29ec6ba10151bd7c58e3c85d4e86d86b38ae9632306e31b17` |
| `references/audit-and-adopt.md` | `b4af599f3838868db9479a6321a1f1aa82a8ff29cc492afa15b7e5de26078321` |
| `references/maintain-and-recover.md` | `5c774b699d832ce0f52f68e6ef0b355d9ca79bc6c3407064276bf3638c5fb9ba` |
| `assets/templates/project-doc-starter.md` | `d5d70f3c2b3422f51be420658bfe2198992ad95daaeac0aa28e5f1e4fe61ec8a` |
| `assets/templates/continuity-anchor.md` | `258578585c4a9c69379afdfa9a872b41233885a11c6342a7458c7677aeb68ec5` |

All six files decoded as strict UTF-8 without BOM, used LF, and retained one
final newline. The package shape remained six files.

## Fresh Behavior Matrix

Each accepted run used a fresh context, read canonical SOURCE directly,
independently reproduced the relevant current hashes, and operated only on a
new ignored synthetic Git workspace.

| Scenario | Outcome | Continuity | Manifest and Git result |
|---|---|---|---|
| Continuity correction | `UPDATE` | `strong` | only `PROJECT_STATE.md` changed; focused test passed before and after; frozen history and exact recovery target remained unchanged; HEAD/index unchanged |
| Authority conflict correction | `PROPOSE` | `weak` | zero manifest delta; pre-existing dirty source preserved; one partial test passed; HEAD/index/status unchanged |
| Safety boundaries | `REPORT` | `weak` | zero manifest delta; current external fact remained `UNKNOWN`; generated source, language, active writer, and immutable release snapshot preserved; HEAD/index/status unchanged |

The continuity run distinguished a possible read-only session from the current
writer, rechecked the writer immediately before update, and kept current state,
writer, gate, next action, and recovery target on the same checkpoint. The
conflict run refused to choose between competing recovery claims, kept the
historical partial result separate from current acceptance, reported the
missing current evidence owner, and kept the implementation next action behind
its authorization gate. The safety run used the nearest service scope and did
not reinterpret the frozen release snapshot as current production evidence.

## Excluded Attempts And Corrections

The first continuity attempt changed the recovery locator from the existing
`next-action-and-recovery` section to another section while claiming the route
was unchanged and continuity was strong. An independent assessor returned
`CORRECTION_REQUIRED`. The recovery reference now states that a valid target is
stable during routine maintenance, the fixture records the exact locator, and
the fixture checker requires the durable anchor and state target to match.

A fresh continuity correction then preserved the exact locator and passed.
That reference change made the earlier conflict result stale for current
SOURCE identity, so it was retained as historical evidence and excluded. A new
fresh conflict correction matched all current references and passed with zero
target delta.

No failed artifact was rewritten, deleted, or counted as current acceptance.

## Deterministic And Independent Assessment

Before the final assessment:

```text
Project Docs quick_validate
  pass
python -B scripts/check_repository.py
  pass: 165 text files / 11 cases / 10 fixtures before evidence sync
pwsh -NoProfile -File evals/check-fixtures.ps1
  pass: 14 named checks
modified PowerShell parser check
  pass
git diff --check
  pass
```

The final fresh assessor independently read the contract, current package,
raw results, complete manifests, setup/inspection and deterministic checks,
and both excluded attempts. It recomputed current SOURCE and frozen other-Skill
identities and returned `ACCEPTED`.

## Limitations

- Behavior evaluators read dirty canonical SOURCE directly; this is
  SOURCE-assisted evidence, not native selection or loaded-copy identity.
- No discovery mapping, installation, exact-commit candidate, stable update,
  private-global change, commit, push, tag, release, or cleanup was performed.
- The three synthetic cases do not establish broad trigger telemetry,
  real-project efficacy, causal correctness improvement, token savings, or
  cross-Harness parity.

Verdict: `ACCEPTED` for current dirty SOURCE-assisted behavior only.
