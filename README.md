# Agent Workflow Skills

[简体中文](README.zh-CN.md)

Keep consequential Codex work recoverable—without turning every task into a
workflow.

This Markdown-first repository contains three independent Codex Skills. Each
can be installed, invoked, used, stopped, and evaluated on its own.

| Skill | Use it for | Guide |
|---|---|---|
| `manage-project-docs` | Establish and maintain reliable project-document governance | [Project Docs](docs/skills/manage-project-docs/README.md) |
| `work-charter` | Bound consequential work by outcome, authority, evidence, recovery, and proportional coordination | [Work Charter](docs/skills/work-charter/README.md) |
| `use-powershell-safely` | Handle material PowerShell, native-process, text, permission, and WSL boundaries | [PowerShell](docs/skills/use-powershell-safely/README.md) |

Repository membership is not a trigger, and one Skill never authorizes or
activates another.

## Install

Choose an accepted immutable tag from the live repository refs and the
[verification ledger](docs/VERIFICATION.md), then install only the package you
need:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/work-charter.
```

Replace the final path with `skills/manage-project-docs` or
`skills/use-powershell-safely` as needed. Do not use moving `main` as a stable
installation identity.

Installation, invocation, project reads, writes, Git, and external effects are
separate authorization surfaces.

## Use

```text
$manage-project-docs Audit this repository's project-document governance.

$work-charter Bound this consequential task, its authority, evidence, and recovery.

$use-powershell-safely Diagnose this Windows shell boundary before changing code.
```

Work Charter may also notice strong complexity, continuity, authority, writer,
evidence, recovery, or collaboration signals. Before explicit activation it
only explains why it appears applicable, proposes the smallest useful read,
and asks for confirmation. It does not claim activation or prescribe a
workflow. After explicit authority and exact body availability, it recommends
the least sufficient protection while ordinary tasks remain flat. See the
[Work Charter guide](docs/skills/work-charter/README.md) for the full boundary.

## Release Status

The current accepted stable set is immutable
[`v0.2.0`](https://github.com/junwei529/skills/releases/tag/v0.2.0) at
`ac790233d5a8ba5afafd6eef95b1d5bc3cbe83a6`. Work Charter and PowerShell are
the changed packages in that set; Project Docs is byte-identical to its
`v0.1.2` package. Exact package, installer, loaded-copy, rollback, and release
evidence is recorded in [Repository Verification](docs/VERIFICATION.md).

A shared tag identifies a coherent release set. It does not imply that every
Skill changed or has the same evidence maturity. Working SOURCE may be ahead
of the installed release; consult [Repository Status](docs/STATUS.md) before
attributing behavior.

## Evidence Limits

The repository records structural checks, synthetic behavior, controlled
loaded-copy canaries, exact-commit candidates, and stable-install identity. It
does not claim broad trigger accuracy, deterministic enforcement, causal
correctness improvement, token savings, cross-Harness parity, or real-project
efficacy.

## Project Documentation

- [Documentation index](docs/INDEX.md)
- [Product specification](docs/SPEC.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Repository status](docs/STATUS.md)
- [Verification](docs/VERIFICATION.md)
- [Development and release runbook](docs/RUNBOOK.md)

Installable packages remain under `skills/<skill-name>/`. Human product,
design, state, and evidence documents live under `docs/skills/<skill-name>/`.

## License

Licensed under the [MIT License](LICENSE).
