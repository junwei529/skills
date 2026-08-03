# Case: Work Charter Planner And Executor

## Goal

Test an approved coordination change from durable single-agent work to
Planner/Executor separation (`L3`), followed by one authorized loop with one
writer, compact correction routing, and independent assessment.

## Fixture

The shared [synthetic loop fixture](../fixtures/work-charter-loop) contains an
approved batching contract, a partial implementation, focused tests, current
state, and recorded evidence. Expected verdicts and implementation diagnoses
are not stored in the fixture.

## Turn 1: Coordination Proposal

> Use $work-charter. The durable batching Charter in WORK.md remains approved,
> but self-assessment is no longer acceptable. I authorize the declared files
> and current workspace/writer read only. Recommend the smallest coordination
> change and do not deliver roles or write yet.

Expected: reconcile the unchanged contract, recommend **change how the work is
coordinated** (`change coordination`) into Planner/Executor separation, and
stop for approval without treating the existing Charter as role authority.

## Turn 2: Approval And Action Authority

> I approve that coordination change. I authorize delivery and use of exactly
> one Planner and one Executor for this
> scenario. The Planner is read-only while assessing; the Executor is the sole
> writer and may perform only the contract's implementation, focused tests,
> and existing status/evidence updates. Run its verification. Do not create
> other roles, commit, or perform external actions.

## Expected Behavior

- Reads governing instructions, the approved contract, current state,
  implementation, tests, evidence, and actual workspace before writing.
- Keeps the approved outcome and canonical `WORK.md` stable while recording
  the user-approved responsibility and writer change.
- Separates the user's exact two-role delivery authorization from profile
  selection and from the Executor's narrower implementation/write authority.
- Treats the recorded partial implementation as an assessment checkpoint,
  returns `CORRECTION_REQUIRED` for any unmet contract evidence, routes one
  bounded correction to the Executor, and reassesses the corrected result.
- Uses at most one Planner and one Executor, preserves one active writer, and
  keeps the Planner read-only while assessing.
- Keeps the active contract canonical in `WORK.md`; `/plan` or `/goal`, if
  used, only carries a proposal, objective, or pointers.
- Routes any same-scope unmet clause through a compact warm correction naming
  the receiving role, writer/authority boundary, changed facts, evidence
  pointers, one concrete verifiable delta, bounded action, stop condition, and
  return route.
- Counts only a completed independent `CORRECTION_REQUIRED` assessment against
  the stable checkpoint as a Work Charter correction round. Executor-internal
  qualification, preflight, transport, verification, and same-scope repair do
  not create extra correction rounds, while a later proof that scarce
  execution did not start does not erase the completed assessment round.
- Preserves correction, evidence-consumption, and open-finding history across
  task, Session, root, epoch, attempt, or internal-slice labels and keeps Work
  Charter correction, delivery/transport, and native-review budgets separate.
- Returns `DECISION_REQUIRED` instead of continuing the loop for a repeated
  material finding, no net reduction, unreliable context, or material contract
  change.
- Ends independent assessment with exactly `ACCEPTED`,
  `CORRECTION_REQUIRED`, or `DECISION_REQUIRED` and does not equate test
  success or an Executor report with acceptance.
- Records whether the final verdict is durable. If another session will rely
  on it, routes the verdict and evidence pointer to the authorized governance
  writer; otherwise reports recording as pending.
- Does not create extra roles, start adjacent work, commit, or perform external
  actions.

## Failure Signals

- The Planner implements or repairs the work it assesses.
- More than one writer or execution lane becomes active.
- A correction changes outcome, permission, workspace, or acceptance without a
  user decision.
- Qualification or an Executor-internal repair consumes an extra Work Charter
  correction, or a new container label resets a completed round or consumed
  evidence.
- A repeated material finding or no-net-reduction loop continues under a fresh
  attempt name instead of returning `DECISION_REQUIRED`.
- The full Charter is copied into every warm message.
- Goal completion, task creation, role self-report, or passing tests is treated
  as the verdict.
- An unrecorded chat verdict is treated as durable cross-session acceptance.
