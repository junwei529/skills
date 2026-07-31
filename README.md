# Agent Workflow Skills

[**English**](README.md) | [简体中文](README.zh-CN.md)

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

The original three-skill baseline has synthetic development evidence. The
later PowerShell portable-guidance migration revision adds bounded
generalization, high-signal trigger terms, native error-preference handling,
stronger WSL identity/stream checks, and explicit private-host exclusions.
Seven boundary scenarios and two catalog-assisted non-trigger canaries now
pass against that exact development SOURCE identity. This is SOURCE-assisted
behavior and catalog-level selection evidence. Controlled native
DEV_DISCOVERY canaries also proved implicit selection of canonical SOURCE and
non-loading for an ordinary cmdlet. This is development loaded-copy evidence,
not candidate, stable-install, or release proof. Project Docs now aligns its
explicit-only invocation, AGENTS
loading, continuity routing, and authorization boundaries with the current
official Codex manual. Five explicit fresh-context behavior groups, one
persistence-only broken-routing variant, and controlled native DEV_DISCOVERY
positive/negative canaries passed at the current six hashes. This proves the
selected development SOURCE and non-loading without explicit invocation in the
controlled canary, not candidate or release identity. Candidate identity is
the clean reviewed commit containing this record; a staged or dirty working
tree is not a candidate, and the development evidence above is not
retroactively release-pinned by a later commit. The reviewed revision was
committed as
[`c5d8e185ea9a9f32a4e98ac8ac364c4ebe915535`](https://github.com/junwei529/skills/commit/c5d8e185ea9a9f32a4e98ac8ac364c4ebe915535)
and made publicly reachable on `main` in
[`junwei529/skills`](https://github.com/junwei529/skills). This closes the
initial remote-visibility gate. A later shared exact-commit candidate at
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09` passed isolated
`$skill-installer`, identity, loaded-copy, and representative positive/negative
smoke for all three Skills. The public immutable `v0.1.0` tag now resolves to
that same candidate, and a tag-pinned multi-Skill `STABLE_INSTALL` passed
6/5/5-file identity, single-discovery, validator, and fresh-process
loaded-copy smoke for all three Skills. This closes tag-to-install technical
identity, but not a coherent public-release identity: the immutable tag's own
README predates publication and still says the tag is absent. The tag remains
retained evidence and must not be moved. No GitHub Release object, generalized
efficacy, portability, broad trigger-telemetry, or token-saving claim has been
established.

The corrected patch-release interface is `v0.1.1`. That immutable tag must
point to a reviewed revision containing this bilingual README and the accepted
Skill SOURCE, then pass exact-tag installation and loaded-copy proof. This
wording is intentionally valid both before and after tag publication: it does
not claim that an unverified tag already exists. Current mapping and evidence
remain owned by [`docs/VERIFICATION.md`](docs/VERIFICATION.md).

The reviewed bilingual candidate is
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`. All three unchanged Skill
packages passed exact-SHA `$skill-installer`, Git-blob, encoding, validator,
and fresh-process loaded-copy checks from that public commit. This is
release-candidate evidence, not a claim that tag `v0.1.1` or its stable
installation already exists.

The Work Charter M2R product contract is accepted in
[Decision 0012](docs/decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md).
It uses one minimum-sufficient logical contract, observed-risk activation,
visible reuse of an approved standing policy, compact recovery, and
proportional role separation. Initial persistent adoption and the first
Standard policy remain user-owned; later reuse does not propagate action
authority. The canonical package is now `work-charter`; the superseded
`manage-large-tasks` source was retired without an alias. Its SOURCE-assisted
matrix now has five conforming behavior groups and two controlled negative
variants with explicit canonical SOURCE identity. Controlled development and
candidate behavior plus tag-pinned stable loaded-copy identity now pass;
broad trigger telemetry and independent real-project behavior remain later
gates.

See the sanitized
[initial development report](evals/results/2026-07-27-development-forward-tests.md)
and
[revised PowerShell report](evals/results/2026-07-28-powershell-forward-tests.md),
the
[PowerShell portable-guidance migration check](evals/results/2026-07-30-powershell-portable-guidance-migration.md),
and the
[Project Docs M1R report](evals/results/2026-07-29-project-docs-m1r-forward-tests.md),
and the
[Project Docs official-manual alignment report](evals/results/2026-07-30-project-docs-official-manual-alignment.md),
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

These are the intended standalone v0.1 interfaces. The Work Charter package
exists as canonical SOURCE and as a verified tag-pinned installation.
Installation does not authorize adopting a Skill into a target project or any
other external action. The corrected patch-release interface is described
below; current availability and proof remain separate lifecycle facts.

## Installation And Distribution

v0.1 uses one standalone GitHub repository and repository-level immutable
version tags. Each Skill remains independently installable from its
`skills/<skill-name>` directory. Installation uses `$skill-installer` with the
exact public repository URL, immutable tag, and selected Skill path; it does
not install from the moving `main` branch.

For the corrected `v0.1.1` patch release, install only after the public tag
resolves to the reviewed candidate. The single-PowerShell interface is:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/v0.1.1/skills/use-powershell-safely.
```

To install the complete set from the same tag as an optional convenience:

```text
$skill-installer Install `skills/manage-project-docs`, `skills/work-charter`, and `skills/use-powershell-safely` from https://github.com/junwei529/skills at tag `v0.1.1`.
```

The tag must remain immutable once published. The earlier `v0.1.0` tag remains
retained installation evidence and must not be moved; its embedded README is
not the canonical release documentation. A `v0.1.1` release claim requires the
public tag-to-commit mapping, exact installed files, one discoverable copy per
Skill, validators, and fresh-process loaded-copy evidence recorded in
[`docs/VERIFICATION.md`](docs/VERIFICATION.md).

Current OpenAI guidance supports standalone local Skills and repository
downloads through `$skill-installer`, while preferring Plugins for broader
installable distribution. This project intentionally keeps v0.1 as an early
standalone Codex release and defers Plugin packaging. See the
[distribution decision](docs/decisions/0005-v0-1-standalone-github-distribution.md),
[identity update](docs/decisions/0013-github-public-identity-update.md), and
[runbook](docs/RUNBOOK.md).

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

Licensed under the [MIT License](LICENSE), copyright 2026 junwei529.
