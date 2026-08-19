# Agent Instructions

## Required Reading

Before changing this repository, read:

1. `README.md`
2. `docs/INDEX.md`
3. `docs/AUTHORITY.md`
4. `docs/STATUS.md`
5. `docs/SPEC.md`
6. `docs/ARCHITECTURE.md`
7. `docs/VERIFICATION.md`
8. The relevant `docs/skills/<skill-name>/DESIGN.md`, `STATE.md`, and
   `VERIFICATION.md` before changing one Skill or its claims
9. `docs/HANDOFF.md` when resuming interrupted work
10. `docs/RUNBOOK.md` before changing Skill discovery, installation, candidate,
   version, or release state
11. `docs/decisions/0017-capability-delta-skill-development.md`, the
    capability-delta intake in `docs/RUNBOOK.md`, and `evals/README.md` before
    creating a public Skill or materially changing Skill selection or behavior

## Scope

- Keep the repository Markdown-first and Codex-first.
- Prefer focused skills over one universal workflow skill.
- Keep every public Skill independently useful, installable, invokable, and
  evaluable. Treat cross-Skill composition as an optional repository-level
  recipe, not a product hierarchy, implicit dependency, or authorization
  bridge.
- Keep ordinary tasks flat. Standard Orchestrator/Planner/Executor may activate
  only under an approved Work Charter and applicable standing policy; initial
  adoption remains user-owned, and profile selection never propagates action
  authorization.
- Require an observed failure or a user-visible decision for every new public
  concept, role, state, artifact, gate, or required file. Prefer an existing
  concept and one canonical owner; keep internal classifications out of the
  user-facing contract unless the user must act on them.
- Start new Skills and material selection or behavior revisions from the
  strongest practical no-target-Skill baseline. Put each responsibility in the
  model, Harness, project rules, deterministic tooling, or external system that
  already owns it, and keep only a demonstrated residual, an explicit product
  requirement, or a hard boundary in the Skill. Stop if no material residual
  remains.
- Keep root instructions limited to repository development and evaluation
  governance. Do not copy target-Skill workflow or expected-answer guidance
  here. When target-derived guidance cannot be removed from a native baseline,
  label it `ambient-guidance` and do not use it for a causal native claim.
- Do not add a Plugin, MCP service, UI, database, remote registry, or generic
  adapter framework without an accepted project decision.

## Repository Coordination

- Keep this repository as one Git repository, one saved Codex Project, and one
  shared release/evaluation envelope. Directory, repository, saved Project,
  branch, worktree, and task or Session identity are separate dimensions; bind
  each relevant identity explicitly instead of inferring one from another.
- Readers, active Sessions, and the repository writer are distinct. Shared
  reads remain bounded by their own authority; exactly one repository writer
  owns the write window, and upstream or integration changes route through
  that exact writer.
- A provider owns its public contract. Each consumer owns its compatibility
  declaration and assembled integration tests. Dependency grants no cross-write
  authority and does not authorize a consumer to rewrite its provider.
- Use compact callback-first Result Notices for independent verification and
  one checkpoint-bound disposition. Stop after dispatch; do not poll, create
  acknowledgement traffic, infer acceptance from silence, or activate a
  replacement writer when delivery is uncertain.
- Apply the measurable reconsideration triggers and non-goals in
  [Decision 0025](docs/decisions/0025-monorepo-coordination-and-skill-contract-hardening.md).

## Publication Safety

- Do not copy the user's global `AGENTS.md`, reference files, memories, or
  session logs verbatim.
- Do not publish private paths, repository state, thread or host identifiers,
  account details, credentials, raw prompts, completions, or reasoning traces.
- Do not repurpose or export production sessions, private prompts, memory,
  rollout data, or unreviewed repository material to an external framework,
  optimizer, secondary model provider, or telemetry service. Use only
  explicitly authorized synthetic or reviewed and redacted inputs with
  recorded retention and provenance.
- Rewrite reusable ideas into portable rules and record their provenance before
  release.
- Do not claim measured efficacy, token savings, portability, or SHICE
  validation without recorded evidence.

## Skill Structure

- After the capability-delta intake records a justified residual and the target
  change is authorized, follow the bundled `$skill-creator` instructions when
  creating or changing a Skill. Invoking it does not itself authorize a write.
- Treat `$skill-creator` as the authoring and package-validation baseline, not
  as lifecycle authority, behavioral acceptance, installation proof, or
  release authorization.
- Keep triggering conditions in the frontmatter `description`.
- Keep `SKILL.md` concise and link every reference directly from it.
- Put detailed guidance in `references/` and output templates in `assets/`.
- Do not place README, installation, changelog, or process-history documents
  inside a skill directory.

## Documentation

- Before the first native review for a material Skill, package, evaluation, or
  lifecycle revision, complete the documentation-impact closure in
  `docs/RUNBOOK.md`. Start from changed fact classes, not an early guessed file
  list. Keep the authorized change envelope, intended change set, and actual
  review target distinct; a broad envelope permits a relevant existing file to
  change but does not require editing or committing it.
- Mark every mapped canonical owner and bounded consumer as `UPDATE`,
  `CHECKED_NO_CHANGE`, or `NOT_APPLICABLE` before freezing the diff. An omitted
  existing consumer of the same facts may be corrected inside an approved
  envelope; a new file, fact class, product contract, permission, side effect,
  or acceptance boundary requires an explicit replan or user decision.
- Shared product requirements belong in `docs/SPEC.md`; per-Skill purpose,
  trigger, non-goals, behavior contract, and internal package boundaries belong
  in `docs/skills/<skill-name>/DESIGN.md`.
- Cross-Skill architecture and ownership boundaries belong in
  `docs/ARCHITECTURE.md`.
- Per-Skill implementation, writer, next gate, and recovery belong in
  `docs/skills/<skill-name>/STATE.md`; `docs/STATUS.md` is the short repository
  dashboard.
- Future milestones belong in `docs/ROADMAP.md`.
- Per-Skill SOURCE, forward-test, DEV, RC, and stable evidence belongs in
  `docs/skills/<skill-name>/VERIFICATION.md`; repository checks, coherent
  candidates, tags, stable installs, and release evidence belong in
  `docs/VERIFICATION.md`.
- Source transformation and publication boundaries belong in
  `docs/PROVENANCE.md`.
- Development, discovery, installation, candidate, update, rollback, and
  release procedures belong in `docs/RUNBOOK.md`.
- Recovery context belongs in `docs/HANDOFF.md`.
- Durable choices belong in `docs/decisions/`.
- Root and per-Skill `README.md` files are human entries, not runtime
  specifications. English is canonical; update each `README.zh-CN.md` mirror in
  the same change set and verify reciprocal navigation.
- Do not duplicate a detailed per-Skill fact in a root dashboard; link to its
  canonical owner and keep only the bounded repository-level summary.

## Verification And Git

- For consequential, interruption-prone, or one-shot Skill development and
  evaluation, prefer one bounded Campaign authorization that names the stable
  subject, tranches, budgets, external effects, consumption points, automatic
  transitions, and material stop conditions. Within that approved envelope,
  continue same-scope reversible qualification, deterministic verification,
  evidence, assessment, and closeout without asking for command-by-command
  approval. A new carrier or label never resets history; contract, candidate,
  permission, cost, workspace, consumed-evidence, installation, release, or
  cleanup changes return to the user as one complete decision.
- Apply the newest verified Campaign authority and terminal disposition before
  diagnosing failure origin. Reclassifying a failure as operator, controller,
  environment, transport, or verification origin never expands authority,
  restores a consumed budget, converts an explicit stop into recovery, or
  creates a successor. Only a newer approved authority revision may change
  that disposition; sealed predecessors remain immutable.
- Before review or replan, classify each observed path delta as canonical
  source/documentation, a declared material evidence input or ignored carrier,
  a generated/cache by-product, or unexplained/unowned. Cache-only churn such
  as `__pycache__/`, `*.pyc`, or `.codegraph/` is non-source and does not
  restabilize the semantic diff. A declared ignored carrier remains bound
  evidence and must be reconciled; unexplained deltas fail closed.
- Before a successor Campaign, candidate, or release claims a material lesson
  is active, record it as `PROMOTED`, `DEFERRED`, or `REJECTED`. `PROMOTED`
  names the canonical owner, writer, effective revision, and proving check;
  `DEFERRED` names the owner and reconsideration trigger and is not described
  as fixed; `REJECTED` retains the evidence and reason. Chat, result, or backlog
  text alone is not an active rule.
- Treat one Campaign, successor, or explicitly bounded evidence tranche as one
  lesson-promotion round, not each command or chat turn. While its inputs or
  evidence are frozen, record lesson candidates without changing the governing
  `AGENTS.md`, references, controller contract, or acceptance target. At the
  terminal boundary, deduplicate and disposition the whole batch before a
  successor relies on it.
- At the start of each Campaign, successor, or lesson-promotion round, reread
  the current project `AGENTS.md` and its mapped Runbook/evaluation references
  after revalidating the workspace and writer. This supplies current working
  context; it does not prove that the Harness loaded a materially changed
  ruleset.
- After a material governing-rule change, the current Codex run may close out
  the old ruleset but cannot prove that the new one was loaded. Before affected
  scarce evidence, start a fresh run or Session, identify the applicable
  instruction sources and normalized-text ruleset hashes, reread the mapped
  references, and requalify the affected boundary. A manual reread in the old
  Session is useful context, not Harness reload evidence.
- Bind every external authority, evidence, predecessor, and task-owned carrier
  root from an explicit authenticated contract input. Never infer such a root
  from the current directory, sibling enumeration, or `__file__` ancestry or
  directory depth. Code-relative paths may locate repository-owned static
  resources only. Resolve and validate containment, reparse/symlink boundaries,
  identity or hash, and expected schema before consumption; missing or
  mismatched inputs fail closed.
- Before scarce product evidence, qualify the exact outer launch and return
  path as well as the inner provider response path. Child stdout/stderr are
  evidence data, not a function return value; phase dispatch must consume one
  typed scalar exit status. A direct app-server canary does not by itself
  qualify a different PowerShell/Python wrapper or its next-phase branch.
- For a multi-stage scarce-evidence carrier, expose one declared outer entry
  point and bind each consuming phase to a phase-specific, hash-bound, one-shot
  launch receipt. An inner worker must fail before its first `thread/start`
  when that receipt is absent, stale, mismatched, or already consumed. Include
  direct-inner and wrong-receipt negatives in the owning runner's tests; a
  receipt proves route provenance, not new action authority.
- Before freezing the diff for native review of a new or materially changed
  multi-stage builder, importer, finalizer, wrapper, or dispatcher, run the
  exact composed zero-model DEV feasibility path through its last pre-scarce
  gate in a disposable bounded mirror. Component checks or a successful first
  stage are insufficient. This pass is implementation qualification only, not
  official Campaign, product, or acceptance evidence; official qualification
  starts only from the reviewed committed revision.
- Before exposing an allowed native command to a model in scarce evidence,
  define its argv in one canonical operation table and render the exact rooted
  executable through the same wrapper, observation adapter, and controller
  path used by the product run. Qualification must round-trip every allowed
  operation and prove that rooted forms are admissible while corresponding bare
  names and shadow paths fail closed. Establish the trusted executable from an
  approved policy or independently authenticated platform anchor before PATH or
  name resolution; PATH may be checked for drift but cannot define trust. A
  shadow negative is rejected before launch. Component-only parsing, identity-
  tuple, or classifier checks do not qualify the composite command route.
- Do not repair, rescore, or submit a sealed qualification-only or transport-
  failure carrier to product, implementation, or assessor review. Review only
  the tracked bytes being proposed for a successor or commit. If a sealed stop
  creates no tracked diff, no native review is required.
- A failure-only closeout commit is limited to a sanitized terminal record and
  its already mapped factual, authority, recovery, and writer consumers. After
  its deterministic consistency check, it receives at most one initial native
  review and one post-fix native review. A remaining actionable finding stops
  at `DECISION_REQUIRED`. This exception does not apply when implementation,
  governance, checker, case, fixture, matrix, rubric, permission, or acceptance
  bytes change.
- A bounded writer lease becomes `RELINQUISHED` only after its named terminal
  action or authorized commit and reconciliation of attributable index and
  worktree state across every registered worktree. One clean checkout, a task
  completion message, or unrelated attributed dirt is not proof; missing or
  conflicting evidence leaves the lease `UNKNOWN` and fails closed.
- Run the skill validator for every changed skill.
- Check for unresolved scaffolding markers, broken local links, encoding
  problems, and publication-unsafe traces.
- Forward-test behavior before treating a skill as release-ready.
- For a new Skill or material selection or behavior revision, compare the
  no-target-Skill baseline, realistic catalog selection including ordinary and
  near-neighbor negatives, and the exact selected revision. Re-run affected
  conditions after a material model, Harness, tool, permission, or catalog
  change, then retain, simplify, delegate, or retire the residual.
- Evaluate applicable safety, authorization, evidence, and recovery boundaries
  independently; an aggregate quality score cannot compensate for their
  failure.
- Treat `skills/` as the only editable Skill source. Do not edit or
  reverse-synchronize discovery entries, installed copies, caches, release
  candidates, or stable installations.
- Keep development mappings local and outside the public package. Candidate and
  release evidence must identify the exact commit or tag, use a clean candidate
  source, and prove which copy was actually loaded.
- Do not create or change a local discovery mapping, install or update a Skill,
  alter user-level configuration, or create an RC or stable installation
  without explicit user authorization.
- Do not commit, configure a remote, push, publish, or create a release unless
  the user explicitly requests it.
