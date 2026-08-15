# Project Docs State

Last updated: 2026-08-14

## Current Implementation

Canonical editable SOURCE remains the six-file package under
[`skills/manage-project-docs`](../../../skills/manage-project-docs). In the
coherent `v0.2.0` release-set candidate, all six files are restored
byte-for-byte to immutable `v0.1.2` commit
`ceed607152849775b981c54add74bfa30d858e4d`. This is the released explicit-only
control; it is `unchanged` in the release set and receives no new behavior,
selection, installation, or loaded-copy claim.

[Decision 0019](../../decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md)
and local development commit `776989f...` remain preserved historical/future
development inputs. Their implicit-discovery and demand-driven-module bytes
are intentionally excluded from this prerelease candidate. Restoring the
released package here does not delete or reinterpret that Git history.

Public candidate commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` contains the
bounded recovery-coherence hardening to the entry and both direct references.
It distinguishes readers, active sessions,
and writers; keeps current state, writer, gate, next action, and recovery target
on one verified checkpoint; audits current/historical/superseded evidence and
result indexes; fails closed when no unique recovery entry exists; and
preserves immutable history while correcting current claims.

The public candidate and stable facts below describe the same released
explicit-only bytes now present in this release-prep branch. Immutable tag `v0.1.2` at
`ceed607152849775b981c54add74bfa30d858e4d`, its GitHub Release, and the
verified stable installed copy contain these exact six package files.

## Current Writer

The historical Decision 0019 implementation and documentation writers are
relinquished. The bounded release-prep writer may materialize these six exact
`v0.1.2` files and update mapped factual consumers only as part of the one
authorized local prerelease commit. It gains no Project Docs behavior-change,
installation, discovery, push, tag, release, cleanup, or external-effect
authority.

## Evidence State

The six live package files match the `v0.1.2` Git blobs and raw SHA-256 values
in [Verification](VERIFICATION.md). Historical stable evidence remains exact-
revision evidence for those bytes; release-prep materialization does not create
new `RC_INSTALL`, `STABLE_INSTALL`, or runtime loaded-copy evidence.

The excluded Decision 0019 development revision previously passed structural
and deterministic checks and received a bounded `PARTIAL` evidence verdict.
Actual candidate selection, physical loaded-copy attribution, and persistent
writes remained `UNKNOWN`. Those results remain historical and do not describe
the package bytes in this prerelease candidate.

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

For this repository change, the next gate is only the Work Charter `v0.2.0`
prerelease closeout. Project Docs stays `unchanged` at exact `v0.1.2`; no
Project Docs candidate, installation, behavior run, or release action is
authorized.

Decision 0019 remains accepted but excluded from this release set. Any future
resumption must start from its own exact Git revision and evidence boundary,
not infer continuity from this package restoration. `v0.1.2` remains the
explicit-only stable release.

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
