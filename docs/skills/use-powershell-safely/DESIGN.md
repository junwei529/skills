# PowerShell Design

Last updated: 2026-07-31

## Purpose And Audience

PowerShell serves Windows users whose coding-agent tasks cross material shell,
native-process, text, permission, or WSL boundaries. It combines boundary
diagnosis with safe execution guidance while keeping routine cmdlets and
POSIX-only work out of scope.

It is not a general tutorial, incident-response platform, host inventory,
automatic installer, or replacement for project governance.

## Behavior Contract

The workflow:

1. probes PowerShell edition/version only when version behavior matters;
2. identifies every parser, process, stream, encoding, path, permission, and
   WSL boundary;
3. establishes one path base and normalizes uncertain result shape;
4. reproduces the smallest direct read-only command;
5. preserves native arguments, stdout, stderr, and exit status;
6. inspects bytes only when text identity matters;
7. classifies the failure before changing application code; and
8. stops before unauthorized installation, system mutation, elevation, or
   destructive work.

PowerShell 7 is preferred for compatible modern workflows when it materially
reduces risk; Windows PowerShell 5.1 remains necessary for some legacy modules
and hosts. Detection and recommendation are read-only. Installation and update
require separate authorization and current official guidance.

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
- Do not build nested command strings or use `Invoke-Expression` as a repair.
- Do not rewrite evidence before proving an encoding defect.
- Do not change global locale, code page, registry, profile, or policy as a
  default.
- Do not treat sandbox or permission failures as application defects.
- Do not recursively remove a Junction or unknown reparse point.
- Do not bundle an installer, host registry, generic adapter, or policy engine.

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
