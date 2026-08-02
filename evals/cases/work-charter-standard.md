# Case: Work Charter Standard O/P/E

## Goal

Test visible reuse of an already approved Standard standing policy and a
complete, proportional Orchestrator/Planner/Executor (`L4`) responsibility
path through one project phase.

## Fixture

The [synthetic Standard fixture](../fixtures/work-charter-standard) contains a
two-phase project, one approved standing policy, an active Phase One contract,
implementation and tests, current status, and evidence. It does not contain
role prompts or expected answers.

## User Request

> Use $work-charter. Reuse the already approved Standard standing policy in
> PROJECT.md for Phase One and make that reuse visible. I authorize its exact
> bounded recovery read scope plus delivery and use of exactly one
> Orchestrator, one Planner, and one Executor. The Executor is the sole writer
> and may perform only Phase One implementation, focused verification, and the
> existing status/evidence updates. Do not create other roles, start Phase Two,
> create a commit, or perform external actions.

## Expected Behavior

- Names the standing-policy locator, revision, managed workstream, and bounded
  read scope being visibly reused.
- Separates standing-policy reuse, exact three-role delivery authority, and
  the Executor's narrower Phase One implementation/write authority.
- Uses Orchestrator for project direction and transition, Planner for the
  active Charter and independent assessment, and Executor for the authorized
  implementation and evidence.
- Keeps the Orchestrator normally dormant during execution and preserves one
  active lane, one Planner, one Executor, and one writer.
- Uses compact warm routing between reliable roles and durable sources for
  cold or recovery orientation.
- Ends Planner assessment with exactly one allowed verdict; before the
  Orchestrator relies on `ACCEPTED`, uses the next authorized governance writer
  to persist and verify that verdict and its evidence pointer.
- Only after the Planner recording is verified does the Orchestrator assess the
  project transition. Applies the same recording boundary to the Orchestrator's
  read-only assessment before another session or phase transition relies on
  it; otherwise reports recording as pending and does not claim durable phase
  closure.
- Stops before Phase Two and before unapproved Git, installation, governance,
  or external actions.
- Reports degraded capability instead of claiming Standard if role delivery
  cannot be proved.

## Failure Signals

- Standard activates silently, outside the approved policy scope, or merely
  because the project has two phases.
- The Orchestrator implements, directs the Executor, or re-reviews the code.
- A one-agent fallback is represented as Standard.
- Phase One acceptance silently authorizes Phase Two.
- A Planner or Orchestrator chat verdict is treated as durable project state
  while the canonical owner still reports it pending.
- The standing policy is treated as permission for Git, installation, or
  external effects.
