# Project Docs State

Last updated: 2026-08-01

## Current Implementation

Canonical editable SOURCE is the six-file package under
[`skills/manage-project-docs`](../../../skills/manage-project-docs). It is
explicit-only, preserves sufficient existing layouts, and implements the five
logical responsibilities, four surfaces, five outcomes, continuity anchor, and
structural authorization gate.

Public candidate commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` contains the
bounded recovery-coherence hardening to the entry and both direct references.
It distinguishes readers, active sessions,
and writers; keeps current state, writer, gate, next action, and recovery target
on one verified checkpoint; audits current/historical/superseded evidence and
result indexes; fails closed when no unique recovery entry exists; and
preserves immutable history while correcting current claims.

The public `v0.1.1` tag and stable installed copy predate this hardening and
must not be described as containing it.

## Current Writer

No Project Docs writer is active. Its SOURCE/eval/evidence and commit-gate
writers relinquished after acceptance, commit, and public push. The current
repository evidence-only gate does not authorize Project Docs SOURCE,
discovery, installation, RC, stable, or release changes.

## Evidence State

Exact-source behavior, explicit-only DEV_DISCOVERY identity, historical shared
exact-commit RC identity, and tag-pinned stable explicit `NOOP` smoke pass.
Three current-SOURCE hardening contexts cover continuity, authority conflict,
and safety boundaries. Two earlier attempts remain visible but excluded after
one recovery-target behavior defect and one later SOURCE-identity invalidation;
the correction runs and a new independent assessor returned `ACCEPTED`.
An isolated exact-commit `c42eef3...` RC then proved current six-file Git-blob
and loaded-copy identity, mature `NOOP`, fail-closed recovery, authority and
safety boundaries, ordinary non-selection, and independent `ACCEPTED`.
Stable mutation behavior, broad trigger telemetry, causal comparison,
cross-Harness parity, and independent real-project efficacy remain unproved.
See [Verification](VERIFICATION.md).

## Next Gate

Project Docs is `READY_FOR_RELEASE_CANDIDATE` at exact commit `c42eef3...`.
After the repository evidence-only commit gate, the next lifecycle decision is
whether to map a new immutable repository tag to that tested commit and repeat
tag-pinned stable installed-copy proof. Stable update, private-global
retirement, retained-evidence cleanup, tag, and GitHub Release remain separate
decisions.

## Recovery Entry

1. Read [`AGENTS.md`](../../../AGENTS.md) and the repository
   [Authority Map](../../AUTHORITY.md).
2. Read [Design](DESIGN.md), this state, and
   [Verification](VERIFICATION.md).
3. Confirm live Git state and writer ownership.
4. Read canonical SOURCE and the relevant eval result before changing behavior
   or claims.
5. Stop before structural, Git, install, or release actions without the
   corresponding authorization.
