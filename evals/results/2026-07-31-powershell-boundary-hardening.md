# PowerShell Boundary-Hardening Development Check

Date: 2026-07-31

## Evidence Boundary

This development check covers an uncommitted revision after repository
baseline `af4cdb243a66bad5b8f23bffff4cb48348b8a95c`. It changes only canonical
PowerShell SOURCE, its public case, one deterministic eval script, and mapped
repository documentation.

No discovery mapping, installed copy, candidate, tag, global rule, private
reference, user configuration, remote, or release was changed. The existing
tag-pinned `v0.1.1` installation therefore does not contain this revision.

The revision generalizes sanitized failure mechanisms rather than host values:

- zero/one/many command-discovery results and scalar string indexing;
- an LF-to-CRLF text bridge affecting a Unix-style consumer;
- relative paths resolved or joined against more than one base;
- sandbox process-creation, program-exit, and write-denial classification; and
- nonrecursive removal of a confirmed Junction while retaining its target.

## Revised Contract

- Frontmatter and the three-reference structure remain unchanged.
- The concise workflow now establishes one path base and normalizes uncertain
  result cardinality before indexing or executable selection.
- Native guidance uses `@(...)`, `Count`, `CommandType=Application`, and an
  explicit precedence or identity rule before selecting one executable.
- Relative paths resolve once; rooted or already-resolved paths are not joined
  again.
- Sandbox guidance separates process creation, program exit, and denied write
  targets, and permits only authorized task-specific temporary state.
- Text guidance treats cross-shell bridges as protocols with explicit
  encoding, BOM, newline, final-newline, and empty-line contracts.
- Junction removal remains a bounded fallback after exact literal-path,
  reparse-type, target-role, authorization, and recovery checks. Recursive and
  wildcard fallbacks are prohibited.

## Deterministic Runtime Checks

[`evals/check-powershell-boundaries.ps1`](../check-powershell-boundaries.ps1)
ran once under a PowerShell 7 process and once under Windows PowerShell 5.1.
Each run passed fifteen assertions and removed its task-specific temporary
root:

- two same-named synthetic `Application` candidates remained a two-item
  collection;
- a scalar executable path normalized to one item, while the control confirmed
  that direct string indexing selects one character;
- a UTF-8-without-BOM LF payload contained no carriage return and ended in
  `0A`;
- a CRLF control exposed the trailing `0D` that a line-oriented consumer can
  receive as data;
- a relative path resolved beneath one declared base, and resolving the
  resulting rooted path did not join it again; and
- a confirmed Junction was removed with
  `Directory.Delete(path, false)` while the retained target sentinel remained.

Controller inspection found no residual task-specific temporary root after
both runs. The check does not execute a live Bash or WSL consumer, inject an
actual sandbox denial, or establish behavior for symbolic links, mount points,
or unknown reparse types.

## Current SOURCE Identity

The five SOURCE files were decoded as strict UTF-8, normalized to LF with one
final newline, and hashed with SHA-256:

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

These hashes identify only the current uncommitted development SOURCE. They
are not a loaded-copy, candidate, stable-install, or release identity.

## Deterministic Repository Results

```text
python -B <skill-creator>/scripts/quick_validate.py skills/use-powershell-safely
  Skill is valid!

pwsh -NoProfile -File evals/check-powershell-boundaries.ps1
  15 PowerShell boundary checks passed.

powershell.exe -NoProfile -File evals/check-powershell-boundaries.ps1
  15 PowerShell boundary checks passed.

python -B scripts/check_repository.py
  Repository check passed: 146 text files, 11 cases, 10 fixtures.

pwsh -NoProfile -File evals/check-fixtures.ps1
  14 checks passed

PowerShell parser check across evals/**/*.ps1
  passed

git diff --check
  passed

gitleaks dir . --no-banner --redact --no-color --exit-code 1
  no leaks found
```

## Current SOURCE Behavior Gate

Three fresh read-only behavior contexts used the frozen canonical SOURCE
directly. Each context independently recomputed all five normalized SOURCE
hashes above. The runners loaded only the references material to their task:
native/process for discovery and path behavior, native/process plus
text/encoding for newline and permission behavior, and no WSL reference when
no Windows/WSL crossing existed.

Observed behavior covered:

- zero, one, and two executable candidates normalized with `@(...)`; zero
  stopped, one preserved the complete command object, and unresolved multiple
  candidates failed closed unless an explicit identity or bare-name
  precedence contract existed;
- a spaced input path, direct native argument arrays, separate stdout/stderr
  interpretation, immediate native exit capture, and one-base resolution that
  left an already rooted path unchanged;
- BOM-free UTF-8 CRLF and LF controls, final-newline and raw-hash differences,
  JSON semantic versus byte identity, and an English-only case that did not
  invent a CJK or legacy-locale diagnosis;
- a synthetic write-denial record classified as a sandbox/permission boundary
  after process creation, with only task-specific authorized cache or
  exact-target permission proposed and no broad elevation or system change;
- read-only inspection of a confirmed contained Junction, retained target, and
  sentinel, with authorization, same-process revalidation, nonrecursive
  fallback, and post-check requirements stated before any removal; and
- negative controls that left a routine version-independent cmdlet,
  POSIX-only work, and already-valid English bytes outside the Skill's material
  workflow.

The native scenario received one same-context follow-up to add direct
zero/one/many and resolve-once observations. It did not execute the synthetic
checker. No runner modified SOURCE, fixtures, Git, discovery, installation, or
configuration.

A separate fresh assessor read the current contract, complete SOURCE, raw
prompts and outputs, deterministic result, fixtures, and before/after
manifests without reading a controller conclusion. It independently matched
all five hashes, rated all eight Must surfaces `PASS`, found no current SOURCE
Must defect, and returned the single verdict `ACCEPTED`.

The repository-outside-run-root manifest and Git status had zero delta during
behavior and assessment. Raw prompts, outputs, manifests, and controller
observations were confined to one ignored task-owned run root; only this
sanitized summary is public evidence.

## Remaining Evidence

- Prove native selection and the actually loaded same-named development copy
  only in a separately authorized discovery environment.
- Repeat critical behavior against an exact-commit `RC_INSTALL` and a later
  stable installation before treating this revision as production-loaded.
- Run live Bash/WSL, actual sandbox-denial, and bounded shadow-use evidence
  only when separately authorized and materially required.
- Keep the private fallback until the revised installed copy completes bounded
  shadow use without a material missed trigger or safety regression.
