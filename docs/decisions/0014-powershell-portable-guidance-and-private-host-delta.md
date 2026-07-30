# 0014: PowerShell Portable Guidance And Private Host Delta

Date: 2026-07-30
Status: accepted

## Context

The intended end state is for `use-powershell-safely` to replace the reusable
Windows, PowerShell, native-process, text, and WSL procedures that were
previously embedded in private global guidance. That private source also
contains current-machine facts such as exact installations, paths,
environment values, accounts, distributions, package provenance, and sandbox
observations. Publishing those facts would be unsafe and would make the Skill
less portable.

The Skill also cannot replace the instruction needed to select it before it is
loaded. Migration therefore needs an explicit boundary between reusable
product guidance, bounded inference from observed failures, and private host
state.

## Decision

### Public Rule Classification

Classify every candidate rule before moving it into public source:

1. **Portable rule** — a documented platform contract or behavior reproduced
   across the versions or interfaces to which the rule applies. Rewrite it
   concisely with its version and prerequisite boundaries.
2. **Bounded inference** — a mechanism suggested by one or more concrete host
   failures and corroborated by an interface contract, version behavior, or a
   reproducible minimal case. Publish only the diagnostic question and
   conditional safe response; retain uncertainty and do not present the
   original observation as universal.
3. **Private host delta** — an exact path, installed version, package source,
   account, environment-variable value, `PATH` order, distribution, registry
   or WSL registration state, sandbox identity, tool route, or current host
   result. Keep it outside the public repository and revalidate it before use.

Do not copy private global files verbatim. Public evidence may state that a
host-specific category was reviewed, but it must not reproduce the private
value.

### Ownership After Migration

- `use-powershell-safely` owns reusable diagnosis and safe-execution guidance.
- A minimal private global bootstrap may retain high-signal routing to the
  Skill, authorization and destructive-operation invariants that apply before
  Skill selection, and a fallback when the Skill is unavailable.
- A private host reference may retain current-machine facts and local recovery
  routes. It must not remain a second canonical owner for portable procedures
  after migration acceptance.

### Migration Evidence

Retire duplicated private procedures only after:

1. the revised canonical `SOURCE` passes structural and publication checks;
2. positive and negative behavior cases pass against the intended development
   source;
3. native selection and the actually loaded same-named copy are proved in an
   authorized discovery environment;
4. an exact-commit candidate and stable installation repeat the critical
   boundary checks; and
5. a bounded shadow period shows no material missed trigger or safety
   regression.

Until then, the private reference may remain as a rollback fallback. Editing
the Skill source, changing discovery, installing a copy, publishing a release,
and changing private global guidance remain separate authorization surfaces.

## Consequences

- The public Skill can absorb broadly useful lessons without leaking or
  ossifying one machine's configuration.
- Exact host state remains available where it is operationally useful but is
  not confused with a product guarantee.
- Some short pre-trigger safety and routing rules remain global by design; the
  goal is one owner for portable procedures, not a zero-line global file.
- Evidence must distinguish documented behavior, bounded inference, and
  current host observations.

## Re-evaluation Conditions

Revisit this decision if the Harness provides a guaranteed pre-selection
policy layer that can replace the minimal bootstrap, or if repeated real use
shows that a host fact is actually a stable public interface with broader
evidence.

## Related Documents

- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Provenance](../PROVENANCE.md)
- [Runbook](../RUNBOOK.md)
- [PowerShell scope decision](0002-powershell-scope-and-runtime-readiness.md)
- [Source and installation decision](0003-source-install-release-boundaries.md)
