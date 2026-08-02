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
- Do not add a Plugin, MCP service, UI, database, remote registry, or generic
  adapter framework without an accepted project decision.

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
