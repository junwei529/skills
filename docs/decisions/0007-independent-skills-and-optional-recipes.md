# 0007: Independent Skills And Optional Recipes

Date: 2026-07-29
Status: accepted
Supersedes in part: Decision 0001 and Decision 0006 product-hierarchy clauses

## Context

The three current Skills originated from one user's recurring problems, and
Project Docs and Large Tasks share a core audience. That common origin does not
make one capability the product and the others subordinate features.

Project Docs, Large Tasks, and PowerShell safety solve different jobs:

- Project Docs makes project truth, authority, evidence, and recovery
  discoverable and maintainable.
- Large Tasks bounds consequential multi-stage work through planning,
  execution, assessment, stopping, and recovery.
- PowerShell safety diagnoses and handles Windows, native-process, text, and
  WSL boundaries.

Future Skills may arise from the same user's development problems. The
repository therefore needs a rule that preserves focus without creating a
hidden suite dependency or a universal workflow.

## Options Considered

1. Keep Project Docs as the primary product and describe the other Skills as
   companions.
2. Create an umbrella product or Skill that owns all composition.
3. Treat every public Skill as an independent product and document optional
   cross-Skill recipes at repository level.

## Decision

Choose option 3.

### Independent Product Contract

- Every public Skill must solve a recognizable standalone job for a defined
  audience or subsegment.
- Every Skill must remain independently discoverable, installable, selectable,
  usable, stoppable, and evaluable.
- A Skill may use a target project's existing documents, tools, or conventions
  without requiring another Skill to create or rewrite them.
- Each Skill keeps complexity proportional to its own job. A narrower Skill
  must not inherit roles, states, artifacts, or gates merely to resemble a
  broader Skill.

### Shared Audience And Separate Jobs

The repository's common core audience is programmers and technical independent
developers who already use Codex, Claude Code, Cursor, or Copilot on real
projects but lack lightweight, reliable governance for project truth,
consequential work, or execution boundaries.

An individual Skill may target only part of that audience. Its own entry point
must state its job, trigger, and boundary; repository membership is not a
trigger.

### Optional Composition

- Cross-Skill composition is a documented recipe, not an implicit dependency,
  bundled adoption, shared runtime, or umbrella Skill.
- A recipe may describe order and handoff boundaries, such as Project Docs
  establishing reliable routing before Large Tasks consumes it, or PowerShell
  safety being separately selected for a material shell boundary within a
  Large Tasks run.
- Each participant retains its own ownership and stop conditions. Project Docs
  owns project-document governance, Large Tasks owns its work-control
  contract, and PowerShell owns shell-boundary diagnosis and guidance.
- Sharing one repository, release tag, user persona, task, role, branch, or
  worktree does not prove that another Skill was loaded or adopted.
- Recipes must not automatically install, discover, select, invoke, or update
  another Skill.

### Authorization

Composition does not propagate authorization. The following surfaces remain
distinct for each Skill and operation:

1. installation or discovery;
2. invocation or adoption;
3. execution or maintenance, including target-project writes, role creation,
   worktrees, commits, and external side effects;
4. packaging or release.

Permission on one surface, Skill, or operation does not imply permission on
another.

### Future Skills

A future public Skill follows the same rule. A real mandatory dependency,
umbrella product, shared runtime, or automatic composer requires a separate
accepted project decision supported by user and evaluation evidence.

## Consequences

- The repository is a lightweight, composable family of workflow and safety
  Skills; it has no main-product hierarchy.
- Project Docs and Large Tasks may share a core user while remaining separate
  products. PowerShell may serve a narrower Windows subset without becoming
  less complete for its own job.
- Repository-level documentation may publish recipes, but Skill entry points
  must not make optional combinations look mandatory.
- Standalone and composed behavior need separate evaluation. Structural
  separation is not evidence that installation, selection, handoff, or
  authorization boundaries work in a real Harness.
- Decision 0001 remains valid for the three-Skill structure, names, explicit
  Standard-flow opt-in, Markdown-first form, and deferred Plugin packaging.
  Its primary-versus-companion hierarchy is superseded.
- Decision 0006 remains valid for the Project Docs audience, logical contract,
  triggers, continuity, safety, and deferred scope. Its primary-public-product
  clause is superseded.

## Re-evaluation Conditions

Revisit this decision only if repeated real use shows that two capabilities
cannot provide their standalone jobs without a shared runtime or mandatory
dependency, or if users consistently adopt and evaluate them only as one
inseparable product.

## Related Documents

- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Current status](../STATUS.md)
- [Verification](../VERIFICATION.md)
- [Decision 0001](0001-v0-1-scope-and-names.md)
- [Decision 0006](0006-project-docs-progressive-governance.md)
