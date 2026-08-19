# PowerShell Design

Last updated: 2026-08-19

## Purpose And Audience

PowerShell serves Windows users whose coding-agent tasks cross material shell,
native-process, text, permission, or WSL boundaries. It combines pre-execution
readiness, boundary diagnosis, and safe execution guidance while keeping
routine cmdlets and POSIX-only work out of scope.

It is not a general tutorial, incident-response platform, host inventory,
automatic installer, or replacement for project governance.

## Behavior Contract

The Skill is eligible before the first relevant command when the request
explicitly requires non-trivial PowerShell: a `.ps1` file, `pwsh` or
`powershell.exe`, multiline logic, loops, `try`/`catch`, regex, complex
pipelines, or material parser-, version-, argument-, stream-, encoding-, path-,
permission-, destructive-filesystem-, process-, or WSL-sensitive behavior.
Destructive PowerShell filesystem work remains eligible even when the broader
task could otherwise be described as general Windows work. Selection is not
contingent on a prior error. Ordinary version-independent cmdlets, simple documented
native commands with no material boundary or symptom, general Windows work,
and POSIX-only work remain negative selections.

The workflow:

1. moves complex PowerShell into a `.ps1` file when practical, or performs a
   parse-only validation in the exact target PowerShell executable/version
   before an unavoidable inline invocation;
2. probes PowerShell edition/version only when version behavior matters;
3. identifies every parser, process, stream, encoding, path, permission, and
   WSL boundary;
4. establishes one path base and normalizes uncertain result shape;
5. checks a cmdlet or script's actual parameter contract before using a common
   parameter shape, including the fact that `New-Item` supports `-Path` but
   not `-LiteralPath`;
6. treats cmdlet error semantics separately from native process exit status,
   uses narrow fail-fast handling for critical cmdlet steps, and verifies the
   expected artifact or state rather than trusting an outer zero exit alone;
7. preserves native arguments, stdout, stderr, and exit status;
8. inspects bytes only when text identity matters;
9. classifies the failure before changing application code; and
10. stops before unauthorized installation, system mutation, elevation, or
   destructive work.

Parser readiness explicitly covers variable-name boundaries such as
`${name}:`, literal regex text containing `$env:` or `$script:`, the automatic
`$Matches` variable, and statement-form `foreach` output that must be collected
before entering a pipeline. These are bounded high-value traps, not a general
PowerShell style guide.

PowerShell 7 is preferred for compatible modern workflows when it materially
reduces risk; Windows PowerShell 5.1 remains necessary for some legacy modules
and hosts. A resolved executable is only a resolution fact. Readiness requires
the exact selected `ApplicationInfo.Path` to launch, return typed native exit
zero, and emit one normalized, well-formed version value; launch failure,
nonzero exit, empty output, or malformed output are separate failed or
`UNKNOWN` conditions, never usable-runtime proof.

WSL discovery likewise normalizes only `ApplicationInfo` candidates, handles
zero/one/many explicitly, executes the exact selected path, and captures the
typed native exit immediately. These are synthetic readiness contracts; live
WSL is not required for SOURCE acceptance. Detection and recommendation are
read-only. Installation and update require separate authorization and current
official guidance.

## Progressive Disclosure

| Source | Load condition |
|---|---|
| [`SKILL.md`](../../../skills/use-powershell-safely/SKILL.md) | Skill is selected; owns core diagnosis, routing, and authorization |
| [`native-process-boundaries.md`](../../../skills/use-powershell-safely/references/native-process-boundaries.md) | Runtime, executable identity, arguments, streams, process APIs, permissions, destructive operations, or installation is material |
| [`text-encoding-boundaries.md`](../../../skills/use-powershell-safely/references/text-encoding-boundaries.md) | Bytes, encoding, BOM, newline, JSON/schema, hashes, native text, or legacy locale is material |
| [`windows-wsl-boundaries.md`](../../../skills/use-powershell-safely/references/windows-wsl-boundaries.md) | Execution, paths, streams, files, permissions, or state crosses Windows and WSL |
| [`openai.yaml`](../../../skills/use-powershell-safely/agents/openai.yaml) | Public metadata and default prompt |
| [PowerShell eval case](../../../evals/cases/powershell-boundary.md) | Positive, negative, stop, and version-boundary contract |

Exactly three conditional references are sufficient for v0.1. UTF-8
correctness is general; legacy locale and CJK are conditional exposures rather
than a separate correctness model.

## Public And Private Boundary

| Category | Owner |
|---|---|
| Documented or reproduced portable rule | Public PowerShell Skill |
| Corroborated one-host mechanism | Bounded conditional diagnosis in the Skill |
| Exact path, version, account, environment, distribution, package, sandbox, or current host state | Private host guidance |
| Pre-selection routing and hard authorization invariants | Minimal global bootstrap |

The public repository never copies private global files. Normal migration
retains a recoverable private fallback until SOURCE, selection, RC, stable, and
bounded shadow evidence support retirement.

## Safety And Non-Goals

- Do not infer native success from stderr text or output truthiness.
- Do not infer cmdlet success from an outer process exit alone or use
  `$LASTEXITCODE` as a cmdlet-failure contract.
- Do not assume every filesystem cmdlet supports `-LiteralPath`; inspect its
  parameter set when uncertain.
- Do not execute complex inline PowerShell without parse-only readiness, or
  repair it by adding another shell or quoting layer.
- Do not build nested command strings or use `Invoke-Expression` as a repair.
- Do not rewrite evidence before proving an encoding defect.
- Do not change global locale, code page, registry, profile, or policy as a
  default.
- Do not treat sandbox or permission failures as application defects.
- Do not recursively remove a Junction or unknown reparse point.
- Do not bundle an installer, host registry, generic adapter, or policy engine.
- Do not claim Harness pre-error selection efficacy from metadata, cases, or
  deterministic checks; that remains a separate model evidence gate.

## Independent-Skill Boundary

PowerShell may be selected inside work governed by Work Charter, but it does
not inherit that Charter's authority or manage its roles. It does not own
project-document semantics. Composition is optional and authorization does not
propagate.

## Accepted Basis

- [Decision 0002](../../decisions/0002-powershell-scope-and-runtime-readiness.md)
- [Decision 0007](../../decisions/0007-independent-skills-and-optional-recipes.md)
- [Decision 0014](../../decisions/0014-powershell-portable-guidance-and-private-host-delta.md)
- [Decision 0015](../../decisions/0015-federated-repository-documentation.md)
- User Authority Revision P1 (2026-08-15), approving the bounded
  `PRE_ERROR_SELECTION_AND_COMMAND_READINESS` residual.
