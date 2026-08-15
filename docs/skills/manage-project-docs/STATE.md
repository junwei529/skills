# Project Docs State

Last updated: 2026-08-15

## Current Implementation

Canonical editable SOURCE remains the six-file package under
[`skills/manage-project-docs`](../../../skills/manage-project-docs). In the
immutable `v0.2.0` release set, all six files are restored
byte-for-byte to immutable `v0.1.2` commit
`ceed607152849775b981c54add74bfa30d858e4d`. This is the released explicit-only
control; it is `unchanged` in the release set and receives no new package
behavior contract or SOURCE revision. The bounded release, installation, and
loaded-copy evidence added for these unchanged bytes is recorded below.

[Decision 0019](../../decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md)
and local development commit `776989f...` remain preserved historical/future
development inputs. Their implicit-discovery and demand-driven-module bytes
are intentionally excluded from this release. Restoring the
released package here does not delete or reinterpret that Git history.

Public candidate commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` contains the
bounded recovery-coherence hardening to the entry and both direct references.
It distinguishes readers, active sessions,
and writers; keeps current state, writer, gate, next action, and recovery target
on one verified checkpoint; audits current/historical/superseded evidence and
result indexes; fails closed when no unique recovery entry exists; and
preserves immutable history while correcting current claims.

The public candidate and historical stable facts below describe the same
released explicit-only bytes now preserved in `v0.2.0`. Immutable tag
`v0.2.0` points to coherent release commit
`ac790233d5a8ba5afafd6eef95b1d5bc3cbe83a6`; its Project Docs subtree is exact
tree `ce6da1202e21d8968ea47c86fb9992c0dd1f6f6b`, identical to `v0.1.2` and
commit `ceed607152849775b981c54add74bfa30d858e4d`. The tag-pinned stable copy
was materialized through the official installer, matched all six tag blobs,
and a fresh loaded-copy canary read the active installed entry and adoption
reference before returning factual `PROPOSE` for a synthetic repository that
intentionally lacked a canonical write locus. The fixture stayed unchanged.

## Current Writer

The historical Decision 0019 implementation and documentation writers are
relinquished. Release actions for `v0.2.0` are complete. The bounded
release-prep writer owns only factual evidence synchronization, deterministic
verification, native review, at most one evidence-only commit, push of that
branch commit, and final all-worktree reconciliation. It gains no Project Docs
behavior-change, discovery, tag movement, release-asset, cleanup, or other
external-effect authority.

## Evidence State

The six live package files match both the `v0.1.2` and `v0.2.0` Git blobs and
raw SHA-256 values in [Verification](VERIFICATION.md). The current active stable
copy is exact `v0.2.0` and has fresh physical loaded-copy evidence; the retained
rollback copy remains exact `v0.1.2`.

The excluded Decision 0019 development revision previously passed structural
and deterministic checks and received a bounded `PARTIAL` evidence verdict.
Actual candidate selection, physical loaded-copy attribution, and persistent
writes remained `UNKNOWN`. Those results remain historical and do not describe
the package bytes in this release.

Exact implicit selection and physical loaded-copy attribution remain `UNKNOWN`
because native automatic injection produced no physical resource-read event.
Authorized adoption and valid routed routine maintenance both rechecked writer
and failed closed when the effective child sandbox rejected writes; their
persistent effects also remain `UNKNOWN`. The detailed attempt and exclusion
boundary is owned by the [implicit-discovery result](../../../evals/results/2026-08-07-project-docs-implicit-discovery-source-eval.md).

For the immutable control, exact-source behavior passes; explicit-only
DEV_DISCOVERY identity and historical shared exact-commit RC identity are
verified; and the tag-pinned stable explicit `NOOP` smoke test passes.
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
Those historical results do not activate or release the excluded implicit-
selection or demand-driven-module revision. See
[Verification](VERIFICATION.md).

## Next Gate

The `v0.2.0` release and stable installed-copy gates are complete. No Project
Docs release action remains pending. Retained carrier, rollback-copy, mapping,
branch, or worktree cleanup is a separate decision and is not performed by this
release closeout.

Decision 0019 remains accepted but excluded from this release set. Any future
resumption must start from its own exact Git revision and evidence boundary,
not infer continuity from this package restoration. Project Docs remains the
explicit-only package in current stable `v0.2.0`.

## Recovery Entry

1. Read [`AGENTS.md`](../../../AGENTS.md) and the repository
   [Authority Map](../../AUTHORITY.md).
2. Read [Design](DESIGN.md), this state, and
   [Verification](VERIFICATION.md).
3. Confirm live Git state and writer ownership.
4. Read canonical SOURCE and the relevant eval result before changing behavior
   or claims.
5. Treat other-Skill and ignored-evidence scopes as independently owned; do not
   infer transfer from this integration record.
6. Stop before model-data transfer, structural, Git, install, or release
   actions without the corresponding authorization.
