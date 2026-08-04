# 0018: Work Charter Adoption, Protection Levels, And Re-entry Checkpoint

Date: 2026-08-02
Amended: 2026-08-04
Status: accepted design; exact `72db7e9...` sealed a fixed-turn Standard `VIOLATION`, and the conditional-role-read correction is implemented and offline-verified without candidate or behavior evidence; Git disposition belongs to the live commit-attempt record

- Planning checkpoint: 14 (conditional role reads and evidence attribution)
- Last incorporated decision: `WC-AR-D26`
- Open decision IDs: none
- Lifecycle authority: this Decision grants none; consult `docs/HANDOFF.md` for
  the live next gate
- Checkpoint reason: completed product-design decision set plus the accepted
  convergence and honest indirect-entry corrections

## Status And Evidence Boundary

This document preserves the accepted outcome of the Work Charter product
discussion. Each item marked **Confirmed** reflects an explicit user decision.
No open product-design decision remains in this scope. Implementation and every
lifecycle gate below still require their own future authority.

It does not describe current executable behavior. The current five-file SOURCE
and the immutable `v0.1.2` stable package remain governed by
[Work Charter Design](../skills/work-charter/DESIGN.md),
[State](../skills/work-charter/STATE.md), and
[Verification](../skills/work-charter/VERIFICATION.md). No selection,
trigger-accuracy, model-adaptation, real-project, or enforcement claim follows
from this discussion record.

This checkpoint authorizes no Skill SOURCE or evaluation change, project or
user-environment mutation, role delivery, worktree, Git action, installation,
release, external effect, or private-global-rule change.

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
only a metadata-level proposal. That response says Work Charter appears
applicable and asks whether to activate it; it does not claim the Skill is
selected, loaded, or active.

Before the user authorizes additional inspection, either path may use only the
conversation and context already supplied by the Harness. It must not call
tools to inspect project-specific files, Git state, worktrees, tasks, or other
environment details.

### WC-AR-D03 — Activation And First Project-Read Authorization

**Confirmed.** Entry uses progressive authorization:

1. for direct intent, load the full Skill and only then say that Work Charter is
   now being used; for an indirect match, say only that it appears applicable
   and ask whether to activate it. Preserve exact copy identity as `UNKNOWN`
   when the runtime does not expose it, without claiming a revision or blocking
   ordinary activation;
2. after the direct load or the load following confirmation, rely on the full
   Skill to describe the smallest proposed read scope, such as project rules,
   declared canonical owners, and the current branch/worktree/writer boundary;
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
| Natural-language explicit intent | Activate, load, and discuss Work Charter without requiring exact syntax | Project inspection, persistent adoption, roles, writes, or side effects unless separately approved |
| Indirect or symptom-only match | Use metadata to say Work Charter appears applicable and propose activation plus the smallest next step | Claiming selected/loaded state, loading the body before confirmation, additional project reads, adoption, coordination changes, or mutation |
| Visible standing-policy reuse | Reuse an applicable previously approved policy and show the user that it is being reused | Authority beyond the policy, silent role delivery, or a material contract change |
| Material change | Request fresh approval before changing outcome, hard boundaries, coordination responsibilities, canonical carrier, workspace/writer routing, permissions, or side effects | Treating an old marker, profile, or policy as sufficient authority |

Initial persistent adoption and the first Standard standing policy remain
explicit user decisions. Later policy reuse must remain visible. A standing
policy can coexist with an ordinary Flat task and does not automatically place
every task in the project under Work Charter.

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
  metadata-only proposal that asks whether to activate Work Charter; or
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
19-run minimum matrix rather than a full product of model, reasoning level,
protection level, trigger phrase, and workspace topology. Stop the matrix when
a hard selection or authorization boundary fails instead of spending the
remaining long-path budget.

#### Evidence Lanes

| Lane | Fresh runs | Minimum purpose |
|---|---:|---|
| Native baseline without the target Skill | 2 | Observe one ordinary task and one consequential continuation request under the strongest practical no-target-Skill condition |
| Realistic catalog selection | 6 | Exercise three natural-language positives and three ordinary or peer-Skill negatives without preselection |
| Exact candidate behavior | 7 | Exercise first adoption, `L1`/`L2`, all four re-entry routes, `L3`, and visible-policy `L4` behavior |
| Exact accepted-control comparison | 4 | Compare positive selection, negative selection, first-turn read authority, and ambiguous fail-closed behavior against the exact current control |

The six selection runs are:

1. natural-language use of Work Charter without exact invocation syntax;
2. a request to choose among already installed Skills, followed in the same
   context by an activation-only confirmation that must load the exact Skill
   while still performing no project read;
3. symptom-only continuity, authority, writer, recovery, or assessment risk,
   which must remain a metadata-only proposal;
4. an ordinary bounded task that must remain Flat;
5. a Project Docs-only near neighbor; and
6. a PowerShell-only near neighbor.

The seven exact-candidate behavior runs are:

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
   existing bounded `L4` O/P/E path with no automatic next phase.

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

- Run the complete 19-run matrix on one exact reference combination.
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
| Exact reference model/reasoning cell | 19 | Full bounded candidate matrix for that cell |
| Same model, one different reasoning setting | 4 | Reasoning sensitivity smoke only |
| Alternate intended model, one controlled reasoning setting | 4 | Model robustness smoke only |

Thus a revision uses 19 runs for one exact tested cell, 23 with reasoning
contrast, and at most 27 when one alternate intended model is also included.
Tokens, latency, and interruption counts are compared only within matched
model/reasoning conditions.

### WC-AR-D18 — Exact Reference And Contrast Evaluation Cells

**Confirmed.** Subject to a later execution authorization and actual model
availability, use these exact evaluation cells:

| Purpose | Model family | Reasoning setting | Fresh runs |
|---|---|---|---:|
| Full reference matrix | Sol | `high` | 19 |
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
19- or 23-run bounded result without claiming support for that contrast. Do not
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
| `SKILL.md` frontmatter | Direct natural-language activation, indirect/symptom metadata proposal, confirmation-time loading, discriminative non-triggers, and the no-false-loaded-claim boundary |
| `SKILL.md` body | Activated entry and first-project-read authority, the compact `L0`-`L4` choice, one-carrier rule, optional Goal boundary, four re-entry routes, and links to conditional detail |
| `references/coordination-and-recovery.md` | Entry/re-entry read order, `L1`/`L2` durability, carrier/fallback and managed-workstream rules, workspace/writer/evidence reconciliation, route precedence, multi-worktree behavior, and `L3` P/E detail |
| `references/standard-ope.md` | Only the `L4` delta: standing-policy approval and visible reuse, O/P/E responsibilities and path, control-location requirement, and honest delivery degradation |
| `assets/work-charter.md` | Optional no-existing-owner durable carrier with applicability, level/responsibilities, locator/revision, workspace/writer, checkpoint/evidence, next action, and reconfirmation fields |
| `agents/openai.yaml` | Concise UI metadata, a natural-language default prompt, and the existing implicit-invocation flag |

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
| 2 — Exact-candidate evaluation | One exact public candidate receives the bounded model and installed-copy assessment | Push the named candidate SHA to the named candidate branch, materialize an isolated `RC_INSTALL`, complete the required 19-run `Sol/high` reference plus each available approved four-run contrast for 19, 23, or 27 total runs, record any unavailable contrast `UNVERIFIED` without substitution, and use one authorized independent read-only assessor; an unavailable or incomplete reference stops without candidate acceptance, and no `main` integration, stable update, tag, or GitHub Release is authorized |
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
   writer, or assessment risk, use surfaced metadata only. Say that Work
   Charter appears applicable, explain the observable reason, propose the
   smallest bounded project read, and ask whether to activate it. Do not claim
   the Skill is selected, loaded, invoked, or active, and do not inspect the
   project.
2. **Confirmed activation.** After the user confirms, load the full
   `SKILL.md` and only then make activation visible and follow its entry
   workflow. An explicit `$work-charter` invocation or ordinary-language
   request that directly names and asks to use Work Charter enters at this stage
   without requiring a separate activation question, but keeps the same
   load-before-claim order. If the runtime does not expose exact copy identity,
   preserve it as `UNKNOWN` and do not claim a revision; this alone does not
   block activation.
3. **Bounded project read.** Activation is not read authority. Inspect only an
   exact scope the user approves or an exact scope visibly reused from an
   applicable standing policy. The user may bundle activation and that scope
   in one clear response.

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

## Important Rejected Alternatives

- Require exact `$work-charter` syntax from users.
- Bootstrap or preload a universal workflow for every conversation.
- Claim that Work Charter is selected or loaded from a metadata match, or load
  its full body for every indirect symptom merely to make that claim.
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
