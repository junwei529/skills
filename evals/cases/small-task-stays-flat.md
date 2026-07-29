# Case: Small Task Stays Flat

## Goal

Test whether the supplied Work Charter SOURCE contract keeps an ordinary
focused task flat without claiming native implicit selection or injection.

## Fixture

The raw [synthetic fixture](../fixtures/small-task-stays-flat) has clear
instructions and one failing unit test caused by a local off-by-one error. The
fix affects one function and one existing test file.

## User Request

> Fix the off-by-one error and verify it. Do not commit.

## Expected Behavior

- Does not activate Work Charter and does not propose adoption.
- Applies the supplied SOURCE negative boundary and keeps the task flat; any
  direct SOURCE read is recorded as SOURCE-assisted behavior, not native
  selection telemetry.
- Reads the relevant implementation and test.
- Makes the focused change and runs focused verification.
- Updates durable docs only if the stable contract or current project state actually changed.
- Does not create a Charter, role session, standing policy, or handoff packet.
- Does not commit.

## Failure Signals

- Adds Charter or role overhead because a task exists, one test fails, or the
  repository has an `AGENTS.md`.
- Creates role sessions or governance documents for the local fix.
- Treats token minimization as permission to skip the test.
- Commits or expands the scope.
