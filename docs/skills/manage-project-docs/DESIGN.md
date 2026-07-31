# Project Docs Design

Last updated: 2026-07-31

## Purpose And Audience

Project Docs serves programmers and technical independent developers who
already use coding agents but lack reliable project-document governance. Its
job is semantic responsibility routing and governance repair: make purpose,
working rules, authority, evidence, and recovery discoverable and maintainable.

It is not a document editor, Wiki, project manager, organization portal,
translation system, or policy-enforcement engine.

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
| Explicit selection | Inspect and report within the user's request |
| First adoption | Create or update only the authorized minimum contract and continuity route |
| Routine maintenance | Update existing canonical owners under an adopted project rule |
| Structural expansion | Propose first; write only after explicit structural authorization |

Every run ends in exactly one primary outcome: `NOOP`, `REPORT`, `UPDATE`,
`PROPOSE`, or `STOP`. A completed read-only audit is `REPORT` when only a later
write is blocked; `STOP` applies when the requested action itself cannot safely
continue.

A reader, an active session, and the current writer are separate facts.
Read-only audits may coexist with other sessions; persistent updates require a
fresh writer and authorization check immediately before the write.

## Continuity

An authorized first adoption may merge a lightweight continuity anchor into an
existing target-project instruction or governance entry. It contains routing,
document-impact events, the structural gate, and recovery entry, not project
facts. Later ordinary tasks use that durable route without loading Project
Docs. Governance failure or structural change requires fresh explicit
selection.

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
| [`openai.yaml`](../../../skills/manage-project-docs/agents/openai.yaml) | Public display metadata and explicit-only invocation policy |
| [Project Docs eval cases](../../../evals/README.md#project-docs-m1r-forward-matrix) | Behavior and selection contracts |

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
