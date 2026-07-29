# 0012: Work Charter v0.1 Identity And Minimum-Sufficient Design

Date: 2026-07-29
Status: accepted
Supersedes in part: Decisions 0001, 0007, 0008, 0009, 0010, and 0011 as
listed below

## Context

Work Charter was created from observed failures in long-running agent-assisted
development: planning and implementation polluted one session, weak handoffs
made successor sessions drift, and stale or incomplete project state produced
incorrect recovery advice. Role separation, durable state, and evidence-aware
recovery directly address those failures.

Product review also found that the design had accumulated more named profiles,
message parts, gates, states, and document projections than users should need
to understand. Requiring an explicit Standard keyword at every later
activation was too costly when the need for separation appears mid-development.
Conversely, silent role creation or action authorization would be unsafe.

## Decision

### Identity

- Use **Work Charter** as the public product, Skill, and contract name.
- Use `work-charter` as the intended v0.1 package name, frontmatter name, and
  canonical SOURCE directory.
- Retire `manage-large-tasks` during the separately authorized M2R source
  revision. Do not retain a compatibility alias or a second discovery entry.
- Use “agent loop” only as a descriptive phrase for bounded progress under a
  Charter. It is not a second product, artifact, state machine, or public
  brand.
- Until that source revision occurs, `skills/manage-large-tasks/` remains the
  only current implementation and must be reported as the superseded M2
  baseline rather than as Work Charter behavior evidence.

### Minimum-Sufficient Structure

- Keep ordinary work flat and do not create a Charter merely because the Skill
  is available.
- Create or reuse a Charter only when observed continuity, control,
  authorization, recovery, or independent-assessment risk justifies it.
- Treat a standing policy and an active Charter as two logical planes, not two
  required files, schemas, or versioned objects. Use one existing durable
  carrier by default.
- Keep coordination profiles and durable-state readiness as internal
  diagnostics. Users see the active outcome, role and writer, next checkpoint,
  pending decision, and a concise profile-change notice rather than a profile
  selection matrix.
- Do not add a named concept, role, state, artifact, gate, message type, or
  document projection unless it resolves an observed failure, changes a real
  decision, and has one canonical owner.

### Activation And Authority

- Observable continuity or control symptoms may cause Work Charter to propose
  midstream adoption or escalation. A new task, one failure, or a same-scope
  correction is not by itself a trigger, and the Skill does not poll in the
  background.
- Initial persistent adoption and the first Standard policy remain user-owned
  decisions. Later profile reuse may follow an approved project standing
  policy and must remain visible.
- A standing policy remains subordinate to applicable Harness and project
  instructions. When those instructions require a fresh explicit selection or
  the needed capability is unavailable, Work Charter proposes the transition
  and stops rather than claiming activation.
- Flat and bounded single-context work do not require a separate profile gate.
  Planner/Executor separation and Standard O/P/E are used only when the
  approved policy and active Charter support them.
- Adoption or profile selection does not authorize role delivery, target
  writes, project-document or `AGENTS.md` changes, worktrees, Git operations,
  installation, or external side effects. Those actions remain separately
  bounded by the active Charter or another explicit authorization.
- Project-document organization, authority, granularity, freshness, and
  evidence may inform readiness and profile selection but never determine the
  profile by themselves. Material ambiguity may require bounded recovery or a
  stop rather than more roles.

### Roles, Handoff, And Assessment

- Preserve a reliable current session and add only the missing responsibility.
  Create a recovery successor only when mixed roles, compaction, interruption,
  or drift makes the current context unreliable.
- Cold or recovery entry reads the durable Charter and authoritative state.
  Warm handoff carries only the receiving role, changed facts, evidence
  pointers, bounded action, stop condition, and return route.
- Anchor, Delta, Role Capsule, Resume Gate, and profile labels may remain
  authoring or evaluation shorthand. They are not mandatory public artifacts
  or independently persisted state.
- Use `draft`, `proposed`, `approved`, and `superseded` for contract state;
  `active`, `paused`, and `closed` for run disposition; and create a separate
  assessment record only when the Charter requires independent assessment.
- An assessment records its scope, owner, one of `ACCEPTED`,
  `CORRECTION_REQUIRED`, or `DECISION_REQUIRED`, evidence pointers, material
  residual risks, and return route. Do not add a partial-acceptance state or
  separate Result and Evidence state machines.
- Planner assessment owns phase or Charter correctness. In Standard, the
  Orchestrator assesses project direction and transition rather than
  re-reviewing implementation.

### v0.1 Operating Bounds

- Keep one active execution lane, at most one Planner and one Executor for the
  active Charter, one repository writer, and a normally dormant Orchestrator.
  Parallel Executors, automatic multi-worktree routing, and automatic
  integration remain deferred.
- Default to at most three completed `CORRECTION_REQUIRED` rounds per
  assessment checkpoint. Stop earlier for a repeated material finding, no net
  reduction, specification ambiguity, or unreliable context; then return
  `DECISION_REQUIRED`.
- The Work Charter correction budget is independent of native review in owner,
  counter, reset, evidence, and completion semantics.
- Standard O/P/E remains a formally supported v0.1 capability. It is
  proportional, policy-governed, advisory, and capability-degraded honestly;
  it is not a generic orchestration runtime.

## Supersession Map

- Decision 0001's `manage-large-tasks` public name and per-run explicit
  Orchestrator opt-in are superseded.
- Decision 0007 remains authoritative for independent Skills and optional
  recipes; references to Large Tasks now mean Work Charter.
- Decision 0008 remains authoritative for the logical contract, conditional
  persistence, Codex-first carriers, and optional Project Docs composition.
  Its open public-name question and separately branded Agent Loop layer are
  superseded.
- Decision 0009's behavioral separation and recovery reasoning remain
  accepted. Profile codes and Resume Gate are internal diagnostics, and
  activation follows the standing-policy rule above.
- Decision 0010's stable-source, compact-warm-handoff, session-reuse, and
  material-checkpoint principles remain accepted. Its three named message
  parts and classes are no longer mandatory public protocol objects.
- Decision 0011's formal Standard support, role ownership, advisory limits,
  and positive and negative evidence obligation remain accepted. Its
  requirement for a new explicit Standard selection at every activation is
  superseded; detailed test permutations belong to the evaluation contract.

## Consequences

- The public product surface is one name and one bounded contract.
- The design preserves the O/P/E capability that addresses the observed
  failures while removing vocabulary that does not change user action.
- Product documents can state current requirements once and link here for
  rationale instead of repeating Decisions 0008 through 0011.
- Implementation, package rename, metadata, references, assets, evals, loaded
  copy proof, installation, Git, and release actions remain separately
  authorized work.

## Re-evaluation Conditions

Revisit this decision if negative tests cannot prevent false escalation, if a
standing policy causes surprising role or action activation, if three
correction rounds repeatedly prove too low or too high, or if the renamed
package cannot remain independently discoverable and understandable.

## Related Documents

- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Current status](../STATUS.md)
- [Verification](../VERIFICATION.md)
- [Decision 0007](0007-independent-skills-and-optional-recipes.md)
- [Decision 0008](0008-work-charter-logical-contract-and-codex-carriers.md)
- [Decision 0009](0009-work-charter-role-profiles-and-resume-gate.md)
- [Decision 0010](0010-compact-role-handoff-and-event-checkpoints.md)
- [Decision 0011](0011-standard-ope-is-a-supported-advanced-profile.md)
