# PowerShell Hardening Exact-Commit RC Gate

Date: 2026-07-31

## Evidence Boundary

This gate tested `use-powershell-safely` from public exact commit
`58fc52600df0e1dc3abd92ba31f031ee2b07db82`. That exact public commit was the
sole candidate source.

The supported `$skill-installer` helper downloaded only
`skills/use-powershell-safely` from the public commit into one task-owned,
ignored, repository-scoped discovery root. The resulting `RC_INSTALL` did not
resolve to editable SOURCE. The existing `v0.1.1` stable installation was
hashed before and after the gate and remained unchanged.

No SOURCE, stable installation, persistent discovery mapping, user
configuration, private global guidance, profile, policy, locale, registry,
WSL state, remote, tag, or release was changed. Raw prompts, events, process
logs, and manifests remained outside tracked source.

## Candidate Identity

The RC contained exactly these five files:

```text
SKILL.md
agents/openai.yaml
references/native-process-boundaries.md
references/text-encoding-boundaries.md
references/windows-wsl-boundaries.md
```

For every file, the installed Git blob and raw SHA-256 matched the selected
public commit. Strict UTF-8 decoding, no BOM, LF-only text, one final newline,
normalized SHA-256, and zero reparse points also passed. The bundled
`skill-creator` validator returned `Skill is valid!`.

The normalized identities remained:

```text
SKILL.md
  ec8c561d8ce1d34fa45c09fb13f28d7e699ff0512dc93dc3d2f866279dbf7dd2
agents/openai.yaml
  87f47ad02d7a15ee309bfad896ea53eabfcff877ce51c7a8be149adc60b7bf68
references/native-process-boundaries.md
  9b6e264b43e08df510a2bb8388cd2bcb35c22985a4c5b3b6fe260f441f07a45b
references/text-encoding-boundaries.md
  ca1fb4c3caea1c045ab06ebd348a9cfd39863e86faf12e4a7a2548f172a69f96
references/windows-wsl-boundaries.md
  5674d97ac52c6c8b05c8f57acae8ba5970afbdab3a1828ba62297038e450ffb7
```

## Fresh Loaded-Copy Canaries

The current Codex CLI documented per-path `skills.config` overrides were used
only inside fresh processes to disable the older stable entry. User
configuration was ignored and not edited. The repository scope then exposed
one same-named Skill: the exact-commit RC under the logical locator
`.agents/skills/use-powershell-safely`.

The positive read-only task implicitly selected the RC and loaded:

- `SKILL.md`;
- `references/native-process-boundaries.md`; and
- `references/text-encoding-boundaries.md`.

It did not load the WSL reference, the disabled stable entry, or the private
host fallback. It correctly classified the fixture as a nested
`pwsh -Command` argument-transport failure rather than JSON corruption,
preserved a spaced path as one argument, captured `$LASTEXITCODE`, and stated
that blocked command launches were policy evidence rather than program
results.

The ordinary `Get-Date -Format o` negative task returned the cmdlet directly
and reported that it loaded no Skill file.

One isolated-home preflight failed authentication before any model response,
and one synchronous launcher exceeded its controller transport window without
a durable final response. Both attempts are excluded from behavior evidence.

## Independent Assessment

A separate fresh assessor read the contract, RC files, manifests, raw tasks,
events, process records, and finals without using a controller verdict. It
accepted exact-commit identity, process-local candidate-only selection, the
loaded logical paths, the parser diagnosis, immediate native exit capture,
and the ordinary-cmdlet non-trigger.

It found a Must behavior defect in the positive response:

- the user-visible safe example selected
  `Get-Command python ... .Path` without `-All`, `@(...)`, a cardinality check,
  or a zero/one/many fail-closed rule; and
- the example did not actually separate stdout and stderr.

The response also used the combined label `sandbox/policy blocker`; the
evidence proved only that tool policy rejected process launch, not an actual
sandbox-denial mechanism.

The assessor could not independently rerun file hashes because the read-only
tool policy rejected its shell probes. Controller hash and before/after
manifests therefore remain the identity and stable-immutability proof; the
assessor did not promote those checks to a second independent runtime
measurement.

Final independent verdict:

```text
CORRECTION_REQUIRED
```

## Claim And Stop Boundary

This gate verifies:

- public exact-commit RC materialization;
- five-file byte and package identity;
- one candidate-only selectable same-named Skill in the process-local test
  scope;
- current RC implicit positive selection and actual loaded logical files; and
- an ordinary-cmdlet native negative.

It does not establish accepted RC behavior for the hardening revision.
Stable update, tag, release, private-global retirement, bounded shadow use,
live Bash/WSL, actual sandbox denial, broad trigger accuracy, general
efficacy, token savings, and cross-Harness parity remain unverified.

The next gate requires separate SOURCE-correction authority and a new commit
identity. Repeating the same prompt with the expected answer disclosed would
not correct this failed forward test.
