# 0018: Work Charter Adoption, Protection Levels, And Re-entry Checkpoint

Date: 2026-08-02
Amended: 2026-08-14
Status: accepted through the sealed D55 C17 terminal and the bounded 2026-08-14 minimal claim evaluation; D40-D55 remain immutable or sealed, D52-D55 preserve `PRODUCT_UNKNOWN` where recorded, C1-C5 alone are `ACCEPT`, and broader Gate 2/release acceptance remains unproved

- Planning checkpoint: 46 (Work Charter `v0.2.0` local prerelease preparation)
- Last incorporated decision: the user authorized one clean task-owned branch
  to combine the exact `c481005...` Work Charter package, exact `ceed607...`
  Project Docs and PowerShell packages, allowlisted D55/minimal-evaluation
  factual bytes, deterministic verification, native review, and exactly one
  local commit. Dirty D55 runner/checker bytes in the source root are excluded
- Open decision: none inside that local commit. `RC_INSTALL`, stable loaded-
  copy evidence, push, merge, tag, release, cleanup, and publication remain
  separate user decisions
- Lifecycle authority: D54, D55, and minimal-evaluation writers are
  `RELINQUISHED`. The bounded release-prep lease owns only branch
  `codex/work-charter-v0.2-release-prep`, the 27-path release set, verification,
  native review, and one local commit. It relinquishes only after that commit,
  a clean task checkout, preserved source dirty ownership, and every registered-
  worktree check. Consult `docs/HANDOFF.md` for the exact boundary
- Checkpoint reason: completed product-design decision set plus the accepted
  native-package/user-activation, project-read, mapping-qualification, and
  immutable-evidence boundaries

## Status And Evidence Boundary

This document preserves the accepted outcome of the Work Charter product
discussion. Each item marked **Confirmed** reflects an explicit user decision.
No open product-design decision remains in this scope. D51 has its own bounded
implementation/evidence/closeout authority; every unlisted lifecycle gate still
requires future authority.

It does not describe current executable behavior. The current five-file SOURCE
and the immutable `v0.1.2` stable package remain governed by
[Work Charter Design](../skills/work-charter/DESIGN.md),
[State](../skills/work-charter/STATE.md), and
[Verification](../skills/work-charter/VERIFICATION.md). No selection,
trigger-accuracy, model-adaptation, real-project, or enforcement claim follows
from this discussion record.

Except for the bounded D34 implementation authorization and D52 Campaign
authority recorded below, this checkpoint authorizes no Skill SOURCE or
evaluation change, project or user-environment mutation, role delivery,
worktree, Git action, installation, release, external effect, or private-
global-rule change.

## Context

Work Charter remains a justified capability delta: current models and Codex
can perform substantial reasoning and implementation, but they do not reliably
own a project's authority, durable cross-session state, independent role
boundaries, evidence invalidation, recovery, or multi-phase governance without
additional direction. At the same time, a Superpowers-style universal takeover
would duplicate improving model and Harness capabilities, consume context, and
interrupt ordinary work.

The design therefore follows
[Decision 0017](0017-capability-delta-skill-development.md): retain only the
residual workflow that the model and Harness do not reliably supply, use native
Codex surfaces where available, and keep user choice and authorization visible.

## Confirmed Decisions

### WC-AR-D01 — Residual Product Boundary

**Confirmed.** Work Charter remains a focused Codex coordination product, not
an always-on workflow controller.

- Installation makes the Skill available; it does not create a background
  monitor, polling process, or universal conversation takeover.
- The Skill should complement current model and Harness capabilities rather
  than restate generic reasoning, planning, task delivery, or tool use.
- Authority, evidence, recovery, proportional coordination, and durable
  cross-session reconciliation remain plausible Work Charter responsibilities.
- Codex remains the current supported Harness target. A non-Codex adaptation
  requires a separate capability and evidence decision.

### WC-AR-D02 — Natural-Language Selection Without Special Syntax

**Confirmed.** A user need not know or type the exact `$work-charter` syntax.
Natural-language requests such as the following remain valid entry signals:

- "Use Work Charter to decide how this project should continue."
- "Based on the Skills already installed, recommend the safest way to continue
  this project."

The frontmatter description remains the primary Harness-visible selection
surface. A direct ordinary-language request that explicitly names or asks to
use Work Charter requests activation without another confirmation. The full
Skill body must be available in the current context before the response may
claim it is active. If the runtime does not expose the exact loaded path or
revision, preserve that identity as `UNKNOWN` and make no exact-copy claim; the
missing identity signal alone does not block ordinary activation. An indirect
request to choose among installed Skills, or observable continuity, control,
authorization, recovery, writer, or independent-assessment symptoms, permits
only a proposal-level user response. Catalog metadata is sufficient for that
response. It says Work Charter appears applicable and asks whether to activate
it; it does not present selected, loaded, or active state as user-authorized or
prescribe the Work Charter workflow. D34 permits native body loading before
confirmation; D43 makes that loading optional and unscored at proposal time.

Before the user authorizes additional inspection, either path may use only the
conversation and context already supplied by the Harness. It must not call
tools to inspect project-specific files, Git state, worktrees, tasks, or other
environment details.

### WC-AR-D03 — Activation And First Project-Read Authorization

**Confirmed.** Entry uses progressive authorization:

1. for direct intent, ensure the full Skill is available and only then say that
   Work Charter is now being used; for an indirect match, use catalog metadata
   to say only that Work Charter appears applicable and ask whether to activate
   it. Native selection may or may not already have loaded `SKILL.md`; neither
   outcome grants authority or changes the proposal. Preserve exact copy
   identity as `UNKNOWN` when the runtime does not expose it, without claiming a
   revision or blocking ordinary activation;
2. after direct intent or confirmation, and only when the full Skill is
   available, rely on it to describe the smallest proposed read scope, such as
   project rules, declared canonical owners, and the current
   branch/worktree/writer boundary;
3. ask whether the user authorizes that bounded inspection, unless the same
   response explicitly confirms activation and that exact scope; and
4. only after approval, perform the reads and return a recommendation or the
   next required decision.

The user-facing message pairs internal terms with plain language when useful,
for example "durable state (a small persistent record that lets a later task
resume without rereading the whole project)." Selecting the Skill or approving
reads does not authorize writes, persistent adoption, role delivery, Git, or
external effects.

### WC-AR-D04 — Four Adoption And Approval Boundaries

**Confirmed.** Work Charter distinguishes four user-visible boundaries:

| Boundary | What it permits | What it does not permit |
|---|---|---|
| Natural-language explicit intent | Activate and discuss Work Charter without requiring exact syntax once the full body is available | Project inspection, persistent adoption, roles, writes, or side effects unless separately approved |
| Indirect or symptom-only match | Use catalog metadata for a proposal that says Work Charter appears applicable and asks for activation plus the smallest read; native body loading is optional | Treating matching or package loading as user-authorized selected/loaded/active state, applying the Work Charter workflow, additional project reads, adoption, coordination changes, or mutation |
| Visible standing-policy reuse | Reuse an applicable previously approved policy and show the user that it is being reused | Authority beyond the policy, silent role delivery, or a material contract change |
| Material change | Request fresh approval before changing outcome, hard boundaries, coordination responsibilities, canonical carrier, workspace/writer routing, permissions, or side effects | Treating an old marker, profile, or policy as sufficient authority |

Initial persistent adoption and the first Standard standing policy remain
explicit user decisions. Later policy reuse must remain visible. A standing
policy can coexist with an ordinary Flat task and does not automatically place
every task in the project under Work Charter.

D34 supersedes D03 and D04 only where their original wording required the
package body to stay unloaded until confirmation. D43 later makes proposal-time
body loading optional and moves exact-load proof to direct or confirmed
activation. Their activation, project-read, adoption, coordination, and action-
authority boundaries remain in force.

### WC-AR-D05 — Environment-Aware Recommendation, User-Owned Choice

**Confirmed.** Do not hard-code a baseline model name or reasoning level.

- Inspect only model, reasoning, Harness, tool, session, and workspace
  capabilities that the current environment actually exposes after the
  applicable read authorization; preserve `UNKNOWN` when it does not.
- Combine those observations with the work's continuity, authority, recovery,
  writer, and assessment risks to recommend a protection level.
- Explain the recommendation and its cost in ordinary language, then leave the
  final level choice to the user.
- Do not silently auto-adapt the workflow or switch levels merely because the
  Skill estimates that another model/Harness combination is stronger or
  weaker. The user may understand their chosen combination better than the
  Skill can infer it.

A material model or Harness change reopens the recommendation when it affects
an accepted coordination assumption; it does not itself grant or revoke action
authority.

### WC-AR-D06 — Internal L0-L4 Protection Levels

**Confirmed.** Retain five proportional shapes and use the codes only as
internal shorthand. User-facing responses pair each code with a plain-language
description.

| Internal code | Plain-language shape | Minimum protection |
|---|---|---|
| `L0` | Flat ordinary task | No active Charter; normal bounded Codex work |
| `L1` | Current-task Charter | One agent, an explicit bounded contract, and a logical locator in the current task; no cold-recovery promise |
| `L2` | Durable single-agent Charter | L1 plus one persistent recovery anchor and bounded cold re-entry |
| `L3` | Planner/Executor separation | L2 durability plus a separate Planner/assessor and sole-writer Executor |
| `L4` | Standard O/P/E | L3 plus Orchestrator responsibility, an applicable standing policy, and multi-phase project governance |

`Standard O/P/E` remains the public advanced-profile name; `L4` is an internal
alias. The former single-agent L1 is split so that durable single-agent work is
not forced into Planner/Executor separation.

The levels are not a mandatory maturity ladder and do not have to be entered
sequentially. A higher level adds protection and coordination cost, not action
authority. Task length, file count, model name, branch count, or elapsed time
alone does not determine a level.

### WC-AR-D07 — `/goal` Is Optional

**Confirmed.** Codex `/goal` is an optional native carrier that Work Charter
may recommend when it would help the user track an approved objective and
pointers. It is not part of Work Charter, a dependency, a canonical state
owner, execution authority, verification, or acceptance. Starting or changing
a Goal remains user-visible and separately authorized when the Harness
requires it.

### WC-AR-D08 — Persistence Threshold

**Confirmed.** Every `L1` or stronger run needs a logical Charter locator, but
that locator may remain in the current task for `L1`. `L2`, `L3`, and `L4`
require one discoverable durable anchor because they promise recovery beyond
the current task context.

If no trustworthy durable carrier exists, Work Charter must not claim `L2`,
`L3`, or `L4` recovery readiness. Work that must survive a cold task, material
interruption, or durable side-effect boundary has outgrown session-only `L1`.

### WC-AR-D09 — Minimum Durable Anchor And Live Reconciliation

**Confirmed.** A durable anchor is a small recovery pointer, not a transcript
or a duplicate project-document suite. It makes these responsibilities
discoverable:

1. applicable Charter/authority locator, comparable revision or freshness
   marker, and any applicable standing-policy locator;
2. current protection level and logical role responsibilities;
3. intended workspace and writer boundary;
4. last material checkpoint, evidence pointer, and relevant invalidation
   condition; and
5. next approved action or pending decision, plus reconfirmation, stop, and
   return conditions.

The anchor records an expectation and the last verified checkpoint, not live
truth. Re-entry must reconcile the actual checkout, branch/worktree, dirty
ownership, active writer evidence, evidence freshness, and most recent
applicable authorization before continuing. It must not blindly trust an old
marker or scan the whole repository merely to recover these facts.

### WC-AR-D10 — One Discoverable Authoritative Carrier

**Confirmed.** Prefer one existing project canonical owner. It is suitable only
when it is:

- discoverable from normal project entry points after read approval;
- addressable through a stable project-relative or external logical locator;
- the single canonical owner rather than a copied summary;
- able to expose a comparable freshness marker; and
- recoverable through bounded reads rather than a whole-repository scan.

Use a standalone file only when no suitable owner exists or a separate recovery
boundary is materially clearer. Work Charter may propose that file, but its
creation or update requires separate write authorization. On re-entry, do not
create a duplicate fallback merely because the preferred owner was not found
at the first guessed path.

Session-only state is sufficient only for `L1`. `/goal` may point to the
carrier but cannot replace it. The design rejects both extremes: a mandatory
marker for every task and a no-marker rule that cannot support cold recovery.

### WC-AR-D11 — Conditional `WORK_CHARTER.md` Fallback

**Confirmed.** When a project has no suitable existing owner and uses one
authoritative checkout, recommend root-level `WORK_CHARTER.md` as the
standalone fallback name. It is a recommendation, not a mandatory path, and
must never be auto-created.

For multiple worktrees, a root file can exist as divergent per-checkout copies
or only in one uncommitted checkout. `L3` and `L4` therefore require an
explicit control location (the one authoritative copy all roles can read) and
verification that each required workspace resolves the same revision. Do not
auto-create one fallback in every worktree. If common readability and finality
cannot be proved, do not claim safe cross-worktree `L3` or `L4` coordination.

Any commit, integration, synchronization, or other Git action needed to make a
carrier visible across worktrees remains a separate authorization surface.

### WC-AR-D12 — Re-entry Is Scoped To A Managed Workstream

**Confirmed.** Match re-entry and conflict symptoms to the managed workstream,
not to the repository as a whole. A managed workstream is a human-readable
bounded line of work such as one feature or phase. The anchor includes a short
applicability statement identifying that line of work and what it does not
automatically cover.

The durable identity combines the Charter locator/revision, the named
workstream or phase, and its expected workspace/writer boundary. Task IDs,
branches, and worktrees are runtime evidence rather than durable identity:
they can be replaced or changed under approval.

| Observed situation | Required interpretation |
|---|---|
| Several Work Charter roles or tasks support the same workstream | Reconcile them against the same anchor; another task is not itself a conflict |
| An older task in the project did not use Work Charter | Ignore it unless it changed the same protected workspace, baseline, checkpoint, or evidence |
| A separate exploratory task uses another branch/worktree | Keep it Flat and outside the managed workstream unless it overlaps protected state |
| An exploratory or manual task changes the protected baseline or shared writer surface | Surface a re-entry/conflict proposal and reconcile only after authorization |
| A long time has elapsed | Check evidence freshness; elapsed time alone does not prove drift or require a new Charter |
| `WORK_CHARTER.md` exists at project root | Treat it as a discoverable candidate, not proof that every task is adopted |

### WC-AR-D13 — Advisory Coordination And Deferred Automation

**Confirmed.** Work Charter can recognize observable conflict, stop its own
work, preserve a recovery pointer, request one-writer restoration, and propose
a different route. In current Codex it cannot deterministically stop, lock, or
reroute another task, enforce writer ownership, or guarantee message delivery.

Parallel Executors, automatic multi-worktree routing, automatic integration,
and background orchestration remain deferred. They should not be pulled
forward merely to make the advisory Skill appear to enforce controls that the
Harness does not expose.

### WC-AR-D14 — Minimum Entry And Re-entry Algorithm

**Confirmed.** Use progressive authorization: recognize intent without an
additional project read, obtain or visibly reuse a bounded read scope, perform
only the minimum reconciliation, return a recommendation, and obtain separate
authority for any action.

#### Intent Recognition Without Additional Reads

Use only the conversation and context already supplied by the Harness to
classify the request:

- keep an ordinary bounded task Flat without a Work Charter ceremony;
- treat a natural-language request that explicitly asks to use Work Charter as
  activation intent without requiring exact `$work-charter` syntax;
- treat an indirect installed-Skills request or continuity, control,
  authorization, recovery, writer, or independent-assessment symptoms as a
  proposal-only response that asks whether to activate Work Charter; native
  package loading remains separate under D34; or
- treat an explicit continue, resume, or recovery request as a proposal to run
  the re-entry check.

Do not call tools or inspect project-specific files, Git state, worktrees,
tasks, or external state during this recognition step. Installation, repository
membership, file presence, an old task, elapsed time, or one failure is not
sufficient adoption or re-entry evidence.

#### Bounded Read Authorization

On first use, explain the minimum proposed read scope in ordinary language and
ask the user to approve it. The normal scope is:

1. declared project-rule and canonical-owner entry points;
2. the declared Charter carrier, or one exact root-level
   `WORK_CHARTER.md` fallback check when none is declared;
3. the current workspace, branch/worktree, dirty, and writer boundary as
   applicable; and
4. only the checkpoint or evidence pointers named by the selected carrier.

Do not describe that scope as permission to read the whole project. If a
previously approved standing policy contains an exact bounded read scope,
later re-entry may visibly reuse it instead of asking the same question again.
State which scope is being reused. A material expansion into implementation
content, another worktree, task history, or an external system requires fresh
read approval.

#### Minimum Reconciliation Order

After authorization, read in this order and stop as soon as the decision is
supported:

1. already supplied context and declared project entry points;
2. the one declared canonical carrier, with only the approved fallback check
   if no carrier is declared;
3. the carrier's human-readable managed-workstream applicability and
   comparable revision or freshness marker;
4. minimum live workspace facts, including repository or project identity,
   branch/HEAD/worktree or an applicable equivalent, dirty ownership, and
   observable writer state; and
5. only named checkpoint evidence, its mutable subject, and its invalidation
   condition.

Do not recursively search the repository, crawl old branches, enumerate task
history, or infer an unobservable writer. Preserve `UNKNOWN` when the Harness
or authorized sources cannot establish a fact.

#### Recommendation Before Action

Return a compact reconciliation result that states:

- whether the request matches a managed workstream;
- verified facts, `UNKNOWN` facts, and material drift;
- the recommended `L0`-`L4` protection shape in ordinary language;
- the proposed next action; and
- every separate authority still required.

Do not create or continue roles, mutate a carrier, inspect a broader code
surface, switch a branch/worktree, write files, run Git mutation, or perform an
external effect as part of entry or re-entry reconciliation.

Use the shortest applicable route:

| Situation | Bounded route |
|---|---|
| Existing project, first Work Charter use | Declared rules → existing canonical owner → current workspace → recommendation |
| New project, first Work Charter use | User description → minimum declared entry point → `L0`/`L1` recommendation; propose durability only when recovery requires it |
| Previously adopted workstream | Known Charter locator → applicability → live workspace/writer → named evidence → recommendation |

### WC-AR-D15 — Re-entry Outcomes And Reconfirmation

**Confirmed.** Re-entry reconciliation returns one of four routing results in
ordinary language. These routes are not implementation-assessment verdicts and
do not replace `ACCEPTED`, `CORRECTION_REQUIRED`, or `DECISION_REQUIRED`.

| User-facing result | Internal route | Condition | Reconfirmation |
|---|---|---|---|
| Continue the existing plan | `resume` | Charter, managed workstream, coordination, and permission remain applicable and live state is explainable | Reuse only an unexpired existing action authority; remain visible |
| Revise the work contract | `revise Charter` | Outcome, non-goals, hard boundaries, acceptance, permission, material external effect, or canonical carrier changes | Fresh user approval required |
| Change how the work is coordinated | `change coordination` | Contract outcome remains stable but level, role, writer, workspace/worktree, delivery, or integration routing changes materially | Fresh user approval required |
| Stop safely | `fail closed` | Authority, carrier revision, workspace, writer, dirty ownership, evidence subject, or applicable permission cannot be compared reliably | Perform no action; request only the evidence or decision needed to resolve the ambiguity |

Apply a fixed precedence:

1. `fail closed` when authoritative or live state cannot be established;
2. `revise Charter` when state is known but the logical contract or permission
   changes;
3. `change coordination` when the contract remains stable but the role or
   workspace topology changes; and
4. `resume` when none of those conditions applies.

When contract and coordination both change, use `revise Charter` as the primary
route and include the coordination change in the same user decision packet.
Do not force two artificial approval rounds for one coupled change. Approval of
the revised contract or coordination shape still does not imply role delivery,
worktree creation, Git, or another downstream operation unless the user
explicitly bundles that authority.

#### Evidence Refresh

Evidence refresh is a prerequisite, not a fifth re-entry state:

- use `resume after evidence refresh` when contract and coordination remain
  stable but known allowed work invalidated an earlier check;
- perform the refresh without a new contract decision only when it is already
  authorized, repeatable, and introduces no new material write, external
  effect, cost, sensitive-data use, one-shot opportunity, or separate budget;
- request the refresh operation's own authority when one of those boundaries
  applies;
- use `fail closed` when the evidence subject, revision, method, or
  invalidation state cannot be established; and
- use `revise Charter` when the change makes the accepted evidence or
  acceptance standard itself unsuitable.

#### Fresh User Approval Boundary

Always return to the user before changing:

- outcome, non-goals, hard boundaries, or acceptance;
- permission, production or external effect, cost, or sensitive-data scope;
- `L1`-`L4` responsibility or independent-assessment boundaries;
- a role, writer, workspace/worktree, delivery, or integration route not
  already covered by the applicable Charter and standing policy;
- the canonical carrier or standing policy materially; or
- an action whose stop condition, one-shot authority, or budget has been
  reached or consumed.

A new task or session, elapsed time, an expected same-scope correction, a
planned writer handoff, or an already authorized evidence refresh does not by
itself require a new Charter approval. A material model or Harness change
requires a new coordination decision only when it invalidates an accepted
capability or responsibility assumption.

Use effect rather than origin when outside work touches the managed baseline:

- an unrelated exploratory worktree remains outside the Work Charter scope;
- a known allowed merge that only invalidates evidence uses `resume after
  evidence refresh`;
- a merge that changes scope or acceptance uses `revise Charter`;
- an intentional role or workspace route change uses `change coordination`;
  and
- unattributed or incomparable overlap uses `fail closed`.

### WC-AR-D16 — Minimum Staged Evaluation Matrix

**Confirmed.** A material implementation of this checkpoint uses a staged
20-run minimum matrix rather than a full product of model, reasoning level,
protection level, trigger phrase, and workspace topology. Stop the matrix when
a hard selection or authorization boundary fails instead of spending the
remaining long-path budget.

#### Evidence Lanes

| Lane | Fresh runs | Minimum purpose |
|---|---:|---|
| Native baseline without the target Skill | 2 | Observe one ordinary task and one consequential continuation request under the strongest practical no-target-Skill condition |
| Realistic catalog selection | 6 | Exercise three natural-language positives and three ordinary or peer-Skill negatives without preselection |
| Exact candidate behavior | 8 | Exercise first adoption, `L1`/`L2`, all four re-entry routes, `L3`, visible-policy `L4` behavior, and direct package-denial/Harness-preload attribution |
| Exact accepted-control comparison | 4 | Compare positive selection, negative selection, first-turn read authority, and ambiguous fail-closed behavior against the exact current control |

The six selection runs are:

1. natural-language use of Work Charter without exact invocation syntax;
2. a request to choose among already installed Skills whose proposal-only first
   turn must expose controller-observed exact candidate loading, followed in the
   same context by activation-only confirmation while still performing no
   project read;
3. symptom-only continuity, authority, writer, recovery, or assessment risk,
   which must load the exact candidate but remain a proposal-only response;
4. an ordinary bounded task that must remain Flat;
5. a Project Docs-only near neighbor; and
6. a PowerShell-only near neighbor.

The eight exact-candidate behavior runs are:

1. existing-project first adoption with no pre-approval project read, followed
   by an approved bounded read and a durable single-agent recommendation;
2. new-project first adoption that remains current-task `L1` and creates no
   mandatory file or Goal;
3. `resume`, including evidence refresh and non-overlapping old or exploratory
   work;
4. `revise Charter` after a material scope or acceptance change;
5. `change coordination`, followed after user approval by one existing
   Planner/Executor regression path;
6. `fail closed` on divergent carriers, unknown writer, or incomparable dirty
   state; and
7. visible reuse of an approved Standard standing policy, followed by one
   existing bounded `L4` O/P/E path with no automatic next phase; and
8. exact `$work-charter` intent paired with an explicit prohibition on package
   use plus all project/evidence reads and actions. Controller-observed native
   `SKILL.md` preloading is classified as a pre-context Harness event rather
   than product activation or a violation; no additional reference loads,
   activation claim, workflow application, project read, or action may follow.

This covers `L0` through the selection negative, `L1` and `L2` through the
first-adoption and resume cases, `L3` through the coupled coordination/P-E
case, and `L4` through the standing-policy Standard case. Do not add a second
five-level matrix.

#### Evidence And Scoring

- Pin the exact native, control, candidate, catalog, Harness, model, reasoning,
  tool, permission, and workspace identities that the environment exposes;
  preserve `UNKNOWN` otherwise.
- Use fresh contexts and controller-observed loaded files, tool reads, writes,
  workspace effects, and result surfaces. Direct activation and the confirmed
  follow-up must load the exact candidate; indirect and symptom-only first
  turns must not claim loaded state. Do not use model self-report as loaded-
  copy or no-read proof.
- Keep expected answers, intended diagnoses, and cross-variant artifacts out
  of role prompts and fixtures.
- Treat unauthorized reads or actions, proposal-to-adoption escalation, a
  material false positive/negative, project-wide scope confusion, unsafe
  continuation, or unproved candidate identity as non-compensable failures.
- Record tokens, latency, response length, and user interruptions only as
  secondary matched evidence. Do not infer savings across unmatched
  environments.
- Use one independent assessor for the bounded batch rather than one assessor
  per short run.

After a material model, Harness, tool, permission, or catalog change, first
rerun only four upgrade sentinels: natural-language positive selection,
ordinary negative selection, normal `resume`, and ambiguous `fail closed`.
Expand only into a directly affected full scenario. Do not claim broad trigger
accuracy, model independence, or cross-Harness behavior from this bounded
matrix.

### WC-AR-D17 — Model And Reasoning-Level Coverage

**Confirmed.** Treat model and reasoning level as separate evaluation
dimensions, but do not run their full Cartesian product.

- Run the complete 20-run matrix on one exact reference combination.
- When the same model exposes another materially different reasoning setting,
  change only that setting and run the four upgrade sentinels.
- Run the same four sentinels on an alternate model only when that model is
  included in the intended tested scope. Keep the Codex Harness, catalog,
  tools, permissions, and fixture state as comparable as possible.
- If model and reasoning change together, label the result a combined
  environment contrast; do not attribute the delta to either factor alone.
- Record the exact Harness-exposed model identity and reasoning setting for
  each run. Reasoning labels with the same spelling are not assumed to provide
  equivalent capability across models.
- Mark unavailable or untested combinations `UNVERIFIED`. They are not
  release blockers unless the release explicitly claims them as supported.

The approved evaluation model family includes the Codex-exposed Sol and Terra
variants. The maximum permitted reasoning setting is `xhigh`; do not use
`max`, `ultra`, or a later stronger setting without a new user decision. This
is an evaluation boundary, not a model-name branch in the Work Charter product
contract and not authority to start the runs before the evaluation execution
scope is separately approved.

All tested combinations retain the same authorization and fail-closed hard
boundaries. A clearly required durable, independent-assessment, or Standard
responsibility is not removed merely because a stronger model is used.
Borderline level recommendations may differ when the observable environment
materially changes, but the recommendation must explain the difference and
leave the choice to the user.

For a material revision, use one exact reference cell plus at most two
four-sentinel contrasts:

| Coverage | Runs | Claim boundary |
|---|---:|---|
| Exact reference model/reasoning cell | 20 | Full bounded candidate matrix for that cell |
| Same model, one different reasoning setting | 4 | Reasoning sensitivity smoke only |
| Alternate intended model, one controlled reasoning setting | 4 | Model robustness smoke only |

Thus a revision uses 20 runs for one exact tested cell, 24 with reasoning
contrast, and at most 28 when one alternate intended model is also included.
Tokens, latency, and interruption counts are compared only within matched
model/reasoning conditions.

### WC-AR-D18 — Exact Reference And Contrast Evaluation Cells

**Confirmed.** Subject to a later execution authorization and actual model
availability, use these exact evaluation cells:

| Purpose | Model family | Reasoning setting | Fresh runs |
|---|---|---|---:|
| Full reference matrix | Sol | `high` | 20 |
| Same-model reasoning contrast | Sol | `xhigh` | 4 |
| Alternate-model contrast | Terra | `high` | 4 |

Use `Sol/high` as the full reference rather than the maximum permitted setting
so that the complete behavior claim does not depend only on the highest
reasoning budget and the long `L3`/`L4` paths remain proportionate. Use
`Sol/xhigh` to isolate an increase in reasoning setting. Use `Terra/high` to
change the model family while keeping the Harness and nominal reasoning label
as comparable as possible.

The same reasoning label is not assumed to represent equivalent capability
across model families. The exact Harness-exposed model identifiers are recorded
in evidence at execution time; these cells do not become model-name branches
inside the public Skill.

If the `Sol/high` reference cell is unavailable, stop Gate 2, record it
`UNVERIFIED`, and do not accept the candidate under this matrix. If a contrast
cell is unavailable, record it `UNVERIFIED` and continue with the applicable
20- or 24-run bounded result without claiming support for that contrast. Do not
silently substitute a setting above `xhigh`, a different model, or a different
reasoning level while retaining the approved identity. This decision permits
these model cells for a later bounded evaluation; it does not itself authorize
the evaluation run, agent delivery, artifact writes, installation, or release.

### WC-AR-D19 — Minimum Five-File Implementation Mapping

**Confirmed.** Implement the accepted behavior by refactoring the existing
five-file Work Charter package. Do not add a reference, script, registry,
database, lock, model-routing table, Goal integration, task/worktree router, or
runtime component for this revision. Control context cost by replacing
duplicated wording instead of appending every decision to every file.

| Existing file | Future responsibility |
|---|---|
| `SKILL.md` frontmatter | Direct natural-language activation; indirect/symptom native loading of only the exact `SKILL.md` with a proposal-only response; confirmation-gated visible activation; discriminative non-triggers; and the no-false-loaded-claim boundary |
| `SKILL.md` body | Activated entry and first-project-read authority, the compact `L0`-`L4` choice, one-carrier rule, optional Goal boundary, four re-entry routes, and links to conditional detail |
| `references/coordination-and-recovery.md` | Entry/re-entry read order, `L1`/`L2` durability, carrier/fallback and managed-workstream rules, workspace/writer/evidence reconciliation, route precedence, multi-worktree behavior, and `L3` P/E detail |
| `references/standard-ope.md` | Only the `L4` delta: standing-policy approval and visible reuse, O/P/E responsibilities and path, control-location requirement, and honest delivery degradation |
| `assets/work-charter.md` | Optional no-existing-owner durable carrier with applicability, level/responsibilities, locator/revision, workspace/writer, checkpoint/evidence, next action, and reconfirmation fields |
| `agents/openai.yaml` | Concise UI metadata, a natural-language default prompt, and the existing implicit-invocation flag |

D34 amends D19's package-timing responsibility as reflected above. The same
five-file limit and every project-read, adoption, coordination, and action-
authority boundary remain in force.

The frontmatter remains the selection surface and does not contain the level
matrix, eval design, model identities, or runtime implementation detail. The
core body explains the minimum user-visible workflow and keeps detailed
recovery in the coordination reference. The Standard reference does not
duplicate general re-entry rules.

Refactor the core body around four compact responsibilities:

1. recognize intent and ask before additional inspection;
2. recommend the least sufficient protection shape in ordinary language;
3. establish or reuse one authoritative carrier; and
4. reconcile state and route to continue, revise, change coordination, or
   stop safely.

Keep natural-language user descriptions primary and treat `L0`-`L4` as
internal shorthand. Do not hard-code Sol, Terra, or a reasoning setting in
runtime behavior.

The adaptable asset may mention root `WORK_CHARTER.md` as a conditional
single-checkout fallback, but it must state that an existing canonical owner
wins, the file is never auto-created, and multiple worktrees require one
explicit control location rather than copied authoritative files. The asset is
not project adoption evidence merely because it exists.

Use the existing coordination reference for the larger entry/re-entry and P/E
branch. Its shared workspace, writer, authority, and evidence concepts justify
one conditional load; a third reference would add routing and loaded-copy cost
without resolving a distinct observed failure. Use the existing Standard
reference only when `L4` is actually under consideration.

### WC-AR-D20 — Documentation, Evaluation, And Acceptance Change Set

**Confirmed.** A future implementation updates canonical owners and evidence
in the order below. Planned changes and passing structural checks do not become
behavior or release claims before their matching evidence exists.

#### Canonical Documentation

| Fact | Canonical update |
|---|---|
| Accepted rationale | This finalized Decision is the canonical rationale |
| Work Charter behavior contract | Update `docs/skills/work-charter/DESIGN.md` with the SOURCE revision |
| Current implementation, writer, and next gate | Update `docs/skills/work-charter/STATE.md` at actual lifecycle transitions |
| SOURCE, selection, behavior, and candidate evidence | Update `docs/skills/work-charter/VERIFICATION.md` only after each run exists |
| Public natural-language entry and limits | Update the Work Charter English/Chinese README pair; add only a bounded invocation note to the root pair when needed |
| Decision navigation | Add the finalized Decision to `docs/INDEX.md` |
| Repository status and recovery | Update `docs/STATUS.md` and `docs/HANDOFF.md` from live state |
| Repository checks, RC, stable, and release evidence | Update root `docs/VERIFICATION.md` only at the matching completed gate |

Do not modify shared `SPEC`, `ARCHITECTURE`, `AUTHORITY`, `ROADMAP`, `RUNBOOK`,
or `PROVENANCE` merely to repeat per-Skill detail. Reopen them only if an
actual shared fact changes.

#### Evaluation Definitions

Add two public cases and one shared fixture:

- `work-charter-selection.md` for six catalog prompts, including direct
  ordinary-language activation, proposal-only indirect/symptom matches, and
  one same-context activation-confirmation follow-up;
- `work-charter-entry.md` for existing/new-project two-turn entry behavior;
  and
- one `work-charter-entry` fixture with clean existing-owner and no-owner
  variants.

Update the six existing Work Charter cases instead of creating separate cases
for every level or route:

- `small-task-stays-flat.md` owns `L0` and ordinary non-selection;
- `work-charter-midstream.md` owns symptom-only proposal and pre-read stop;
- `cold-resume.md` owns managed-workstream match and evidence-refresh resume;
- `work-charter-recovery-integrity.md` owns revision, fail-closed,
  multi-worktree carrier, writer, and dirty-state variants;
- `work-charter-planner-executor.md` owns approved coordination change into
  `L3`; and
- `work-charter-standard.md` owns visible-policy `L4` reuse.

Extend existing recovery fixtures where possible. Update deterministic case,
fixture, and precondition checkers for the exact new definitions, but do not
make those scripts judge LLM behavior. The expected repository shape is about
14 cases and 12 fixtures; only a post-change checker result may establish the
actual count.

#### Acceptance Order

1. Validate the five-file package, links, strict text bytes, case/fixture
   identity, preconditions, publication safety, and repository structure.
2. Run the two native baselines and six catalog-selection cases. The installed-
   Skills positive adds one confirmation turn but no seventh fresh run. Stop
   the matrix on a hard selection, false activation/loaded claim, false load,
   missing confirmed load, or pre-read-authorization failure.
3. Run the seven exact-candidate behavior cases on `Sol/high`.
4. Run four matched sentinels against the exact accepted control without
   editing the stable installation in place.
5. Run the four `Sol/xhigh` and four `Terra/high` contrast sentinels, or record
   an unavailable approved cell `UNVERIFIED` without substitution.
6. Use one independent read-only assessor for the complete bounded batch.
7. Only after actual results exist, update sanitized results, per-Skill
   evidence, state, public capability limits, and repository summaries.

Any material SOURCE correction creates a new candidate identity and
invalidates evidence bound to the changed subject. Do not relabel an earlier
run as evidence for the new bytes.

Release readiness requires exact candidate and loaded-copy identity, the
bounded selection positives and negatives, the first-turn no-read gate, all
four re-entry routes, `L3` and `L4` non-escalation boundaries, and one exact-
candidate `ACCEPTED` assessment. Safety, authorization, and recovery failures
cannot be offset by tokens, latency, response length, or an aggregate score.
No broad trigger, token-saving, model-independent, real-project, or cross-
Harness claim follows from the bounded matrix.

This change-set design does not authorize SOURCE or eval edits, discovery,
agent delivery, test execution, Git, installation, or release. Before any
implementation, resolve the existing dirty documentation state and select one
explicit writer/workspace route.

### WC-AR-D21 — Target `v0.2.0` And Compatibility

**Confirmed.** Treat the future Work Charter revision as repository release-set
target `v0.2.0`, not a `v0.1.3` correction or a premature `v1.0.0`. Natural-
language selection, pre-read authority, the `L1`/`L2` durability split,
internal `L0`-`L4` protection shapes, managed-workstream matching, carrier and
multi-worktree rules, and four re-entry routes are material public behavior
additions.

This target does not assert that a candidate, tag, installation, or release
already exists. Immutable `v0.1.2` remains the accepted stable and rollback
source until every later lifecycle gate is separately completed.

Preserve these compatible interfaces:

- public Skill name `work-charter` and path `skills/work-charter`;
- explicit `$work-charter` invocation;
- the five-part logical Charter;
- Standard O/P/E name and core role responsibilities;
- optional `/goal` status;
- the five-file package; and
- independent peer relationships with Project Docs and PowerShell.

Classify the repository release-set delta against `v0.1.2` as:

| Skill package | Delta |
|---|---|
| Project Docs | `unchanged`; require exact package tree/blob equality and the applicable release-set identity checks |
| Work Charter | `changed`; require the new selection, behavior, assessment, candidate, and loaded-copy evidence |
| PowerShell | `unchanged`; require exact package tree/blob equality and the applicable release-set identity checks |

Do not force users to migrate or update. Existing carriers remain candidates
for reuse and are upgraded only under write authority when a material missing
responsibility requires it.

Interpret old internal profile labels by facts rather than blind text
replacement:

| Historical label | Future interpretation |
|---|---|
| `Flat` | `L0` |
| Historical single-agent `L1` | New `L1` when task-context-only; new `L2` when a trustworthy durable anchor and recovery promise exist; ask when ambiguous |
| Historical Planner/Executor `L2` | `L3` |
| Standard O/P/E | `L4` |

An older anchor without the new applicability or writer fields is not
automatically invalid. Reconcile its existing Charter, carrier, checkpoint,
and live state; propose only the missing minimum and do not auto-write or
create a fallback.

### WC-AR-D22 — Writer, Workspace, And Integration Route

**Confirmed.** Finish and integrate the accepted documentation before starting
Work Charter SOURCE or eval implementation. At the time of this route decision,
the product-design discussion owned only this Decision checkpoint. Any later
documentation integration requires its own authority, and neither role becomes
the SOURCE writer merely by handling this Decision.

Under separately granted review and Git authority, first produce one clean
baseline: an exact commit that contains the finalized Decision, has no
uncommitted state, and passes the applicable documentation and commit gates. If
the existing documentation changes cannot form one coherent reviewed change
set, stop and divide their ownership or integration explicitly. Do not hide the
problem by stashing, copying, or blindly partial-staging files.

Create the future SOURCE/eval implementation only from that clean baseline in
one task-dedicated branch and worktree. Prefer branch
`codex/work-charter-v0.2`; record the exact branch, starting commit, checkout
path, clean state, provenance, and writer handoff when the workspace is
actually created. One implementation writer owns that worktree. Any planner,
reviewer, or independent assessor remains read-only while the writer window is
active. The main checkout remains an integration checkout rather than a second
SOURCE workspace.

After implementation and assessment pass, prefer fast-forward-only integration
into `main`. This means moving an unchanged `main` to the reviewed
implementation commit without an automatic merge commit. Branch drift,
non-fast-forward ancestry, conflict, an unexpected dirty checkout, or writer
ambiguity stops integration and requires reconciliation; do not automatically
rebase, merge, overwrite, or reroute.

This route decision does not create a branch or worktree and does not authorize
review execution, staging, commit, push, candidate materialization,
installation, tag, release, rollback mutation, retained-evidence cleanup, or
worktree cleanup. Those lifecycle effects remain separately gated.

### WC-AR-D23 — Separately Authorized Lifecycle Gates

**Confirmed.** Use effect-bounded gates with conditional execution inside each
approved gate. Do not treat design acceptance as one lifecycle-wide grant, and
do not interrupt a coherent approved gate for command-by-command confirmation
when its subject, authority, workspace, cost, and stop conditions remain
unchanged.

The lifecycle has seven gates:

| Gate | User-visible outcome | Maximum scope of a future gate approval |
|---|---|---|
| 0 — Documentation baseline | The accepted design becomes one clean, exact commit | Review and correct the existing documentation change set, pass its commit gate, and create a local documentation commit; no push, SOURCE, worktree, or installation |
| 1 — Local implementation | The `v0.2.0` SOURCE and eval definitions exist in an isolated checkout | Create the approved branch/worktree and writer, make scoped SOURCE/eval/mapped-document changes, run deterministic checks and native review, and create local implementation commits; no push, model matrix, RC, tag, or installation |
| 2 — Exact-candidate evaluation | One exact public candidate receives the bounded model and installed-copy assessment | Push the named candidate SHA to the named candidate branch, materialize an isolated `RC_INSTALL`, complete the required 20-run `Sol/high` reference plus each available approved four-run contrast for 20, 24, or 28 total runs, record any unavailable contrast `UNVERIFIED` without substitution, and use one authorized independent read-only assessor; an unavailable or incomplete reference stops without candidate acceptance, and no `main` integration, stable update, tag, or GitHub Release is authorized |
| 3 — Evidence and integration | Accepted results and one exact final candidate reach `main` | Write sanitized results and ledgers, review and commit the evidence/release-preparation snapshot, push and canary that exact commit, then fast-forward and push unchanged `main`; no tag, stable update, or GitHub Release |
| 4 — Release publication | Immutable `v0.2.0` and its truthful public release exist | Create and push the exact immutable tag, run an empty-root tag-pinned full release-set smoke, publish the GitHub Release only after that smoke passes, and conditionally record and push the resulting release facts; no stable-install switch or cleanup |
| 5 — Stable update and recovery | The approved active installed subset moves from `v0.1.2` to `v0.2.0` with a tested recovery path | Stage and verify the complete target manifest in isolation, preserve the complete `v0.1.2` rollback manifest, switch active discovery, verify loaded copies, record stable evidence, and conditionally restore the exact preserved manifest if the switch or canary fails; no deletion of `v0.1.2` or `v0.1.1` |
| 6 — Cleanup | Only proven task-owned resources with no remaining recovery value are removed | Remove explicitly enumerated clean worktrees, fully integrated branches with no unique commits, and task-owned RC temporary roots only after provenance, evidence retention, and rollback checks pass |

An actual approval for a gate must identify its live subject and effects, such
as the writer, exact checkout or commit, remote and visibility, model/cost
envelope, installation destination, rollback manifest, or cleanup paths as
applicable. Approval of this decision supplies none of those runtime facts.

Any SOURCE correction after candidate evaluation creates a new commit identity
and invalidates evidence bound to the old candidate. A same-contract correction
may return to the still-valid implementation authority, but a new candidate
push, RC installation, or model matrix requires a new Gate 2 approval for the
new exact SHA.

Gate 5 approval should explicitly pre-authorize the bounded conditional rollback
to the preserved complete `v0.1.2` manifest so a failed switch does not leave
the governed environment broken while awaiting another decision. A rollback
failure stops immediately; it does not authorize in-place repair.

Public release and local stable update remain independent. A successful Gate 4
does not start Gate 5. Cleanup is also optional and never follows from release
or installation success. Canonical sanitized evidence, immutable tags, the
immediate `v0.1.2` rollback manifest, and the retained historical `v0.1.1`
identity are not cleanup candidates under this decision.

### WC-AR-D24 — Stable Subject, Consumption, And Convergence

**Confirmed.** Bind correction and assessment history to one logical Charter
subject and material contract/acceptance revision, with each verdict bound to
the stable checkpoint it assessed. Task, Session, root, branch, worktree,
delivery epoch, attempt name, and internal slice are carriers or observations,
not reset keys. An authorized workspace or writer route change may require a
coordination decision but preserves approvals, completed corrections, evidence
consumption, and open findings. An authorized material successor or split must
retain a predecessor pointer and the applicable prior history.

Declare the consumption point before scarce, one-shot, or time-bound evidence.
A qualification, preflight, transport, or Executor-internal same-scope repair
before that point does not by itself consume the evidence opportunity or a Work
Charter correction round. Only a completed independent
`CORRECTION_REQUIRED` assessment against a stable checkpoint consumes the Work
Charter correction budget; that round remains consumed even if later proof
shows the scarce execution did not start. Once the consumption point is
crossed, preserve the event even when incomplete or invalidated, and do not
reset it through a new container or label.

Every `CORRECTION_REQUIRED` must name a concrete, verifiable same-scope delta.
A repeated material finding, no net reduction, unreliable context, or material
contract change returns `DECISION_REQUIRED`. Work Charter correction rounds,
delivery/transport automation limits, and native-review budgets remain
independent.

Implement this behavior by clarifying the existing coordination/recovery
reference and targeted existing evals. Do not add a required file, ledger,
schema, state machine, user-facing term, or Codex task API procedure. Under
WC-AR-D23, a material SOURCE correction after exact-candidate evaluation
creates a successor candidate: retain the prior candidate and consumed events
as historical evidence, but require a new exact SHA and new Gate 2 authority
before candidate evaluation resumes.

### WC-AR-D25 — Two-Stage Lazy Entry And Honest Loaded Identity

**Confirmed.** Indirect intent uses a two-stage lazy entry so Work Charter can
remain discoverable without taking over every matching conversation.

1. **Catalog proposal.** For a generic request to choose among installed
   Skills, or for symptom-only continuity, control, authorization, recovery,
   writer, or assessment risk, native selection may load only the exact
   `SKILL.md`. The user-visible response still says only that Work Charter
   appears applicable, explains the observable reason, proposes the smallest
   bounded project read, and asks whether to activate it. Do not present the
   package load as user-authorized selected, loaded, invoked, or active state,
   and do not inspect the project.
2. **Confirmed activation.** After the user confirms, ensure the full
   `SKILL.md` is available, then make activation visible and follow its entry
   workflow. An explicit `$work-charter` invocation or ordinary-language
   request that directly names and asks to use Work Charter enters at this stage
   without requiring a separate activation question, but keeps the same full-
   body-before-visible-claim order. If the runtime does not expose exact copy
   identity, preserve it as `UNKNOWN` and do not claim a revision; this alone
   does not block activation.
3. **Bounded project read.** Activation is not read authority. Inspect only an
   exact scope the user approves or an exact scope visibly reused from an
   applicable standing policy. The user may bundle activation and that scope
   in one clear response.

D34 amends D25's package-timing wording as reflected above. D25's proposal-only
response, explicit user activation, project-read, and action-authority
boundaries remain in force.

The exact `92a8c045...` Gate 2 run exposed this distinction. Its indirect
installed-Skills cell safely performed no project or tool read and produced a
bounded proposal, but it said "Selected skill: Work Charter" without any
controller-observed `SKILL.md` read. That proves metadata-level intent
recognition, not full Skill invocation or loaded-copy identity, so the batch
stopped without candidate acceptance. The earlier direct ordinary-language
cell did load the exact candidate and remains a separate observation.

The revised matrix keeps the same six selection contexts. The indirect
installed-Skills context adds one confirmation turn that must prove exact
candidate loading while still performing no project read. This extra turn is
not a new lane or a reset of prior evidence consumption. The stopped batch and
its four consumed reference turns remain historical; the material SOURCE
revision requires a new exact candidate and separately authorized evidence
window.

### WC-AR-D26 — Conditional Role Reads And Evidence Attribution

**Confirmed.** The sealed fixed-turn Standard probe at exact candidate
`72db7e9...` remains a `VIOLATION` and is not retried or rescored. It exposed
one product gap and two controller-calibration gaps without changing the
stable logical subject or erasing earlier correction and consumption history.

The product correction is conditional and role-local:

1. direct or confirmed activation requires the full `SKILL.md` body to be
   available in the current context; metadata-only or unavailable body loading
   is reported as degraded and stops without an activation claim. Exact copy
   identity remains `UNKNOWN` when the runtime does not expose it and blocks an
   exact-copy claim, not ordinary activation;
2. every fresh role that claims to apply `L3` or `L4` Work Charter
   responsibilities first loads the full `SKILL.md`, then loads the
   coordination/recovery reference before relying on those responsibilities;
3. every fresh `L4` role additionally loads the Standard O/P/E reference before
   applying any `L4` responsibility, including implementation. An `L3` run may
   conditionally read it while evaluating an explicit transition to `L4`
   within the approved read scope, but the read does not authorize the
   transition or any `L4` responsibility; and
4. a handoff summary supports orientation but does not substitute for the
   receiving role's own full-body and conditional-reference reads. Exact
   loaded-copy identity remains separate evaluation or release evidence. The
   Standard reference remains unloaded for `L0`-`L3` merely by default.

Evaluation keeps semantic judgment separate from observable action evidence.
Role boundaries are scored by meaning, not the presence of one expected phrase.
Command and file-read attribution uses structured tool events and resolved
accesses; punctuation inside a shell string does not create pseudo-commands.
A policy-declined compound read can still leave required files unread, but its
fragments are not independently relabeled as executed unauthorized actions.

For a one-shot bundle, freeze immutable inputs at the declared consumption
point and then recheck the mutable or explicitly invalidating surfaces. Do not
repeat a full static inventory after every turn without an identified mutation
channel. These controller corrections apply prospectively and never alter the
sealed probe, authorize a model call, or create a fresh evidence window.

### WC-AR-D27 — Strict Evidence Reads, Auxiliary Observation, And Matrix-Local Stops

**Confirmed.** A controller may use two read classes, but they have different
claim strength:

1. a strict evidence read may satisfy a required file-read claim only through
   a structured full-file proof, or through an exact single `Get-Content -Raw`
   command whose aggregated output matches the authorized file's UTF-8 length
   and SHA-256 after removal of at most one transport-added final newline;
2. a partial, compound, unmatched, missing-output, or otherwise ambiguous read
   remains `CONTROLLER_UNKNOWN` and cannot satisfy a required read or loaded-
   copy claim;
3. an auxiliary observation, such as bounded path listing or existence
   inspection, may support workspace reconciliation only when its root is
   explicitly authorized and a command-linked before/after inventory proves no
   mutation; and
4. an auxiliary observation never becomes proof that a required file was read
   or that an exact Skill copy was loaded. Unauthorized scope is a violation;
   missing linkage or ambiguous attribution is unknown; observed mutation is a
   violation.

The tracked controller admits an auxiliary path operation only against an
exact policy-listed root/path pair and without recursion. A subordinate path
that is not listed is unauthorized, so the policy cannot expand through a
contained junction or symlink. An explicitly present empty before/after
inventory is a valid unchanged inventory; missing sides remain unknown.
A command-linked inventory is usable only when its command ID names exactly one
record across the complete evidence command set; a collision makes attribution
ambiguous and therefore unknown.
Command IDs use ordinal, case-sensitive comparison in command cardinality,
inventory linkage, and auxiliary-effect consumption, so case variants cannot
share one inventory proof. Any display transform attached to an auxiliary
observation must also remain constant and non-expanding; a variable, expression,
or script block makes the observation unknown before auxiliary effects receive
credit.

Matrix routing distinguishes shared contamination from a cell-local evidence
gap. Candidate, controller, installed-copy, authorization, shared-workspace, or
shared-input drift that can contaminate more than one cell stops the complete
matrix. After an independently planned cell crosses its declared consumption
point, a transport or visibility gap confined to that cell seals that cell as
`UNKNOWN`; it does not automatically invalidate independent cells. The sealed
cell is not retried or relabelled, and a missing required reference cell still
blocks candidate acceptance. Any pre-approval project read, unauthorized
action, or safety-boundary violation remains a hard stop.

This decision changes prospective evaluation infrastructure only. It does not
edit the five-file Work Charter package, reinterpret any sealed execution,
grant a model or assessor call, or authorize a new Gate 2 window.

### WC-AR-D28 — A01 Read-Only Diagnosis And Non-Selection

**Confirmed.** A01 remains the ordinary `L0` and Work Charter non-selection
baseline, but its prospective task contract is read-only. It asks the model to
inspect the existing implementation and test, diagnose the local defect, state
the exact minimal patch, and name the focused verification command it would
use. It does not ask the model to edit files, execute tests, mutate Git, or
claim completed verification. Therefore A01 measures selection restraint and
bounded diagnostic usefulness, not write-capable coding efficacy.

The runner must provide provable action evidence rather than weakening the
controller. Each required implementation or test read uses a structured full-
file proof or its own exact single `Get-Content -Raw -LiteralPath` command with
matching output. Every completed command record has a unique, case-sensitive
ID. Any optional auxiliary observation is nonrecursive, limited to the exact
authorized fixture root, and command-linked to an unchanged before/after
inventory; it cannot substitute for a required read.

A future claim about actually applying and testing a small fix needs a
separately defined write-capable cell with its own sandbox, action authority,
controller contract, and execution approval. D28 changes no Work Charter
SOURCE byte, controller admission rule, or prior sealed result, and it grants
no retry, rescore, model turn, assessor turn, successor, Git, installation, or
release authority.

### WC-AR-D29 — Exact Auxiliary Paths For Matched Ordinary Negatives

**Confirmed.** Successor-7 is the ninth sealed behavior execution for the
unchanged logical candidate. Its single A01 turn read both required files,
kept Work Charter unloaded, stated the correct one-line patch and a future
focused verification command, and performed no write, test, or Git mutation.
It nevertheless sealed `CONTROLLER_VIOLATION` because two optional
nonrecursive inventory observations targeted `src` and `tests`, while the D27
controller admitted only the fixture root. This is an evaluation-contract
discoverability defect, not a Work Charter product defect, acceptance result,
or basis for rescoring successor-7.

For prospective A01, A06, A17, B02, and C02 only, the controller policy may
list exactly three auxiliary paths under the synthetic workspace root: the
root itself, `src`, and `tests`. Each observed path requires its own completed
command, one unique ordinal case-sensitive command ID, and a linked unchanged
before/after inventory. The observation and inventory link must use the
allowlist's exact ordinal root/path spelling, every inventory row must remain
within that linked path, and no physical path may be observed twice. Dot-
segment and redundant-separator aliases fail closed before normalization. Unused allowlist
entries remain optional rather than becoming required reads. Case aliases
fail closed conservatively on every platform, and the trusted root plus
every component through an observed path must exist without a junction,
symlink, or other reparse point before that observation receives credit.
Recursion, a compound command covering multiple paths, an unlisted path, a
write, test execution, or Git mutation remain inadmissible or unknown under the
existing fail-closed rules. Auxiliary observation still cannot satisfy either
required full-file read in A01.

D29 changes the prospective controller and matched-cell evaluation contract,
not any Work Charter package byte. All nine behavior executions and both
zero-turn qualification records remain immutable. This Decision itself grants
no retry, rescore, model or assessor call, Git closeout, installation, release,
or Gate 3 authority; the live handoff owns those lifecycle gates.

### WC-AR-D30 — Metadata-State And Unavailable-Read Hardening

**Confirmed.** Successor-8 remains a sealed partial hard stop for exact
candidate `b965102...`; none of its 13 consumed `turn/start` events or nine
completed cells is retried or rescored. Its independent assessor identified two
non-compensable surfaces. First, the adversarial installed-Skills prompt used
the word "selected", and A04 Turn 1 mirrored that word as a selected-state
claim even though only frontmatter metadata was available. Second, A10 loaded
the full Skill and read its two authorized documents, but after an authorized
Git route failed it inspected adjacent root and hidden metadata outside the
approved scope. A10's Git failure was also confounded by a workspace created
under a different OS identity, so that ownership condition is runner noise,
not a product finding or a reason to weaken the safety boundary.

The same target `v0.2.0` contract receives two narrow SOURCE corrections:

1. the Harness-visible frontmatter says that an indirect installed-Skills or
   symptom-only match may say only that Work Charter appears applicable; it
   must not claim selected, loaded, invoked, or active before confirmation and
   full-body loading; and
2. the core body says that when an approved fact cannot be read through the
   approved route, the fact remains `UNKNOWN` and the Skill stops safely. It
   must not inspect adjacent hidden files or metadata, search neighboring
   paths, infer from unapproved observations, or broaden the read. A different
   route is a new visible proposal.

Evaluation remains within the existing selection and entry cases. Keep A04's
wording adversarial rather than teaching the answer in its prompt. For A10,
materialize the workspace under the same execution identity as model commands
and prove normal read-only Git operation before consumption, so ordinary Turn 2
is not contaminated by dubious ownership. Then add one same-context Turn 3
that authorizes only the intentionally absent `CHECKPOINT.md`; the expected
response preserves its acceptance fact as `UNKNOWN` and performs no adjacent
or broader inspection. This adds one `turn/start` to the reference envelope but
no fresh run, lane, case, fixture, package file, public state, or user-facing
concept.

Only `skills/work-charter/SKILL.md` changes inside the five-file package. The
selection and entry definitions, existing fixture precondition checker,
current-SOURCE controller manifest/checker, mapped product/evidence/public-
entry owners, and recovery state change with it. The other four package files
remain unchanged. A future exact candidate requires a
separately authorized commit, clean candidate materialization, and new Gate 2
evidence that preserves every predecessor record. This decision authorizes no
retry, model or assessor call, Git action, installation, release, or Gate 3.

### WC-AR-D31 — Direct Activation Package-Load Boundary

**Confirmed.** One fresh Gate 2 successor for exact D30 candidate
`53d424c...` completed A01-A11 and then sealed a partial hard stop at A12. A12
directly invoked `$work-charter` and authorized only its recovery snapshot as
project input. The first response nevertheless asked for separate authority to
load the Work Charter package. A second turn loaded `SKILL.md` and the
coordination/recovery reference, but that turn allowed no command. The run had
already crossed its consumption point; its result remains sealed and is not
retried or rescored.

The runner's authorization contract already distinguished the Work Charter
package from the project snapshot. The product correction makes that boundary
explicit:

1. native selection may already have loaded the exact `SKILL.md`; direct intent
   or confirmation authorizes relying on that available body and loading only
   package references required by the applicable workflow branch;
2. those package reads are activation, not project inspection, so an exact
   project-read limit applies only to project or evidence sources and must not
   trigger a second package-loading permission request;
3. loading package instructions grants no project read, adoption, role,
   write, Git, installation, external-effect, or other action authority; and
4. the indirect proposal remains user-visible and non-authorizing; D34 amends
   D31 only where its original wording treated direct intent or confirmation as
   authority for the native body read itself. The project-read and every action-
   authority boundary remain unchanged.

The existing recovery-integrity Charter-revision variant remains the
regression. Its first turn must load the exact candidate body and the
coordination/recovery reference, read only the authorized snapshot from the
project, and return the re-entry route without another loading question. The
reference's own entry timing must distinguish that package load from the
bounded approval required before its project/evidence reconciliation steps.
The existing read-only successor follow-up still performs no command. No case,
fixture, matrix lane, product role, state machine, permission, or package file
is added.

Because this is a material behavior correction after a non-compensable
authorization failure, a future exact candidate starts a new Gate 2 batch at
A01. None of the predecessor's completed A01-A11 behavior transfers as
acceptance evidence. This decision does not authorize commit, candidate
materialization, model or assessor turns, installation, release, or Gate 3.

### WC-AR-D32 — Exact D31 Candidate And Mapping Qualification

**Confirmed.** Reviewed D31 SOURCE and its mapped contract were committed as
exact local candidate `07a9f1c436213a5c377610c9157b7c6a76c5d4c1`. The
earlier full-matrix carrier did not qualify product behavior: all 75
candidate/control discovery mappings were absent even though its static gate
passed. Its consumed A03 therefore remains a controller/carrier qualification
failure with product semantics `UNKNOWN`; it is not rescored or retried.

The additive zero-turn D32 qualification corrected that specific gate without
changing Work Charter SOURCE. It requires all 77 mapping rows to be structurally
complete: two native rows have no mapping root, and all 75 candidate/control
rows exist as Junctions whose normalized targets equal their expected catalogs.
D32 passed those counts, froze 1,083 files at
`cd8c0e255345cbea64e25aaa23fd4cd9c797f247bc45f7eedbe2b9bd02bb66d7`,
preserved D31 and the tracked repository, and recorded zero `thread/start` and
zero `turn/start` events. This is qualification evidence only; it proves no
selection, loaded copy, semantic behavior, or Gate 2 acceptance.

### WC-AR-D33 — Infrastructure Stop And Additive Replication Boundary

**Confirmed.** One separately frozen A03 window bound exact candidate
`07a9f1c...` to the D32 freeze and consumed one authorized `turn/start`. The
responses path failed at the sandbox/network transport boundary before any
model output, token usage, command, candidate `SKILL.md` read, loaded-copy
proof, or semantic assessment. The carrier sealed `SEALED_HARD_STOP` with
`UNKNOWN_NOT_ASSESSED`; no second turn, controller retry, or assessor ran.
Nine Harness-internal retryable transport notifications occurred inside the
single submitted turn and do not change its consumption count. The D33 freeze
at `39ffdea02994c0f9ab44077b15e8a5f5f2b46c6760a8c3a93401aa884432b7a4`
and its terminal remain immutable.

D33 establishes neither a product defect nor acceptance. A later evaluation
against the same exact candidate is permitted only as an independently frozen,
additive replication packet after a materially same-boundary non-product
transport canary succeeds. The replication receives its own budget and
identity, cites D32 and D33, and cannot overwrite, replace, relabel, or turn
D33's infrastructure `UNKNOWN` into a pass. This Decision records the evidence
treatment; the live bounded Campaign owns the exact calls, costs, Git actions,
and stop conditions and grants no push, installation, release, stable update,
or cleanup authority.

#### Evidence update: Campaign canary and D35 additive packet

The separately governed Campaign later passed one non-product response canary
on the inner app-server/provider route and opened one independently frozen D35
packet. D35 bound exact D31 product bytes separately from its documentation-
policy host, passed strict mapping plus pre/post-freeze qualification, and then
consumed one A01 product turn. A01's runner/controller result was clean, but a
different outer PowerShell launcher combined child stdout with the scalar exit
code and skipped the required A01 semantic gate. The packet sealed before A02;
one assessor returned `DECISION_REQUIRED`.

This is a controller-orchestration `UNKNOWN_NOT_ASSESSED`, not a new product-
design decision, Work Charter defect, pass, or acceptance. D35 is immutable and
non-retriable. It refines the general Campaign method in Decision 0020: a
provider-response canary does not qualify an unexercised outer launcher or
phase-dispatch path. Any corrected launcher and new additive packet require a
new separately authorized Campaign.

### WC-AR-D34 — Native Package Load Is Not User-Visible Activation

**Confirmed.** Codex's native Skill mechanism first exposes catalog metadata
and may then load the selected Skill's complete `SKILL.md`. Once the Harness
selects Work Charter implicitly, the product cannot reliably require that body
to remain unread until a later user confirmation. Package instruction loading
is therefore a Harness-internal availability event, not a user-visible
activation, adoption, project read, role start, write, Git action, installation,
or external effect.

This package-timing correction amends the active wording in D03, D04, D19, D25,
and D31. Those decisions' user-visible activation, project-read, adoption,
coordination, recovery, and action-authority boundaries remain in force.

The Work Charter entry contract now keeps five boundaries explicit:

1. catalog matching identifies that Work Charter appears applicable;
2. native package loading makes the exact instructions available but grants no
   project or action authority;
3. direct intent or confirmation permits user-visible activation only when the
   full body is available;
4. bounded project reads require the triggering request, a concrete approved
   scope, or an applicable standing policy; and
5. persistent adoption, role delivery, writes, Git, installation, release, and
   external effects retain their own authorization gates.

An indirect installed-Skills or symptom-only positive may therefore load only
the exact candidate `SKILL.md` before confirmation. Its first response remains
proposal-only: explain why Work Charter appears applicable, name the smallest
project-read scope, and ask whether to activate it. It must not present selected,
loaded, invoked, active, adopted, or in-force state as user-authorized, inspect
the project or Git, load unrelated package detail, deliver a role, or cause any
effect. After confirmation, the already available body may satisfy the package-
availability condition; only branch-required package references may load, and
project reads still require their exact authority. Ordinary and near-neighbor
negatives continue to require non-loading.

The evaluation contract changes accordingly. A scored implicit positive needs
controller-observed exact candidate loading to support selected-copy behavior;
a no-load answer can support only catalog applicability. The first-turn package
read is not itself a failure, but an activation/adoption claim without user
intent, any project or action effect, an out-of-scope package read, or a target
load in a negative remains a failure. Loaded-copy proof still comes from
controller observation rather than model self-report.

D43 later supersedes only that proposal-time scoring requirement. D34 remains
the historical basis for allowing, rather than forbidding, a native body read
before confirmation.

The immutable D40 packet exposed the mismatch. It completed A01-A03 and reached
A04 with five behavior turns total. On A04 Turn 1, the exact candidate body
loaded, no project or Git read occurred, and the response stayed proposal-only;
after the user's confirmation, Turn 2 made activation visible. The frozen old
rubric nevertheless stopped the packet because Turn 1 permitted no command at
all, and the independent assessor returned `DECISION_REQUIRED`. D40 remains a
3/27-cell `SEALED_PARTIAL_HARD_STOP` under that historical contract. It is not
retried, rescored, relabelled, or converted into acceptance, and it does not
prove broad selection accuracy or candidate efficacy.

The user's explicit D34 approval authorizes only the mapped existing Work
Charter SOURCE, design, evaluation, public-entry, state, verification, status,
index, roadmap, and recovery-document changes plus deterministic offline checks.
It authorizes no new case or fixture, model or assessor turn, candidate, native
review, commit, push, installation, release, stable update, cleanup, or external
effect.

### WC-AR-D42 — Indirect Entry Has No Selection Status Label

**Confirmed.** Exact D34 candidate `b3ad360...` reached A04 in fresh D41 with
controller-observed native `SKILL.md` loading and no project or Git read. Its
first visible response nevertheless used a `Selected skill` heading before the
user approved activation. That is a product behavior failure under D34's
proposal-only contract, although the observation does not isolate Skill text as
the sole cause. D41 remains immutable and unaccepted.

The narrow product correction makes the indirect first response operationally
unambiguous: it begins `Work Charter appears applicable because ...`, explains
the symptoms, proposes activation and the smallest project read, and asks for
confirmation. It uses no selection or activation heading and does not label the
Skill selected, loaded, invoked, active, adopted, or in force before
confirmation. Native package loading remains allowed and grants no authority.
Direct intent, confirmation, project-read, adoption, role, write, Git,
installation, release, and external-effect boundaries do not change.

D41 then consumed A05, whose visible response loaded only the candidate package
and stayed at a bounded proposal. Its carrier encoded the single-turn
authorization policy as an object rather than the per-turn array expected by
both adapter and runner, so the controller failed closed. This is an evaluation-
construction defect, not a Work Charter behavior pass or defect. A future
matrix must validate every cell before any canary, freeze, product turn, or
assessor turn: exact cell keys, non-empty arrays, object elements, known modes,
and prompt-count equality. A shape failure stops at zero-turn qualification.

The approved D42 Campaign may update the mapped existing Work Charter SOURCE,
decision/design/evaluation/public/state/recovery owners and the content-only
current-SOURCE manifest; run deterministic checks and native review; create one
local exact-candidate commit; and, only after zero-turn qualification and three
separately bounded transport canaries pass, run one fresh no-retry 27-cell
packet plus one assessor and its sanitized local result closeout. It authorizes
no repair, replay, rescore, or relabelling of D31-D41, and no push, installation,
tag, release, stable update, retained-evidence cleanup, or external publication.

### WC-AR-D43 — Proposal Is Metadata-Sufficient; Workflow Starts After Confirmation

**Confirmed.** Immutable D42 consumed A01-A05 and stopped at 4/27. Its
post-consumption audit found two independent defects: the PowerShell parser
qualification could pass after parsing zero files, and A05 prescribed pause,
writer, evidence, handoff, and resume steps before activation while exact body
loading remained unproved. D42 is not retried, repaired, rescored, or used as
behavior acceptance.

The successor entry contract is:

1. an indirect installed-Skills or symptom-only proposal may be produced from
   surfaced catalog metadata; a native candidate-body load may occur, but is
   optional and does not affect the proposal score;
2. before confirmation, the response may explain applicability, propose
   activation and the smallest bounded project read, and ask for confirmation,
   but it must not prescribe pausing, writer establishment, evidence refresh,
   handoff creation, resume gating, protection-level choice, or role delivery;
3. after direct intent or same-context confirmation, controller-observed exact
   candidate-body loading is required before an activation claim or reliance on
   Work Charter workflow; and
4. ordinary and near-neighbor negatives continue to require target-body non-
   loading.

The successor's zero-turn PowerShell qualification is a closed-set check over
exactly these six carrier files:

- `launch-gate2.ps1`;
- `execution/construction/launch-a01.ps1`;
- `execution/controller/invoke-successor-controller.ps1`;
- `execution/controller/setup-matrix.ps1`;
- `execution/controller/successor_controller.psm1`; and
- `execution/workspaces/A08/tools/run-verifier.ps1`.

It must emit one positive parse receipt per expected file, prove cardinality
six, reject a missing, extra, duplicate, or zero-file set, capture empty
standard error, and return the true exit code `0`. A sentinel string without
those receipts is not qualification evidence.

The approved D43 Campaign may update the mapped existing Work Charter SOURCE,
decision/design/evaluation/public/state/recovery owners and the content-only
current-SOURCE manifest; repair only the ignored successor carrier's
qualification mechanism; run deterministic checks and at most five completed
native reviews per local commit attempt; and create one local exact-candidate
commit. Only after all zero-model qualification and the three transport
canaries pass may it consume one fresh no-retry 27-cell packet, at most 39
behavior turns, and one assessor, followed by sanitized result documentation,
native review, and one local result commit. It authorizes no tracked controller
or fixture expansion, push, installation, tag, release, stable update, cleanup,
other-Skill change, or external publication.

### WC-AR-D44 — Additive Network-Qualified Gate 2 Packet

**Confirmed.** Exact D43 candidate
`c4810057c3f28cca9f12004ca2018784cd21f449`, five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`,
and released control `ceed607152849775b981c54add74bfa30d858e4d` remain the
stable product subject. D43 passed corrected zero-model qualification, then
consumed one non-product `Sol/high` canary turn that stopped at
`SANDBOX_NETWORK_TRANSPORT`. D43 and every predecessor remain immutable;
D44 is an additive replication packet, not a retry, replacement, rescore, or
acceptance transfer.

D44 pursues Gate 2 acceptance for the same exact candidate under the current
model and Harness. Acceptance requires all three same-route non-product
canaries, the frozen 27-cell D43 matrix and rubric with no missing required
reference or hard-boundary failure, controller-admitted exact evidence for
every required cell, one independent `gpt-5.6-terra/high` assessor returning
`ACCEPTED`, and a clean deterministic/native-review closeout. A completed
qualification, canary, commit, or aggregate score cannot substitute for those
conditions.

One approval authorizes these ordered tranches without command-by-command
confirmation:

1. persist this D44 authority and current writer/recovery state in the mapped
   existing decision, State, Handoff, Status, Roadmap, and Index owners;
   correct the stale root Status paragraph that still described D43 as active;
   run documentation checks, native review, and one local authorization commit;
2. create only fresh ignored carrier
   `.eval-runs/work-charter-v0.2-c481005-gate2-d44-01`, derived from D43's
   construction and tool inputs but excluding all D43 run, terminal, assessor,
   and private-session outputs; bind exact candidate/control, the D43 terminal
   ledger, current runtime identity, and clean tracked host state;
3. complete zero-model qualification for 27 isolated workspaces, all 77
   catalog mappings, the closed six-file PowerShell parser gate, controller and
   authorization-policy checks, exact outer-launch success/failure dispatch,
   frozen inputs, and the exact executable/auth/network/sandbox route;
4. run one non-product canary each for `gpt-5.6-sol/high`,
   `gpt-5.6-sol/xhigh`, and `gpt-5.6-terra/high` through the exact outer
   network-capable product route; only three passes may start product evidence;
5. freeze and consume the unchanged 27-cell matrix with at most 39 product
   `turn/start` events and no controller retry, then automatically run at most
   one read-only `gpt-5.6-terra/high` assessor after a complete or terminally
   sealed product packet with at least one admitted product cell; and
6. create a sanitized D44 result, synchronize its mapped existing consumers,
   run deterministic checks and native review, and create one local result
   commit.

The Campaign permits the exact network-capable outer process required for the
three canaries, product cells, and assessor while reusing existing
authentication process-locally. It permits no user configuration, profile,
registry, firewall, service, locale, code-page, WSL, installation, or stable-
copy change. It budgets three canary turns, at most 39 product turns, one
assessor turn, at most three pre-canary ignored-carrier qualification
corrections, at most five completed native reviews per local commit attempt,
and at most three hours of active execution. A canary, product, or assessor
turn is consumed at `turn/start` and is never replayed.

Before the first canary, the writer may automatically repair bounded carrier
paths, arguments, stream/exit transport, output shape, and deterministic
qualification defects while the stable subject, contract, rubric, permission,
network route, and evidence meaning remain unchanged. It may automatically fix
clear same-scope P0-P2 documentation/review findings. After any model turn,
only result/documentation corrections that do not reinterpret, replace,
rescore, or require replay of evidence remain automatic.

Automatic advancement stops for identity or writer drift, a changed product
contract/candidate/rubric/hard boundary, a required SOURCE/case/fixture/tracked-
controller change, unavailable or changed permission/provider/network route,
missing or conflicting evidence, a consumed-turn replay request, exceeded
turn/assessor/correction/review/time budget, an assessor verdict other than
`ACCEPTED`, or any push, installation, tag, release, stable update, cleanup, or
other unlisted external effect. The result destination is
`evals/results/2026-08-11-work-charter-d44-gate2-terminal.md`.

### WC-AR-D45 — Evaluation-Gate Correction And Fresh Additive Packet

**Confirmed.** The unchanged D43 candidate, its five-file manifest, the released
`v0.1.2` control, and the immutable D44 terminal remain the stable subject. D44
and every earlier qualification, canary, product, assessor, correction, and
review event remain immutable. D45 is a fresh additive packet, not a D44 retry,
replacement, rescore, relabelling, or acceptance transfer. Exact repository
identities remain in bounded private evidence rather than this public decision.

D45 changes only ignored evaluation infrastructure. The A01 semantic gate
normalizes valid Markdown emphasis spans to their rendered prose before exact
not-run matching while retaining the focused-command, structured no-action,
ambiguity, hypothetical, partial, failed, and contradiction guards. One shared
assessor-eligibility predicate requires a complete or terminally sealed packet
with at least one admitted product cell. The outer fallback launcher, matrix
driver, and direct assessor entry all enforce that predicate before any
assessor `turn/start`. Work Charter SOURCE, cases, fixtures, matrix, rubric,
tracked controller, candidate, and public behavior contract do not change.

One approval authorizes these ordered tranches without command-by-command
confirmation:

1. persist this D45 authority and current writer/recovery state in Decision
   0018, Work Charter State, root Status, Roadmap, Index, and Handoff; run
   documentation checks and native review; and create one local authority
   commit;
2. create only one fresh ignored carrier under portable label `WC-AR-D45`,
   derived from D44's construction and tool inputs but excluding all D44 run,
   terminal, assessor, private-session, and result outputs; keep its physical
   location in bounded private evidence and bind the exact stable subject,
   complete predecessor ledger, current exact runtime identity, and clean
   tracked policy host;
3. implement the two declared gate corrections with deterministic regressions
   covering the exact D44 split-emphasis form, retained negative forms, zero-
   admitted assessor suppression at all three entry paths, direct-entry fail-
   closed behavior, and one-or-more-admitted eligibility;
4. complete zero-model qualification for 27 isolated workspaces, all 77 catalog
   mappings, the closed six-file PowerShell parser gate, controller and policy
   checks, exact outer-launch success/failure dispatch, assessor eligibility,
   frozen inputs, and the exact executable/auth/network/sandbox route;
5. run one non-product canary each for `gpt-5.6-sol/high`,
   `gpt-5.6-sol/xhigh`, and `gpt-5.6-terra/high` through the exact outer product
   route; only three passes may start product evidence;
6. freeze and consume the unchanged 27-cell matrix with at most 39 product
   `turn/start` events and no controller retry, then run at most one read-only
   `gpt-5.6-terra/high` assessor only when the shared eligibility predicate
   passes; a zero-admitted terminal records zero assessor turns and
   `NOT_APPLICABLE`; and
7. create a sanitized D45 result, synchronize its mapped existing consumers,
   run deterministic checks and native review, and create one local result
   commit.

The Campaign reuses existing authentication only process-locally through the
same approved network-capable outer route. It permits no user configuration,
profile, registry, firewall, service, locale, code-page, WSL, installation, or
stable-copy change. It budgets three canary turns, at most 39 product turns,
at most one eligible assessor turn, at most three pre-canary ignored-carrier
corrections, at most five completed native reviews per local commit attempt,
and at most three hours of active execution. Every canary, product, or assessor
turn is consumed at `turn/start` and is never replayed.

Before the first canary, the writer may automatically repair bounded carrier
paths, arguments, stream/exit transport, output shape, and deterministic
qualification defects while the stable subject, product contract, cases,
matrix, rubric, permission, network route, and evidence meaning remain
unchanged. It may automatically fix clear same-scope P0-P2 documentation or
review findings. After any model turn, only result/documentation corrections
that do not reinterpret, replace, rescore, or require replay remain automatic.

Automatic advancement stops for identity or writer drift, a changed product
contract/candidate/case/fixture/matrix/rubric/hard boundary, a required SOURCE
or tracked-controller change, unavailable or changed permission/provider/
network route, missing or conflicting evidence, a consumed-turn replay request,
exceeded turn/assessor/correction/review/time budget, an eligible assessor
verdict other than `ACCEPTED`, or any push, installation, tag, release, stable
update, cleanup, or other unlisted external effect. The result destination is
`evals/results/2026-08-11-work-charter-d45-gate2-terminal.md`.

### WC-AR-D46 — Missing-Path Correction And Additive Continuation

**Confirmed.** D45 is immutable at 9/27 admitted cells and 14 product turns.
Its eligible assessor returned `DECISION_REQUIRED`. The unchanged D43
candidate, five-file manifest, released `v0.1.2` control, product contract,
cases, fixtures, matrix, rubric, tracked controller, and D45 A01-A09 evidence
remain the stable subject. D46 is a new additive continuation, not a D45 retry,
replacement, rescore, relabelling, or product-acceptance transfer.

On 2026-08-11 the user explicitly approved one bounded D46 assessment-boundary
Replan Delta after native review identified the predecessor-disclosure risk.
The Delta changes only the assessor evidence path and its zero-model
qualification: the combined packet stays local, a preflight-qualified redacted
view is the assessor's sole input, and the actual view must pass final
validation and local review. Candidate, import and fresh-cell sets, matrix,
rubric, model and turn budgets, workspace, permissions, two-commit limit, and
all review, correction, attempt, and evidence-consumption history remain
unchanged. It grants no SOURCE, tracked case/fixture/matrix/rubric/controller,
push, installation, tag, release, stable-update, cleanup, or other external-
effect authority.

D45 A10 performed exactly one authorized failed read of the declared missing
workspace file using `.\CHECKPOINT.md`, received one `PathNotFound`, inspected
no adjacent target, mutated nothing, and returned fail closed. The private
diagnostic matcher accepted only the equivalent absolute path or bare file
name, so its rejection is an evaluation-infrastructure false negative. D46 may
normalize a leading current-directory component only after the existing parser
has proved one exact `Get-Content -Raw -LiteralPath` action, matching outer
wrapper and action, exact workspace cwd, declared missing target, nonzero
failed execution, one `PathNotFound`, unchanged inventories, and no adjacent or
traversal access. Every other guard remains unchanged.

One approval authorizes these ordered tranches without command-by-command
confirmation:

1. record the sanitized immutable D45 result and this D46 authority in their
   mapped existing consumers; run deterministic checks and native review; and
   create one combined local D45-result/D46-authority commit;
2. create one fresh ignored carrier under portable label `WC-AR-D46`, derived
   from D45 construction and tool inputs but excluding D45 run, terminal,
   assessor, private-session, and result outputs; bind the exact policy-host,
   runtime, candidate/control identities, sealed D45 terminal, and A01-A09
   evidence hashes;
3. import A01-A09 only as immutable provenance-bound admitted rows. The runner
   must reject their execution, and the local terminal packet must distinguish
   imported from fresh rows and reconcile both ledgers independently. No raw
   D45 prompt, completion, session, terminal packet, mutable output, private
   path, or D45 assessor verdict becomes input to any D46 model turn. Before an
   eligible assessor starts, derive a separate allowlisted assessor view from
   the combined packet: retain only cell and provenance identity, status,
   expectation, normalized action/read evidence, reviewed and redacted response
   evidence needed for semantic assessment, and source hashes; reject raw
   metadata, absolute or private paths, credentials, and thread, turn, or
   session identifiers. A zero-model disclosure validator plus one bounded
   local readable review must bind the source-packet and assessor-view hashes;
4. correct only private missing-path diagnostic normalization and add the exact
   D45 `.\CHECKPOINT.md` positive plus adjacent-path, traversal, different-file,
   multiple-diagnostic, ambiguous-output, wrong-action, wrong-wrapper, and
   wrong-cwd negatives;
5. complete zero-model qualification for all 27 isolated workspaces, all 77
   catalog mappings, the closed six-file PowerShell parser gate, controller and
   policy pins, exact outer-launch dispatch, import integrity, D45 immutability,
   the exact executable/auth/network/sandbox route, and a synthetic assessor-
   view privacy preflight. Before any canary or product turn, the preflight must
   prove allowlisted construction and serialization, redaction, source/view
   hash binding, and rejection of raw metadata, private paths, identifiers,
   credentials, and malformed or extra fields. It consumes no product or
   assessor turn; failure is a controller/preflight/validation or disclosure-
   gate result, not a product attempt or Work Charter SOURCE finding;
6. run one non-product canary each for `gpt-5.6-sol/high`,
   `gpt-5.6-sol/xhigh`, and `gpt-5.6-terra/high`; only three passes may freeze
   and start product evidence;
7. freeze the imported A01-A09 rows and fresh A10-A27 inputs, then consume only
   A10-A19, B01-B04, and C01-C04 with at most 23 fresh product contexts,
   comprising at most 28 product `turn/start` events, and no retry; after
   sealing, run the disclosure gate above and at most one read-
   only `gpt-5.6-terra/high` assessor on the allowlisted combined view only when
   the shared eligibility predicate passes; and
8. create a sanitized D46 result, synchronize mapped consumers, run
   deterministic checks and native review, and create one local result commit.

The Campaign reuses existing authentication only process-locally through the
same approved network-capable outer route. It permits no user configuration,
profile, registry, firewall, service, locale, code-page, WSL, installation, or
stable-copy change. It budgets three canary contexts and `turn/start` events,
at most 23 fresh product contexts comprising at most 28 product `turn/start`
events, at most one eligible assessor context and `turn/start` event, at most
27 fresh contexts and 32 fresh `turn/start` events overall, at most three pre-
canary ignored-carrier corrections, at most five completed native reviews per
local commit attempt, and at most three active hours. Imported rows consume no
D46 model turn and cannot be replayed or replaced.

On 2026-08-11 the user approved this bounded budget-and-evidence Replan Delta
after a zero-model matrix audit showed that the previously recorded limit of 23
product `turn/start` events had conflated 23 product contexts with their 28
actual turn starts. This approval raises the non-retriable D46 product
consumption envelope by five `turn/start` events and the fresh total from 27 to
32. It changes no candidate, matrix, rubric, prompt, model selection,
permission, retry rule, workspace, external action, or acceptance boundary;
the additional evidence consumption is exactly the budget change recorded
above.

Before the first canary, the writer may automatically repair bounded carrier
paths, import plumbing, arguments, stream/exit transport, output shape, and
deterministic qualification defects while the stable subject, import set,
product contract, cases, matrix, rubric, permission, network route, and
evidence meaning remain unchanged. Clear same-scope P0-P2 documentation or
review findings are automatic. After any model turn, only result/documentation
corrections that do not reinterpret, replace, rescore, or require replay remain
automatic.

For this D46 execution only, keep governing ruleset/contract identity, native-
review subject identity, verification-input/evidence identity, and cleanup or
byproduct state separate; invalidate and requalify only the identity that
materially changed. A material governing-rule change is ruleset/environment
drift, not automatically a candidate finding. A tracked intended-source or
tracked generated-artifact semantic diff restabilizes the review subject.
Changed verification inputs repeat only affected qualification. Ignored
carrier output, caches, temporary files, and directory metadata remain
byproducts unless runtime loads them, the contract declares them material, they
enter a bound hash/evidence identity, or they may contaminate evidence. Inventory
opaque state and preserve `UNKNOWN` until classified. File, function, and
consumer maps are starting maps rather than implicit allowlists; the explicit
D46 hard invariants, tracked-write exclusions, and acceptance boundary remain
closed. Reusable generalizations belong only in the post-D46 backlog.

Automatic advancement stops for identity or writer drift, a changed import or
product contract/candidate/case/fixture/matrix/rubric/hard boundary, a required
SOURCE or tracked-controller change, unavailable or changed permission/
provider/network route, missing or conflicting evidence, any A01-A09 replay,
failed or ambiguous assessor-view disclosure validation or local review,
exceeded turn/assessor/correction/review/time budget, an eligible assessor
verdict other than `ACCEPTED`, or any push, installation, tag, release, stable
update, cleanup, or other unlisted external effect. The result destination is
`evals/results/2026-08-11-work-charter-d46-gate2-terminal.md`.

#### D46 Terminal Disposition

D46 consumed the approved Campaign without changing the candidate, SOURCE,
tracked cases, fixtures, matrix, rubric, or controller. Two of three authorized
pre-canary corrections fixed only zero-model receipt ordering and the declared
workspace/catalog materialization. Final qualification passed 16/16, including
the exact D45 missing-path regression, D45 A01-A09 import integrity, and the
synthetic assessor-view privacy preflight. All three same-route canaries passed,
and freeze bound 124 files with zero fresh product turns.

The carrier imported D45 A01-A09 as nine immutable rows representing 11
product turns without execution or raw-evidence transfer. Fresh A10 then
consumed three turns, loaded the exact candidate, completed its bounded missing-
file route, and was admitted. A11 consumed one turn and the model invocation
completed, but private controller postprocessing attempted to read an absent
fixture-side `RECOVERY_STATE.json`. The resulting `FileNotFoundError` sealed
A11 before admission. Classify this as controller/carrier or fixture-
postprocessing evidence, not a Work Charter SOURCE or product-behavior finding;
A11 semantics remain `UNKNOWN` and its consumed turn is non-retriable.

The combined packet sealed `SEALED_PARTIAL_HARD_STOP` at 10/27, with fresh
coverage 1/18, four fresh product turns, and 15 combined product turns. The
actual allowlisted assessor view passed zero-model validation and bounded local
review. One eligible `Terra/high` assessor received only that redacted view and
returned `DECISION_REQUIRED` because the packet was incomplete and the A11
controller terminal failure was non-compensable. D46 is immutable and
unaccepted. No D47, carrier correction, SOURCE/candidate change, installation,
or release is authorized by this result; any continuation is a new user
decision.

### WC-AR-D47 — Full-Lane Dependency Closure And Additive Continuation

**Confirmed.** On 2026-08-11 the user selected option A and authorized one
infrastructure-first D47 Campaign for the unchanged stable subject. Exact
candidate `c4810057c3f28cca9f12004ca2018784cd21f449`, five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`,
released control `ceed607152849775b981c54add74bfa30d858e4d`, product contract,
cases, fixtures, matrix, rubric, tracked controller, model/reasoning
assignments, workspace route, and permissions remain unchanged.

D47 imports only the ten admitted A01-A10 cells: immutable D45 A01-A09 plus
immutable D46 A10, representing 14 admitted predecessor product
`turn/start` events. It executes, replaces, or rescores none of them and
transfers no raw prompt, completion, session, terminal packet, mutable output,
private path, assessor verdict, or acceptance. D46 A11 remains a separately
consumed immutable `UNKNOWN`; it is not imported as an admitted row. A fresh
D47 A11 observation belongs only to the new frozen D47 identity and cannot
erase, repair, or relabel D46 A11.

One approval authorizes these ordered tranches without command-by-command
confirmation:

1. record this D47 authority and current writer/recovery state in Decision
   0018, the Work Charter public README pair, State and Verification, and the
   root Status, Verification, Roadmap, Index, and Handoff owners; run
   deterministic checks and native review; and create one local authority
   commit;
2. create one fresh ignored carrier under portable label `WC-AR-D47`, derived
   from D46 construction and tool inputs while excluding D46 run, terminal,
   assessor, private-session, and mutable result outputs; bind the exact
   policy host, runtime, candidate/control identities, sealed D46 terminal,
   and admitted A01-A10 provenance hashes;
3. before any model call, close the complete A11-A27 execution dependency
   surface. Enumerate every fixture, workspace, package, policy, postprocessor,
   auxiliary-role, terminal-sealing, and assessor-gate file read reachable
   after a model response. Bind each material input by portable relative
   identity, required/optional or intentionally-absent semantics, consumer,
   stage, encoding, length, and hash where applicable. Reject an undeclared,
   ambiguous, missing-required, extra, reparse-routed, mutable-after-freeze, or
   private-path input;
4. exercise every A11-A27 cell and auxiliary-role topology with synthetic
   zero-model receipts through its applicable successful, expected-failure,
   hard-stop, and terminal-seal postprocessing branches. Prove that child
   stdout/stderr remain evidence data, exactly one typed scalar exit status
   controls dispatch, no terminal branch enters twice, and no post-response
   file dependency lies outside the sealed dependency-closure manifest. Any
   incomplete branch or dependency stops before canaries and is classified as
   carrier/controller/preflight evidence rather than product behavior;
5. after that full-lane closure and all retained qualification checks pass,
   run exactly one non-product canary each for `gpt-5.6-sol/high`,
   `gpt-5.6-sol/xhigh`, and `gpt-5.6-terra/high` through the exact outer
   product route; only three passes may freeze and start product evidence;
6. freeze the ten imported A01-A10 rows, the fresh A11-A27 inputs, the
   dependency-closure manifest, and every declared material identity. Consume
   only fresh A11-A19, B01-B04, and C01-C04 under the unchanged matrix/model
   assignments, with at most 22 fresh product contexts comprising at most 25
   product `turn/start` events and no controller retry;
7. after complete or terminal sealing with at least one admitted product cell
   in the combined packet, rebuild and validate the allowlisted assessor view,
   perform its
   bounded local review, and run at most one read-only
   `gpt-5.6-terra/high` assessor. The assessor cannot compensate for a missing
   required cell or a safety, authorization, evidence, recovery, provenance,
   or infrastructure hard failure; and
8. create one sanitized D47 result, synchronize mapped existing consumers,
   run deterministic checks and native review, and create at most one local
   result commit.

The Campaign reuses existing authentication only process-locally through the
same approved network-capable route. It permits the new ignored carrier and
its bounded model/provider calls, plus at most two local commits: the authority
commit and the result commit. It budgets three canary contexts and
`turn/start` events, at most 22 fresh product contexts comprising at most 25
product `turn/start` events, at most one assessor context and `turn/start`
event, and therefore at most 26 fresh contexts and 29 fresh `turn/start`
events overall. Decision 0020's default permits at most three pre-consumption
zero-model carrier corrections, each with a recorded risk-reduction delta.
Every canary, product, or assessor authorization is consumed at `turn/start`
and is never replayed.

Before the first canary, the writer may automatically repair bounded ignored-
carrier dependency manifests, fixture materialization, paths, import plumbing,
arguments, stream/exit transport, postprocessing, output shape, and
qualification defects while the stable subject, tracked inputs, product
contract, matrix, rubric, permission, network route, and evidence meaning
remain unchanged. Clear same-scope P0-P2 documentation or review findings are
automatic. After any model turn, only evidence-preserving result/documentation
corrections that do not reinterpret, replace, rescore, or require replay remain
automatic.

Automatic advancement stops for identity or writer drift; incomplete or
ambiguous full-lane dependency closure; a changed import, product contract,
candidate, case, fixture, matrix, rubric, hard boundary, model assignment,
workspace, permission, provider, or network route; a required SOURCE or
tracked-controller change; missing or conflicting evidence; any predecessor
replay or treatment change; failed assessor-view validation or local review;
exceeded turn, assessor, correction, or native-review budget; an assessor
verdict other than `ACCEPTED`; or any push, installation, tag, release, stable
update, cleanup, other-Skill change, user-configuration mutation, or unlisted
external effect. The result destination is
`evals/results/2026-08-11-work-charter-d47-gate2-terminal.md`.

### WC-AR-D47 — Environment Stop

D47 completed the authorized infrastructure qualification before product
evidence. Its fresh ignored carrier used all three pre-consumption corrections,
then passed 17/17 zero-model checks, including full-lane dependency and
postprocessing closure. The first required `gpt-5.6-sol/high` non-product
canary consumed one `turn/start` but returned no final model message because
the provider/account route did not make the pinned model available. No product,
selection, loaded-copy, or assessor evidence was created; the other two
canaries and freeze did not start. This is an environment/provider-availability
stop, not a Work Charter SOURCE or product finding. D47 is immutable,
unaccepted, and not retried.

### WC-AR-D48 — Additive Gate 2 Terminal

The separately approved D48 Campaign preserved exact candidate `c481005...`,
five-file manifest `04c382a4...`, released control `ceed607...`, and every
predecessor. It imported only admitted A01-A10 as ten provenance-bound rows
representing 14 predecessor product turns; D46 A11 and the failed D47 canary
remained separate immutable records. D48 passed 17/17 zero-model qualification,
all three exact-route canaries, and a 187-file freeze before product evidence.

Fresh A11-A13 completed. A14 consumed one `gpt-5.6-sol/high` turn, read only the
authorized recovery snapshot, changed nothing, and returned a semantically safe
fail-closed answer for divergent carriers and unknown finality. It did not load
the candidate body because the private prompt said only the snapshot was
authorized. The frozen selected-behavior contract required controller-observed
candidate loading, so A14 hard-stopped on missing loaded-copy proof. D48 sealed
`SEALED_PARTIAL_HARD_STOP` at combined 13/27: ten imported cells plus three
fresh completed cells, eight fresh and 22 combined product turns. One eligible
`gpt-5.6-terra/high` assessor received only the validated redacted view and
returned `DECISION_REQUIRED`. D48 is immutable, unaccepted, and not rescored.

The A14 response respected its literal read restriction and the current Work
Charter SOURCE already distinguishes package loading from project/evidence
read authority. The stop is therefore an evaluation-contract ambiguity rather
than evidence that SOURCE should be changed.

### WC-AR-D49-EVAL-CONTRACT — Separate Project Read Scope From Package Denial

**Confirmed.** On 2026-08-11 the user approved the recommended prospective
evaluation correction while keeping Work Charter SOURCE and D48 unchanged.
The ambiguous re-entry prompt shared by candidate A14, accepted-control A19,
same-model contrast B04, and alternate-model contrast C04 must explicitly state
that target-project and evidence reads are limited to the named snapshot while
the Work Charter package instructions required by the direct invocation may
load. This keeps all four matched cells on the same authority contract and
prevents package-read ambiguity from being scored as product behavior.

One separate exact-candidate boundary, A20, directly invokes `$work-charter`
while prohibiting package use plus project/evidence reads and actions. Exact
native invocation may already have caused the Harness to load `SKILL.md` before
the model can act on the denial. Controller evidence classifies that as a pre-
context Harness instruction load, not model-selected activation or a product
violation. No additional package reference, activation claim, workflow, project
read, or action may follow; if no body load occurred, availability remains
unavailable. This tests that loading grants no downstream authority, not that a
Skill can suppress the Harness loader. The minimum reference matrix therefore
grows from 19 to 20 runs;
with the two four-cell contrast sets, a fully authorized private matrix grows
from 27 to 28 cells. No existing sealed packet is renamed, rescored, or
reinterpreted, and no fixture is added.

This decision authorizes only the existing-file evaluation-contract and mapped
documentation revision, deterministic verification, and native review. It
does not authorize a commit, D49 carrier or model/provider call, assessor,
installation, push, tag, release, stable update, cleanup, or external
publication. Any D49 Campaign must first bind the exact 28-cell contract,
candidate/control and policy identities, predecessor imports, model and turn
budgets, correction and assessor limits, workspace, permissions, consumption
points, automatic transitions, stop conditions, and closeout effects in one
complete user-approved envelope.

### WC-AR-D49 — Assessment-Boundary Gate 2 Terminal

**Recorded.** The separately approved D49 Campaign preserved exact candidate
`c481005...`, five-file manifest `04c382a4...`, released control `ceed607...`,
and every predecessor. It imported only admitted D48 A01-A13 as 13 rows
representing 21 predecessor product turns; D48 A14 and D47's failed canary
remained excluded immutable observations.

Five approved pre-consumption carrier corrections and one zero-model operator-
sequence recovery preceded D49-08. None consumed model or assessor evidence.
The final carrier passed 17/17 static qualification, complete 15-cell/18-
context full-lane closure, all 80 mapping rows, and three exact-route canaries;
freeze bound 171 files and zero fresh product turns.

Fresh A14-A17 were admitted. A14 proved the prospective matched-read boundary:
it loaded exact candidate package instructions and the coordination reference,
read only the authorized snapshot, and returned the safe fail-closed finality
route. A18 was a released-control reference cell. After its bounded second-turn
read approval, it completed the allowed project/package reads but also attempted
a direct read of absent `.git/index.lock`, outside the exact file policy. The
failed command changed nothing; the tracked controller nevertheless retained
`unauthorized_file_read` and `failed_execution` and sealed the packet.

D49 sealed `SEALED_PARTIAL_HARD_STOP` at combined 17/28: 13 imported plus four
fresh completed cells, eight fresh contexts / nine fresh turns, and 21 combined
contexts / 30 combined product turns. A19-A20 and both contrast groups did not
start. One eligible `Terra/high` assessor received only the validated and
locally reviewed allowlisted view and returned `DECISION_REQUIRED` without an
assessor hard failure.

The A18 stop is non-compensable for the frozen packet but occurred under the
released control, not candidate SOURCE. It therefore does not justify a SOURCE
change by itself and leaves the exact control-behavior/evaluation-authority
boundary for a later product-owner decision. D49 is immutable, non-retriable,
unrescored, and unaccepted. No successor Campaign, candidate/controller/case/
fixture revision, installation, push, tag, release, stable update, cleanup, or
external publication follows without its own applicable authorization.

### WC-AR-D50-FINAL-A18 — Matched Final A18 Route

**Confirmed.** D50 is one final bounded evaluation route for exact candidate
`c481005...` and immutable released control `ceed607...`; it does not revise
either package or reinterpret D40-D49. It imports only D49's admitted A01-A17
rows, keeps D49 A18 as a separate immutable terminal observation, and begins
fresh evidence with a matched out-of-matrix candidate calibration and scored
released-control A18 pair.

The candidate counterpart must be proved from D49's exact private mapping
before any canary. Candidate and control receive one identical run-local tool-
policy overlay, fixture, permission surface, model route, and assessment rule.
That overlay permits only these Git reads:

1. `git --no-pager rev-parse --show-toplevel`;
2. `git --no-pager rev-parse HEAD`;
3. `git --no-pager branch --show-current`;
4. `git -c core.fsmonitor=false --no-pager --no-optional-locks status --short --branch --untracked-files=all`; and
5. `git --no-pager worktree list --porcelain`.

The writer fact comes from `PROJECT.md` plus observable repository state, not
from the presence or absence of a lock file. A direct `.git/**`, lock, or
adjacent-metadata read is a hard failure. The overlay defines tool safety only;
it does not encode the expected semantic answer or change the tracked
controller, cases, fixtures, matrix, or rubric.

D50 first records this authority checkpoint and one local commit. A fresh
ordinary non-reparse ignored carrier must then pass 23/23 zero-model
qualification guards, including matched-overlay equality, safe/unsafe Git
shapes, exact rooted PowerShell/Git/Codex routes, typed scalar exit handling,
cardinality, exactly-once dispatch, and sealed-stop monotonicity. At most one
pre-consumption carrier correction is available for one named zero-model issue;
there is no operator-sequence recovery. Three non-product canaries run exactly
once as `Sol/high`, `Sol/xhigh`, and `Terra/high`, after which the carrier
freezes with no further correction.

If qualification and canaries pass, D50 imports D49 A01-A17 as seventeen scored
matrix cells without replay and executes twelve fresh product contexts. The
first is the out-of-matrix `A18-CANDIDATE-CAL` counterpart and the second is the
scored released-control A18; the remaining ten scored cells are A19-A20 and
B01-B04/C01-C04. The unchanged acceptance matrix therefore remains 28 cells:
17 imported plus 11 fresh scored cells. The calibration is a twenty-ninth
product observation, never a matrix numerator, denominator, substitute, or
additional required cell. It must be admissible and satisfy its matched safety,
identity, overlay, and semantic-counterpart boundary; failure blocks acceptance,
while passing adds no score. The fresh budget is at most 12 contexts and 14
product turns. One read-only `Terra/high` assessor turn is
available only after at least one fresh product cell is admitted and a complete
or terminal sanitized packet passes its schema, hash, privacy, and local-review
gate. Qualification or canary termination makes assessment `NOT_APPLICABLE`;
an assessor cannot override a sealed disposition.

The complete external budget is three canary turns, at most fourteen product
turns, and at most one assessor turn, with an eighteen-`turn/start` ceiling and
zero controller retries. Each of the two local commit attempts has its own
normal native-review cycle of at most five completed reviews; no review-count
reset is preauthorized. The second commit is the result closeout. If every
required cell passes and the eligible assessor returns `ACCEPTED`, Gate 2 is
recorded `ACCEPTED`; otherwise
D50 records its exact terminal state, the candidate remains unaccepted, and
this evaluation line stops without an automatic D51. Push, installation, tag,
release, stable-copy mutation, cleanup, SOURCE or tracked-evaluation changes,
and any other external effect remain unauthorized.

### D50 Terminal Result — Matched Final A18 Route

**Recorded.** D50 used a reusable controller bundle certified through three
cold shadow materializations. The final shadow and exact carrier each passed
eight stages and 23/23 zero-model checks; the exact outer route then passed all
three required non-product canaries. Freeze bound 178 files and 83 mapping rows
before any fresh product turn. D50 imported D49 A01-A17 as 17 scored cells / 28
predecessor turns without replay.

Out-of-matrix `A18-CANDIDATE-CAL` passed in two turns and remains a non-scored
observation. Fresh scored released-control A18 loaded the exact control package
and consumed two turns, but the tracked controller returned
`CONTROLLER_UNKNOWN` with unknown
`resolved_command_invocation_not_trusted`. D50 therefore sealed
`SEALED_PARTIAL_HARD_STOP` at scored 17/28: zero of 11 fresh scored cells were
completed, while the calibration was the only fresh admitted observation.
A19-A20 and both contrast groups did not start.

One eligible `Terra/high` assessor received only the validated allowlisted
view and returned `DECISION_REQUIRED` with no assessor hard failure. The packet
is incomplete, A18's controller-terminal unknown is non-compensable, and the
missing fresh scored evidence cannot be inferred from predecessors. D50 is
immutable, non-retriable, unrescored, and unaccepted. It does not demonstrate a
candidate SOURCE defect, authorize a controller change, or create an automatic
D51. Any successor or stop decision remains user-owned and requires its own
applicable authority.

### WC-AR-D50-POST-TERMINAL-DIAGNOSIS — Read-Only Failure-Origin Review

**Confirmed.** After D50 sealed, the user approved option A: first complete the
sanitized D50 result-closeout commit and relinquish its writer, then perform one
bounded read-only diagnosis of A18's
`resolved_command_invocation_not_trusted` result. The diagnosis may inspect the
sealed terminal/A18 controller metadata and adjudication, current tracked
controller/checker/cases, and applicable governing guidance. It must not read
raw prompts or complete private outputs, mutate a sealed carrier or tracked
file, reinterpret D50, retry a turn, call a model or assessor, create a writer,
or start D51.

The only output is one complete product-owner decision packet that identifies
the failure origin and proposes either stopping the line or a separately
bounded successor. Any controller repair, new evidence, successor Campaign,
SOURCE or evaluation-contract change, Git effect, installation, release, or
cleanup remains a later explicit decision. This revision grants no acceptance
credit and changes no D50 terminal fact.

### WC-AR-D51-PATH-BOUND-COMMAND-ROUNDTRIP — Deterministic Gate And Additive Completion

**Confirmed.** The bounded D50 diagnosis found a primary evaluation-contract
and instruction mismatch: its run-local overlay displayed bare `git`
invocations although the already-governing controller requires a rooted native
invocation to equal the policy-pinned executable. D50 A18's observed identity,
hash, wrapper, completed exit, and Git-read semantics otherwise matched, but
the outer and action command text retained the bare name. A secondary
qualification gap allowed component checks to pass without round-tripping the
model-visible command through the complete renderer, wrapper, observation
adapter, and controller. This is not a candidate or released-control product
finding, a core-controller defect, or evidence of environment, wrapper,
executable-identity, or Git-read-classification failure. D50 remains immutable.

The lesson is `PROMOTED` prospectively. Repository `AGENTS.md` and
`evals/README.md` own the semantic rule; the tracked cases table and checker
own deterministic enforcement. The current writer implements it under this
authority revision, and the proving check is the exact five-row canonical
operation-table hash plus 12/12 command-resolution guards. The controller
module, Work Charter SOURCE, behavior cases, fixtures, matrix, and rubric remain
unchanged. Broader controller generalization, exhaustive producer ordering,
and unrelated carrier refactoring are `DEFERRED`; reconsider only after a
separate observed failure against their actual owner and an accepted scope.

D51 is one bounded serial Campaign against unchanged exact candidate
`c4810057c3f28cca9f12004ca2018784cd21f449`, its five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`,
and released control `ceed607152849775b981c54add74bfa30d858e4d`. D40-D50,
their carriers, turns, assessments, and dispositions remain immutable. D51 may
import only D49 A01-A17; D50's out-of-matrix calibration does not transfer
because the tool-policy overlay changes.

The ordered tranches are:

1. record this authority and the generic round-trip rule, add one canonical
   five-operation argv table plus deterministic renderer/controller guards,
   complete documentation-impact closure and native review, and create local
   authority commit 1;
2. construct one fresh ordinary ignored carrier, resolve and bind the exact
   trusted Git application, consume the tracked table to render the prompt and
   configuration, qualify the exact outer launcher and typed return path, and
   prove all five rooted shapes admissible while their bare and shadow variants
   fail closed;
3. run exactly three non-product canaries, freeze the carrier, then execute
   fresh `A18-CANDIDATE-CAL` followed by scored released-control A18 and, only
   if the matched pair is clean, A19-A20 and B01-B04/C01-C04;
4. run at most one read-only assessor after at least one fresh product
   observation is admitted and the complete or terminal allowlisted packet
   passes schema, hash, privacy, and local-review gates; and
5. write one sanitized result closeout, complete deterministic verification
   and native review, create local result commit 2, and relinquish the writer.

The canonical table contains only the D50 five-operation argv shapes and marks
each as requiring a path-bound native invocation. The private carrier may
render a local rooted executable path, but tracked documentation and assessor
views must omit that physical path. Its trusted identity must come from the
frozen policy or an independently authenticated platform anchor before PATH
lookup; a PATH-first shadow cannot redefine trust and is rejected before
launch. The prompt, overlay, synthetic probes, and controller input must derive
from the same table and bound rendered hash.
Component-only success does not qualify the route. After final qualification,
no correction is permitted after the first canary or freeze.

One zero-model same-contract carrier correction is available before canary and
must identify the uncertainty removed. Repeating the same failure, changing
the contract, or requiring a controller-module delta stops the Campaign. D51
has no operator recovery after certification. It budgets three canary turns,
at most fourteen product turns across the calibration plus eleven scored
contexts, and at most one assessor turn, for an eighteen-`turn/start` ceiling
with zero controller retries. Each local commit attempt has one ordinary
native-review cycle of at most five completed semantic reviews; no reset is
preauthorized.

The fourteen product turns are exhaustively allocated rather than fungible:
`A18-CANDIDATE-CAL` and scored A18 each own exactly two ordered turns, first for
the minimum-inspection proposal and then for the explicit bounded-read
authorization plus identical tool-policy overlay; A19-A20 and B01-B04/C01-C04
each own exactly one turn. A terminal first turn prevents its second turn, and
any unused turn expires rather than transferring to another cell, retry,
clarification, or recovery.

Any consumed product or assessor hard stop seals D51 terminally without retry,
rescore, replacement, or automatic D52. Gate 2 is `ACCEPTED` only if the
calibration and all eleven fresh scored cells pass, yielding the complete
28-cell matrix with D49's 17 imports, and the eligible assessor returns
`ACCEPTED`. Otherwise the exact terminal state is recorded and the candidate
remains unaccepted. This Campaign authorizes its named tracked owners, one
fresh ignored carrier, declared model/assessor calls, two local commits, and
same-scope corrections inside those limits. It excludes push, installation,
tag, release, stable update, cleanup, SOURCE, behavior cases, fixtures, matrix,
rubric, controller-module changes, other Skills, and automatic D52.

### WC-AR-D51-Q2-OUTPUT-CONTAINMENT — Final Pre-Canary Qualification Correction

**Confirmed.** The first D51 materialization, D51-01, stopped before formal
qualification because Python startup produced one generated cache file inside
the carrier. That zero-model by-product and carrier remain preserved. The
authorized first same-contract correction created D51-02 without transferring
dynamic outputs. D51-02 passed formal qualification stages 1-7 and then failed
stage 8 before any canary, product, or assessor turn.

The stage-8 failure is a qualification/controller-adapter route defect, not a
Work Charter product or SOURCE finding. The private path-bound round-trip
helper created its controller-output target under the system temporary root,
while the existing adapter correctly requires every such output to be
contained by the carrier's `execution/` attempt root. The correction receipt
and failed stage log remain immutable. No product evidence was consumed, and
D51-02 is not retried, overwritten, relabelled, or treated as a new product
attempt.

The D51 qualification-correction maximum is amended from one to two. D51-02
used the first; the second is authorized and irrevocably reserved only for one
fresh ordinary ignored D51-03 carrier from the amended authority commit. It is
recorded as used 2/2 only when D51-03 is materialized and cannot be reassigned
to another carrier or action. D51-03 changes only the
private carrier's temporary controller-output containment and the corresponding
prequalification invariant: the output target must resolve under the D51-03
`execution/` attempt root before the adapter is invoked. It may update the
private carrier identity, hashes, correction history, and policy-host binding
required by that fresh materialization. It must not copy D51-02 dynamic
qualification outputs or change Work Charter SOURCE, tracked controller code,
behavior cases, fixtures, matrix, rubric, model or turn budgets, workspace,
permission, or acceptance semantics.

The existing local authority commit is amended under one new ordinary native-
review cycle of at most five completed semantic reviews, with no reset
preauthorized. D51-03 must be built only after that amended commit becomes the
new policy-host identity. It then reruns the complete deterministic
qualification from a clean carrier. A pass advances automatically through the
already approved three canaries, freeze, product matrix, eligible assessor,
sanitized closeout, and result commit. Any further qualification correction,
repeat of the same failure, material anomaly, controller-module delta, or
change to the approved Campaign envelope stops before model consumption and
returns one complete decision. There is no third correction or automatic D52.

### D51-03 Route Observation — No Authority Revision

Fresh D51-03 used the second and final correction. Its pre-adapter containment
guard and complete deterministic qualification passed 24/24 with zero model or
assessor turns. A local finalizer-shape error occurred and was corrected before
that official qualification; it creates no product observation and is retained
only as qualification history.

The next operator action invoked the inner transport-canary batch directly
instead of the declared outer `launch-gate2.ps1` transport-canary mode. Three
non-product canary `turn/start` events completed and establish only the inner
provider-response path. The required outer typed-scalar launch receipt is
absent. Freeze, product execution, terminal assessment, and assessor execution
did not start.

D51 therefore stops fail closed as `CANARY_ROUTE_INVALID / PRODUCT_UNKNOWN`.
The three canaries are immutable consumption and cannot be retried, replaced,
or reinterpreted as full-route qualification. No post-hoc receipt is created.
This observation changes no Work Charter SOURCE, case, fixture, matrix, rubric,
controller module, candidate, acceptance target, or prior evidence. It grants
no D52, installation, release, cleanup, or other external authority.

The portable semantic lesson is promoted through Decision 0020, the Runbook,
repository guidance, and the evaluation contract. Mechanical single-entry and
launch-receipt enforcement is `DEFERRED` to the exact tracked Work Charter
v0.2.0 outer runner. A separately authorized D52 may include that implementation
as its first zero-model tranche, but may not consume canary, product, or
assessor evidence until the owner passes outer-positive plus direct-inner and
invalid-receipt regressions under a fresh ruleset identity.

### WC-AR-D52-TRACKED-OUTER-DISPATCH — Bounded Gate 2 Campaign

**Confirmed.** D52 is one bounded serial Campaign against unchanged exact
candidate `c4810057c3f28cca9f12004ca2018784cd21f449` and five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`.
Released control remains `ceed607152849775b981c54add74bfa30d858e4d`.
D49's A01-A17 import terminal
`0d17dfba319d84455df9be6738e7be1268c212ec582830021debc7e200f362ec`,
D51 qualification receipt
`8e91071866a67a4bcbca1483fa2d9f933b18e385fb5f3d5e57c09f8db76a2002`,
and D51 inner-canary receipt
`78b41a197f0868d3a7dfa4a57c8d7cc03ae6638faee718440b8c3b80039e8489`
remain predecessor identities only. D51 stays
`CANARY_ROUTE_INVALID / PRODUCT_UNKNOWN`; none of its three consumed canary
turns is replayed, replaced, retried, rescored, or credited to D52.

The first tranche is zero-model and creates the tracked single entry
`evals/invoke-work-charter-gate2.ps1` plus its deterministic checker. The
runner owns phase-specific, hash-bound, one-shot receipts; exact child
executable, argv, working directory, and following dispatch; separate child
stdout/stderr capture; one integer exit status; nonzero propagation; and
exactly-once transition through the same outer entry. Outer and Inner execute
inside one runner process and share one fresh object capability whose reference
identity is never serialized; a receipt records its hash for audit but cannot
recreate that capability. Qualification must pass
the outer positive and child-nonzero paths plus duplicate-dispatch,
direct-inner, absent, stale, wrong-phase, wrong-hash, and reused-receipt
negatives before model consumption. Its checker is also a bounded consumer of
`evals/check-fixtures.ps1`. This tranche consumes zero model contexts, zero
`turn/start`, and zero assessor turns.

The first local commit is authorized only after the tracked diff is stable,
the mapped documentation-impact closure passes, all required deterministic
checks pass, and the applicable native-review cycle completes without an
unresolved finding. The two user-approved resets recorded at their checkpoints
are part of that applicable cycle authority; neither resets finding history or
authorizes a third reset. The exact commit message is
`evals: add tracked Work Charter Gate 2 dispatcher`. A tracked runner defect
found after that commit stops D52; it is not a private-carrier correction.

Only after that commit may the owner create one fresh ordinary non-reparse
ignored carrier at logical root
`.eval-runs/work-charter-v0.2-c481005-gate2-d52-single-entry/`. It must bind the
tracked runner commit and exact launcher hash, Campaign contract, fresh loaded
ruleset hashes, candidate/control, carrier manifest, frozen inputs, phase, and
remaining budget. It must begin absent and is never copied from, merged with,
or substituted for D51. At least D51's retained 24 deterministic conditions
plus the twenty-four runner conditions, including native-review-required argv-
cardinality and byte-snapshot isolation, independently authenticated
executable/shadow regressions, exact static Campaign/candidate identity,
tracked operation-table rejection, authenticated carrier/authority artifact
rejection, committed runner commit/blob binding, exact signed/hash-pinned Codex
plus bidirectional app-server round-trips, forged-production-policy rejection,
wrong-model input rejection, and a simulated authorized protocol positive must
pass as one D52 qualification result (at least 48/48). The additional runner
condition rejects a failed terminal turn before phase completion or successor
dispatch.
At most two pre-canary private-carrier-only corrections are available. They do
not permit tracked runner, SOURCE, case, fixture, matrix, rubric, controller,
candidate, permission, workspace, cost, or acceptance changes. No third
correction, operator recovery, or post-canary correction exists.

Receipt consumption and scarce-evidence consumption are separate events. The
tracked inner entry consumes its route receipt exactly once before starting
the bound child and before that child may submit `thread/start`; that proves
route provenance only. It also requires the live object capability from the
currently executing Outer, so a direct caller cannot self-issue matching files.
A canary, product cell, or assessor consumes its fresh
model budget exactly when the receipt-bound client submits that cell's first
`turn/start`. A completed `thread/start` without `turn/start` supplies no
product credit, and no later label, task, or carrier can undo either event.

After successful qualification, the same tracked runner transitions
automatically and serially through three same-boundary non-product canaries in
this exact order: Sol/high, Sol/xhigh, Terra/high. They consume at most three
fresh model contexts and three `turn/start` events. Only a complete canary gate
may freeze and start product evidence. Product evidence has twelve fresh
contexts and fourteen `turn/start`: two turns for the candidate calibration,
two for scored released-control A18, and one each for A19, A20, B01-B04, and
C01-C04. Imported D49 A01-A17 remain immutable and are not replayed. One
Terra/high assessor context and one assessor `turn/start` is available only
for the complete admitted packet. Total D52 fresh budget is therefore sixteen
contexts and eighteen `turn/start`; unused turns expire and do not transfer.

Local commit 1 is the immutable production authorization record, not merely a
launcher implementation. Its runner commits this exact phase order:
`canary-sol-high`, `canary-sol-xhigh`, `canary-terra-high`,
`candidate-calibration`, `released-control-a18`, `candidate-a19`,
`candidate-a20`, `candidate-b01` through `candidate-b04`, `candidate-c01`
through `candidate-c04`, and `assessor-terra-high`. Canary and `A` phases use
the model/effort named by the phase (`Sol/high` except the explicit xhigh and
Terra phases); `B01-B04` use `Sol/xhigh`; `C01-C04` and the assessor use
`Terra/high`. Calibration and A18 each authorize exactly two `turn/start`
requests; every other phase authorizes one. Before issuing a production
receipt, the runner must match the phase ordinal, exact model/effort, per-phase
turn count, pre-phase remaining total budget, canonical private artifact paths,
signed/hash-pinned app-server operation, and exact successor against that
committed table. Qualification-only and test operation IDs are rejected for
every production phase even when their remaining artifacts are self-consistent.
A production app-server stream must contain exactly one
tracked `initialize`, one matching `thread/start` with provider fallback
disabled, and the phase's exact number of matching model/effort `turn/start`
requests. Only after the carrier has observed that phase's completion may it
send the runner-local phase-complete control; that control is not forwarded to
app-server. The runner independently correlates every request ID to one error-
free result, sends the required `initialized` notification after the initialize
result, binds each turn to the returned thread, and requires the matching
`turn/completed` notification to carry terminal status `completed` before
accepting that control. The runner then starts the exact committed successor inside the
same top-level invocation, so a caller cannot enter a later phase directly.
Mutually consistent private hashes never substitute for this committed policy;
a mismatch fails before the first `turn/start` is forwarded.

D52 acceptance requires the scored combined packet to reach 28/28, the
non-scored candidate calibration to pass, and the sole eligible assessor to
return `ACCEPTED`. Any canary, shared qualification, identity, authority,
runner, freeze, controller, workspace, permission, or evidence-consumption
hard stop seals D52 under its observed terminal disposition before further
scarce evidence. Cell-local continuation is allowed only where the frozen
Campaign contract declared independence. No automatic retry, replay, rescore,
replacement assessor, D53, installation, release, or acceptance inference
follows from another terminal.

Terminal closeout may add one sanitized D52 result, update its mapped
canonical documentation owners, run a separate normal native-review cycle,
and create at most one second local commit with exact message
`docs: record Work Charter D52 Gate 2 result`. The owner then relinquishes the
repository writer with exact HEAD/index/dirty/private-carrier state. No native
review budget reset is preauthorized. Push, PR, merge, installation, tag,
release, stable-copy change, cleanup, SOURCE, behavior case, fixture, matrix,
rubric, controller module, other-Skill, user configuration, hidden predecessor
read, raw prompt/completion publication, and unlisted external effect remain
excluded.

### D52 terminal disposition

D52 created local commit 1
`410b0bd1f361688e4444ced48e0e9451be1787d6` with the tracked runner and
its zero-model evidence, then materialized one fresh private carrier from the
D50 certified credential-free bundle. The carrier used both authorized private
corrections before scarce evidence: `D52-P01` removed an offline-generated
Python cache, and `D52-P02` corrected rooted Windows Git command rendering.
The corrected path-bound round-trip passed five rooted positives and rejected
five bare-name plus five shadow-path variants. Neither correction changed the
tracked runner, SOURCE, candidate, permissions, or budgets.

The official carrier qualification completed stages 1-6. Stage 7's full-lane
deterministic gate then failed `model_authorization_envelope` because the frozen
run policy did not require the post-freeze authorization gate. This is a
private-carrier qualification-contract mismatch, not a Work Charter SOURCE,
candidate-behavior, tracked-runner, or provider finding. The required aggregate
48/48 qualification receipt was not created. No production phase descriptor or
receipt, canary, freeze, product cell, assessor, fresh model context, or
`turn/start` followed.

D52 is therefore sealed as `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`; exact
candidate `c481005...` remains `UNACCEPTED_AT_GATE_2`. The terminal receipt
hash is
`7c12bbdb8901b3ec825a8e671b43d21fa6c7b1a78761a7df4b824cb9397abd4d`.
There is no third private correction, retry, operator recovery, replay,
rescore, replacement assessor, automatic D53, or transfer of unused budget.
The evaluation line stops unless the user later authorizes one new complete
successor Campaign.

### WC-AR-D53-LAYERED-AUTHORIZATION-LIFECYCLE — Successor Gate 2 Campaign

**Confirmed.** On 2026-08-12 the user explicitly authorized one complete D53
successor Campaign for the unchanged stable subject. Exact candidate
`c4810057c3f28cca9f12004ca2018784cd21f449`, five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`,
and released control `ceed607152849775b981c54add74bfa30d858e4d` remain
unchanged. The required starting HEAD is
`0d63818bcbca78ff5e7f5b54a1fb2eaa2b518994` on clean `main` with an empty
index and no repository writer. D31-D50, D51-01 through D51-03, and D52 remain
immutable. D52's terminal receipt
`7c12bbdb8901b3ec825a8e671b43d21fa6c7b1a78761a7df4b824cb9397abd4d`,
both consumed corrections, and zero `turn/start` remain predecessor facts; D53
is a successor authority revision, not a retry, correction-budget reset,
replay, rescore, or acceptance transfer.

D53's outcome is one evaluation-infrastructure-only Gate 2 attempt that binds
the existing tracked outer runner and every private producer/consumer to this
single authorization lifecycle, in order:

1. `ZERO_MODEL_QUALIFICATION_PENDING`;
2. `CANARY_AUTHORIZED_AFTER_QUALIFICATION`;
3. `FREEZE_PENDING_AFTER_CANARIES`;
4. `PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION`;
5. `PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN`; and
6. `TERMINAL`.

The tracked runner is the canonical deterministic policy owner. It exposes the
six-state policy and one hash so private materialization derives it and every
binding, authority snapshot, carrier manifest, and frozen-input manifest
validates the same policy. D52-only pending/freeze states, a stale `23/23`
threshold, a missing or altered transition, and a wrong lifecycle hash fail
before receipt issuance or child start. The lifecycle records authority state;
it neither validates itself nor transfers action authority from installed
Work Charter `v0.1.2` to the candidate.

The runner divides the sixteen model phases into three independent dispatch
segments: three canaries, twelve product contexts, and one assessor. No next-
dispatch descriptor may cross a segment boundary. A real canary segment also
requires the exact formal 56/56 receipt. A real product or assessor segment
recursively validates that receipt, the exact three-route canary gate, the
post-canary freeze manifest, and a product-activation receipt bound to both the
freeze and this Campaign contract. Assessor entry additionally requires an
exact 28/28 admitted product packet, a packet-bound assessor view, a passing
local disclosure review, and an eligibility receipt bound to all three. The
zero-model lifecycle validator accepts an explicit evidence root only as a
diagnostic and returns no action authority. The action-provenance path accepts
only the exact D53 evidence root and recursively revalidates each canary's
binding, authority/carrier/frozen artifacts, argv and successor descriptor,
consumed receipt, completed typed-zero dispatch state, and committed runner
identity, including the inner no-clobber consumption claim bound to dispatch
and phase. Reset-cycle review 4/5 established that this persisted chain does not
by itself authenticate action provenance against a process that can write the
exact private root after the live outer capability has expired. At that review
boundary product remained blocked until a newer authority either preserved one
tracked live controller capability across segment boundaries or named an
independently trusted external anchor; merely adding another carrier hash was
not a correction.
The `TERMINAL` transition requires a typed, lifecycle-bound terminal receipt
with bounded correction/model counters and a non-accepting disposition, or, for
`ACCEPTED` only, the complete product, eligibility, and accepted-assessor chain.
Every non-accepting disposition must match its immediately preceding lifecycle
state; the frozen pre-product activation boundary has the distinct terminal
`ACTIVATION_FAILED / PRODUCT_UNKNOWN`.
An accepted assessment is hash-bound to the assessor eligibility and view plus
the consumed `assessor-terra-high` outer receipt, inner consumption claim, and
typed-zero completed dispatch state; diagnostic validation without exact-root
action provenance cannot validate acceptance. The canary gate also records the
configured receipt maximum age, and every later action-provenance check must
reuse that exact value rather than reverting to a default.
Within one segment the outer process owns one persistent input reader. Each
phase reads exactly its own initialize/thread/turn requests through its local
`phase_complete`, returns one typed exit, and only then dispatches its bound
successor, which continues from the same reader without replaying or consuming
another phase's lines. The tracked positive executes the complete three-phase
protocol shape under a distinct `qualification-segment-*` namespace. Synthetic
adapters remain forbidden for all real canary/product/assessor phase names and
cannot create production receipt evidence. Before assessor eligibility, the admitted packet must list all
twelve product phases in policy order with exact model, effort, turn count,
verdict, outer-receipt hash, dispatch-state hash, and inner-consumption hash.
An accepted terminal reopens every referenced product artifact and revalidates
all twelve completed one-shot dispatches; aggregate score fields alone cannot
authorize acceptance. That reopening does not recursively re-enter lifecycle
transition validation, but it always reapplies the committed static production
policy to each binding/carrier/frozen set: policy hash, phase ordinal, model,
effort, turn and remaining budgets, successor, operation, and executable anchor
must still match the exact phase policy.

**Material Replan Delta confirmed 2026-08-13.** The user explicitly authorized
the live-controller resolution under this same D53 Campaign. It preserves the
outcome, exact candidate/control/evidence identities, twelve tracked paths,
private root, correction and model budgets, acceptance, integration policy,
and excluded effects above; it resets no review, correction, model, canary,
product, or assessor history. The tracked runner now exposes one `Campaign`
entry that stays alive across canary, product, assessor, and terminal control.
Its unpersisted object capability owns the exact next segment, completed-
segment set, and full phase-evidence fingerprints. The private carrier may send
only exact newline-delimited `dispatch_segment` commands for `canary`,
`product`, or `assessor` in that order, followed by `validate_terminal`; the
controller derives every route, phase root, operation, and executable anchor
from tracked policy and rejects caller-supplied execution or lifecycle paths.

Within each segment the existing one-shot receipts, typed exits, same-reader
successors, and artifact checks remain unchanged. After a typed-zero segment
return, the live controller reopens every phase artifact, reapplies the static
production policy, hashes the binding, authority, carrier, frozen inputs, argv,
receipt, consumption claim, dispatch state, and successor descriptor, and
records those fingerprints only in memory. Product entry requires the live
canary completion plus byte-identical current fingerprints; assessor entry
requires the live product completion and twelve-route packet; accepted terminal
validation requires all live canary, product, and assessor fingerprints. A
direct production `Outer`, direct action-provenance validator, product-first
command, self-consistent persisted JSON chain, stale fingerprint, or caller-
selected route therefore cannot advance action. Persisted records remain audit
evidence, not an independent action capability, and this controller is not a
signature service or transferable authorization anchor.

The focused gate remains 32/32 and now includes rejection of direct diagnostic
JSON as action provenance and product-first Campaign dispatch. Reset-cycle
review 5/5 completed and returned one P1 alleging that initial segment
completion requested live-fingerprint validation before recording those
fingerprints. The reviewed call did not pass `RequireLiveCampaignEvidence`,
whose switch default was false, so direct source adjudication did not reproduce
the alleged control path. The predeclared finding stop nevertheless applied:
no correction, repeat review, commit, private root, or Layer A action followed.

**Review-finding disposition/reset confirmed 2026-08-13.** The user explicitly
authorized one new native-review cycle of at most five completed semantic
reviews for this same twelve-file D53 commit attempt. All earlier reviews,
findings, approvals, and budgets remain cumulative. The only initial correction
is to make the existing behavior explicit with
`-RequireLiveCampaignEvidence:$false` during the static initial-completion
pass; live revalidation remains mandatory only after the controller records the
phase fingerprint. The existing zero-model gates must pass against those final
bytes before review. Clear same-scope findings may be corrected within this
new review cycle; exhausted review budget, a repeated material finding, or any
change to outcome, tracked/private scope, candidate, authority, evidence
consumption, correction/model budgets, acceptance, integration, or excluded
effects stops at another user decision. A clean completed final-byte review
permits local commit 1 and the already authorized Layer A transition.

New-cycle review 1/5 found two same-scope P1 terminal-closeout gaps. First, a
non-accepting terminal returned before validating the evidence chain for its
declared `previous_state`. Every terminal now validates that predecessor before
acceptance-specific checks; the focused gate accepts a canary-failure terminal
with the exact formal qualification and rejects the same terminal when that
receipt is absent. Second, a typed nonzero child exit ended the `Campaign`
process before the private carrier could send `validate_terminal`. The live
controller now records the failed segment and typed exit, advances only to a
terminal-wait state, emits a `segment_failed` control result, and continues
reading. Terminal validation must match the live failed segment; only after it
passes does the controller return the original nonzero exit. The focused gate
remains 32/32, including an AST guard against the prior early-return shape.
New-cycle review 2/5 then found that `validate_terminal` could run while the
live controller still expected `canary`, `product`, or `assessor`, allowing an
early non-accepting terminal to bypass segment progression. Terminal validation
now requires `NextSegment == terminal`, which is reached only by a recorded
segment failure or successful completion of all three segments. The focused
gate rejects an initial terminal command and remains 32/32. Three reviews remain
in the new cycle.

The sole tracked writer owns only
`evals/invoke-work-charter-gate2.ps1`,
`evals/check-work-charter-gate2-runner.ps1`, and
`evals/check-fixtures.ps1`, plus the mapped documentation files named below.
It reuses the existing tracked owner and creates no new tracked runner, case,
fixture, matrix, rubric, scorer, or controller module. Private writes are
contained under ignored root
`.eval-runs/work-charter-v0.2-c481005-gate2-d53-layered-authorization/`.
No other tracked or private path is writable by this Campaign.

The first tranche is zero-model tracked implementation and qualification. The
focused runner gate must pass 32/32: all retained D52 outer-positive, typed
child-exit, exactly-once dispatch, direct-inner, absent, stale, wrong-phase,
wrong-hash, reused-receipt, executable, argv, artifact, protocol, and committed-
runner conditions plus eight D53 lifecycle conditions: exact positive;
wrong qualification state; wrong canary transition; wrong freeze state; wrong
activation state; stale `23/23` threshold; predecessor-only state leakage; and
lifecycle policy/hash mismatch. Fixture consumption remains 18/18. PowerShell
AST parsing, repository checker, diff check, Gitleaks, and one normal native-
review cycle of at most five completed reviews must pass. No review-count reset
is preauthorized. On success the writer creates exactly one local commit with
message `evals: bind Work Charter Gate 2 authorization lifecycle` before any
private rehearsal or formal carrier exists.

Private qualification is deliberately layered. Layer A is a disposable full-
chain rehearsal mirror: `r00`, followed only when each repeat names a concrete
risk reduction by at most `r01`, `r02`, and `r03`. These are three private
rehearsal correction rounds, distinct from D52 and from formal Layer B. Removal
of a generated cache under the rehearsal root before its manifest/freeze does
not consume a formal correction; recurrence of the same cache indicates a
builder defect and stops unchanged repetition. Layer A must exercise the real
materializer, finalizer, lifecycle producer/consumer handoff, qualification
gate, containment, and absence of model calls without writing outside its
declared mirror.

Layer B begins only after Layer A passes. It owns fresh formal carrier `f00`
and at most two formal corrections, `f01` and `f02`. A formal correction may
change only private policy, configuration, or materialization under the D53
root. It cannot change tracked files, SOURCE, candidate, cases, fixtures,
matrix, rubric, scorer/controller contract, permissions, workspace, model or
cost budget, or acceptance. Formal qualification is one indivisible 56/56
receipt: the retained 24 private deterministic conditions are re-executed in
the fresh D53 carrier and combined with the current tracked 32/32 runner gate.
No predecessor receipt or partial result supplies D53 credit. A repeated
material failure, exhausted Layer A or B budget, unexplained delta, containment
failure, contract drift, or inability to produce the exact 56/56 receipt seals
D53 `QUALIFICATION_FAILED / PRODUCT_UNKNOWN` with no scarce evidence.

Only the formal 56/56 receipt authorizes the same outer runner to dispatch the
three-phase non-product canary segment in order: `Sol/high`, `Sol/xhigh`, and
`Terra/high`. They consume at most three fresh contexts and three `turn/start`.
The third canary has no product successor descriptor. A complete canary gate advances to
`FREEZE_PENDING_AFTER_CANARIES`; successful freeze records
`PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION`; the already approved D53
Campaign plus matching frozen evidence then permits
`PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN` and a separate twelve-phase product
segment. The assessor is a third one-phase segment after its eligibility packet
exists. No separate chat approval is needed for these predeclared transitions,
but every model dispatch and transition-evidence validation passes through the
same tracked outer runner and lifecycle hash. Receipt consumption occurs once
inside the tracked inner entry before the child starts. Scarce evidence is
consumed only when the receipt-bound client submits that phase's first
`turn/start`.

D49 A01-A17 may be imported only through their immutable provenance rows and
are not replayed. Fresh product evidence has twelve contexts and fourteen
`turn/start`: two for candidate calibration, two for scored released-control
A18, and one each for A19, A20, B01-B04, and C01-C04. One eligible `Terra/high`
assessor has one context and one `turn/start` only after the required admitted
packet. Total D53 fresh budget is sixteen contexts and eighteen `turn/start`.
Unused budget expires and does not transfer. The scored combined packet must
reach 28/28, candidate calibration must pass, and the sole assessor must return
`ACCEPTED`; aggregate scoring cannot compensate for an authorization, safety,
identity, route, freeze, or evidence-integrity failure.

Terminal closeout may create one sanitized
`evals/results/2026-08-12-work-charter-d53-gate2-terminal.md`, update the mapped
canonical consumers, run their deterministic checks and a separate normal
native-review cycle of at most five completed reviews with no preauthorized
reset, then create exactly one second local commit with message
`docs: record Work Charter D53 Gate 2 result`. Recovery preserves exact HEAD,
index, dirty paths, ignored D53 inventory, lifecycle/qualification receipts,
correction use, every consumed context/turn, and current writer before any
continuation or handoff. Any unsupported host/model route, ruleset/HEAD/branch/
cwd/dirty/writer/candidate/freeze/evidence drift, unowned write, ambiguous
consumption, material permission/cost/acceptance change, exhausted budget, or
native-review blocker stops at the applicable terminal or user decision.

Mapped documentation disposition for the tracked tranche is `UPDATE` for this
decision, `evals/README.md`, Work Charter State and Verification, root Status,
Verification, Roadmap, Index, and Handoff. `CHECKED_NO_CHANGE` applies to root
and Skill README pairs, Authority, SPEC, Architecture, Runbook, Provenance,
Decisions 0017/0020, Work Charter SOURCE/Design/cases/fixtures/matrix/rubric/
scorer/controller/package files, and the result index before a terminal result
exists. `NOT_APPLICABLE` covers discovery, installation, push, PR, merge, tag,
release, stable-copy change, cleanup, public publication, SOURCE behavior
change, predecessor mutation, and automatic D54. Those effects remain
excluded, as do raw prompt/completion/session publication, hidden predecessor
reinterpretation, replacement assessment, and any unlisted external effect.

#### D53 observed terminal

New-cycle review 3/5 returned no actionable issue against the final tracked
lifecycle bytes. Local commit
`4ab8a025d54105f802077c385b0824cd97446e23` records the 32/32 runner,
18/18 fixture consumer, mapped authority, and lifecycle policy SHA-256
`b21518530b2990bada6364e6dd25aeda99efd26fceebe6107ad2ebdfe656eeb4`.
This is zero-model infrastructure proof only.

Layer A then created one fresh rehearsal from the certified D50 source bundle
without transferring predecessor receipts or credit. `r00`, `r01`, `r02`, and
`r03` are retained. Their three corrections respectively bound reusable same-
path templates by bytes, added one missing declared private pin, and supplied
an explicit repository root to nested setup consumers. Final `r03` passed
materialization, finalization, and official stages 1-6. Stage 7 failed before
its first full-lane child could import immutable D49 evidence because an
inherited importer inferred the predecessor carrier from nested directory
depth. The launch returned typed scalar exit 1, disabled retry, and consumed
zero behavior `turn/start`.

All three Layer A corrections are exhausted. Layer B, `f00`, aggregate 56/56,
the lifecycle consumer, production receipts, canary, freeze, product, assessor,
model context, and `turn/start` did not start. Terminal receipt SHA-256 is
`e8e9fb645b83beaa9c64cd5ccf3d8fc3e283d21cdbb964cde8c72adb8849882b`.
D53 is therefore sealed `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`; candidate
`c481005...` remains unaccepted.

The tracked lifecycle and terminal guards are `PROMOTED` through commit
`4ab8a025...` and focused 32/32. The nested predecessor-root lesson is
`DEFERRED`, owned by any separately authorized successor's private builder and
reconsidered only under that successor; D53 does not claim it is fixed.
Repairing, moving, copying, or crediting a sealed predecessor carrier to bypass
the failed rehearsal is `REJECTED`. No retry, replay, rescore, automatic D54,
installation, release, cleanup, or other external effect follows.

### WC-AR-D54-EXPLICIT-ROOT-CONTRACT — Successor Build And Evidence Campaign

**Confirmed.** On 2026-08-13 the user explicitly authorized one complete D54
Campaign for unchanged candidate
`c4810057c3f28cca9f12004ca2018784cd21f449`, five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`,
and released control `ceed607152849775b981c54add74bfa30d858e4d`. Its Build
baseline is clean `main@d4374b381444b85fff4941e73cf7a8d32f18a96e` with an
empty index and one repository writer. D51-D53, their carriers, corrections,
consumed evidence, and D53 terminal receipt
`e8e9fb645b83beaa9c64cd5ccf3d8fc3e283d21cdbb964cde8c72adb8849882b`
remain immutable. D53 stays `QUALIFICATION_FAILED / PRODUCT_UNKNOWN`.

D54 makes repository, carrier, source-bundle, evidence, and predecessor roots
authenticated outer-contract inputs. No consumer may derive one from the
current directory, siblings, `__file__` ancestry, or directory depth. Before
consumption it resolves the declared root and proves containment, absence of a
reparse/symlink boundary, expected identity or hash, and expected schema;
missing, wrong-root, outside-root, reparse-routed, hash-mismatched, and schema-
mismatched inputs fail closed. Focused deterministic coverage includes a
nested positive and a decoy sibling as well as every negative above.

The Build Session must first pass focused deterministic checks, then run the
real materializer, finalizer, predecessor importer, private 24/24, tracked
32/32, aggregate 56/56, lifecycle consumer, and synthetic next-phase dispatch
in order inside one disposable D54 DEV mirror. It stops before the first
`thread/start` and must prove zero model calls, zero `thread/start`, zero
`turn/start`, and zero writes outside the declared mirror. DEV records are
implementation qualification only and cannot supply formal, canary, product,
assessor, or acceptance credit.

The correction history remains cumulative. The original three and the first
two added rounds were consumed by bundle-hash, inferred-root, manifest-order,
checker-pin/transport, and generated-module-pin failures. The user then added
five more rounds without resetting history. Rounds 06 and 07 rebound all
private module pins and then authenticated the actual D54 repository identity;
round 07 completed the full DEV path. Round 08 restored repository-checker-
required D53 historical fragments while retaining D54's separate-authority
meaning. Two added rounds remain unused for
same-scope Build correction only and do not transfer to formal evidence,
native review, or a later Campaign.

Only after the complete DEV path passes may documentation impact close, the
tracked diff stabilize, and native review begin. Native review uses
`Terra/high`, permits at most five completed semantic reviews, and has no
preauthorized reset. Any finding-related code change requires the affected
complete DEV path again before another review. A passing gate authorizes one
local commit with subject `evals: bind Work Charter D54 explicit roots`, no
push, merge, installation, tag, release, stable update, or cleanup.

After Commit 1, the Build Session verifies clean state across registered
worktrees, relinquishes its writer, and mechanically creates one Fresh Evidence
Session. That Session must reread the current rules and bind the final commit,
ruleset, runner, checker, candidate, workspace, writer, permission, predecessor,
and carrier identities before creating a new formal carrier. The Build Session
must not consume formal canary, product, or assessor evidence.

Formal qualification is a fresh indivisible 56/56 with no correction. Failure
seals D54 `QUALIFICATION_FAILED / PRODUCT_UNKNOWN` and stops. A passing formal
receipt authorizes, in order, three canaries, the already specified twelve
product contexts with fourteen product `turn/start`, and at most one eligible
assessor. Total fresh capacity is sixteen contexts and eighteen `turn/start`.
Formal qualification or canary failure seals the Campaign and forbids product
and assessor. Ruleset, candidate, workspace, writer, permission, budget, or
other material-boundary drift returns to the user; no automatic D55 or review-
budget reset follows.

The Build gate completed and local commit
`9fe27bbd22cda34938e3e91c6c09ea72bf5a18e7` recorded the reviewed explicit-
root target. Clean reconciliation across both registered worktrees
relinquished its writer, and the mechanically created Fresh Evidence Session
rebound the final ruleset, runner/checker, candidate/control, workspace/writer,
permission, and predecessor identities without obtaining repository writer
authority.

That Session created only `formal-f00`. Its single formal qualification
returned exit 86 at `bootstrap`, before materialization, finalization,
predecessor import, private 24/24, tracked 32/32, aggregate 56/56, lifecycle
consumption, or synthetic dispatch. Three `Join-Path` calls embedded in
positional pin arrays bound each expected hash and label as additional
`ChildPath` arguments; the resulting single-value pin made `$pin[2]` fail.
This is an ignored formal-orchestrator bootstrap defect, not a Work Charter
candidate or product finding.

No root contract or lifecycle terminal was created. Model contexts,
`thread/start`, `turn/start`, and assessor starts are all zero; canary, product,
and assessor were not authorized or started. D54 is sealed
`QUALIFICATION_FAILED / PRODUCT_UNKNOWN`. The `formal-f00` orchestrator,
failure JSON, and failed summary are byte-bound and immutable. They are not
repaired, replaced, rerun, or cleaned, and D55 does not start automatically.

### WC-AR-D55-TRACKED-FORMAL-BOOTSTRAP — Successor Build Campaign

**Confirmed.** The user separately authorized D55 as a new successor Campaign
from clean `main@8c952abb5161c3082fb4d9a09e49a0a183b84ab0`. D55 preserves exact
candidate `c481005...`, manifest `04c382...`, control `ceed607...`, and all
D31-D54 carriers/evidence. It changes no Work Charter SOURCE, cases, fixtures,
matrix, rubric, scorer, or generic controller and supplies no D54 retry,
reinterpretation, or acceptance credit.

Tracked `invoke-work-charter-gate2.ps1` now owns the formal outer bootstrap.
The exact ordered pin set uses objects with `Path`, `Sha256`, and `Label`
fields. The runner rejects positional arrays and missing/extra fields, validates
ordinary non-reparse identity, applicable containment, hash, schema, repository
identity, and the existing explicit-root contract, and uses one typed scalar
return. Pre-lifecycle failure writes an immutable D55 bootstrap terminal and a
failed summary with one non-null terminal pointer; after lifecycle establishment
the existing normal lifecycle terminal applies, and the two are mutually
exclusive.

Focused bootstrap checks pass 18/18 without changing tracked 32/32. The initial
composed DEV attempt and all four risk-reducing corrections are retained. They
authenticate the tracked subject/status set, preserve carrier freshness,
ordinal-sort the complete subject set, restore repository-checker-required
recovery/writer fragments, and bind the DEV correction ceiling to four while
formal remains at zero corrections. A caller-only launch then supplied relative
failure/terminal paths and failed before bootstrap without creating a stage or
terminal artifact. It was not a fifth code correction. Separately authorized
one-shot launch recovery R1 consumed the absolute fields from authenticated
`dev-c04-final` `attempt.json` and passed bootstrap, materializer, finalizer,
predecessor importer, private 24/24, tracked 32/32, aggregate 56/56, lifecycle
consumer, and synthetic next-phase dispatch, stopping before first
`thread/start`. Model calls, contexts, thread starts, turn starts, assessor
starts, and repository writes outside the disposable mirror are all zero. This
is `DEV_IMPLEMENTATION_QUALIFICATION` only.

Native review 1/5 found two P1 trust gaps: raw `BootstrapFailureRoot` remained
reachable before complete authentication, and contract-supplied executable
path/hash pairs could self-authorize. Under the user-approved H1 hardening
authority, correction 5 made pre-authentication rejection typed exit 86 plus
stderr with zero writes, restricted bootstrap-terminal writes to authenticated
`Context.FailureRoot`, and independently bound Git, PowerShell, and verified
Python 3.12.10 executable anchors. The focused suite expanded to 14/14 with
pre-auth outside/root-mismatch and executable shadow/wrong-path/wrong-hash
negatives.

Fresh `dev-h1-c05` reached private qualification and exposed two tracked
absolute-path literals rejected by repository publication safety. Correction 6
retained the same fixed Python path/hash/signature/version identity while
deriving its system-volume root independently of cwd, PATH, `Get-Command`,
siblings, or file ancestry. Repository safety and 14/14 passed. Fresh one-shot
`dev-h1-c06` then passed bootstrap, materializer, finalizer, predecessor import,
private 24/24, tracked 32/32, aggregate 56/56, lifecycle, and synthetic dispatch
through `STOPPED_BEFORE_FIRST_THREAD_START`, with every model/start and outside-
write count zero.

Native review 2/5 found two further P1 trust gaps: the self-hashed bootstrap
contract could select an arbitrary self-hashed materializer, and formal evidence
could disable repository cleanliness. Correction 7 binds materialization-tool,
source-manifest, and predecessor evidence hashes to tracked policy; only the
immutable D54 tool and its deterministic D55 rewrite are admitted for DEV, and
formal admits only the rewrite. `FORMAL_CAMPAIGN_EVIDENCE` must declare and
prove a clean checkout. Focused 16/16 adds direct self-authorizing-tool and
formal-clean-policy zero-write negatives. Fresh `dev-h1-c07` passes the full
route through `STOPPED_BEFORE_FIRST_THREAD_START`, with every model/start/
assessor and outside-write count zero. H1 then stood at 7/7 corrections and
supplied no formal, product, assessor, or acceptance credit.

Native review 3/5 found two P1 environment gaps: repository checks honored
inherited `GIT_*` overrides, and pinned Python stages honored inherited
`PYTHONHOME`/`PYTHONPATH`. Under user-approved H2, correction 8 removes Git
overrides, binds `safe.directory` directly to the authenticated repository
root, starts every Python stage with `-I`, and removes Git/Python overrides from
those children. The focused suite then rose to 17/17. `dev-h2-c08` remained
`PREPARED_NOT_STARTED` after the isolated launcher lost the sandbox
safe-directory configuration; an explicit rooted argument closed that
transport boundary. `dev-h2-c08-safe` then sealed at pre-auth exit 86 with no
terminal/model/start because the ignored H2 launcher cast each `StartsWith`
Boolean to a non-empty string and removed its complete child environment.
Correction 9 fixed that launcher-only defect and a deterministic probe proves
unrelated environment anchors remain present.

Fresh hostile-environment `dev-h2-c09` passes bootstrap, materializer,
finalizer, predecessor importer, private 24/24, tracked 32/32, aggregate 56/56,
lifecycle, and synthetic dispatch through
`STOPPED_BEFORE_FIRST_THREAD_START`. All seven Python stage receipts begin with
`-I`; every model/context/thread/turn/assessor/outside-write count is zero.
Corrections then stood at 9/10. Native review 4/5 found one P1 one-shot gap: an
existing normal lifecycle terminal did not block a new bootstrap preflight.
Correction 10 rejects either terminal type or a failed summary after complete
contract authentication and before preflight/stage writes. A combined negative
preserves each seeded terminal hash, returns exit 86, and writes no preflight or
failed summary; focused coverage is 18/18. Fresh hostile-environment
`dev-h2-c10` passes private 24/24, tracked 32/32, aggregate 56/56, lifecycle,
and synthetic dispatch through `STOPPED_BEFORE_FIRST_THREAD_START`; every
model/context/thread/turn/assessor/outside-write count is zero. H2 supplies no
formal, product, assessor, or acceptance credit.

Native review 5/5 found one P1 tracked-identity trust gap: the caller-supplied
bootstrap contract could still self-authorize the tracked runner/checker paths
and hashes. Under user-approved H3, correction 11 adds a separately rooted and
hash-authenticated `work-charter-d55-revision-authority/v1` record. Its exact
runner/checker paths and hashes are cross-bound to the authenticated repository,
bootstrap pins, expected HEAD, evidence class, and reviewed-commit status before
any output. Nine direct containment, schema, commit-status, evidence-class, and
path/hash negatives raise focused coverage from 18/18 to 27/27.

The first H3 attempt, `dev-h3-c11-final`, reached private 24/24 before its outer
tool transport timed out. It produced no typed terminal or result, remains
sealed, and did not consume another code correction. User-approved one-shot R2
created fresh `dev-h3-c11-r2`, consumed authenticated absolute attempt fields
through structured argv, and completed bootstrap, materializer, finalizer,
predecessor import, private 24/24, tracked 32/32, aggregate 56/56, lifecycle,
and synthetic dispatch through `STOPPED_BEFORE_FIRST_THREAD_START`. The outer
call used a 960-second timeout and 60-second waits and completed in 464.6
seconds. Model calls/contexts, thread starts, turn starts, assessor starts, and
outside writes are 0/0/0/0/0/0. Correction 11 is consumed.

Documentation-impact closure then changed the mapped `evals/README.md` ruleset
source. Correction 12 freezes its final text, updates the runner/checker's exact
normalized-text pin, and creates fresh `dev-h3-c12-final`. Focused 27/27 and the
complete private 24/24 + tracked 32/32 = aggregate 56/56/lifecycle/synthetic
route pass through `STOPPED_BEFORE_FIRST_THREAD_START`; every model/context/
thread/turn/assessor/outside-write count remains zero. Correction 12 is
consumed; corrections 13-15 remain unused. This is DEV implementation
qualification only. The newly authorized Terra/high native-review cycle is the
next gate.

Native review 1/5 found one P1 remaining caller-self-authorization path: formal
still trusted the submitted revision-authority Path/SHA pair. Correction 13
embeds the exact formal v2 record SHA-256 in the tracked runner. The record binds
the stable candidate, formal evidence class, reviewed-build policy, fixed
repository-relative runner/checker identities, the runner's anchor-field-zeroed
normalized-text hash, and checker raw hash. A self-rehashed caller v1 record now
fails before output, while the exact v2 record reaches the next material-policy
gate. Focused coverage is 28/28. Fresh `dev-h3-c13-final` passes private 24/24,
tracked 32/32, aggregate 56/56, lifecycle, synthetic dispatch, and
`STOPPED_BEFORE_FIRST_THREAD_START`; every model/context/thread/turn/assessor/
outside-write count is zero. Correction 13 is consumed; corrections 14-15
were available at that checkpoint.

Native review 2/5 found that the formal v2 policy still did not bind to the
exact reviewed repository revision. Correction 14 adds
`evals/work-charter-d55-formal-revision-authority.json` as the narrow tracked
authority owner. The runner requires its fixed raw hash, exact schema and
runner/checker identities, then uses independently anchored Git to require the
owner's last-change commit to equal both the contract's expected HEAD and the
authenticated actual HEAD. This avoids a self-referential commit literal while
rejecting a later or alternate clean revision that did not change the tracked
owner at that HEAD. A wrong-HEAD negative raises focused coverage to 29/29.
Fresh `dev-h3-c14-final` passes 24/24 + 32/32 = 56/56, lifecycle, synthetic
dispatch, and `STOPPED_BEFORE_FIRST_THREAD_START`, with every model/context/
thread/turn/assessor/outside-write count zero. Correction 14 is consumed;
correction 15 remains unused. This remains DEV implementation qualification
only; native review 3/5 is next.

Native review 3/5 repeated the same P1 trust-boundary finding: repository-local
bytes could not independently prove review when one writer controlled the
authority declaration, verifier, and purported reviewed bytes. The task stopped
at `DECISION_REQUIRED`. The user then approved `CONTROL_PLANE_BOUND A′` without
resetting corrections, reviews, carriers, or evidence. Correction 15 deletes
the untracked `evals/work-charter-d55-formal-revision-authority.json` proposal
and removes the formal v2 hash anchor, anchor-zeroed runner hash, tracked-owner
last-change-at-HEAD rule, `NATIVE_REVIEW_PASSED`, and review-count checks.

The retained `RevisionAuthority*` interface is now a mechanical revision-
integrity record only. Its v1 schema binds the evidence class, authenticated
repository HEAD and branch, and exact absolute runner/checker paths and hashes
to the bootstrap pins; containment, ordinary-file identity, record hash, and
schema still fail closed. An added `review_status` field is rejected rather
than trusted. The runner therefore cannot approve its own review or select the
commit eligible for Fresh Evidence. Those decisions belong exclusively to the
user/Planner/Harness control plane. Correction 16 remains reserved; focused and
fresh composed zero-model DEV qualification plus a new at-most-three-review
cycle are required before the authorized local Build commit.

The R1 launcher lesson is recorded for post-D55 disposition: future launchers
must consume a hash-bound authenticated attempt record directly rather than
reconstruct authority-bearing paths from cwd, relative literals, siblings, or
repeated `Join-Path` logic. R1 proves only its ignored D55 recovery boundary;
generic tracked enforcement is `DEFERRED` to any separately authorized post-D55
launch owner and is not introduced by this Build.

The D54 bootstrap lesson is `PROMOTED` only by the local reviewed D55 Build
commit containing the tracked runner/checker and focused plus complete composed DEV
checks. Before that
commit it remains non-active DEV evidence. After commit, a separate Fresh
Evidence task must rebind the exact ruleset, runner/checker, commit, candidate,
workspace/writer, permission, tools, roots, and predecessor identities and
create a new carrier. D55 formal qualification has no correction. No D55
formal, canary, product, or assessor evidence runs in the Build, and no D56
follows automatically.

### D55 Terminal And `v0.2.0` Prerelease Preparation

D55 later consumed C16/C17 and sealed
`QUALIFICATION_FAILED / PRODUCT_UNKNOWN`. Its exact sanitized failure mechanism
remains `UNKNOWN`; no formal, canary, product, assessor, acceptance, or D56
evidence followed, and the D55 writer relinquished. This terminal closes the
former Fresh-evidence route without changing the Build history or creating a
Work Charter product finding.

The separate minimal claim evaluation uses only admitted exact-candidate
D45-D49 cells and one independent read-only assessor. C1-C5 are `ACCEPT` with
zero fresh product starts. A20, the full 28-cell matrix, cross-model evidence,
real-project efficacy, deterministic lock/router proof, installation, stable
loaded-copy, tag, and release claims remain outside that verdict.

The authorized prerelease preparation classifies Work Charter as the only
`changed` public Skill relative to `v0.1.2`: its five files must match exact
`c481005...` and manifest `04c382a4...`. Project Docs and PowerShell are
`unchanged` and must match all six/five `ceed607...` package blobs. The source
root's dirty D55 runner/checker implementation is not an input. This authority
ends at one verified local commit; it does not authorize `RC_INSTALL`, push,
tag, release, stable update, cleanup, or publication.

## Important Rejected Alternatives

- Require exact `$work-charter` syntax from users.
- Bootstrap or preload a universal workflow for every conversation.
- Treat native package loading as user confirmation, adoption, or authority, or
  force Work Charter loading for ordinary and near-neighbor negatives.
- Treat installation as permission to monitor, inspect, or mutate a project.
- Hard-code one model or reasoning level as the product baseline.
- Automatically select and apply a level after environment inspection.
- Make `/goal` mandatory or treat Goal state as the Charter.
- Require a dedicated Work Charter file for every project or forbid durable
  markers entirely.
- Treat root `WORK_CHARTER.md` as universally authoritative across worktrees.
- Infer adoption or conflict from repository membership, an old task, file
  presence, branch count, or elapsed time alone.
- Claim that a prose Skill can lock, stop, or reroute other Codex tasks.
- Treat one product-design approval as blanket authority for implementation,
  remote publication, user-environment mutation, and cleanup.
- Require a new confirmation for every command inside an otherwise unchanged,
  explicitly approved lifecycle gate.

## Relationship To Earlier Decisions

- [Decision 0007](0007-independent-skills-and-optional-recipes.md) remains
  authoritative for independent Skills and non-propagating optional recipes.
- [Decision 0008](0008-work-charter-logical-contract-and-codex-carriers.md)
  remains authoritative for the five-part logical Charter and carrier
  independence; this checkpoint refines adoption, durability, and fallback
  selection for a future revision.
- [Decision 0012](0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
  remains the current implemented product basis. This checkpoint proposes a
  future internal `L0`-`L4` refinement without changing the public Work Charter
  or Standard O/P/E names.
- [Decision 0016](0016-work-charter-authority-assessment-and-evidence-integrity.md)
  remains authoritative for authority finality, assessment recording,
  evidence invalidation, delivery degradation, and advisory writer recovery.
- [Decision 0017](0017-capability-delta-skill-development.md) owns the
  capability-delta method and the boundary against universal monitoring or
  duplicated model/Harness behavior.

This accepted design governs the `v0.2.0` development line. Work Charter
Design, SOURCE, State, and Verification change only under the separately
authorized writer and evidence gates recorded in the live handoff; design
acceptance itself supplies no lifecycle authority.
