# 0006: Project Docs Progressive Governance Contract

Date: 2026-07-28
Status: accepted
Partial supersession: Decision 0007 replaces the primary-public-product clause;
Decision 0019 replaces the explicit-only selection and broken-route re-entry
clauses. The remaining Project Docs contract stays accepted.

## Context

The original Project Docs baseline exposed a broad documentation template
system. Further product review showed that the most reachable v0.1 users are
already building with coding agents but lack reliable project-document
governance. They need durable project truth and recovery more than a prescribed
documentation architecture.

A fixed file suite or public maturity ladder would make adoption harder,
duplicate mature repositories, and pull architect-only governance into the
default product. A completely free-form approach would not provide enough
authority, conflict, or continuity protection.

## Options Considered

1. Require one complete document suite and expand it through named maturity
   levels.
2. Accept any existing documentation without a minimum governance contract.
3. Define a small logical contract, preserve existing layouts, and add modules
   only when concrete project events justify them.

## Decision

### Product And Audience

- The primary audience is programmers and technical independent developers who
  already use Codex, Claude Code, Cursor, or Copilot but do not have reliable
  project-document governance.
- Capabilities directly required by that audience are v0.1 Must. Capabilities
  needed only for architect, organization, compliance, or platform use are
  Deferred unless they are also required for the primary user's safety.
- Project Docs is a semantic responsibility-routing and governance-repair
  layer. It is not a document editor, Wiki, project manager, portal, or policy
  enforcement platform.

### Minimum Logical Contract

A sufficient project exposes five logical responsibilities:

1. project purpose and scope;
2. work and verification method;
3. authority and canonical write routing;
4. current state and its evidence;
5. next action and recovery entry.

These are responsibilities, not required filenames. One file may own several
responsibilities, and one responsibility may have several read locations.
Within one scope and lifecycle, however, each normative durable fact has one
canonical write locus.

Project Docs must adopt and preserve a mature or nonstandard layout when that
layout already satisfies the contract. It returns `NOOP` when no change is
needed.

### Triggers, Outcomes, And Authorization

The public behavior distinguishes four surfaces:

| Surface | Trigger | Default authority |
|---|---|---|
| Explicit selection | The user invokes Project Docs for an audit, adoption, repair, update, pause, or recovery task | inspect and report within the request |
| First adoption | The user authorizes Project Docs to establish the minimum contract and continuity anchor | create or update only the approved target-project structure |
| Routine maintenance | A later agent follows an already adopted project rule after a material project event | update the existing canonical owner; do not redesign structure |
| Structural expansion | A new scope, conflict, split, merge, rename, migration, or owner change makes the current routing insufficient | propose first; write only after explicit structural authorization |

Every run ends with one primary outcome: `NOOP`, `REPORT`, `UPDATE`, `PROPOSE`,
or `STOP`.

Audit alone does not authorize structural writes. First adoption, new modules,
file split or merge, rename or migration, authority changes, and canonical-owner
changes require explicit target-project authorization.

### Continuity And Persistence

- The user explicitly selects Project Docs for initial adoption. If authorized,
  it writes a lightweight continuity rule into the target project's existing
  agent-instruction or governance entry.
- The continuity anchor contains only routing: read order, document-impact
  events, the structural authorization gate, and the recovery entry. It does
  not duplicate project facts.
- Later ordinary tasks use the target project's durable rule and canonical
  documents. Project Docs is reselected when governance fails or structure
  changes, not on every task.
- Persistence belongs to target-project sources. It does not depend on chat
  history, agent private memory, a discovery mapping, an installed Skill copy,
  or a release version identity.
- If the active Harness cannot write, load, or verify the persistent entry,
  Project Docs reports weak continuity and does not promise automatic reuse.
- Cross-Harness continuity uses one canonical project anchor and only thin
  adapters or imports that already exist or are separately authorized. v0.1
  does not promise native Project Docs packages for every Harness.

### Safety And Scope

- Preserve `UNKNOWN` and classify intended contract, actual implementation,
  current work state, verification evidence, and historical decision before
  resolving conflicts.
- Stop a requested mutation on an unowned concurrent writer or unresolved
  canonical-owner conflict. A completed read-only audit remains `REPORT` when
  only a later write is blocked.
- With no write permission, report or propose rather than implying an update.
- Treat generated documentation as derived output and locate its editable
  source before proposing a change.
- Allow an external Wiki or issue tracker to own a fact, but mark it unverified
  when the source is unavailable.
- Respect the nearest project scope in monorepos. Preserve an existing document
  language, but do not add a full localization or translation system in v0.1.
- Pause, handoff, and recovery are required capabilities, but no fixed
  `HANDOFF.md` filename is required.
- Named levels may be used internally to explain examples. They are not public
  project state and do not trigger whole-layer upgrades.

### Relationship To Other Skills

- Project Docs and Large Tasks are independently installable and usable. Their
  combination is a recipe; no umbrella Skill is required.
- Project Docs and Large Tasks are product and technical peers under
  [Decision 0007](0007-independent-skills-and-optional-recipes.md). Project Docs
  owns document semantics, placement, repair, and the continuity anchor; Large
  Tasks owns phases, roles, work boundaries, verdicts, and recovery timing.
  When combined, Large Tasks may consume the project's document routing.

## Deferred

- Cross-repository or organization catalogs, ownership hierarchies, portfolio
  maps, and Backstage-style portals.
- RBAC, SSO, audit, compliance, policy engines, and deterministic enforcement
  through CODEOWNERS, CI, PR rules, or watchers.
- Full scope-by-version-by-locale-by-lifecycle registries, translation
  publishing, and versioned documentation sites.
- Connectors and bidirectional synchronization for Wiki, Jira, Notion, or
  Confluence.
- Generator orchestration, provenance graphs, and continuous drift scanning.
- A mandatory mapping manifest, database, index, or automatic
  invalidation/remapping engine.
- Native packages, adapters, certification, an umbrella Plugin, or MCP service
  for multiple Harnesses.

## Consequences

- The existing Project Docs Skill, references, templates, and tests remain
  development artifacts for the earlier contract. They must be revised and
  forward-tested before Project Docs is treated as v0.1 content-complete.
- The previous M1 milestone is historical. An M1R refinement milestone now
  blocks candidate and release progression.
- Existing Project Docs evidence may support only the behavior it actually
  exercised; it does not prove this revised contract.
- Decision 0001 remains valid for the three-Skill structure but not its
  primary-versus-companion hierarchy. Decision 0003 remains valid for Skill
  source, discovery, installation, and release identity. Decision 0007 owns
  the independent-product and optional-recipe boundary.

## Re-evaluation Conditions

Revisit this contract if novice non-programmers become the primary reachable
audience, repeated real-project evidence shows the five responsibilities are
insufficient, organization-wide governance becomes a v0.1 requirement, or
cross-Harness continuity cannot work without native distribution.

## Related Documents

- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Current status](../STATUS.md)
- [Roadmap](../ROADMAP.md)
- [Verification](../VERIFICATION.md)
- [Decision 0001](0001-v0-1-scope-and-names.md)
- [Decision 0003](0003-source-install-release-boundaries.md)
- [Decision 0007](0007-independent-skills-and-optional-recipes.md)
