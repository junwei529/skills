# Agent Workflow Skills

[简体中文](README.zh-CN.md)

A Markdown-first collection of three independent Codex Skills for reliable
project truth, consequential work, and Windows shell boundaries.

## Choose A Skill

| Skill | Use it for | Public guide |
|---|---|---|
| `manage-project-docs` | Audit, adopt, repair, and maintain project-document governance | [Project Docs](docs/skills/manage-project-docs/README.md) |
| `work-charter` | Bound consequential work with explicit authority, evidence, recovery, and proportional coordination | [Work Charter](docs/skills/work-charter/README.md) |
| `use-powershell-safely` | Diagnose and safely execute material PowerShell, native, text, permission, and WSL boundaries | [PowerShell](docs/skills/use-powershell-safely/README.md) |

Each Skill can be discovered, installed, invoked, used, stopped, and evaluated
alone. Repository membership is not a trigger.

## Install

Choose an accepted immutable repository tag from the live repository refs and
the [Repository Verification](docs/VERIFICATION.md) ledger, then substitute it
for `<version-tag>`:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/manage-project-docs.
```

Replace the final path with `skills/work-charter` or
`skills/use-powershell-safely` for another Skill.

Install the complete set from one repository identity:

```text
$skill-installer Install `skills/manage-project-docs`, `skills/work-charter`, and `skills/use-powershell-safely` from https://github.com/junwei529/skills at tag `<version-tag>`.
```

Installation, invocation/adoption, execution/writes, and packaging/release are
separate authorization surfaces. Do not use the moving `main` branch as a
stable installation identity.

## Invoke

```text
$manage-project-docs Audit this repository's project-document governance.

$work-charter Bound this consequential task, its authority, evidence, and recovery.

$use-powershell-safely Diagnose this material Windows shell boundary before changing application code.
```

Project Docs may be selected from a direct documentation-governance request or
high-confidence authority, evidence, routing, or recovery symptoms. That
implicit path is read-only and proposal-only; it never authorizes adoption,
structure, canonical-owner changes, or writes. `$manage-project-docs` remains
the manual override. After a concrete proposal is visible, natural-language
approval authorizes only its listed target-project changes. Valid persisted
project routing handles ordinary maintenance without loading the Skill.

Work Charter also accepts ordinary-language requests such as “use Work Charter
to decide how this project should continue”;
that direct request permits an activation claim only after the full body is
available in the current context. An indirect installed-Skills request or
concrete control or recovery symptoms need only catalog metadata for a proposal;
native selection may or may not load `SKILL.md`, and neither outcome grants
authority. The first response begins `Work Charter appears applicable because
...`, explains why, proposes activation plus the smallest project read, and
asks for confirmation. It uses no selection or activation heading, claims no
selected, loaded, invoked, active, or adopted state, does not inspect the
project, and does not prescribe pause, writer, evidence, handoff, resume,
protection-level, or role workflow.
After confirmation, the exact body must be available before activation or
workflow reliance; branch-required package references may then load, while
project inspection still requires approval for the exact scope. If the body is unavailable, activation
stops; if an approved project read is unavailable through its route, the
affected fact stays `UNKNOWN` and any different route needs a new proposal.
When the runtime does not expose the exact loaded path or revision, that
identity remains `UNKNOWN` and Codex makes no exact-copy claim.
PowerShell may be selected for material Windows boundaries. Activation or read
approval does not authorize adoption, roles, writes, Git, installation, or
external effects.

## Compose Optionally

The Skills are peers, not a hierarchy:

- Project Docs can repair document routing before Work Charter consumes it.
- Work Charter can retain task authority while PowerShell handles one material
  Windows boundary.
- All three can be used in one project without sharing runtime state or
  propagating authorization.

A recipe never installs, invokes, adopts, writes through, or releases another
Skill automatically.

## Release Status

This repository uses one immutable repository-level tag for the three
independent packages in a supported set. The current accepted stable release is
[`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2) at
`ceed607152849775b981c54add74bfa30d858e4d`. `v0.1.0` and `v0.1.1` remain
recorded historical identities. Live refs and
[Repository Verification](docs/VERIFICATION.md) own the exact release and
installed-copy evidence.

The shared tag is a release-set identity. It does not assert that every Skill
changed in that release or has the same maturity.

The working SOURCE may contain later development that is not in an installed
release. See [Repository Status](docs/STATUS.md) and the per-Skill State pages
before attributing behavior.

## Repository Documentation

- [Documentation index](docs/INDEX.md)
- [Authority map](docs/AUTHORITY.md)
- [Product specification](docs/SPEC.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Repository status](docs/STATUS.md)
- [Repository verification](docs/VERIFICATION.md)
- [Development and release runbook](docs/RUNBOOK.md)
- [Roadmap](docs/ROADMAP.md)

Installable packages remain under `skills/<skill-name>/`. Human product,
design, state, and evidence documents live under
`docs/skills/<skill-name>/`; they are not copied into the installable package.

## Evidence Limits

The repository records structural checks, synthetic behavior, controlled
loaded-copy canaries, exact-commit candidates, and stable-install identity.
It does not claim causal correctness improvement, token savings, broad trigger
accuracy, cross-Harness parity, or SHICE validation.

## License

Licensed under the [MIT License](LICENSE).
