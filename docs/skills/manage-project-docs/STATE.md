# Project Docs State

Last updated: 2026-07-31

## Current Implementation

Canonical editable SOURCE is the six-file package under
[`skills/manage-project-docs`](../../../skills/manage-project-docs). It is
explicit-only, preserves sufficient existing layouts, and implements the five
logical responsibilities, four surfaces, five outcomes, continuity anchor, and
structural authorization gate.

The current candidate adds a bounded recovery-coherence hardening to the entry
and both direct references. It distinguishes readers, active sessions,
and writers; keeps current state, writer, gate, next action, and recovery target
on one verified checkpoint; audits current/historical/superseded evidence and
result indexes; fails closed when no unique recovery entry exists; and
preserves immutable history while correcting current claims.

The public `v0.1.1` tag and stable installed copy predate this hardening. The
candidate is fully staged against local baseline `a150a865...` at the reviewed
commit checkpoint and must not be attributed to that tag or stable copy. If
live `HEAD` is a clean descendant containing this snapshot, the hardening is
locally committed but remains absent from the public and stable identities.

## Current Writer

The SOURCE/eval/evidence writer relinquished after acceptance. The separately
authorized commit-gate runner is the sole repository writer while the exact
candidate remains staged; it relinquishes when the local commit succeeds or
the gate stops. Installation and release remain separately gated.

## Evidence State

Exact-source behavior, explicit-only DEV_DISCOVERY identity, shared
exact-commit RC identity, and tag-pinned stable explicit `NOOP` smoke pass.
Three current-SOURCE hardening contexts cover continuity, authority conflict,
and safety boundaries. Two earlier attempts remain visible but excluded after
one recovery-target behavior defect and one later SOURCE-identity invalidation;
the correction runs and a new independent assessor returned `ACCEPTED`.
Stable mutation behavior, broad trigger telemetry, causal comparison,
cross-Harness parity, and independent real-project efficacy remain unproved.
See [Verification](VERIFICATION.md).

## Next Gate

While live `HEAD` remains the baseline and the candidate is staged, the active
gate is the separately authorized native review and local commit. After a clean
commit, public push and a new exact-commit `RC_INSTALL` loaded-copy/behavior
gate remain separate later actions. Stable update, private-global retirement,
cleanup, tag, and release are not authorized.

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
