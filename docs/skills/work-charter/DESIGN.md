# Work Charter Design

Last updated: 2026-08-02

## Purpose And Audience

Work Charter serves Codex users whose consequential work needs an explicit
contract, proportional responsibility separation, independent assessment, or
durable recovery. It adds only the control delta that current model and Harness
behavior do not reliably own; it does not take over every conversation.

Work Charter is advisory, not a project-document system, shell guide, generic
workflow engine, scheduler, permission system, task/worktree router, or
deterministic lock. Installation makes it available but creates no background
monitor.

## Selection And First Read

Users may invoke `$work-charter` or explicitly ask in ordinary language to use
Work Charter without knowing special syntax. That direct intent activates the
Skill: the Harness loads the full body, and the response makes activation
visible before following its workflow.

An indirect request to choose among installed Skills, or observable
continuity, control, authorization, recovery, writer, or independent-
assessment symptoms, creates only a metadata-level proposal. The response says
that Work Charter appears applicable, explains why, proposes the smallest
bounded project read, and asks whether to activate it. It must not claim the
Skill is selected, loaded, or active, and must not inspect project details.
Ordinary bounded tasks, a new task, one failure, elapsed time, file count,
document governance, and shell diagnosis remain non-triggers.

After confirmation, the full Skill must load before its workflow is relied on.
The user may authorize activation and one exact bounded project read together;
otherwise activation stops at a read proposal. A later entry may visibly reuse
an exact read scope from an applicable approved standing policy. Metadata
matching, activation, loaded-copy proof, read approval, persistent adoption,
roles, writes, project-document changes, worktrees, Git, installation, and
external effects remain distinct. Controller-observed Skill reads, not model
self-report, establish loaded-copy identity in evaluation.

## Minimum Contract And Carrier

A Charter makes five logical responsibilities discoverable:

1. intended outcome and non-goals;
2. scope and hard boundaries;
3. authorization for writes and external effects;
4. acceptance evidence and verification expectations; and
5. stop, decision, and recovery conditions.

Use one authoritative carrier. Prefer a discoverable existing canonical owner
with a stable locator and comparable revision. A current-task Charter may stay
in the active task. Work that promises cold recovery needs a small durable
anchor containing workstream applicability, Charter and policy locators,
responsibilities, workspace/writer boundary, checkpoint/evidence, next action,
and reconfirmation conditions. A standalone `WORK_CHARTER.md` is only a
conditional single-checkout fallback and is never auto-created. Multiple
worktrees require one explicit control location, not divergent copies.

`/plan` may draft a Charter and `/goal` may optionally track an approved
objective and pointers. Neither is part of Work Charter, a canonical state
owner, execution authority, verification, or acceptance.

## Proportional Protection

The Skill recommends the least sufficient shape in ordinary language, explains
its cost, and leaves the choice to the user. Codes are internal shorthand:

| Code | User-facing shape | Minimum protection |
|---|---|---|
| `L0` | Ordinary flat task | No active Charter |
| `L1` | Current-task Charter | One agent and a bounded contract in the reliable current task; no cold-recovery promise |
| `L2` | Durable single-agent Charter | `L1` plus one discoverable persistent recovery anchor |
| `L3` | Planner/Executor separation | `L2` plus a separate Planner/assessor and sole-writer Executor |
| `L4` | Standard O/P/E | `L3` plus Orchestrator responsibility, an applicable standing policy, and multi-phase governance |

Levels are not a mandatory maturity ladder and add no action authority. The
recommendation considers observable environment capability and work risks but
does not hard-code model names, silently auto-adapt, or infer a level from task
length, file count, branch count, or elapsed time. Preserve `UNKNOWN` when the
Harness does not expose a fact.

## Managed Workstream And Re-entry

Adoption and conflict are scoped to one human-readable managed workstream, not
the whole repository. Durable identity combines its Charter locator/revision,
named feature or phase, and expected workspace/writer boundary; task IDs,
branches, and worktrees are live evidence. An old non-Chartered task or a
separate exploratory worktree matters only when it changes protected state.
The workspace/writer boundary detects routing drift; an authorized route
change does not erase the workstream's approval, correction, evidence-
consumption, or finding history.

After bounded read approval, reconcile the carrier and applicability before
minimum live workspace/writer facts and named evidence. Do not scan the whole
repository, crawl old branches, or infer unobservable writers. Route with fixed
precedence:

1. stop safely (`fail closed`) when authoritative or live state is not
   comparable;
2. revise the work contract (`revise Charter`) for material contract,
   permission, effect, acceptance, or carrier change;
3. change how work is coordinated (`change coordination`) for material level,
   role, writer, workspace, delivery, or integration routing change; or
4. continue the existing plan (`resume`) when workstream, contract,
   coordination, authority, and live state align.

Evidence refresh is a prerequisite to resume, not a fifth route. Material
contract, responsibility, carrier, permission, workspace/writer, side-effect,
one-shot, or budget changes return to the user. A new session, elapsed time,
expected correction, planned writer handoff, or authorized refresh does not by
itself require a new Charter.

## Assessment And Advisory Limits

Keep one active execution lane and one repository writer, at most one Planner
and one Executor, and a normally dormant Orchestrator. Planner assessment ends
in exactly `ACCEPTED`, `CORRECTION_REQUIRED`, or `DECISION_REQUIRED`. Keep the
verdict separate from durable recording and bind material evidence to its
mutable subject and invalidation condition.

Bind correction history to the logical Charter subject and material contract
revision, with each verdict tied to a stable checkpoint rather than a task,
Session, root, epoch, attempt, or internal slice. An authorized material
successor or split preserves a predecessor pointer and applicable history.
Declare the consumption point before scarce, one-shot, or time-bound evidence:
pre-consumption qualification does not consume that evidence opportunity, but
a completed independent `CORRECTION_REQUIRED` still consumes its Work Charter
round. Preserve a post-consumption event even when its evidence is later
invalidated. Keep Work Charter correction, delivery/transport, and native-
review budgets independent.

Work Charter may stop its own work, request one-writer restoration, and propose
a new route. It cannot deterministically stop, lock, or reroute another Codex
task, guarantee delivery, or automatically integrate worktrees. Parallel
Executors, automatic worktree routing, and automatic integration remain
deferred.

## Internal Package Boundaries

| Source | Owner |
|---|---|
| [`SKILL.md`](../../../skills/work-charter/SKILL.md) | Selection/read boundary, five-part contract, compact levels/carrier/re-entry workflow, authority, and stop boundary |
| [`coordination-and-recovery.md`](../../../skills/work-charter/references/coordination-and-recovery.md) | Entry/re-entry order, L1/L2 durability, managed workstreams, multi-worktree reconciliation, re-entry precedence, L3, correction, and evidence |
| [`standard-ope.md`](../../../skills/work-charter/references/standard-ope.md) | L4 standing-policy reuse, control location, responsibilities, operating path, and honest degradation |
| [`work-charter.md`](../../../skills/work-charter/assets/work-charter.md) | Optional no-existing-owner durable carrier |
| [`openai.yaml`](../../../skills/work-charter/agents/openai.yaml) | Concise UI metadata and implicit-invocation policy |
| [Work Charter eval cases](../../../evals/README.md#work-charter-v02-staged-matrix-definition) | Direct activation, two-stage indirect entry, project-read authorization, L0-L4, managed resume, four re-entry routes, and negative contracts |

## Independent-Skill Boundary

Work Charter may consume reliable project-document locators but does not
require or invoke Project Docs. Project Docs owns document semantics; Work
Charter owns consequential-work contract, responsibilities, authority,
evidence, recovery, and coordination decisions. PowerShell remains separately
selected for material Windows boundaries. Composition transfers no authority.

## Accepted Basis

- [Decision 0007](../../decisions/0007-independent-skills-and-optional-recipes.md)
- [Decision 0012](../../decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
- [Decision 0016](../../decisions/0016-work-charter-authority-assessment-and-evidence-integrity.md)
- [Decision 0017](../../decisions/0017-capability-delta-skill-development.md)
- [Decision 0018](../../decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md)
