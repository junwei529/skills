---
name: use-powershell-safely
description: Diagnose and safely execute boundary-sensitive Windows shell workflows across PowerShell, native executables, and WSL. Use when a Windows task involves PowerShell 5.1 versus 7, PowerShell 7 readiness or installation guidance, quoting or argument boundaries, NativeCommandError, unexpected stdout/stderr or native exit status such as $LASTEXITCODE, missing or truncated output, stdin, pipelines, redirection, heredocs or nested shell strings, $PSNativeCommandArgumentPassing, Invoke-Expression, UTF-8/BOM/newline/hash correctness, JSON/schema/text, legacy code pages or non-ASCII text, WSL path or transport, Start-Process or ProcessStartInfo, sandbox or permission boundaries, or destructive filesystem operations. Do not use for ordinary version-independent cmdlets with no boundary symptom or for POSIX-only work.
---

# Use PowerShell Safely

Treat the shell boundary as part of correctness. Use this skill as the minimum
combination of boundary diagnosis and safe execution guidance, not as a general
PowerShell tutorial or an automatic system installer.

## Start With Runtime And Boundary Readiness

- Do not run a version probe for every routine cmdlet. Probe when the task
  materially depends on text encoding, native argument passing, stream
  behavior, WSL transport, or PowerShell-version compatibility.
- Inspect the current edition, version, and executable before relying on
  version-specific behavior:

```powershell
$PSVersionTable.PSEdition
$PSVersionTable.PSVersion
$PSHOME
Get-Command pwsh -CommandType Application -ErrorAction SilentlyContinue
```

- Prefer a supported PowerShell 7 release for modern UTF-8, native-command, and
  WSL workflows when the target modules and scripts are compatible. Keep a
  Windows PowerShell 5.1 path when a legacy module or host requires it.
- If no usable `pwsh` exists and the current task would materially benefit from
  PowerShell 7, explain the task-specific benefit, note that 7 installs
  side-by-side with 5.1, and ask whether the user wants the official
  installation path. Detection alone never authorizes installation.
- Read the runtime-readiness and installation sections in
  [Native And Process Boundaries](references/native-process-boundaries.md)
  before recommending a version or installation method.

## Classify Evidence Before Generalizing

- Treat documented platform behavior and a reproduced version boundary as
  portable guidance.
- Treat a failure seen on one host as a bounded hypothesis until the mechanism,
  prerequisite, and affected versions are established. State the uncertainty
  instead of turning one observation into a universal PowerShell rule.
- Treat exact executable paths, installed versions, account or distribution
  names, environment-variable values, `PATH` order, package provenance,
  sandbox identities, and current host state as local evidence. Verify them on
  the active host and do not expose unrelated values.
- Generalize the diagnostic question or safe command shape, not the private
  host answer.

## Load Only The Relevant Detail

- Read [Native And Process Boundaries](references/native-process-boundaries.md)
  for cmdlets versus native executables, versions, arguments,
  `NativeCommandError`, streams, pipelines, `ProcessStartInfo`,
  `Start-Process`, permissions, destructive operations, or PowerShell 7
  installation guidance.
- Read [Text And Encoding Boundaries](references/text-encoding-boundaries.md)
  only when text bytes, UTF-8, BOM, newline, JSON/schema, hashes, non-ASCII
  content, or a legacy code page may matter.
- Read [Windows And WSL Boundaries](references/windows-wsl-boundaries.md) only
  when execution, paths, data, or state crosses between Windows and WSL.

## Diagnose In Order

1. Identify the current PowerShell edition and every parser, process, encoding,
   path, permission, and WSL boundary involved.
2. Reproduce the failure with the smallest read-only command that preserves the
   suspected boundary.
3. Establish the command contract: PowerShell object/error semantics or native
   arguments, stdout, stderr, and exit status.
4. Prefer a direct cmdlet or `& $exe @args`; move complex multi-line logic into
   a script for the shell that owns it.
5. Inspect exact bytes only when text encoding, BOM, newline, or byte identity
   is relevant.
6. Capture `$LASTEXITCODE` immediately after a native program whose contract is
   exit-status based.
7. Classify the result as application defect, argument or parser transport,
   stream or exit handling, text encoding, WSL or path semantics, environment
   drift, sandbox or permission, cleanup noise, or still unknown.
8. Change application code only when the direct, correctly transported
   reproduction demonstrates an application defect.

## Stop And Ask

- Obtain explicit authorization before installing or updating PowerShell,
  elevating, downloading packages, changing profiles or execution policy, or
  modifying system locale, code page, registry, firewall, services, WSL state,
  or other system configuration.
- Stop for organizational policy, unavailable package tooling, required
  administrator approval, an incompatible legacy module, or uncertainty about
  the intended installation scope.
- Before destructive recursion, resolve every target to an absolute literal
  path and prove it stays inside the intended root. Keep enumeration and
  mutation in one shell.
- Do not expose credentials, tokens, cookies, private keys, environment-file
  contents, or unrelated host paths.
- Do not retry with more parser layers, broader permissions, or a riskier
  transport until the failure is classified and the added authority is
  justified.

Report the observed runtime, failing boundary, evidence, safe command shape,
authorization status, and remaining uncertainty.
