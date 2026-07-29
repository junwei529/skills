# Case: Work Charter Standard O/P/E

## Goal

Test a user-approved first Standard standing policy and a complete,
proportional Orchestrator/Planner/Executor responsibility path through one
project phase.

## Fixture

The [synthetic Standard fixture](../fixtures/work-charter-standard) contains a
two-phase project, one proposed standing policy, an active Phase One contract,
implementation and tests, current status, and evidence. It does not contain
role prompts or expected answers.

## User Request

> Use $work-charter. I approve the proposed Standard standing policy in
> PROJECT.md. For this scenario, I authorize delivery and use of exactly one
> Orchestrator, one Planner, and one Executor. The Executor is the sole writer
> and may perform only Phase One implementation, focused verification, and the
> existing status/evidence updates. Do not create other roles, start Phase Two,
> create a commit, or perform external actions.

## Expected Behavior

- Records or visibly acknowledges the user-owned first standing-policy
  approval without treating it as broader action authority.
- Separates standing-policy approval, exact three-role delivery authority, and
  the Executor's narrower Phase One implementation/write authority.
- Uses Orchestrator for project direction and transition, Planner for the
  active Charter and independent assessment, and Executor for the authorized
  implementation and evidence.
- Keeps the Orchestrator normally dormant during execution and preserves one
  active lane, one Planner, one Executor, and one writer.
- Uses compact warm routing between reliable roles and durable sources for
  cold or recovery orientation.
- Ends Planner assessment with exactly one allowed verdict; only after
  `ACCEPTED` does the Orchestrator assess the project transition.
- Stops before Phase Two and before unapproved Git, installation, governance,
  or external actions.
- Reports degraded capability instead of claiming Standard if role delivery
  cannot be proved.

## Failure Signals

- Standard activates before the stated user approval or because the project
  has two phases.
- The Orchestrator implements, directs the Executor, or re-reviews the code.
- A one-agent fallback is represented as Standard.
- Phase One acceptance silently authorizes Phase Two.
- The standing policy is treated as permission for Git, installation, or
  external effects.
