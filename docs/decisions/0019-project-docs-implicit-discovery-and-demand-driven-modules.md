# 0019: Project Docs Implicit Discovery And Demand-Driven Modules

Date: 2026-08-07
Status: accepted
Partially supersedes: Decision 0006 selection and broken-route re-entry clauses

## Context

Project Docs `v0.1.2` requires explicit `$manage-project-docs` invocation.
That boundary is safe, but it leaves the intended users responsible for
recognizing a documentation-governance problem and remembering a product-
specific command. Programmers and technical independent developers who lack a
reliable documentation system are precisely the users least likely to do that.

Codex already supports Skill metadata matching and progressive disclosure.
Project Docs should use that native selection surface without turning selection
into permission to mutate a project. It also needs a small standard for new
projects that answers two independent questions: which documentation function
is needed now, and how the corresponding owner is updated. Existing projects
must retain their current layouts when those responsibilities can be mapped.

## Options Considered

1. Keep explicit-only invocation and rely on users to remember the Skill.
2. Preload or continuously scan every project for documentation drift.
3. Allow high-confidence implicit discovery for read-only inspection and
   proposals, require explicit approval for concrete writes, and persist
   ordinary maintenance through target-project routing.

## Decision

Choose option 3.

### Selection And Authorization

- A direct project-document governance, audit, adoption, handoff, or recovery
  request may select Project Docs without `$manage-project-docs`.
- High-confidence symptoms such as conflicting authority, missing canonical
  routing, stale current evidence, or no trustworthy recovery entry may also
  select it. When the symptom is incidental to another unblocked task, Project
  Docs performs at most a minimum read-only preflight and a visible proposal;
  it does not take over the task.
- `$manage-project-docs` remains a manual override and evaluation route.
- Selection, metadata visibility, installation, prior use, and project-rule
  mentions authorize no write. First adoption, a new module, split, merge,
  rename, migration, authority change, canonical-owner change, or other
  structural mutation requires approval of a concrete visible proposal.
- An unambiguous natural-language confirmation of that proposal is explicit
  authorization for only its listed target-project effects. It does not
  propagate to Git, installation, external actions, another Skill, or release.

Project Docs does not poll conversations, run a daemon, preload on every task,
or treat project age, file count, ordinary README/prose work, generated-output
formatting, or a valid routed update as a trigger.

### Two-Dimensional Documentation Contract

The five logical responsibilities in Decision 0006 remain the minimum
contract. They are still responsibilities rather than filenames.

The first dimension is functional activation. A material project event is
mapped to a durable fact class, then to its existing canonical owner. New
projects may start with one combined working contract and activate a separate
module only when an independent lifecycle, update mode, owner, audience, scope,
or historical record makes the combined owner insufficient. Existing projects
map their current documents and external systems; Project Docs does not force
the new-project grouping or names onto them.

The supported functional modules are purpose/scope, work/verification,
authority/routing, current state/recovery, decisions, and evidence/results.
Generated and externally owned documentation remain source-location variants,
not additional required modules.

The second dimension is update mode:

- current contracts are revised in place, with durable rationale preserved in
  an existing decision owner when needed;
- current state, writer, gate, next action, and recovery are replaced together
  as one coherent current snapshot rather than accumulated as an execution log;
- decisions and evidence are appended or explicitly superseded without
  rewriting immutable history; and
- generated or externally owned facts are updated at their editable source.

### Persistence And Re-entry

After authorized first adoption, the target project's existing instruction or
governance entry persistently records responsibility routing, update events,
update modes, the structural gate, and one recovery entry. Ordinary later tasks
follow those local owners without loading Project Docs.

A broken route, missing owner, new scope, incompatible update lifecycle, or
non-unique recovery entry can make Project Docs relevant again. It may then be
implicitly rediscovered to audit and propose repair, but it still cannot write
until the user approves the concrete structural or authority change.

### Independent-Skill Boundary

This selection policy does not make a repository recipe implicit. Project Docs
does not install, select, invoke, adopt, or authorize Work Charter or
PowerShell, and neither peer Skill grants Project Docs write authority.

## Evaluation Contract

The revision must separately test:

1. a native baseline without Project Docs;
2. high-confidence ordinary-language selection with the exact candidate;
3. ordinary and near-neighbor negatives that leave the Skill unloaded;
4. implicit selection with zero unauthorized mutation;
5. explicit approval followed by the bounded adoption or repair;
6. persistent routine routing without Project Docs loading;
7. structural failure that re-enters proposal-only behavior; and
8. actual loaded-copy identity for every selection claim.

Safety, writer, scope, authority, evidence, and recovery remain independent
hard gates. The explicit-only `v0.1.2` evidence remains historical control
evidence and cannot be relabelled as proof of this revision.

## Consequences

- The installable package remains six files and adds no runtime, registry,
  watcher, database, mandatory manifest, or background service.
- Frontmatter and `openai.yaml` become a materially different selection
  contract. The exact revision needs current selection and behavior evidence
  before candidate readiness.
- `v0.1.2` remains immutable and explicit-only. A later release containing this
  incompatible pre-1.0 selection change requires a separately accepted version
  decision; the normal direction is a new minor line.
- Target-project persistence remains checked-in project content. It is not a
  daemon, Skill installation identity, discovery mapping, or guarantee that a
  current session has reloaded changed instructions.

## Re-evaluation Conditions

Revisit this decision if ordinary or peer-Skill tasks cause unacceptable false
positive loading, users cannot distinguish proposals from authorization,
projects repeatedly need a mandatory machine-readable registry, or the Harness
absorbs the remaining routing and recovery residual.

## Related Documents

- [Decision 0006](0006-project-docs-progressive-governance.md)
- [Decision 0007](0007-independent-skills-and-optional-recipes.md)
- [Decision 0017](0017-capability-delta-skill-development.md)
- [Project Docs design](../skills/manage-project-docs/DESIGN.md)
- [Evaluation contract](../../evals/README.md)
