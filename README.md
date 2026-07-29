# Agent Workflow Skills

A small, composable family of Codex-first Skills for reliable project truth
across agent sessions, bounded large-task coordination, and explicit
PowerShell/native/WSL boundary checks.

It turns lessons from a large personal ruleset into three independently useful,
selectively loaded Skills. The target project's own instructions remain
authoritative, detailed guidance loads only when needed, and unverified claims
stay visible.

## What It Gives You

- A Project Docs governance layer that adopts existing documentation, repairs
  authority and state drift, and adds only the minimum structure needed for a
  later agent to continue safely.
- A bounded Work Charter for consequential work, with proportional,
  policy-governed Orchestrator/Planner/Executor support when observed
  continuity or control risk justifies it.
- A Windows shell diagnostic and safe-execution workflow that distinguishes
  code defects from runtime, encoding, quoting, native-process, WSL,
  permission, and environment failures.

## Status

The Project Docs product contract and canonical Skill source were refined on
2026-07-28 for programmers and technical independent developers already using
Codex, Claude Code, Cursor, or Copilot without reliable project-document
governance. The accepted
[progressive-governance decision](docs/decisions/0006-project-docs-progressive-governance.md)
defines five logical responsibilities, event-driven expansion, explicit
structural authorization, and a lightweight target-project continuity anchor.
The implementation now uses two conditional references, two minimal output
assets, and five focused Project Docs eval scenarios rather than a prescribed
document suite.

The original three-skill baseline has synthetic development evidence, and the
revised PowerShell Skill has three passing behavior scenarios, one partial
Windows-to-WSL result, and one catalog-assisted POSIX non-trigger smoke. The
M1R Project Docs development source passed five explicit fresh-context
behavior scenarios plus a separate persistence-only continuity run after two
recorded contract corrections. A later source alignment made outcome
precedence explicit in one direct reference and enforced explicit-only
invocation in frontmatter and metadata. Five new fresh contexts then reran all
explicit scenarios against the current six-file package and passed with exact
SOURCE hashes. This closes current-source behavior attribution only; native
selection behavior remains unproved. Candidate identity is determined by the
repository's actual `HEAD`; the development evidence above is not
retroactively release-pinned by a later commit. No remote, candidate
installation, stable installation, tag, or release exists. The standalone GitHub
distribution contract and
[`matsuri1987/eddie-skills`](https://github.com/matsuri1987/eddie-skills)
repository identity are selected. Release progression requires an exact
reviewed commit, isolated candidate evidence, and the other repository
milestones. No generalized efficacy, portability, native-trigger, or
token-saving claim has been established.

The Work Charter M2R product contract is accepted in
[Decision 0012](docs/decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md).
It uses one minimum-sufficient logical contract, observed-risk activation,
visible reuse of an approved standing policy, compact recovery, and
proportional role separation. Initial persistent adoption and the first
Standard policy remain user-owned; later reuse does not propagate action
authority. The canonical package is now `work-charter`; the superseded
`manage-large-tasks` source was retired without an alias. Its SOURCE-assisted
matrix now has five conforming behavior groups and two controlled negative
variants with explicit canonical SOURCE identity. Native selection, installed
copy identity, and release proof remain later gates.

See the sanitized
[initial development report](evals/results/2026-07-27-development-forward-tests.md)
and
[revised PowerShell report](evals/results/2026-07-28-powershell-forward-tests.md),
and the
[Project Docs M1R report](evals/results/2026-07-29-project-docs-m1r-forward-tests.md),
and the
[Work Charter M2R report](evals/results/2026-07-29-work-charter-m2r-forward-tests.md)
for evidence and limitations.

## Skills

| Skill | Purpose |
|---|---|
| [`manage-project-docs`](skills/manage-project-docs/SKILL.md) | Adopt and repair project-document governance so later agents can find authoritative state and resume safely. |
| [`work-charter`](skills/work-charter/SKILL.md) | Bound consequential work with a minimum-sufficient contract, proportional coordination, evidence-aware recovery, and explicit authority. |
| [`use-powershell-safely`](skills/use-powershell-safely/SKILL.md) | Diagnose PowerShell/native/WSL boundaries, check runtime readiness, and recommend PowerShell 7 when it materially reduces risk. |

Each Skill is a standalone product for a distinct job. `manage-project-docs`
owns document semantics, canonical placement, governance repair, and the target
project's lightweight continuity anchor. Work Charter owns consequential-work
boundaries, proportional role coordination, recovery, and assessment.
`use-powershell-safely` owns
Windows shell-boundary diagnosis and safe-execution guidance. None must be
installed or invoked for another to work.

They can also be combined through optional recipes. For example, Project Docs
can establish reliable document routing before Work Charter consumes it, and
PowerShell safety can be selected inside a large run when a Windows/native/WSL
boundary becomes material. A recipe does not auto-install, auto-invoke, or
transfer authorization between Skills. See the
[independent-Skills decision](docs/decisions/0007-independent-skills-and-optional-recipes.md).

## 60-Second Tour

1. Read the accepted
   [Project Docs contract](docs/decisions/0006-project-docs-progressive-governance.md)
   and its five logical responsibilities.
2. Inspect the current
   [`manage-project-docs`](skills/manage-project-docs/SKILL.md) workflow,
   conditional references, and
   [minimal output assets](skills/manage-project-docs/assets/templates).
3. Read the accepted
   [Work Charter contract](docs/decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md),
   then inspect [`work-charter`](skills/work-charter/SKILL.md), its two
   conditional references, and minimal output asset.
4. Review the planned [evaluation cases](evals/README.md) and the honest
   [claim ledger](docs/VERIFICATION.md).

Example invocations after installation:

```text
Use $manage-project-docs to audit this repository's authority, status, and handoff docs.
Use $work-charter to bound this consequential migration and its acceptance loop.
Use $use-powershell-safely to diagnose this PowerShell-to-WSL quoting failure.
```

These are the intended interfaces. The Work Charter package now exists as
canonical development SOURCE. A supported public skill-package installation
path and release-pinned checks remain release gates.

## Installation And Distribution

v0.1 uses one standalone GitHub repository and one repository-level release
tag. Each Skill remains independently installable from its
`skills/<skill-name>` directory. Stable installation instructions will invoke
`$skill-installer` with the exact public repository URL, immutable tag, and
selected Skill path; they will not install from the moving `main` branch.

The approved PowerShell installation prompt for the intended `v0.1.0` release
is:

```text
$skill-installer Install the Skill from https://github.com/matsuri1987/eddie-skills/tree/v0.1.0/skills/use-powershell-safely.
```

To install the complete set from the same tag as an optional convenience:

```text
$skill-installer Install `skills/manage-project-docs`, `skills/work-charter`, and `skills/use-powershell-safely` from https://github.com/matsuri1987/eddie-skills at tag `v0.1.0`.
```

These prompts are the intended release contract, not currently working
commands: the repository has not been configured as a remote and the tag does
not exist.
Before release, an isolated candidate must prove the installer source,
destination, actually loaded copy, tag, and commit.

Current OpenAI guidance supports standalone local Skills and repository
downloads through `$skill-installer`, while preferring Plugins for broader
installable distribution. This project intentionally keeps v0.1 as an early
standalone Codex release and defers Plugin packaging. See the
[distribution decision](docs/decisions/0005-v0-1-standalone-github-distribution.md)
and [runbook](docs/RUNBOOK.md).

## Why Skills Instead Of One Global File

- Trigger-specific descriptions keep unrelated guidance out of ordinary tasks.
- Concise entry files route to conditional references and output templates.
- Project-local rules can override generic workflow guidance without forking a
  monolithic global file.
- Documentation, role control, and shell diagnostics can be evaluated
  independently.

## Design Principles

- Keep each `SKILL.md` small and load detailed references only when needed.
- Keep every Skill independently useful; document combinations as optional
  recipes rather than implicit dependencies.
- Preserve project-local instructions and existing documentation systems.
- Persist continuity in the target project's own governance entry, not in chat,
  private memory, or a Skill installation.
- Keep ordinary tasks flat; add role separation only when observed continuity,
  control, authorization, recovery, or independent-assessment risk justifies
  it.
- Treat skills as advisory workflows, not as sandboxes, locks, or permission
  systems.
- Record unknowns and unverified claims honestly.
- Keep publication artifacts free of private paths, IDs, credentials, raw
  conversations, and host-specific fingerprints.

## Repository Documentation

Start with [docs/INDEX.md](docs/INDEX.md).

The repository's own governance documents describe this project. Templates
under `skills/*/assets/` are outputs for target projects and are not current
facts about this repository.

Contributors should follow the
[development, installation, and release runbook](docs/RUNBOOK.md). Repository
files under `skills/` are the only editable source; development mappings,
release candidates, and stable installations are derived environments.

Evidence and release boundaries are tracked in the
[evaluation plan](evals/README.md), [verification ledger](docs/VERIFICATION.md),
and [provenance record](docs/PROVENANCE.md).

## Current Non-Goals

- A general-purpose agent Harness runtime.
- Automatic thread or session orchestration.
- MCP services, a Web UI, a database, or a remote registry.
- Organization-wide documentation catalogs, compliance or policy engines,
  connector synchronization, and automatic mapping invalidation.
- Native cross-Harness Project Docs packages or an umbrella Skill.
- Automatic commits, pushes, merges, cleanup, software installation or update,
  elevation, or system configuration changes.
- Claims of cross-Harness portability or causal token savings.

## License

Licensed under the [MIT License](LICENSE), copyright 2026 matsuri1987.
