# Work Charter Design

Last updated: 2026-07-31

## Purpose And Audience

Work Charter serves Codex users whose consequential work needs an explicit
contract, proportional role separation, independent assessment, and durable
recovery. It protects outcome and authority without turning every task into an
orchestration system.

“Agent loop” is descriptive language, not a second product or state machine.
Work Charter is not a project-document system, shell guide, generic workflow
engine, scheduler, permission system, or deterministic lock.

## Minimum Contract

A Charter makes five logical responsibilities discoverable:

1. intended outcome and non-goals;
2. scope and hard boundaries;
3. authorization for writes and external effects;
4. acceptance evidence and verification expectations;
5. stop, decision, and recovery conditions.

One existing project owner is preferred. A bounded single-session Charter may
remain in active context; multi-session, interruption-prone, or materially
side-effecting work requires durable state. `/plan` and `/goal` are optional
Codex carriers, not the contract or authority themselves.

## Activation And Coordination

Observable continuity, control, authorization, recovery, or independent-
assessment symptoms may cause only a visible proposal on implicit invocation.
Initial persistent adoption and the first Standard standing policy are
user-owned. Profile selection never authorizes role delivery, target writes,
project-document changes, worktrees, Git, installation, or external effects.

Use the least sufficient structure:

- keep small or bounded Chartered work in the current session;
- use Planner/Executor when a separate contract owner or assessor materially
  protects implementation; and
- use Standard O/P/E only under an applicable approved standing policy and
  active Charter.

Keep one active execution lane, one repository writer, at most one Planner,
and at most one Executor. The Orchestrator normally remains dormant during
Standard execution.

## Assessment And Recovery

Contract state is `draft`, `proposed`, `approved`, or `superseded`; run
disposition is `active`, `paused`, or `closed`. A separately required
assessment returns exactly `ACCEPTED`, `CORRECTION_REQUIRED`, or
`DECISION_REQUIRED`.

Default to at most three completed correction rounds per assessment
checkpoint, stopping earlier for repeated material findings, no net reduction,
specification ambiguity, or unreliable context. This budget is independent of
native review.

Cold or recovery entry reconciles the canonical Charter, project state,
workspace, evidence freshness, writer, and last approved action. Warm handoff
contains only role and authority, changed facts, evidence pointers, bounded
action, stop condition, and return route.

For a material cross-session decision, use a stable logical locator and a
comparable authoritative revision or equivalent freshness marker. Message
arrival order is not finality: an older observation cannot overwrite a newer
verified revision, and incomparable observations stop before write or
advancement.

Keep an assessment's three-state verdict separate from its recording state.
If another session, recovery, or transition will rely on the verdict, the next
authorized governance writer records it in the target project's canonical
owner. Until that write is verified, report recording as pending rather than
durable acceptance.

Bind material evidence to mutable subjects and invalidation conditions when
applicable, and use a method that observes the actual result surface. Later
material source drift invalidates bound evidence. Ignored, untracked, private,
generated, or external results require evidence beyond tracked Git status.

Uncertain non-idempotent role delivery stops without an automatic retry or
replacement. Writer ownership remains advisory: a conflict pauses writing,
inventories deltas, restores one authorized writer, and revalidates affected
evidence. Harness routing and deterministic enforcement remain outside the
public Skill.

## Internal Package Boundaries

| Source | Owner |
|---|---|
| [`SKILL.md`](../../../skills/work-charter/SKILL.md) | Charter responsibilities, proportional coordination, authority, assessment, and stop boundary |
| [`coordination-and-recovery.md`](../../../skills/work-charter/references/coordination-and-recovery.md) | Midstream adoption, bounded work, P/E, correction, cold recovery, and warm handoff |
| [`standard-ope.md`](../../../skills/work-charter/references/standard-ope.md) | Formal Standard responsibilities and operating path |
| [`work-charter.md`](../../../skills/work-charter/assets/work-charter.md) | Optional adaptable durable carrier |
| [`openai.yaml`](../../../skills/work-charter/agents/openai.yaml) | Public metadata and bounded implicit-invocation policy |
| [Work Charter eval cases](../../../evals/README.md#work-charter-forward-matrix) | Flat, proposal, recovery, P/E, Standard, and negative contracts |

## Independent-Skill Boundary

Work Charter may consume reliable project-document locators but does not
require or invoke Project Docs. Project Docs owns document semantics; Work
Charter owns consequential-work contract, roles, recovery, and assessment.
PowerShell remains separately selected for material Windows boundaries.

## Accepted Basis

- [Decision 0007](../../decisions/0007-independent-skills-and-optional-recipes.md)
- [Decision 0012](../../decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
- [Decision 0016](../../decisions/0016-work-charter-authority-assessment-and-evidence-integrity.md)
- [Decision 0015](../../decisions/0015-federated-repository-documentation.md)
