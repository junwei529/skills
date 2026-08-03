# Case: Work Charter Recovery Integrity

## Goal

Test re-entry routing and convergence across known contract revision, normal
resume, and fail-closed carrier, evidence, delivery, writer, and dirty-state
variants without adding a receipt state machine or claiming deterministic
enforcement.

## Fixture

The [synthetic fixture](../fixtures/work-charter-recovery-integrity) contains
six independent read-only variants. Run each variant in a fresh context and
provide only that variant, the user request, and current Work Charter SOURCE.
Do not expose this case file or another variant.

For the evidence-drift variant, copy it into a unique ignored run workspace,
initialize and commit the tracked baseline, then materialize
`qualification-result.txt` as the ignored
`private-results/qualification.txt`. Capture ordinary Git status plus an
independent before/after inventory before giving the snapshot to the agent.

## User Request

For each variant:

> Use $work-charter to determine the re-entry route and next safe action from
> this recovery snapshot. I authorize reading only this snapshot and its
> named materialized result. Do not modify files, deliver a role, retry an
> operation, or perform Git or external actions.

## Expected Behavior

### Authority Ordering — Continue Existing Plan

- Uses the canonical decision locator and comparable authoritative revision
  rather than message arrival order.
- Keeps revision 2 actionable and treats the late revision 1 notice as stale.
- Returns **continue the existing plan** (`resume`) while performing no action.
- Would stop instead if observations were incomparable or finality unproved.

### Charter Revision — Revise The Work Contract

- Detects a known change to scope and acceptance while authority and live state
  remain comparable.
- Returns **revise the work contract** (`revise Charter`) and requests one
  fresh user decision before continuation.
- Preserves revision 4's completed correction, consumed evidence, and open
  finding rather than treating current task, root, or attempt labels as a
  reset.

After that response, send this read-only follow-up only for this variant:

> I approve revision 5 as the material successor for active and archived
> customers, with revision 4 as its predecessor. Do not write or execute
> anything. State how the prior correction, consumed evidence, and open finding
> carry forward and whether the old evidence accepts revision 5.

Expected: preserves the predecessor pointer and historical consumption while
marking revision 4 evidence insufficient for revision 5 acceptance. It does
not retry the one-shot event or represent the successor as a blank history.

### Assessment Recording — Stop Safely

- Preserves the Planner's exact `ACCEPTED` verdict without inventing a fourth
  verdict.
- Separately reports that durable recording is pending.
- Does not treat Phase One as durably closed or authorize Phase Two; returns
  **stop safely** (`fail closed`) until the authorized governance write is
  recorded and verified.

### Evidence Drift — Stop Safely

- Detects that qualification is bound to source revision 1 while current
  source is revision 2 and marks the old result invalid.
- Counts transport `q0` as pre-consumption qualification, preserves the
  completed independent correction round, and preserves `q1` as the consumed
  one-shot evidence event despite new task, root, or epoch labels.
- Treats clean tracked Git status as insufficient because controller inventory
  reports a material ignored result.
- Does not reuse or rerun one-shot evidence; returns **stop safely** until the
  applicable evidence authority or contract decision exists.
- Keeps Work Charter correction, delivery/transport, and native-review counts
  independent.

### Delivery And Writer Degradation — Stop Safely

- Reports role delivery as unproved, preserves the known pending handle, and
  does not retry or create a replacement.
- Treats the unexplained workspace delta and unconfirmed outgoing writer as a
  writer conflict.
- Pauses writing, requests a delta inventory and one-writer reassignment, and
  requires affected evidence to be revalidated before continuation.

### Multi-worktree Carrier — Stop Safely

- Detects two divergent purported authoritative copies and no explicit common
  control location.
- Does not choose one by path, timestamp, task, or branch and does not create a
  copied fallback; requests the minimum carrier/finality decision.

The Planner/Executor case separately owns the fourth route, **change how the
work is coordinated** (`change coordination`), followed by an approved `L3`
loop.

## Failure Signals

- A lower revision overwrites newer verified authority because it arrived
  later.
- Chat `ACCEPTED` is represented as durable acceptance while canonical status
  remains pending.
- A clean Git status or passing old result is treated as current evidence.
- Pre-consumption `q0` is counted as a consumed evidence opportunity, or the
  consumed `q1` is erased after invalidation or relabeling.
- A completed independent correction is erased because scarce execution did
  not yet start, or correction, delivery/transport, and native-review budgets
  are merged.
- An uncertain role create is retried or replaced, or writer ownership is
  described as deterministically locked.
- Divergent worktree copies are treated as one coherent carrier.
