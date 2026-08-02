# 0017: Capability-Delta Skill Development

Date: 2026-08-02
Status: accepted

## Context

Public Skills are developed against a moving combination of model capability
and Agent Harness capability. A Skill that restates generic reasoning,
planning, or tool-use behavior can become redundant as either layer improves.
A Skill that rebuilds those layers behind its own fixed workflow cannot reuse
their improvements and accumulates adapter and maintenance cost.

The design discussion called the desired alternative "oblique development":
the Skill should move with the model/Harness boundary rather than remain
parallel to it or isolated from it. This is not an established term in the
reviewed literature. This decision uses **capability-delta development** as the
internal engineering name. Users do not need to learn that term.

Several evidence classes support the direction without proving efficacy for
this repository:

- Current OpenAI Skill guidance uses progressive disclosure, treats the
  frontmatter description as the selection surface, and recommends focused
  Skills rather than broad workflow bundles. Current GPT-5.6 guidance also
  recommends removing repeated instructions and examples while retaining
  domain context, hard constraints, approval boundaries, and success criteria.
- Research on the
  [automation-augmentation paradox](https://doi.org/10.5465/2018.0072),
  [complementary investment around general-purpose technology](https://www.aeaweb.org/articles?id=10.1257/mac.20180386),
  the
  [jagged technological frontier](https://doi.org/10.1287/orsc.2025.21838),
  and
  [Agent-Computer Interface design](https://proceedings.neurips.cc/paper_files/paper/2024/hash/5a7c947568c1b1328ccc5230172e1e7c-Abstract-Conference.html)
  shows related task-allocation, organizational-complement, uneven-capability,
  and interface effects. None directly validates a Codex Skill product.
- The
  [Superpowers release history](https://github.com/obra/superpowers/blob/44c9b2d6e889982ac18c27d05a19fefe335194e1/RELEASE-NOTES.md)
  is a relevant maintainer-reported case: it removed generic tool mappings,
  Codex bootstrap behavior, and expensive review structure when native Agent
  behavior or its own evaluations no longer justified them. It is product
  evidence from one project, not an independent benchmark.

This repository already requires concise Skills, progressive disclosure,
observed failures or user decisions for new concepts, and honest evidence
attribution. Its historical runs are predominantly Skill-assisted and do not
provide a matched native-versus-Skill causal comparison.

## Options Considered

1. Develop parallel Skills that restate complete workflows so behavior remains
   similar across model and Harness versions.
2. Develop vertically isolated Skills that emulate model, Harness, lifecycle,
   and enforcement behavior behind one self-contained interface.
3. Treat the current model and Harness as a moving substrate and add only the
   measured or explicitly required capability delta.

## Decision

Choose option 3 for new public Skills and material selection or behavior
revisions after this decision. The accepted `v0.1.2` release is not
retroactively invalidated.

### Capability-Delta Contract

- Start with the strongest practical no-target-Skill baseline for the intended
  model, Harness, task, project rules, and tools. Do not assume that a longer
  Skill is useful merely because it is more explicit.
- Add instructions or resources only for a demonstrated gap, a user-approved
  product requirement, or a hard boundary whose ownership must remain
  explicit. Record which condition justifies each material public concept.
- Keep generic interpretation, synthesis, and adaptable planning with the
  model. Use the Harness's native discovery, context, tools, permissions,
  sandbox, sessions, and delivery surfaces instead of imitating them in prose.
- Keep always-applicable repository policy in project instructions, durable
  facts in their canonical project owners, and deterministic checks or
  enforcement in scripts, hooks, tools, or external systems. A Skill may route
  to those surfaces but must not claim their guarantees as its own.
- Let the Skill own the on-demand residual: precise selection boundaries,
  non-obvious domain or procedural knowledge, evidence and approval gates,
  failure routing, recovery behavior, and the smallest user-visible workflow
  that joins those responsibilities.
- Keep selection metadata short and discriminative, load the body only after
  selection, and load references only when their branch is needed. A Skill
  must not poll conversations or preload a universal workflow to manufacture
  relevance.
- Prefer capability checks and stable outcome contracts over branching on
  model marketing names. Record the actual model/Harness identity as far as
  the Harness exposes it and preserve `UNKNOWN` where it does not.

### Upgrade And Retirement Rule

A reproducible production failure or selection regression, or a material
model, Harness, tool, permission, or catalog change, reopens the delta rather
than automatically expanding the Skill. Re-run the relevant baseline and
selection/behavior cases, then choose the smallest truthful disposition:

1. retain the Skill behavior because the residual gap still exists;
2. simplify instructions or examples that the substrate now handles;
3. delegate deterministic or native behavior to the correct layer; or
4. retire the behavior or Skill when its remaining benefit no longer justifies
   trigger, context, latency, interruption, and maintenance cost.

Safety, authorization, and recovery invariants are not averaged away by an
aggregate quality score. If one of those boundaries justifies the delta, its
applicable cases must pass independently.

### Evaluation Contract

For a new Skill or material selection or behavior revision, use the
proportional comparison owned by
[`evals/README.md`](../../evals/README.md):

- a native condition without the target Skill discoverable;
- a catalog/selection condition that exposes realistic Skill metadata and
  includes ordinary and near-neighbor non-triggers;
- a selected behavior condition for the exact target Skill revision; and
- an upgrade regression when the target model, Harness, tools, permissions, or
  installed catalog changes materially.

Keep task input, repository state, permissions, tools, and reasoning budget as
comparable as the Harness permits. Measure outcome and hard-boundary behavior
first; record token/context use, latency, user interruptions, and maintenance
cost as secondary evidence. Do not claim correctness improvement, token
savings, or portability from design reasoning, one assisted run, or
maintainer-reported external results.

When a material revision has an exact accepted control revision, compare that
control and the exact candidate in addition to the native condition. Do not
use a moving working tree, an earlier unpinned run, or a later candidate commit
as the control identity.

### External Frameworks And Optimizers

This decision owns the accepted rationale, external-framework disposition, and
hard invariants. `docs/SPEC.md` owns the product requirement,
`docs/ARCHITECTURE.md` owns layer allocation, `docs/RUNBOOK.md` owns current
procedure, `docs/PROVENANCE.md` owns external reference and data handling, and
`evals/README.md` owns the evaluation schema and detailed results.

The bundled `$skill-creator` remains the default authoring and structural
validation entry after the intake records a justified residual and the target
change is separately authorized. Invoking it does not authorize a write, and it
does not own the product decision, behavioral acceptance, lifecycle state, or
release authorization.

The reviewed
[YAO Meta Skill snapshot](https://github.com/yaojingang/yao-meta-skill/tree/e15472e1f5dc96f79ea0259bf9fdf67598cea356)
at commit `e15472e1f5dc96f79ea0259bf9fdf67598cea356` is a design reference,
not a dependency or evidence source for this repository's efficacy. Its
duplicate-install diagnostics, baseline/candidate comparison, claim/evidence
consistency, and metadata-focused review patterns may be adapted only when a
local observed problem justifies them. This decision does not adopt its Skill
OS, intermediate representation, compilers, UI, registry, telemetry, Plugin,
MCP service, or umbrella meta-Skill.

The reviewed
[SkillOpt snapshot](https://github.com/microsoft/SkillOpt/tree/e7014cd18a18e11e6f6c10b897f7a009960d2e1b)
at commit `e7014cd18a18e11e6f6c10b897f7a009960d2e1b` may inform a separately
authorized, isolated experiment that proposes changes to one frozen Skill
revision under the procedure and evaluation schema owned by the Runbook and
evaluation contract. For a multi-file Skill, freeze and assess the whole
package even if an optimizer accepts or emits only one document.

Optimizer output is an untrusted suggestion, not accepted SOURCE, causal
evidence, installation proof, or release evidence. No experiment may consume
raw production sessions or private project context, write automatically into
canonical SOURCE, auto-adopt an output, or bypass `$skill-creator`, the normal
evaluation contract, and the candidate/release lifecycle. Preview or
session-derived optimization surfaces receive no broader exception.

## Consequences

- A Skill is a thin, revisable complement to a model/Harness combination, not
  a frozen substitute for either layer.
- Model and Harness improvement is expected to delete Skill content as well as
  enable new residual workflows.
- The principle does not require an umbrella Skill, lifecycle meta-Skill,
  Plugin, MCP service, adapter framework, or new file inside every package.
  Each still needs its own observed problem and accepted decision.
- External framework patterns may reduce future design work, but remain
  selectively imported into existing canonical owners rather than creating a
  parallel lifecycle control plane.
- Existing evidence ledgers remain truthful: the three current Skills do not
  acquire causal, token-saving, broad-trigger, SHICE, or cross-Harness claims.
- For Work Charter specifically, authority, evidence, recovery, and durable
  cross-session reconciliation are plausible residual responsibilities;
  broad natural-language selection and net benefit remain evaluation
  questions rather than accepted facts.

## Re-evaluation Conditions

Revisit this decision if matched evaluations show that the delta method hides
necessary end-to-end behavior, if reproducible production feedback repeatedly
escapes the intake, if users cannot discover focused Skills without a broader
entry surface, if a supported Harness absorbs a current hard boundary, or if
repeated real use requires a shared runtime rather than an optional composition
recipe.

## Related Documents

- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Development and release runbook](../RUNBOOK.md)
- [Evaluation contract](../../evals/README.md)
- [Provenance and publication boundary](../PROVENANCE.md)
- [Decision 0007](0007-independent-skills-and-optional-recipes.md)
- [Decision 0012](0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
- [OpenAI Build Skills](https://learn.chatgpt.com/docs/build-skills)
- [OpenAI GPT-5.6 guidance](https://developers.openai.com/api/docs/guides/latest-model)
