# Documentation Index

Last updated: 2026-08-10

## Core Documents

| File | Purpose | Status |
|---|---|---|
| [`LICENSE`](../LICENSE) | Public MIT license terms and attribution | active |
| [`README.md`](../README.md) | Public project entry point | active |
| [`README.zh-CN.md`](../README.zh-CN.md) | Simplified Chinese mirror of the public project entry point; English remains canonical | active |
| [`AGENTS.md`](../AGENTS.md) | Repository-specific agent rules | active |
| [`docs/AUTHORITY.md`](AUTHORITY.md) | Fact ownership and conflict handling | active |
| [`docs/SPEC.md`](SPEC.md) | Stable product scope and acceptance contract | active |
| [`docs/ARCHITECTURE.md`](ARCHITECTURE.md) | Skill and documentation boundaries | active |
| [`docs/ROADMAP.md`](ROADMAP.md) | Planned milestones | active |
| [`docs/STATUS.md`](STATUS.md) | Current verified progress | active |
| [`docs/HANDOFF.md`](HANDOFF.md) | Recovery entry point | active |
| [`docs/RUNBOOK.md`](RUNBOOK.md) | Capability-delta intake, bounded Campaign authorization, optional optimizer experiment, development, discovery, installation, candidate, and release procedure | active |
| [`docs/VERIFICATION.md`](VERIFICATION.md) | Checks, evidence, and claim ledger | active |
| [`docs/PROVENANCE.md`](PROVENANCE.md) | Source transformation, external reference/data handling, and publication boundary | active |

## Per-Skill Product Documents

| Skill | Human Entry | Design | State | Verification |
|---|---|---|---|---|
| Project Docs | [`README.md`](skills/manage-project-docs/README.md) / [`简体中文`](skills/manage-project-docs/README.zh-CN.md) | [`DESIGN.md`](skills/manage-project-docs/DESIGN.md) | [`STATE.md`](skills/manage-project-docs/STATE.md) | [`VERIFICATION.md`](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter | [`README.md`](skills/work-charter/README.md) / [`简体中文`](skills/work-charter/README.zh-CN.md) | [`DESIGN.md`](skills/work-charter/DESIGN.md) | [`STATE.md`](skills/work-charter/STATE.md) | [`VERIFICATION.md`](skills/work-charter/VERIFICATION.md) |
| PowerShell | [`README.md`](skills/use-powershell-safely/README.md) / [`简体中文`](skills/use-powershell-safely/README.zh-CN.md) | [`DESIGN.md`](skills/use-powershell-safely/DESIGN.md) | [`STATE.md`](skills/use-powershell-safely/STATE.md) | [`VERIFICATION.md`](skills/use-powershell-safely/VERIFICATION.md) |

These repository documents do not belong inside the installable Skill
packages. English is canonical; each public README has a Simplified Chinese
mirror.

## Decisions

| File | Decision | Status |
|---|---|---|
| [`docs/decisions/0001-v0-1-scope-and-names.md`](decisions/0001-v0-1-scope-and-names.md) | Initial three-skill v0.1 structure and names | accepted; partially superseded by 0007 and 0012 |
| [`docs/decisions/0002-powershell-scope-and-runtime-readiness.md`](decisions/0002-powershell-scope-and-runtime-readiness.md) | PowerShell scope, progressive references, and runtime-readiness boundary | accepted |
| [`docs/decisions/0003-source-install-release-boundaries.md`](decisions/0003-source-install-release-boundaries.md) | Canonical source, development mapping, candidate, stable install, and version identity | accepted |
| [`docs/decisions/0004-public-mit-license.md`](decisions/0004-public-mit-license.md) | MIT license selection and public-attribution boundary | accepted; identifier clause superseded by 0013 |
| [`docs/decisions/0005-v0-1-standalone-github-distribution.md`](decisions/0005-v0-1-standalone-github-distribution.md) | Standalone GitHub source, tag-pinned per-Skill installation, and deferred Plugin packaging | accepted; repository-owner clause superseded by 0013 |
| [`docs/decisions/0006-project-docs-progressive-governance.md`](decisions/0006-project-docs-progressive-governance.md) | Project Docs target user, minimum logical contract, triggers, continuity, and deferred architecture | accepted |
| [`docs/decisions/0007-independent-skills-and-optional-recipes.md`](decisions/0007-independent-skills-and-optional-recipes.md) | Independent Skill products, shared audience, optional recipes, and non-propagating authorization | accepted; naming clauses refined by 0012 |
| [`docs/decisions/0008-work-charter-logical-contract-and-codex-carriers.md`](decisions/0008-work-charter-logical-contract-and-codex-carriers.md) | Work Charter logical responsibilities, persistence threshold, Codex carriers, and deferred Harness adaptation | accepted; partially superseded by 0012 |
| [`docs/decisions/0009-work-charter-role-profiles-and-resume-gate.md`](decisions/0009-work-charter-role-profiles-and-resume-gate.md) | Flat, L1, L2, and Standard role profiles plus evidence-aware recovery | accepted; partially superseded by 0012 |
| [`docs/decisions/0010-compact-role-handoff-and-event-checkpoints.md`](decisions/0010-compact-role-handoff-and-event-checkpoints.md) | Anchor + Delta + Role Capsule handoffs, session reuse, and event-based checkpoints | accepted; partially superseded by 0012 |
| [`docs/decisions/0011-standard-ope-is-a-supported-advanced-profile.md`](decisions/0011-standard-ope-is-a-supported-advanced-profile.md) | Formal v0.1 support for Standard Orchestrator/Planner/Executor | accepted; activation detail superseded by 0012 |
| [`docs/decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md`](decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md) | Work Charter identity, proportional activation, simplified handoff and assessment, concurrency, and correction bounds | accepted |
| [`docs/decisions/0013-github-public-identity-update.md`](decisions/0013-github-public-identity-update.md) | Current GitHub owner, repository slug, local-directory boundary, and MIT public-attribution identifier | accepted; supersedes only public-identity clauses in 0004 and 0005 |
| [`docs/decisions/0014-powershell-portable-guidance-and-private-host-delta.md`](decisions/0014-powershell-portable-guidance-and-private-host-delta.md) | Public PowerShell rule classification, minimal global bootstrap, private host delta, and safe migration evidence | accepted |
| [`docs/decisions/0015-federated-repository-documentation.md`](decisions/0015-federated-repository-documentation.md) | Root/per-Skill documentation ownership, bilingual public entries, and unchanged installable-package boundary | accepted |
| [`docs/decisions/0016-work-charter-authority-assessment-and-evidence-integrity.md`](decisions/0016-work-charter-authority-assessment-and-evidence-integrity.md) | Work Charter authority finality, assessment recording, evidence invalidation, delivery degradation, and advisory writer recovery | accepted |
| [`docs/decisions/0017-capability-delta-skill-development.md`](decisions/0017-capability-delta-skill-development.md) | Prospective capability-delta design, layer placement, matched evaluation, and upgrade/retirement rule for Skill development | accepted |
| [`docs/decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md`](decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md) | Work Charter two-stage natural-language entry, proportional protection levels, durable re-entry, task convergence, evaluation, workspace, and lifecycle gates | accepted through D33; exact D31 candidate `07a9f1c...` remains unaccepted after zero-turn D32 qualification and the immutable D33 infrastructure `UNKNOWN`; see the Work Charter State and Verification ledgers |
| [`docs/decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md`](decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md) | Project Docs implicit discovery, proposal/write boundary, demand-driven modules, update modes, and persistent routing | accepted; current implementation is an unreleased working-tree revision; see Project Docs State |
| [`docs/decisions/0020-bounded-campaign-authorization-and-evidence-convergence.md`](decisions/0020-bounded-campaign-authorization-and-evidence-convergence.md) | One bounded authorization for qualification, evidence, assessment, and closeout with same-boundary transport qualification and cumulative convergence | accepted |

## Skill Sources

| Skill | Entry Point | Detailed Resources |
|---|---|---|
| Project Docs | [`skills/manage-project-docs/SKILL.md`](../skills/manage-project-docs/SKILL.md) | [`references/`](../skills/manage-project-docs/references), [`assets/templates/`](../skills/manage-project-docs/assets/templates) |
| Work Charter | [`skills/work-charter/SKILL.md`](../skills/work-charter/SKILL.md) | [`references/`](../skills/work-charter/references), [`assets/`](../skills/work-charter/assets) |
| PowerShell | [`skills/use-powershell-safely/SKILL.md`](../skills/use-powershell-safely/SKILL.md) | [`references/`](../skills/use-powershell-safely/references) |

## Evaluation

| Path | Purpose |
|---|---|
| [`evals/README.md`](../evals/README.md) | Evaluation types, rubric, and evidence policy |
| [`evals/cases/`](../evals/cases) | Public scenario contracts and pass/fail expectations |
| [`evals/fixtures/`](../evals/fixtures) | Synthetic task inputs without expected answers |
| [`evals/check-fixtures.ps1`](../evals/check-fixtures.ps1) | Deterministic fixture-precondition checks |
| [`evals/results/`](../evals/results) | Sanitized development evidence and limitations |

## Reading Routes

- Understand the product: [`README.md`](../README.md) →
  [`Decision 0007`](decisions/0007-independent-skills-and-optional-recipes.md) →
  [`docs/SPEC.md`](SPEC.md) → [`docs/ARCHITECTURE.md`](ARCHITECTURE.md).
- Develop or materially revise a Skill:
  [`Decision 0017`](decisions/0017-capability-delta-skill-development.md) →
  [`docs/SPEC.md`](SPEC.md) → [`docs/ARCHITECTURE.md`](ARCHITECTURE.md) →
  [`docs/RUNBOOK.md`](RUNBOOK.md#capability-delta-intake) →
  [`evals/README.md`](../evals/README.md).
- Run a consequential or one-shot Skill evaluation:
  [`Decision 0020`](decisions/0020-bounded-campaign-authorization-and-evidence-convergence.md) →
  [`docs/RUNBOOK.md`](RUNBOOK.md#bounded-campaign-authorization) →
  [`evals/README.md`](../evals/README.md#campaign-evidence-semantics).
- Evaluate an external Skill optimizer:
  [`Decision 0017`](decisions/0017-capability-delta-skill-development.md#external-frameworks-and-optimizers) →
  [`docs/RUNBOOK.md`](RUNBOOK.md#external-optimizer-experiment) →
  [`docs/PROVENANCE.md`](PROVENANCE.md#external-optimization-data) →
  [`evals/README.md`](../evals/README.md#external-optimizer-experiment-contract).
- Understand the Project Docs refinement:
  [`Decision 0006`](decisions/0006-project-docs-progressive-governance.md) →
  [`Decision 0019`](decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md) →
  [`Project Docs Design`](skills/manage-project-docs/DESIGN.md) →
  [`Project Docs State`](skills/manage-project-docs/STATE.md).
- Understand the Work Charter refinement:
  [`Decision 0012`](decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md) →
  [`Decision 0016`](decisions/0016-work-charter-authority-assessment-and-evidence-integrity.md) →
  [`Decision 0018`](decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md) →
  [`Work Charter Design`](skills/work-charter/DESIGN.md) →
  [`Work Charter State`](skills/work-charter/STATE.md).
- Understand the PowerShell global-rule migration:
  [`Decision 0014`](decisions/0014-powershell-portable-guidance-and-private-host-delta.md) →
  [`PowerShell Design`](skills/use-powershell-safely/DESIGN.md) →
  [`PowerShell State`](skills/use-powershell-safely/STATE.md).
- Check reuse terms: [`LICENSE`](../LICENSE).
- Check current progress: [`docs/STATUS.md`](STATUS.md) →
  the relevant per-Skill `STATE.md` →
  the relevant per-Skill `VERIFICATION.md`.
- Inspect behavior evidence: [`evals/README.md`](../evals/README.md) →
  [`evals/results/`](../evals/results).
- Resume work: [`docs/HANDOFF.md`](HANDOFF.md) →
  [`docs/STATUS.md`](STATUS.md) → Git state.
- Develop, install, or release:
  [`docs/RUNBOOK.md`](RUNBOOK.md) →
  [`docs/VERIFICATION.md`](VERIFICATION.md) →
  [`docs/STATUS.md`](STATUS.md).
- Change a skill: its `SKILL.md` → only the references needed for that change.

This index is navigation only. It does not replace the documents it links.
