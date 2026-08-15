# PowerShell

[简体中文](README.zh-CN.md)

PowerShell diagnoses and safely handles material Windows shell boundaries
across PowerShell, native executables, text bytes, permissions, and WSL. It is
a focused boundary workflow, not a general PowerShell tutorial or installer.

## Use It When

- before the first relevant command, the task explicitly requires a
  non-trivial `.ps1`, `pwsh`, or `powershell.exe` workflow, including
  multiline logic, loops, `try`/`catch`, regex, complex pipelines, native
  execution, or child-process handling;
- PowerShell 5.1 versus 7 behavior is material;
- native arguments, quoting, stdout, stderr, `$LASTEXITCODE`, pipelines,
  redirection, stdin, or nested shell strings are suspect;
- UTF-8, BOM, newline, JSON, schema, hashes, legacy code pages, or non-ASCII
  text matters;
- Windows and WSL execution or paths cross; or
- sandbox, permission, destructive filesystem, or process-control boundaries
  need diagnosis.

## Do Not Use It When

- an ordinary version-independent cmdlet has no boundary symptom; or
- the task is POSIX-only.

## Install Independently

Choose an accepted immutable repository tag from the live repository refs and
the repository [Verification](../../VERIFICATION.md) ledger, then substitute
it for `<version-tag>`:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/use-powershell-safely.
```

The current stable `v0.1.2` package includes the later hardening.
Installation, updates, PowerShell setup, and system changes remain separate
authorized actions. Do not use the moving `main` branch as a stable identity.

## Invoke

Explicit non-trivial PowerShell or material symptoms may select the Skill
before execution. Explicit use is appropriate for pre-execution readiness or
reproducible diagnosis:

```text
$use-powershell-safely Validate this non-trivial PowerShell command before it
runs, then preserve its native argument, stream, and exit-code boundaries.
```

## Safety Boundaries

Prefer a `.ps1` for complex logic or parse the exact inline payload in the same
PowerShell executable/version that will run it. Inspect a cmdlet's actual
parameter set instead of assuming
`-LiteralPath`; `New-Item` uses `-Path`. Use narrow fail-fast cmdlet handling
and verify the expected artifact or state, while reserving `$LASTEXITCODE` for
native process status. Preserve native arguments as structured values and
treat exact text bytes as correctness when relevant.
Obtain explicit authorization before installation, update, elevation, profile,
policy, locale, registry, service, firewall, WSL-state, or destructive host
changes. Resolve destructive targets literally and prove containment.

## Verified Capability And Limits

The historical `v0.1.1` revision has fresh-context, controlled DEV_DISCOVERY,
exact-commit RC, and tag-pinned stable loaded-copy evidence. Package bytes at
`c42eef3...` add the later hardening and have exact-commit corrected-copy
identity, native positive and negative loaded-copy canaries, dual-runtime
deterministic checks, an executed native/text controller boundary, and an
independent readiness verdict. The repository-level
[`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2) stable copy
has exact loaded-copy identity plus a guarded native/text diagnosis canary.
The hardening still lacks live Bash/WSL, an executed native probe inside the
stable canary sandbox, actual sandbox-denial injection, and shadow-use proof.
The unreleased P1 SOURCE revision adds deterministic dual-runtime command-
readiness checks and a pre-error selection contract. One bounded fresh tranche
observed the exact P1 revision load before the first risky command while the
same request did not load immutable `v0.1.2`; ordinary-cmdlet and POSIX-only
negatives also stayed unloaded. The target command did not execute, no
assessor ran, and broad selection, selected behavior, RC, and stable readiness
remain unproved.
See [Verification](VERIFICATION.md) and [State](STATE.md).

## Authoritative Contract

This page is a human entry point. The repository
[product contract](../../SPEC.md), [PowerShell design](DESIGN.md), accepted
decisions, and canonical
[`SKILL.md`](../../../skills/use-powershell-safely/SKILL.md) own behavior.
