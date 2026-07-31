# PowerShell Verification

Last updated: 2026-07-31

## Claim Ledger

| Claim | Status |
|---|---|
| The current package has one entry and exactly three conditional references | verified structurally |
| Released portable guidance handles the recorded native, text, WSL, version, locale, sandbox, and destructive boundaries | seven fresh development scenarios pass |
| Ordinary cmdlet and POSIX-only work remain outside the Skill | catalog-assisted and controlled native negatives pass |
| Released DEV_DISCOVERY, exact-commit RC, and stable loaded-copy identity | verified |
| Current local hardening preserves cardinality, LF bytes, one-base paths, and confirmed-Junction link-only removal | fifteen assertions pass under PowerShell 7 and Windows PowerShell 5.1; current SOURCE behavior independently accepted |
| Current hardening native selection, loaded copy, RC, stable, live Bash/WSL, actual sandbox denial, or shadow use | unverified |
| General efficacy, token savings, or cross-Harness parity | unverified |

## Current Local SOURCE Identity

The five current SOURCE files were decoded as strict UTF-8, normalized to LF
with one final newline, and hashed with SHA-256:

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

These hashes identify the local SOURCE revision. Public `main`, candidate, and
stable identities remain separate.

## 2026-07-31 Boundary-Hardening Evidence

The authorized SOURCE-only revision generalized:

- zero/one/many executable discovery and scalar-string indexing;
- LF-to-CRLF bridge failures at Unix-style consumers;
- paths resolved or joined against more than one base;
- process-creation, program-exit, and write-denial classification; and
- nonrecursive confirmed-Junction removal that retains the target.

[`evals/check-powershell-boundaries.ps1`](../../../evals/check-powershell-boundaries.ps1)
passed fifteen assertions under both a PowerShell 7 process and Windows
PowerShell 5.1. It verified two synthetic application candidates, scalar
normalization, UTF-8 without BOM plus LF and final `0A`, a CRLF trailing-`0D`
control, one-base path resolution, and link-only Junction removal with a
retained sentinel. Both task-specific temporary roots were removed.

This check did not run a live Bash/WSL consumer, inject an actual sandbox
denial, or establish symbolic-link, mount-point, or unknown reparse behavior.
No fresh agent, discovery, installed copy, candidate, stable install, global
rule, private reference, tag, remote, or release changed. The full
[sanitized result](../../../evals/results/2026-07-31-powershell-boundary-hardening.md)
owns commands, hashes, limits, and the recorded 146-file/11-case/10-fixture
check result.

### Current SOURCE behavior and independent assessment

Three fresh read-only contexts used the five frozen canonical SOURCE hashes
directly and independently recomputed them. A same-context follow-up completed
the native runner's direct zero/one/many and resolve-once observations.

The behavior evidence covered:

- application-only discovery, explicit candidate identity, normalized
  cardinality, scalar-string avoidance, fail-closed ambiguity, a spaced path,
  direct argument arrays, streams, and immediate native exit capture;
- one-base path resolution that left an already rooted path unchanged;
- UTF-8 without BOM, CRLF versus LF, final newline, JSON/text semantics,
  raw-byte hashes, and no unsupported locale or CJK diagnosis;
- synthetic post-start cache write denial with task-specific remediation and
  no broad permission or system change;
- confirmed-Junction identity, containment, retained target/sentinel, explicit
  authorization, bounded nonrecursive fallback, and no actual removal; and
- routine-cmdlet, POSIX-only, and valid-English-byte negative controls.

A separate fresh assessor read the contract, complete SOURCE, raw tasks and
outputs, deterministic evidence, fixtures, and manifests without using a
controller conclusion. It independently matched all hashes, rated all eight
Must surfaces `PASS`, found no SOURCE Must defect, and returned `ACCEPTED`.
The outside-run-root manifest and Git status had zero delta during the runs.

This is SOURCE-assisted development behavior, not native selection,
`DEV_DISCOVERY`, loaded-copy, candidate, stable, live Bash/WSL, actual
sandbox-denial, shadow-use, commit, or release evidence. See the
[sanitized result](../../../evals/results/2026-07-31-powershell-boundary-hardening.md).

## Released Development Evidence

### 2026-07-30 — Portable-guidance migration

The revision later released as `v0.1.1` had these recorded raw identities:

```text
SKILL.md
  5bbdc428febfebede4144f98d25d7952a4dfe9e6bafc90711b32a22dc17fa70f
agents/openai.yaml
  87f47ad02d7a15ee309bfad896ea53eabfcff877ce51c7a8be149adc60b7bf68
references/native-process-boundaries.md
  476f735f012a12739ebe1193fe331f26f0b6120c8753ec0cb4c8a7327a5d643c
references/text-encoding-boundaries.md
  fef6a7eaab548e90752c3720021ee8c0e5dba532caab44b95ee915ead81a0af8
references/windows-wsl-boundaries.md
  5674d97ac52c6c8b05c8f57acae8ba5970afbdab3a1828ba62297038e450ffb7
```

Seven isolated scenarios passed Windows PowerShell 5.1 argument/UTF-8 and
`NativeCommandError` branches, PowerShell 7.3/7.4 native and redirection
branches, staged WSL identity/path/stream/exit diagnosis, legacy CJK versus
valid English bytes, a useful-but-gated PowerShell 7 recommendation, and
sandbox plus destructive stop boundaries. Two catalog-assisted negatives
declined an ordinary cmdlet and POSIX-only task without loading the body.

A separately authorized DEV_DISCOVERY junction resolved directly to SOURCE.
The positive native canary implicitly selected the Skill, loaded only the entry
and two relevant references, reproduced direct exit `0`, broken-wrapper exit
`1`, and split-argument exit `2`, and classified parser transport rather than
JSON corruption. The ordinary `Get-Date` canary did not load the Skill body.
This was development identity only. The
[portable-guidance result](../../../evals/results/2026-07-30-powershell-portable-guidance-migration.md)
preserves the full scenario and limitation record.

### 2026-07-28 — Earlier revision

Four fresh behavior contexts produced three passes and one partial WSL result;
the partial answer did not preserve the unknown PowerShell minor/native mode or
separately isolate WSL user, cwd, stdout, and stderr. A POSIX-only canary
declined the Skill. This is historical evidence for older SOURCE, not current
acceptance. See the
[historical result](../../../evals/results/2026-07-28-powershell-forward-tests.md).

## Candidate And Stable Evidence

At public exact commit
`b0099c9d5ad986be5e893ceea13f1fc8b5aea384`, a first test-home attempt was
invalid because a development copy remained discoverable and was actually
loaded. It is excluded from RC evidence.

The corrected repository-scoped `RC_INSTALL` exposed only one ordinary
five-file candidate. All files matched Git blobs and the released hashes,
decoded as strict UTF-8 without BOM, and were not reparse points. The positive
canary implicitly loaded only the entry plus native/process and text/encoding
references and diagnosed the parser/argument boundary; `Get-Date` did not load
the Skill. Controller runs reproduced exits `0`, `1`, and `2` with separated
streams.

The shared candidate
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09` repeated the same identity and
positive/negative behavior with Project Docs and Work Charter in one isolated
scope. Failed preflights involving discovery isolation, prompt transport, or
semantic completion were excluded.

The coherent `v0.1.1` candidate
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42` repeated exact-commit proof.
Immutable tag `v0.1.1` resolved to that commit, and the tag-pinned stable entry
was actually loaded in a fresh read-only process and preserved the requirement
to capture `$LASTEXITCODE` immediately. The current local hardening has
none of this loaded-copy evidence.

Repository-level shared candidate, tag, installation, and release evidence is
owned by [root Verification](../../VERIFICATION.md).

## Required Checks

For any current PowerShell change:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/use-powershell-safely
pwsh -NoProfile -File evals/check-powershell-boundaries.ps1
powershell.exe -NoProfile -File evals/check-powershell-boundaries.ps1
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
PowerShell parser check across evals/**/*.ps1
git diff --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

SOURCE, DEV_DISCOVERY, RC_INSTALL, and STABLE_INSTALL identity and behavior
must be attributed separately.
