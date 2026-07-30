# Native And Process Boundaries

Use this reference for PowerShell runtime readiness, cmdlet/native distinctions,
arguments, stdout/stderr, exit codes, pipelines, process APIs, permissions,
destructive operations, and PowerShell 7 installation guidance.

## Contents

- [Runtime Readiness](#runtime-readiness)
- [Installation Is A Separate Authorized Action](#installation-is-a-separate-authorized-action)
- [Cmdlet Or Native Executable](#cmdlet-or-native-executable)
- [Native Errors And Preference Variables](#native-errors-and-preference-variables)
- [Preserve Native Arguments](#preserve-native-arguments)
- [Streams, Pipelines, And Redirection](#streams-pipelines-and-redirection)
- [Process APIs](#process-apis)
- [Paths, Permissions, And Destructive State](#paths-permissions-and-destructive-state)
- [Official Sources](#official-sources)

## Runtime Readiness

Probe only when version-specific behavior is material. Start with the current
host and a read-only lookup:

```powershell
$currentHost = [pscustomobject]@{
    Edition = $PSVersionTable.PSEdition
    Version = $PSVersionTable.PSVersion.ToString()
    Home = $PSHOME
}

$pwsh = Get-Command pwsh -CommandType Application -ErrorAction SilentlyContinue |
    Select-Object -First 1
```

If `pwsh` resolves, verify that exact executable rather than trusting `PATH`:

```powershell
$probeArgs = @(
    '-NoLogo'
    '-NoProfile'
    '-NonInteractive'
    '-Command'
    '$PSVersionTable.PSVersion.ToString()'
)

& $pwsh.Path @probeArgs
$pwshProbeExit = $LASTEXITCODE
```

Classify the result:

| Observation | Response |
|---|---|
| A usable, supported PowerShell 7 is present | Prefer it for version-sensitive modern workflows when the task is compatible |
| `pwsh` resolves but cannot launch | Treat this as environment drift; inspect the resolved executable before proposing another install |
| Only Windows PowerShell 5.1 is usable | Continue on a 5.1-compatible path; conditionally recommend 7 when it materially reduces task risk |
| The installed PowerShell 7 may be out of support | Check the current official lifecycle; do not hard-code a support date |
| A required module or host supports only 5.1 | Keep that workload on 5.1 or stop for a compatibility decision |
| No usable PowerShell host exists | Stop PowerShell execution and offer official installation guidance |

PowerShell 7 uses `pwsh` and installs side-by-side with Windows PowerShell 5.1;
it does not replace `powershell.exe`. Some legacy modules still require 5.1.
Prefer a supported stable or LTS release, but verify the current lifecycle at
the time of use. If current lifecycle evidence is unavailable, report support
status as unknown instead of inferring it from the major/minor version.

When 7 is absent, recommend it only with a task-specific reason:

> Only Windows PowerShell 5.1 is currently usable. This task depends on
> PowerShell-version-sensitive text, native-command, or WSL behavior.
> PowerShell 7 can reduce those compatibility risks and installs side-by-side
> with 5.1. Would you like the official installation options?

Do not imply that PowerShell 7 makes nested quoting, incompatible modules, or
cross-shell transport automatically safe.

## Installation Is A Separate Authorized Action

Detection and recommendation are read-only. Before an installation:

1. Obtain explicit user authorization for the network download and host
   mutation.
2. Check Windows version, architecture, enterprise policy, administrator
   requirements, existing installation method, and whether `winget` is usable.
3. Re-open the current Microsoft installation guide because package formats,
   versions, and supported methods change.
4. On a supported Windows client, WinGet is the usual first option:

   ```powershell
   winget install --id Microsoft.PowerShell --source winget
   ```

5. On Windows Server or an enterprise-managed host, use the approved MSI,
   MSIX, ZIP, or managed deployment route from the current official guidance.
   Do not bootstrap WinGet or bypass organizational controls automatically.
6. Explain material installer choices such as scope, `PATH`, updates, remoting,
   profiles, and package sandbox limitations before accepting non-default
   behavior.
7. After installation, start a fresh process if necessary, resolve `pwsh`
   again, verify its edition/version/exit status, and rerun the original
   minimal reproduction.

Never silently install or update PowerShell, elevate, select a preview release,
change the default shell or terminal profile, remove Windows PowerShell 5.1, or
modify locale, execution policy, registry, or global code page.

## Cmdlet Or Native Executable

Establish which contract applies:

- A cmdlet writes PowerShell objects and PowerShell streams. Judge failures
  through its error contract, exceptions, and common parameters.
- A native executable receives process arguments and byte/text streams. Judge
  it through its documented stdout, stderr, and exit-code contract.
- `$?` is useful context, but capture `$LASTEXITCODE` immediately when the
  native program's numeric status matters.
- A native tool may write diagnostics or progress to stderr and still exit
  successfully. Text on stderr is not automatically failure.

For routine cmdlets, prefer named parameters and literal filesystem paths:

```powershell
Get-Content -LiteralPath $path -Encoding UTF8
```

## Native Errors And Preference Variables

Windows PowerShell 5.1 can surface text written by a native executable to
stderr as a `NativeCommandError` record. In some hosts or collection shapes,
`$ErrorActionPreference = 'Stop'` can then terminate the surrounding
PowerShell operation before the caller has classified the native result. The
error record is evidence about the PowerShell stream boundary; it does not
replace the executable's documented stdout, stderr, and numeric exit-code
contract.

PowerShell 7 behavior also depends on version and preferences. When available,
inspect `$PSNativeCommandUseErrorActionPreference` before assuming that a
nonzero native exit is or is not converted into a PowerShell error. Do not
change that preference globally as a diagnostic shortcut.

Use this order:

1. record the PowerShell edition, version, relevant preference values, and
   invocation shape;
2. reproduce with the smallest direct native invocation;
3. preserve stdout, stderr, and `$LASTEXITCODE` as separate evidence;
4. decide success from the native tool's documented contract; and
5. change preference handling only in the narrow owning scope when the task
   requires it.

Do not catch and discard a terminating error merely to force a green result.
If PowerShell prevents complete stream capture, use the native tool's
output-file options or an explicitly configured process API and keep the
original error as evidence.

## Preserve Native Arguments

Prefer one array item per argument:

```powershell
$exe = 'tool.exe'
$nativeArgs = @(
    '--input'
    $inputPath
    '--format'
    'json'
    '--empty'
    ''
)

& $exe @nativeArgs
$exitCode = $LASTEXITCODE
```

Omitted arguments, `''`, and `$null` are distinct. Do not pre-quote values that
are already separate array elements, concatenate untrusted strings into a
command, or repair quoting by adding `cmd.exe /c`, another `powershell
-Command`, or `Invoke-Expression`.

PowerShell 7.3 changed native argument passing. On Windows,
`$PSNativeCommandArgumentPassing` normally uses `Windows` mode, which falls
back to legacy behavior for `cmd.exe`, Windows Script Host, and common batch or
script extensions. When quotes or empty arguments arrive differently:

```powershell
$PSNativeCommandArgumentPassing
Trace-Command -Name ParameterBinding -Expression { & $exe @nativeArgs } -PSHost
```

Treat a 5.1-to-7 behavior change as a compatibility hypothesis, not immediate
proof that either the application or PowerShell is defective. Use the
Windows-only stop-parsing token `--%` only for a narrow native-command case
that cannot be expressed safely with normal argument arrays; it is not a
cross-platform or multi-line solution.

## Streams, Pipelines, And Redirection

- Capture stdout and stderr separately when their distinction matters.
- Save `$LASTEXITCODE` before another native command can overwrite it.
- A PowerShell pipeline normally carries objects; a native pipeline carries
  process streams. Do not assume POSIX stdin or byte behavior across a
  PowerShell cmdlet boundary.
- `pwsh -File` is usually clearer for multi-line automation. A `pwsh -Command`
  wrapper has its own exit semantics; preserve or explicitly `exit
  $LASTEXITCODE` when the wrapped native status must cross that boundary.
- PowerShell 7.4 and newer preserve native stdout bytes when redirecting them
  to a file or piping them to another native command. This guarantee does not
  apply after merging stderr into stdout with `2>&1`.
- For binary output, prefer the native tool's output-file option or a verified
  byte-safe route. Do not pass binary data through text cmdlets.
- If output is missing, truncated, reordered, or reformatted, remove
  formatting and filtering stages, use a minimal command, and capture streams
  independently before changing application code.

## Process APIs

Use the simplest structure-preserving mechanism:

1. a cmdlet with explicit parameters;
2. `& $exe @nativeArgs` for a foreground native process;
3. a `.ps1` or target-shell script for complex multi-line logic;
4. `ProcessStartInfo.ArgumentList` when separate process control, environment,
   or redirected streams are genuinely required;
5. `Start-Process` for an approved need such as elevation, a new window,
   detached execution, credentials, or shell association.

`Start-Process -ArgumentList` joins array elements into one command-line string.
It is not a structured argument API for complex quotes, empty strings, JSON, or
regular expressions. `ProcessStartInfo.ArgumentList` is available on the modern
.NET runtime used by PowerShell 7 and accepts arguments one at a time without
pre-escaping:

```powershell
$startInfo = [System.Diagnostics.ProcessStartInfo]::new()
$startInfo.FileName = $exe
$startInfo.UseShellExecute = $false

foreach ($argument in $nativeArgs) {
    [void]$startInfo.ArgumentList.Add($argument)
}
```

Set stdout/stderr redirection, asynchronous reading, environment, working
directory, wait behavior, and timeout deliberately. Validate untrusted input
even when the API preserves argument boundaries.

Windows PowerShell 5.1 runs on .NET Framework and does not provide
`ProcessStartInfo.ArgumentList`. Prefer direct `& $exe @nativeArgs` or a script
file there. If a separate 5.1 process is unavoidable, treat the string-based
`Arguments` property as a new quoting boundary and test it against the exact
target executable rather than presenting it as structured transport.

## Paths, Permissions, And Destructive State

- Use `-LiteralPath` unless wildcard expansion is intentional.
- Resolve ambiguous command names before destructive work. For example,
  `rd`/`rmdir` may name a PowerShell alias or a `cmd.exe` built-in depending on
  the parser. Use `Get-Command <name> -All` for PowerShell resolution and name
  the intended executable or cmdlet explicitly.
- Before recursive delete, move, or overwrite, reject empty, unresolved, root,
  home, or workspace-wide targets; resolve each target and prove it stays under
  the intended root.
- Keep enumeration and mutation in one PowerShell process. Preview a new
  destructive shape with a read-only listing or `-WhatIf` when supported.
- Do not enumerate paths in PowerShell and concatenate them into a
  `cmd.exe /c rd` or `rmdir` string. If a native or `cmd.exe` operation is
  genuinely required, treat it as a new parser boundary and revalidate every
  literal target in the owning shell.
- Treat success only with elevation as a permission boundary, not evidence for
  an application patch.
- A sandbox process-creation failure can occur before the requested command
  starts. Preserve the exact error and retry only the same narrow safe probe
  before requesting additional authority.
- Installing tools, changing profiles or policy, starting persistent
  processes, and modifying services, firewall, registry, networking, or WSL
  state require explicit authorization, verification, and a material rollback
  plan.

## Official Sources

- [Install PowerShell 7 on Windows](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows)
- [PowerShell support lifecycle](https://learn.microsoft.com/en-us/powershell/scripting/install/powershell-support-lifecycle)
- [Migrate from Windows PowerShell 5.1 to PowerShell 7](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/migrating-from-windows-powershell-51-to-powershell-7)
- [about_Parsing](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parsing)
- [about_Automatic_Variables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables)
- [about_Preference_Variables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables)
- [about_Redirection](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_redirection)
- [Start-Process](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process)
- [ProcessStartInfo.ArgumentList](https://learn.microsoft.com/en-us/dotnet/api/system.diagnostics.processstartinfo.argumentlist)
