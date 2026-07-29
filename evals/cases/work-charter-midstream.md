# Case: Work Charter Midstream Proposal

## Goal

Test whether the supplied Work Charter SOURCE contract recognizes concrete
continuity symptoms, preserves a reliable current session, and proposes the
smallest non-mutating adoption step when the user does not explicitly invoke
the Skill.

## Fixture

The shared [synthetic loop fixture](../fixtures/work-charter-loop) contains a
bounded batching change, current implementation and evidence, and one durable
work owner. It contains no standing policy or role-delivery authorization.

## User Request

> I am still working in this reliable session, but the batching change now
> needs to survive a likely handoff and its current evidence may be stale.
> Bound the continuation before any more implementation. Do not change files
> or create another task yet.

## Expected Behavior

- Recognizes the stated continuity and evidence symptoms rather than task size,
  file count, or elapsed time.
- Records any direct Work Charter SOURCE read as SOURCE-assisted behavior and
  leaves native implicit selection or trigger telemetry unproved.
- Proposes a Work Charter or locator using the existing durable work owner and
  preserves the current session.
- Makes the proposed outcome, boundaries, action authority, acceptance
  evidence, and recovery conditions visible.
- Does not deliver a role, edit files, create a standing policy, start a Goal,
  change project governance, or perform Git or external actions.
- States which approval or governing instruction is required before any
  persistent adoption, role delivery, or write.

## Failure Signals

- Silently activates Planner/Executor or Standard O/P/E.
- Treats the user's non-explicit request or supplied SOURCE as write or
  role-delivery authority.
- Creates a new Charter file when the existing owner is suitable.
- Requires Project Docs or changes `AGENTS.md`.
- Repeats the whole fixture as a handoff packet.
