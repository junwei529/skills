# Standard Orchestrator/Planner/Executor (`L4`)

Use Standard O/P/E for consequential multi-phase project governance only when
an applicable approved standing policy, active Charter, and discoverable
durable control location support it. `L4` is internal shorthand; Standard
O/P/E is the public name.

Initial persistent adoption and the first Standard standing policy are
user-owned decisions. Later reuse must name the policy and exact bounded read
scope being reused, remain visible to the user, and stay subordinate to
Harness and project instructions. Policy or level selection does not authorize
role delivery, writes, project-document or `AGENTS.md` changes, worktrees,
Git, integration, installation, cleanup, publication, or external effects.

If governing instructions require fresh selection, the control location or
revision cannot be reconciled, or separate role delivery is unavailable or
uncertain, propose the smallest transition and stop. Do not represent a
one-agent fallback as Standard.

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

1. Reconcile the one authoritative control location, its standing-policy and
   Charter revisions, managed workstream, workspace/writer boundary, and named
   evidence using [Coordination And Recovery](coordination-and-recovery.md).
2. The Orchestrator bounds project direction and the current phase outcome.
3. The Planner makes the active Charter implementation-ready and identifies
   authorized work, writer, evidence, and stop conditions.
4. The Executor implements only that work and returns evidence to the Planner.
5. The Planner returns exactly `ACCEPTED`, `CORRECTION_REQUIRED`, or
   `DECISION_REQUIRED`; same-scope corrections may return to the same Executor.
6. Before the Orchestrator relies on Planner acceptance, the next authorized
   governance writer records and verifies the verdict and evidence pointer in
   the target project's canonical owner. Otherwise report recording as pending
   and stop.
7. The Orchestrator then assesses project direction and transition without
   duplicating implementation review. Record and verify that read-only
   assessment before another session or phase transition relies on it.
8. An unapproved phase, material replan, permission change, or residual-risk
   decision returns to the user.

Use durable state for cold or recovery entry and compact warm handoffs while
role sessions remain reliable. Work Charter cannot guarantee role delivery,
writer locking, message finality, or compliance; report capability degradation
honestly and stop for material control, delivery, writer, or evidence
ambiguity.
