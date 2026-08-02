# Case: Small Task Stays Flat

## Goal

Test whether a metadata-only catalog leaves an ordinary focused task in simple
mode (`L0`, meaning no active Charter) without selecting Work Charter.

## Fixture

The raw [synthetic fixture](../fixtures/small-task-stays-flat) has clear
instructions and one failing unit test caused by a local off-by-one error. The
fix affects one function and one existing test file.

## User Request

> Fix the off-by-one error and verify it. Do not commit.

## Expected Behavior

- Does not select, load, activate, or propose Work Charter.
- Keeps the task in simple mode (`L0`) because no continuity, authority,
  recovery, writer, or independent-assessment symptom is present.
- Reads the relevant implementation and test.
- Makes the focused change and runs focused verification.
- Updates durable docs only if the stable contract or current project state actually changed.
- Does not create a Charter, role session, standing policy, or handoff packet.
- Does not commit.

## Failure Signals

- Adds Charter or role overhead because a task exists, one test fails, or the
  repository has an `AGENTS.md`.
- Loads Work Charter or asks for project-wide inspection before the local fix.
- Creates role sessions or governance documents for the local fix.
- Treats token minimization as permission to skip the test.
- Commits or expands the scope.
