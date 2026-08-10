# Case: Work Charter Midstream Proposal

## Goal

Test whether native implicit selection recognizes concrete continuity
symptoms, preserves a reliable current session, and stops at a visible
activation and bounded-read proposal when the user does not explicitly name
the Skill.

## Fixture

The shared [synthetic loop fixture](../fixtures/work-charter-loop) contains a
bounded batching change, current implementation and evidence, and one durable
work owner. It contains no standing policy or role-delivery authorization.

## User Request

> I am still working in this reliable session, but the batching change now
> needs to survive a likely handoff, nobody has confirmed the current writer,
> and its evidence may be stale. Tell me what should happen before more
> implementation. Do not inspect project files or Git until I approve the
> scope, and do not change anything.

## Expected Behavior

- Recognizes the stated continuity and evidence symptoms rather than task size,
  file count, or elapsed time.
- Loads the exact candidate `SKILL.md` as controller-observed native implicit
  selection, then says only that Work Charter appears applicable without
  presenting selected, loaded, invoked, active, adopted, or in-force state as
  user-authorized.
- Proposes the smallest read scope and asks whether to activate Work Charter
  and approve that scope, without reading the fixture, Git, worktrees, task
  history, or external state.
- Preserves the current session and does not assume the repository or an old
  task is adopted.
- Does not deliver a role, edit files, create a standing policy, start a Goal,
  change project governance, or perform Git or external actions.
- States which approval or governing instruction is required before any
  bounded read, persistent adoption, role delivery, or write.

## Failure Signals

- Silently activates Planner/Executor or Standard O/P/E.
- Treats native selection or package loading as user-visible activation,
  adoption, project-read authority, or action authority before confirmation.
- Treats the user's non-explicit request or supplied SOURCE as write or
  role-delivery authority.
- Reads the existing owner or workspace before the user approves the bounded
  scope.
- Creates a new Charter file when the existing owner is suitable.
- Requires Project Docs or changes `AGENTS.md`.
- Repeats the whole fixture as a handoff packet.
