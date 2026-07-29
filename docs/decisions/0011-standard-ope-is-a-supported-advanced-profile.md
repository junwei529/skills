# 0011: Standard O/P/E Is A Supported Advanced Profile

Date: 2026-07-29
Status: accepted

## Context

Standard Orchestrator/Planner/Executor flow was created to solve observed
long-running project failures: one session mixing direction, planning, and
implementation; weak cross-session handoff; and incorrect continuation after a
long interruption. Treating Standard as merely experimental would demote the
product capability most directly aimed at those failures.

The same structure is unnecessarily expensive for ordinary work and many
bounded Chartered tasks. Formal support must therefore remain distinct from
default activation.

## Decision

Work Charter v0.1 formally supports Standard O/P/E as its principal advanced
profile for consequential, multi-phase, long-lived project work.

### Product Position

- Standard is a supported v0.1 capability, not an experimental appendix or
  deferred concept.
- Standard is not the default for ordinary work, L1, or L2.
- Standard activates only after explicit user selection. Task size, duration,
  module count, Work Charter selection, or the presence of project documents
  does not silently opt a run into Standard.
- Flat, L1, and L2 remain supported because proportional activation is part of
  the product rather than a compatibility fallback.

### Role Boundaries

- The Orchestrator owns project direction, approved phase order, phase
  mandates, project-level transition decisions, and project-level acceptance.
- The Planner owns the current phase Charter, execution boundaries, correction
  direction, and phase assessment.
- The Executor owns implementation, focused and broad verification, evidence,
  and authorized implementation documentation.
- The Orchestrator may remain dormant while a phase is executing. Formal
  support does not require three agents to exchange messages continuously.
- Standard uses the Resume Gate and the Anchor + Delta + Role Capsule protocol
  accepted in Decisions 0009 and 0010.

### Authorization And Capability Boundaries

- Selecting Standard does not implicitly authorize repository writes,
  worktrees, Git operations, installation, external side effects, or changes to
  target-project governance. Those actions retain their own approved Charter
  or operation boundaries.
- Role creation and continuation follow the approved project or phase
  delivery contract; a profile name is not proof that a role task exists,
  received a message, or loaded the expected Skill copy.
- If Codex cannot create, address, or reliably continue the required separate
  roles, the agent reports that Standard is unavailable or degraded. Falling
  back to L2 or L1 requires an explicit user choice when it changes the
  accepted role or assessment boundary.

### v0.1 Evidence Boundary

Formal support makes Standard behavior part of release readiness. Forward tests
must cover at least:

- explicit Standard selection and a complete O/P/E responsibility path;
- a negative ordinary or L2 case that does not upgrade itself;
- phase planning, authorized execution, bounded correction, assessment, and
  transition handling;
- cold, warm, and recovery messages using the compact handoff protocol;
- interruption or stale-state recovery that stops on material ambiguity;
- one-writer preservation and material authorization stops;
- unavailable or uncertain role-delivery degradation;
- proof of the actually loaded standalone Skill copy.

These tests must not treat task creation, role self-report, passing tests, or
document presence alone as proof of correct orchestration or acceptance.

## Consequences

- Standard implementation and positive and negative forward tests are v0.1
  release requirements for Work Charter.
- The public narrative may call Standard a supported advanced profile, but
  must also state that it is explicit opt-in and advisory.
- Agent Loop remains the internal kernel and Work Charter remains the
  user-facing contract; Standard is a role profile, not a fourth Skill or a
  dependency on Project Docs.
- Skills cannot deterministically guarantee role compliance, message delivery,
  writer locking, or correct assessment without supporting Harness or
  deterministic mechanisms.
- The current `manage-large-tasks` Standard reference implements the earlier M2
  contract. It is not evidence for Decision 0011 until revised and
  forward-tested.
- Acceptance labels, concurrency scope, and correction budget remain open.

## Re-evaluation Conditions

Revisit formal support if Codex removes the required role-session capability,
if full-loop evaluation cannot establish a coherent supported path, or if
comparative evidence shows that the Standard profile consistently costs more
than it protects for its intended multi-phase use.

## Related Documents

- [Decision 0008](0008-work-charter-logical-contract-and-codex-carriers.md)
- [Decision 0009](0009-work-charter-role-profiles-and-resume-gate.md)
- [Decision 0010](0010-compact-role-handoff-and-event-checkpoints.md)
- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Roadmap](../ROADMAP.md)
- [Current status](../STATUS.md)
- [Verification](../VERIFICATION.md)
