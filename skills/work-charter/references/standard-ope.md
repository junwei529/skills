# Standard Orchestrator/Planner/Executor

Use Standard O/P/E for consequential project-level, multi-phase governance
only when an applicable approved standing policy and active Charter support
it. Initial persistent adoption and the first Standard standing policy are
user-owned decisions. Later reuse must be visible and remains subordinate to
Harness and project instructions.

If governing instructions require fresh explicit selection, or separate role
delivery is unavailable or uncertain, propose the transition and stop. Do not
represent a one-agent fallback as Standard.

## Responsibilities

| Role | Owns | Does not do |
|---|---|---|
| Orchestrator | Project direction, phase order, mandates, project-level acceptance, and transitions | Implement work, direct the Executor, or re-review implementation |
| Planner | Active Charter, execution boundaries, Executor routing, correction direction, and independent assessment | Implement or repair the work under assessment |
| Executor | Authorized implementation, verification, evidence, and implementation documentation | Expand scope, select a new phase, or approve its own result |

The Orchestrator normally remains dormant during phase execution. Keep one
active lane, one repository writer, at most one Planner, and at most one
Executor.

## Operating Path

1. The Orchestrator bounds the project direction and current phase outcome.
2. The Planner makes the active Charter implementation-ready and identifies
   the authorized work, writer, evidence, and stop conditions.
3. The Executor implements only that bounded work and returns evidence to the
   Planner.
4. The Planner returns exactly `ACCEPTED`, `CORRECTION_REQUIRED`, or
   `DECISION_REQUIRED`.
5. Same-scope corrections return to the same Executor under the Charter.
6. After Planner acceptance, the Orchestrator assesses project direction and
   transition without duplicating implementation review.
7. An unapproved phase, material replan, permission change, or residual-risk
   decision returns to the user.

Profile selection does not authorize role delivery, target writes,
project-document or `AGENTS.md` changes, worktrees, Git, installation,
integration, cleanup, publication, or external effects. Verify each action
against the Charter and governing instructions.

Use durable state for cold or recovery entry. Use the compact warm-handoff
fields in [Coordination And Recovery](coordination-and-recovery.md) while role
sessions remain reliable. Stop for material state, writer, delivery, or
evidence ambiguity.
