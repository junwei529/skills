# 0002: PowerShell Scope And Runtime Readiness

Date: 2026-07-28
Status: accepted

## Context

The original `use-powershell-safely` combined all detail in one reference and
had behavior evidence for one spaced-path argument failure. An independent
product review found that the public Skill needed a clearer purpose, narrower
triggering, explicit PowerShell-version boundaries, conditional text/locale
guidance, broader WSL and process coverage, and a forward-test matrix.

PowerShell 7 generally provides a better default for modern UTF-8,
native-command, and WSL workflows, but it does not replace Windows PowerShell
5.1 or guarantee compatibility with legacy modules and scripts. The user also
requested environment detection and a recommendation when PowerShell 7 is
absent.

## Options Considered

1. Keep a single broad reference and treat PowerShell 5.1 as the universal
   baseline.
2. Keep one independently installable PowerShell Skill, split detail into
   conditional native/process, text/encoding, and WSL references, and add a
   read-only runtime-readiness and recommendation branch.
3. Add a bundled installer that automatically installs or updates PowerShell 7.

## Decision

- Keep `use-powershell-safely` as one standalone Skill.
- Define it as the minimum combination of Windows/PowerShell boundary diagnosis
  and safe execution guidance, not a general tutorial or a universal incident
  response system.
- Keep the core workflow concise and directly link exactly three conditional
  references: native/process, text/encoding, and Windows/WSL.
- Treat UTF-8/BOM/newline/hash correctness as general text correctness. Keep
  legacy locale, CJK, and other non-ASCII cases as a conditional subsection
  loaded only when evidence points to that boundary.
- Probe runtime readiness only when PowerShell version behavior is material.
- Prefer a supported PowerShell 7 release for compatible modern workflows,
  while preserving Windows PowerShell 5.1 for required legacy modules or hosts.
- If no usable PowerShell 7 exists, explain the task-specific benefit, state
  that 7 installs side-by-side with 5.1, and ask whether the user wants current
  official installation guidance.
- Keep detection and recommendation read-only. Installation, update, elevation,
  downloads, profile or policy changes, and system mutation require separate
  explicit authorization.
- Do not bundle an automatic installer in v0.1.
- Do not trigger for ordinary version-independent cmdlets without a boundary
  symptom or for POSIX-only work.

## Consequences

- Most PowerShell tasks load only the core and the one or two relevant
  references.
- Version-dependent claims must stay qualified and point to current official
  Microsoft documentation.
- A PowerShell 7 recommendation cannot be presented as proof that a task will
  work or that Windows PowerShell 5.1 is obsolete.
- The existing PowerShell forward test remains historical evidence for the
  earlier argument-boundary branch; the revised Skill requires new
  fresh-context evidence before release.
- A real assisted installer can be reconsidered only if repeated user demand
  justifies the added package, platform, policy, architecture, integrity,
  rollback, and maintenance surface.

## Related Documents

- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [PowerShell evaluation case](../../evals/cases/powershell-boundary.md)
