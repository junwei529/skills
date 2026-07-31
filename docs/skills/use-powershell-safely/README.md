# PowerShell

[简体中文](README.zh-CN.md)

PowerShell diagnoses and safely handles material Windows shell boundaries
across PowerShell, native executables, text bytes, permissions, and WSL. It is
a focused boundary workflow, not a general PowerShell tutorial or installer.

## Use It When

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

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/v0.1.1/skills/use-powershell-safely.
```

The stable `v0.1.1` package does not include the later local SOURCE hardening.
Installation, updates, PowerShell setup, and system changes remain separate
authorized actions.

## Invoke

Material symptoms may select the Skill implicitly. Explicit use is appropriate
for high-risk or reproducible diagnosis:

```text
$use-powershell-safely Diagnose this native argument, stream, and exit-code
boundary before changing application code.
```

## Safety Boundaries

Capture native exit status according to the tool contract, preserve arguments
as structured values, and treat exact text bytes as correctness when relevant.
Obtain explicit authorization before installation, update, elevation, profile,
policy, locale, registry, service, firewall, WSL-state, or destructive host
changes. Resolve destructive targets literally and prove containment.

## Verified Capability And Limits

The `v0.1.1` SOURCE has fresh-context, controlled DEV_DISCOVERY, exact-commit
RC, and tag-pinned stable loaded-copy evidence. A later local
boundary-hardening revision passes fifteen deterministic assertions under
PowerShell 7 and Windows PowerShell 5.1 plus fresh SOURCE-assisted behavior and
independent acceptance, but lacks current native selection, loaded-copy,
candidate, stable, live Bash/WSL, actual sandbox-denial, and shadow-use proof.
See [Verification](VERIFICATION.md) and [State](STATE.md).

## Authoritative Contract

This page is a human entry point. The repository
[product contract](../../SPEC.md), [PowerShell design](DESIGN.md), accepted
decisions, and canonical
[`SKILL.md`](../../../skills/use-powershell-safely/SKILL.md) own behavior.
