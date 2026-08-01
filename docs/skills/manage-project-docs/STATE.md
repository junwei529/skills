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

Immutable tag `v0.1.2` at
`ceed607152849775b981c54add74bfa30d858e4d`, its GitHub Release, and the
verified stable installed copy contain these exact six package files.

## Current Writer

No Project Docs SOURCE writer is active. Its implementation and candidate
writers relinquished after acceptance and publication. The authorized
repository release-evidence closeout may change only mapped documentation; it
does not authorize Project Docs SOURCE changes or cleanup of retained evidence
or rollback copies.

## Evidence State

Exact-source behavior, explicit-only DEV_DISCOVERY identity, historical shared
exact-commit RC identity, and tag-pinned stable explicit `NOOP` smoke pass.
Three current-SOURCE hardening contexts cover continuity, authority conflict,
and safety boundaries. Two earlier attempts remain visible but excluded after
one recovery-target behavior defect and one later SOURCE-identity invalidation;
the correction runs and a new independent assessor returned `ACCEPTED`.
An isolated exact-commit `c42eef3...` RC proved current six-file Git-blob
and loaded-copy identity, mature `NOOP`, fail-closed recovery, authority and
safety boundaries, ordinary non-selection, and independent `ACCEPTED`.
The later tag-pinned `v0.1.2` stable copy matched the same six package blobs,
was actually loaded in a fresh process, returned mature `NOOP` with strong
continuity, and left the fixture unchanged. Stable mutation behavior, broad
trigger telemetry, causal comparison, cross-Harness parity, and independent
real-project efficacy remain unproved.
See [Verification](VERIFICATION.md).

## Next Gate

Project Docs is released and installed as part of repository release
`v0.1.2`. No further release action is pending for this revision. Stable
mutation behavior, broader trigger and real-project evidence, private-global
retirement, retained-evidence cleanup, and rollback-copy cleanup remain
separate future decisions.

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
