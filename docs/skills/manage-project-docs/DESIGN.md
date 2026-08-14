# Project Docs Design

Last updated: 2026-08-14

## Purpose And Audience

Project Docs serves programmers and technical independent developers who
already use coding agents but lack reliable project-document governance. Its
job is semantic responsibility routing and governance repair: make purpose,
working rules, authority, evidence, and recovery discoverable and maintainable.

It is not a document editor, Wiki, project manager, organization portal,
translation system, or policy-enforcement engine.

## Work Charter `v0.2.0` Release-Set Applicability

The Work-Charter-only `v0.2.0` prerelease candidate includes the immutable
Project Docs `v0.1.2` package at
`ceed607152849775b981c54add74bfa30d858e4d`. For this release set, Project
Docs is explicit-only: the user must invoke `$manage-project-docs` before the
Skill loads, while an adopted target-project instruction may route ordinary
canonical updates without loading the Skill. A governance failure or
structural change may ask the user to invoke Project Docs; it does not itself
invoke the Skill or authorize a change.

The later [Decision 0019](../../decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md)
development contract remains accepted history but is excluded from this
candidate. Its implicit-selection and demand-driven-module requirements below
are historical/future development requirements, not behavior supplied or
claimed by the six live `v0.1.2` package files.

## Behavior Contract

A sufficient project exposes five logical responsibilities:

1. project purpose and scope;
2. work and verification method;
3. authority and canonical write routing;
4. current state and supporting evidence;
5. next action and recovery entry.

These are responsibilities, not filenames. One file may own several
responsibilities and one responsibility may have several read locations.
Within one scope and lifecycle, each normative durable fact has one canonical
write locus.

Project Docs distinguishes four surfaces:

| Surface | Behavior |
|---|---|
| Discovery or audit | The user explicitly invokes `$manage-project-docs`; an adopted project rule may instead handle a valid ordinary canonical update without loading the Skill |
| First adoption | After approval of a concrete proposal, create or update only the authorized minimum contract and continuity route |
| Routine maintenance | Update existing canonical owners under an adopted project rule |
| Structural repair or expansion | Rediscover and propose first; write only after explicit structural or owner authorization |

Every run ends in exactly one primary outcome: `NOOP`, `REPORT`, `UPDATE`,
`PROPOSE`, or `STOP`. A completed read-only audit is `REPORT` when only a later
write is blocked; `STOP` applies when the requested action itself cannot safely
continue.

A reader, an active session, and the current writer are separate facts.
Read-only audits may coexist with other sessions; persistent updates require a
fresh writer and authorization check immediately before the write.

Selection, metadata visibility, installation, prior use, and project-rule
mentions do not authorize mutation. A user's natural-language approval is
explicit only when it unambiguously confirms a concrete visible proposal and
its listed target effects. `$manage-project-docs` remains a manual override,
not a write token.

When governance symptoms are incidental to another unblocked task, the live
explicit-only package does not take over the task or load itself. An adopted
project rule may visibly ask the user to invoke Project Docs. The Skill never
polls conversations or runs as a background scanner.

## Excluded Decision 0019 Demand-Driven Modules And Update Modes

This section records the accepted Decision 0019 development contract. The
exact `v0.1.2` package in the Work Charter `v0.2.0` release set does not
implement or claim these demand-driven-module requirements.

New projects may begin with one combined working contract that covers the five
logical responsibilities. Existing projects map their current documents and
external systems instead of adopting this grouping or its names.

A material event is routed to a durable fact class, its existing canonical
owner, and that owner's update mode. Keep the current owner when it remains
coherent. A separate functional module is justified only by an independent
lifecycle, update mode, owner, audience, scope, or historical record.

| Functional module | Activation signal | Update mode |
|---|---|---|
| Purpose and scope | first adoption or accepted product/scope change | revise the current contract; preserve durable rationale in a decision owner when needed |
| Work and verification | repeatable work, acceptance, or verification method exists or changes | revise the current method; put time-bound results in the evidence owner |
| Authority and routing | multiple owners/scopes or a generated/external route must be resolved or changed | revise the current map only after structural or owner authorization |
| Current state and recovery | work spans sessions, pauses, transfers, or changes writer, gate, next action, or recovery target | replace one coherent current snapshot; do not accumulate execution history there |
| Decisions | a non-obvious durable tradeoff or supersession needs rationale | append or explicitly supersede; preserve accepted history |
| Evidence and results | a claim depends on repeatable checks or comparison with older results | append or supersede a bounded, time-labelled result and keep the current index accurate |

Generated projections are updated through their editable source. Externally
owned facts are updated in that system and remain unverified or `UNKNOWN` when
the owner is unavailable. Neither source type creates another required module.

## Continuity

An authorized first adoption may merge a lightweight continuity anchor into an
existing target-project instruction or governance entry. It contains routing,
document-impact events, update modes, the structural gate, and recovery entry,
not project facts. Later ordinary tasks use that durable route without loading
Project Docs. Under the live explicit-only package, a governance failure, new
scope, missing owner, incompatible update lifecycle, or structural change may
ask the user to invoke Project Docs for inspection and proposal, but does not
itself invoke the Skill or authorize repair. Decision 0019's later implicit
rediscovery contract remains excluded historical/future development.

Persistence belongs to target-project sources, not chat history, memory,
discovery mappings, installed copies, or caches. If the Harness cannot load or
verify the route, continuity is reported as weak.

Current state, current writer, current gate, next safe action, and recovery
target form one verified snapshot. A valid durable anchor and recovery target
remain stable during routine maintenance. Conflicting snapshots or competing
recovery entries make continuity weak; a new owner or route requires
`PROPOSE` and structural authorization.

## Safety And Non-Goals

- Preserve sufficient mature and nonstandard layouts.
- Preserve `UNKNOWN` when contract, implementation, state, evidence, and
  historical rationale do not resolve a conflict.
- Label time-bound evidence as current, historical, or superseded; keep result
  indexes pointed at the current owner and keep next actions behind their
  current authorization gate.
- Preserve immutable historical artifacts. Correct or downgrade a current
  claim in its canonical owner and point to a later revision instead of
  rewriting history.
- Stop a requested mutation on unresolved writer or owner conflict.
- Edit generated-document sources rather than generated output.
- Preserve unavailable external owners as unverified.
- Respect the nearest monorepo scope and established document language.
- Do not create organization catalogs, connectors, mapping databases,
  continuous scanners, translation publishing, Plugins, or deterministic
  enforcement in v0.1.

## Internal Package Boundaries

| Source | Owner |
|---|---|
| [`SKILL.md`](../../../skills/manage-project-docs/SKILL.md) | Concise workflow, five responsibilities, outcomes, canonical-write rule, and safety boundaries |
| [`audit-and-adopt.md`](../../../skills/manage-project-docs/references/audit-and-adopt.md) | Inventory, claim classification, adoption, structural proposals, and special sources |
| [`maintain-and-recover.md`](../../../skills/manage-project-docs/references/maintain-and-recover.md) | Existing-owner maintenance, continuity, pause, handoff, recovery, and completion reconciliation |
| [`project-doc-starter.md`](../../../skills/manage-project-docs/assets/templates/project-doc-starter.md) | Adaptable single-file first-adoption output |
| [`continuity-anchor.md`](../../../skills/manage-project-docs/assets/templates/continuity-anchor.md) | Adaptable persistent routing fragment |
| [`openai.yaml`](../../../skills/manage-project-docs/agents/openai.yaml) | Public display metadata and explicit-only release-set policy |
| [Project Docs eval cases](../../../evals/README.md#historical-project-docs-m1r-forward-matrix-excluded-from-this-candidate) | Excluded Decision 0019 behavior and selection contract history |

Assets are optional outputs, not mandatory target-project filenames.

## Independent-Skill Boundary

Project Docs and Work Charter are peers. Project Docs owns document semantics,
canonical routing, adoption, repair, and continuity. It does not create or
activate a Work Charter, choose roles, or transfer action authority. Optional
composition remains a repository-level recipe.

## Accepted Basis

- [Decision 0006](../../decisions/0006-project-docs-progressive-governance.md)
- [Decision 0007](../../decisions/0007-independent-skills-and-optional-recipes.md)
- [Decision 0015](../../decisions/0015-federated-repository-documentation.md)
- [Decision 0019](../../decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md)
  (accepted development history; excluded from this release set)
