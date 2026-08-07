# Project Docs State

Last updated: 2026-08-07

## Current Implementation

Canonical editable SOURCE remains the six-file package under
[`skills/manage-project-docs`](../../../skills/manage-project-docs). The
current uncommitted development revision implements
[Decision 0019](../../decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md):
high-confidence implicit discovery starts read-only and proposal-only, concrete
mutation still needs explicit approval, valid target-project routing owns
ordinary maintenance, and new projects can activate functional modules with
declared update modes while existing projects retain sufficient layouts.

The package still implements the five logical responsibilities, four surfaces,
five outcomes, continuity anchor, structural authorization gate, reader/
session/writer distinction, coherent recovery snapshot, and immutable-history
boundary. It adds no daemon, registry, mandatory file, reference, or runtime.

Public candidate commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` contains the
bounded recovery-coherence hardening to the entry and both direct references.
It distinguishes readers, active sessions,
and writers; keeps current state, writer, gate, next action, and recovery target
on one verified checkpoint; audits current/historical/superseded evidence and
result indexes; fails closed when no unique recovery entry exists; and
preserves immutable history while correcting current claims.

The public candidate and stable facts below describe the released explicit-only
control, not this working-tree revision. Immutable tag `v0.1.2` at
`ceed607152849775b981c54add74bfa30d858e4d`, its GitHub Release, and the
verified stable installed copy contain these exact six package files.

## Current Writer

No Project Docs SOURCE writer is active after the SOURCE evaluation and
evidence checkpoint. The implementation task relinquished with its changes
unstaged and uncommitted. A later bounded documentation-integration window
corrected this state and mapped root consumers, passed its deterministic
checks, and relinquished. It granted no Skill SOURCE, eval, staging, commit,
installation, persistent discovery mapping, candidate, release, user-
configuration, ignored-evidence cleanup, or other-Skill authority.

## Evidence State

The current six-file development revision passes structural and deterministic
checks at the exact hashes in [Verification](VERIFICATION.md). A bounded
synthetic matrix observed an isolated no-target baseline, an unchanged
explicit-only stable control, candidate-routing signals with mature `NOOP`, an
ordinary non-selection negative, and authority-conflict `PROPOSE`. A separate
assessor returned `ACCEPTED` only for the static SOURCE/eval contract. Overall
current-revision evidence is `PARTIAL` because actual candidate selection was
not controller-observed.

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
Those historical results do not prove the current implicit-selection or
demand-driven-module revision. See [Verification](VERIFICATION.md).

## Next Gate

Decision 0019 remains the accepted design and the six-file SOURCE structurally
implements it, but the revision's evidence verdict is `PARTIAL`. Native review
identified an environment bootstrap conflict plus an overbroad selection-
acceptance claim. The package keeps `allow_implicit_invocation: true`; a
corrected stable diff needs another native review before any separate commit
decision. Neither the static assessor nor an environment-guidance correction
is loaded-copy, write-persistence, candidate, or release evidence.

After an accepted commit and separate authorization, an exact-commit candidate
can test physical loaded-copy identity and a write-capable synthetic adoption/
routine-maintenance pair. A separate near-neighbor incidental-symptom or
broken-route re-entry canary remains useful before broad trigger claims.
`v0.1.2` remains the unchanged explicit-only stable release.

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
