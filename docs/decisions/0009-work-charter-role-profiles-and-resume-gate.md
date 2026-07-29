# 0009: Work Charter Role Profiles And Resume Gate

Date: 2026-07-29
Status: accepted

## Context

The earlier Large Tasks design used Orchestrator, Planner, and Executor as
separate roles. That separation addressed real long-running-work failures:

- planning and implementation polluted one long session's context;
- a new session drifted when its handoff or durable project state was weak;
- after a long interruption, an agent could read stale or incomplete project
  documents and recommend the wrong next action.

Always creating every role would add token, handoff, and coordination cost.
Making one Chartered agent the unconditional default would recreate the
context and self-assessment failures that motivated the product.

## Decision

Use four progressively stronger role profiles. Keep role responsibilities
stable, but create separate Codex sessions only when their isolation provides a
material benefit.

### Profiles

| Profile | Intended use | Role and session shape |
|---|---|---|
| `Flat` | Small, ordinary work that fits a reliable context | Do not select Work Charter; use the ordinary task session. |
| `L1 Chartered single-agent` | One bounded stage needs an explicit contract or recovery state, but planning, execution, and verification remain reliable together | One agent works under an approved Charter. |
| `L2 Planner/Executor` | Context lifetime, deliberate handoff, writer isolation, or independent assessment makes separation materially useful | A Planner owns the Charter, direction correction, and assessment; a separate Executor implements and records evidence. |
| `Standard O/P/E` | Explicit project-level, multi-phase governance | An Orchestrator owns project direction and phase transitions; Planner and Executor retain the L2 boundaries. Standard remains explicit opt-in. |

Task length, file count, or module count alone does not require a stronger
profile. Selection must consider whether separation materially improves
context reliability, handoff clarity, writer ownership, or assessment
independence enough to justify its communication cost.

### Responsibilities Versus Sessions

- Orchestrator, Planner, and Executor are responsibility boundaries, not three
  permanently active agents.
- Orchestrator responsibility may remain dormant in authoritative project
  documents between direction or transition decisions.
- L1 may combine planning, execution, and verification only while one context
  remains reliable and self-assessment risk is acceptable.
- L2 physically separates Planner and Executor. The Planner does not implement
  or repair work it is assessing during the active execution loop.
- Selecting Work Charter or a profile does not itself authorize creation of
  role sessions, repository mutation, worktrees, Git actions, or external side
  effects.

### Resume Gate

A multi-session or materially interrupted run must reconcile durable state
before recommending or executing the next action:

1. identify the authoritative project sources and active Charter or logical
   locator;
2. inspect the actual repository, branch, workspace, and relevant
   implementation state;
3. check whether verification evidence is present and current enough for the
   proposed continuation;
4. distinguish proposed, approved, executed-but-unassessed, accepted, and
   user-decision states;
5. compare documents, workspace facts, and evidence for material drift;
6. continue only when the next action follows from a coherent recovered state.

If authority, current state, writer ownership, evidence freshness, or the next
approved action is materially ambiguous, the Agent Loop stops for recovery or
a user decision. Reading project documents is necessary but is not, by itself,
proof that the recovered recommendation is correct.

## Consequences

- Ordinary work remains cheaper than any Chartered profile.
- Work Charter can address long-session context failure without forcing
  three-session orchestration on every selected task.
- Planner/Executor separation remains a first-class product capability rather
  than a universal startup sequence.
- Project Docs can supply durable project truth, but remains an optional peer.
  Without it, multi-session Work Charter use still requires a sufficient
  durable source.
- The current `manage-large-tasks` Skill does not implement these profiles or
  the Resume Gate and must not be described as doing so until revised and
  forward-tested.
- A compact cross-session message and correction protocol remains to be
  designed. This decision does not require every handoff to repeat the complete
  Charter.

## Re-evaluation Conditions

Revisit the profile boundaries if comparative tests show that L2 separation
does not improve recovery or assessment enough to justify its cost, if L1
repeatedly suffers context confusion, or if Codex role-session capabilities
change materially.

## Related Documents

- [Decision 0008](0008-work-charter-logical-contract-and-codex-carriers.md)
- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Roadmap](../ROADMAP.md)
- [Current status](../STATUS.md)
- [Verification](../VERIFICATION.md)
