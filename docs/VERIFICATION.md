# Repository Verification

Last updated: 2026-08-01

## Scope

This ledger owns repository checks, coherent multi-Skill candidates, public
repository and tag identity, stable installation, release evidence, and shared
claim boundaries. Skill-specific SOURCE, forward-test, DEV_DISCOVERY, RC, and
stable behavior ledgers are:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

Sanitized detailed runs remain under [`evals/results`](../evals/results/README.md).

## Required Repository Checks

| Check | Purpose | Current result |
|---|---|---|
| Three Skill validators | Validate frontmatter and package names without changing packages | pass for current Project Docs, Work Charter, and PowerShell SOURCE after the Work Charter authority/evidence hardening |
| Repository checker | Validate strict UTF-8/no BOM, whitespace, local links/fragments, publication safety, exact Skill/eval sets, federated docs, and bilingual navigation | pass: 177 text files / 12 cases / 11 fixtures |
| Fixture checker | Validate eleven synthetic starting states and their Git/reparse/ignored-result boundaries | 15 checks pass |
| PowerShell deterministic hardening | Validate cardinality, LF bytes, one-base paths, and Junction link-only removal | 15 assertions pass in PowerShell 7 and Windows PowerShell 5.1 |
| PowerShell parser sweep | Parse all `evals/**/*.ps1` files | 6 files parse |
| Markdown navigation and ownership | Verify local links/fragments, English/Chinese routes, expected per-Skill owners, and no orphan canonical owner | pass through repository checker |
| `git diff --check` and cached diff check | Reject whitespace defects in unstaged or staged candidates | both pass; the cached check makes no empty-index claim |
| Gitleaks | Detect secret-like content independently | pass; no leaks |

## Repository Claim Ledger

| Claim | Status |
|---|---|
| Three independent public Skill packages exist | verified; Project Docs 6 files, Work Charter 5 files, PowerShell 5 files |
| The superseded `manage-large-tasks` package is retired | verified; no alias or second discovery entry |
| Federated repository documentation has one root and one per-Skill owner for each fact class | verified in the current working tree by the repository checker, including expected owners and no orphan canonical owner |
| English-canonical public entries have Simplified Chinese mirrors | verified for the root and all three per-Skill pairs, including reciprocal navigation and corresponding section counts |
| Public source, development discovery, candidate, and stable roles are distinct | accepted and operationally verified |
| Public standalone distribution works | verified for `junwei529/skills`, exact-SHA RC, immutable `v0.1.1`, and per-Skill `$skill-installer` paths |
| One coherent multi-Skill candidate was loaded | verified at `78caaa6...` and repeated at `f7c07b5...` |
| Tag-pinned stable loaded-copy identity works for all three Skills | verified for immutable `v0.1.1` |
| `v0.1.0` is the coherent public release | false; retained as immutable installation evidence only |
| `v0.1.1` is the coherent tag-based standalone release | verified |
| A GitHub Release object exists | no |
| The repository improves correctness, saves tokens, works across Harnesses, or passed SHICE | unverified |

## Candidate And Release Evidence Template

Use this record for a material development run, release candidate, stable
install, or release. Public evidence uses logical locators rather than private
absolute paths.

```text
Evidence level: DEV | RC | STABLE_INSTALL | RELEASE
Skill or package:
Source branch or checkout:
Commit state: unborn | <SHA>
Working tree clean: yes | no
Canonical source locator:
Actually loaded copy role: DEV_DISCOVERY | RC_INSTALL | STABLE_INSTALL
Actually loaded logical locator or resolved-source proof:
Distribution form and package version:
Installer or package source ref/SHA:
Structural validation:
Repository and fixture checks:
Fresh-context behavior tests:
Installed-copy smoke:
Stable tag-to-commit verification:
Known gaps:
```

The [Runbook](RUNBOOK.md) owns procedure. This section alone owns the shared
field schema.

## Shared Candidate And Release History

### 2026-07-31 — Hardening and federated-document commit gate

The complete 38-path local candidate integrated the accepted federated
documentation migration with the PowerShell boundary hardening and its mapped
evidence. Native review covered staged, unstaged, and untracked changes. An
initial completed review found two P2 current-state contradictions: completed
documentation checks were still marked pending, and a completed writer
handoff remained listed as a next action. Both were corrected, the equivalent
per-Skill writer-state wording was synchronized, and the full candidate was
re-reviewed clean. A later state synchronization incorrectly described the
not-yet-created local commit and exposed a stale PowerShell roadmap row; a
third completed review identified both as P2. The candidate was restored to
truthful pre-commit state, the roadmap was updated with the accepted
fresh-context evidence, and final re-review had no open finding.

The final commit-gate checks repeat all three Skill validators, the
repository checker, fixture checker, PowerShell 7 and Windows PowerShell 5.1
boundary checks, parser sweep, Git whitespace checks, and Gitleaks. This is
local commit-gate evidence only. It does not prove current native selection,
loaded-copy identity, RC or stable installation, live Bash/WSL, actual sandbox
denial, shadow use, push, tag, or release.

The reviewed correction became local commit
`a150a8652111ad7a04b4b8a048e861ee5c91fc93`. Its writer relinquished and the
index/worktree were clean immediately after commit. Public `main` remains at
`58fc52600df0e1dc3abd92ba31f031ee2b07db82`; the local commit has no corrected
loaded-copy, RC, stable, push, tag, or release proof.

### 2026-07-31 — Federated repository-document migration

The user explicitly invoked Project Docs and authorized a structural migration
from root-concentrated documentation to the accepted federated ownership in
Decision 0015. The migration created five repository-document owners for each
Skill, retained English-canonical plus Simplified Chinese public entries,
reduced root files to shared fact classes, and added minimum deterministic
shape, bilingual-navigation, and no-orphan checks.

The inherited PowerShell implementation writer had relinquished. The migration
preserved the current uncommitted PowerShell SOURCE identities:

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

Final deterministic results:

```text
three bundled Skill validators
  pass
python -B scripts/check_repository.py
  Repository check passed: 162 text files, 11 cases, 10 fixtures.
pwsh -NoProfile -File evals/check-fixtures.ps1
  14 checks passed
pwsh -NoProfile -File evals/check-powershell-boundaries.ps1
  15 PowerShell boundary checks passed.
powershell.exe -NoProfile -File evals/check-powershell-boundaries.ps1
  15 PowerShell boundary checks passed.
PowerShell parser sweep across evals/**/*.ps1
  6 files parsed
git diff --check
  passed
git diff --cached --check
  passed; inherited index empty
gitleaks dir . --no-banner --redact --no-color --exit-code 1
  no leaks found
```

This is documentation-structure and deterministic repository evidence. It is
not a PowerShell fresh-context or independent assessment, loaded-copy,
candidate, stable update, commit, or release result. No file was staged, no
derived installation was edited, and no discovery, user configuration,
private-global, remote, tag, or release state changed.

### 2026-07-31 — Immutable `v0.1.1` tag and stable installed-copy proof

Reviewed bilingual candidate
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42` became immutable public tag
`v0.1.1`. Local and public refs matched; `v0.1.0` remained unmoved at
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`.

One complete-set `$skill-installer` request materialized all three Skills from
the public tag in a non-discoverable staging root. Controller checks proved:

- exact 6/5/5 file sets and raw tag-blob equality;
- strict UTF-8 without BOM, zero reparse points, and three passing validators;
- both reciprocal root README language entries; and
- unchanged candidate entry hashes:
  `0211FC4A93F1D3FB35D15ABE502F0ECAE26D25274E742D558DD189D82D7F5A06`,
  `CE6D65DCCEE281558154FEBFA18E8D1DBA83780D52CB1043BCB402AE60403D34`,
  and
  `5BBDC428FEBFEBEDE4144F98D25D7952A4DFE9E6BAFC90711B32A22DC17FA70F`.

The recoverable switch moved the prior complete set to a new non-discoverable
backup and activated the verified tag-derived directories. Its first reporting
expression failed after the moves because of a PowerShell array-shape defect;
the switch was not rerun. Immediate reconciliation and an independent audit
proved three complete active directories, three complete backups, no remaining
staging Skill directory, exact tag blobs, encoding, reparse, and validator
results.

A synthetic scope exposed exactly one known same-named stable entry per Skill.
Three fresh read-only Codex processes loaded:

- Project Docs entry plus audit reference and returned `NOOP`;
- Work Charter entry and kept a small task Flat; and
- PowerShell entry plus native/text references and preserved immediate
  `$LASTEXITCODE` capture.

Fixtures and active manifests remained unchanged. No persistent configuration,
SOURCE, tag, profile, policy, locale, registry, or system setting changed.
Prior installed and RC material remains retained; no cleanup or GitHub Release
object was created.

```text
Evidence level: STABLE_INSTALL
Skill or package: manage-project-docs; work-charter; use-powershell-safely
Commit state: f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42
Working tree clean: yes before evidence synchronization
Actually loaded copy role: tag-pinned STABLE_INSTALL
Distribution form and package version: standalone GitHub Skills, v0.1.1
Installer source: public junwei529/skills at v0.1.1
Structural validation: pass; 6/5/5 exact tag files; strict UTF-8/no BOM; no reparse points
Fresh-context behavior: three narrow explicit read-only canaries pass
Known gaps: no GitHub Release; no cleanup; broad trigger, real-project, efficacy, token, or cross-Harness proof
```

The final sanitized stable record was committed and pushed as
`af4cdb243a66bad5b8f23bffff4cb48348b8a95c`.

### 2026-07-31 — `v0.1.1` exact-commit RC

Before tag creation, one `$skill-installer` request materialized all three
Skills by exact public SHA
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42` in a new ignored RC root.
Controllers proved exact 6/5/5 files, Git-blob equality, strict UTF-8/no BOM,
ordinary directories, three validators, candidate and fixture immutability,
and the same entry hashes listed above.

Three candidate-only read-only processes loaded the intended entries:
PowerShell diagnosed a spaced-path nested-command-string boundary; Project
Docs returned mature-layout `NOOP`; Work Charter kept a small recovery check
Flat. Two PowerShell launches failed before Codex execution because of wrapper
argument conflict and Windows application redirection. They were excluded from
behavior evidence. Local and remote `v0.1.1` tags were absent at the RC audit,
so no tag or stable claim was made at that gate.

### 2026-07-31 — Bilingual patch-candidate preparation

The user authorized a patch candidate correcting the immutable `v0.1.0`
README contradiction and adding a complete Simplified Chinese root README.
English and Chinese entries had ten corresponding sections, reciprocal links,
the same independent-Skill boundaries, and the same proposed `v0.1.1`
interfaces without claiming the tag already existed.

All Skill validators, repository and fixture checks, navigation checks,
whitespace, and Gitleaks passed before commit. This was documentation-only DEV
evidence, not RC, tag, stable, or release proof.

### 2026-07-31 — Immutable `v0.1.0` tag and stable smoke

Public tag `v0.1.0` was created at exact shared candidate
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`. Local and public refs matched,
and public `main` could move independently to later evidence commits. GitHub
release-by-tag returned `404`.

One complete-set tag install proved exact 6/5/5 files, tag-blob equality,
strict UTF-8/no BOM, ordinary directories, and three validators. A recoverable
switch moved one Project Docs development junction and a prior byte-equivalent
PowerShell directory into a non-discoverable rollback area, then activated the
three tag-derived directories. Exactly one known same-named user entry per
Skill remained. Three explicit read-only processes loaded each entry and
returned Project Docs `NOOP`, Work Charter Flat, and the PowerShell
`$LASTEXITCODE` rule.

Later native review found the immutable tag snapshot's README still said the
tag did not exist and exposed non-executable installer prompts. This does not
invalidate observed tag-to-install identity, but it prevents `v0.1.0` from
being the coherent public release. The tag remains immutable historical
evidence; `v0.1.1` is the corrected identity.

### 2026-07-30 — Shared exact-commit candidate

Public and local candidate
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09` contained the accepted SOURCE for
all three Skills. The current dirty checkout was not candidate input.

One exact-SHA multi-Skill installer request materialized Project Docs and
PowerShell in an ignored isolated discovery root; a retained Work Charter
candidate already used the same commit. Controllers proved:

- 6/5/5 expected files and SOURCE-to-commit-to-candidate equality;
- strict UTF-8/no BOM and ordinary non-reparse directories;
- one same-named Skill per candidate directory;
- an exact 27-file shared native scope;
- fixture provenance and candidate immutability; and
- no tracked or persistent discovery/configuration change.

PowerShell passed implicit native-boundary selection, relevant-reference
loading, ordinary-cmdlet non-loading, and controller exits `0`, `1`, and `2`.
Project Docs passed explicit standalone `NOOP`, a focused test, and ordinary
routing non-loading. The earlier same-commit Work Charter RC passed implicit
recovery selection and flat non-loading.

Preflights that failed candidate-only discovery, complete prompt transport,
standalone isolation, or semantic completion were excluded. Uncontrolled
Harness and tool-policy overhead prevents any cost claim.

### 2026-07-30 — Historical PowerShell-only RC

Exact public commit
`b0099c9d5ad986be5e893ceea13f1fc8b5aea384` passed the first isolated
PowerShell candidate gate. A test-home attempt was rejected because a
development entry remained discoverable and SOURCE loaded instead; no result
from that attempt counts as RC evidence.

The corrected repository-scoped candidate was an ordinary five-file directory,
the only same-named Skill in scope, strict UTF-8/no BOM, and exact Git-blob
identity. Its positive implicit canary loaded only the entry and native/text
references, diagnosed parser/argument transport, and controller runs reproduced
exits `0`, `1`, and `2`. `Get-Date` did not load the Skill.

This gate established PowerShell-only RC identity at that date, not the later
shared candidate or release.

## Public Repository And Governance History

### 2026-07-30 — Public repository and first push

An empty public
[`junwei529/skills`](https://github.com/junwei529/skills) repository was
created without generated initialization. Reviewed source
`c5d8e185ea9a9f32a4e98ac8ac364c4ebe915535` was pushed to public `main`.
Independent Git ref and GitHub API checks resolved the public branch and commit
to that SHA. No install, candidate, tag, stable, or release action was implied.

### 2026-07-30 — Baseline commit and identity correction

The first complete public baseline became root commit
`624553b03c794bb8cbd24e6c454d251ac214e24f` after a cumulative native-review
gate. A later accepted account/repository correction became
`24714788a4c489620643a58f5651a6a3888a8fd3`, selecting `junwei529/skills`
and public attribution `Copyright (c) 2026 junwei529`.

The baseline review used five semantic reviews in cycle 1 and, after one
user-approved reset, five in cycle 2. Eleven unique findings were corrected:

1. stale pre-commit current-state claims;
2. publication-unsafe local host/Git detail;
3. a cold-resume fixture without reproducible Git preconditions;
4. a broken PowerShell wrapper that also split the verifier path;
5. missing Markdown-fragment validation;
6. cold-resume setup staging interpreter caches;
7. a premature candidate-state claim;
8. an inaccurate PowerShell fixture contract;
9. a fixture README command using the wrong repository-root path;
10. setup accepting destinations outside the ignored run root; and
11. lexical containment allowing an existing reparse point to escape that
    root.

The corrected helpers reject out-of-root and reparse-routed destinations and
have deterministic negative coverage. Earlier clean reviews did not certify
later changed trees. The final reviewed baseline excluded discovery mappings,
installed copies, caches, and ignored run roots.

### 2026-07-28 — Source, installation, license, and distribution contracts

Accepted governance established:

- one editable repository SOURCE;
- optional local DEV_DISCOVERY;
- exact-commit clean RC_INSTALL;
- immutable-tag STABLE_INSTALL;
- repository-level v0.1 versioning;
- root MIT license with current attribution;
- standalone GitHub distribution through `$skill-installer`; and
- deferred Plugin packaging.

Early checks and interface reads did not create a mapping, installation,
candidate, tag, remote, or release. The operational owner is the
[Runbook](RUNBOOK.md), and rationale remains in Decisions 0003–0005 and 0013.

## Repository Checker History

The initial 2026-07-27 scanner was a one-off check over 40 text files.
Adversarial review found four false-green paths: an overly broad nonzero test
acceptance, fixture checks without exact test identity/count, incomplete
publication patterns, and direct-reference detection that accepted unrendered
path text.

The checked-in repository and fixture scripts were strengthened to require
named tests and exact counts, detect publication-unsafe path/ID/secret forms,
exercise scanner probes, require rendered direct links, validate Markdown
fragments, and cover Git/reparse fixture boundaries. Later source/install
governance added `.codegraph` to non-source exclusions without deleting the
cache.

The checker validates structure and configured publication boundaries. It does
not prove selection, behavior, efficacy, permissions, or release identity.

## Per-Skill Evidence Routing

The former root ledger contained detailed Project Docs, Work Charter, and
PowerShell development histories. Decision 0015 moves their canonical claim
ledgers without deleting sanitized results:

| Evidence family | Canonical ledger |
|---|---|
| Project Docs decisions, M1R source revisions, explicit behavior, explicit-only selection, and Skill-specific limits | [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter identity, M2R source matrix, independent acceptance, P/E and Standard delivery, and Skill-specific limits | [Work Charter Verification](skills/work-charter/VERIFICATION.md) |
| PowerShell runtime readiness, portable-guidance migration, fresh contexts, deterministic hardening, and Skill-specific limits | [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md) |

Shared exact-commit candidates, repository tags, complete-set stable installs,
public repository state, and commit/review history remain in this root ledger.

## Evidence Policy

- SOURCE-assisted, DEV_DISCOVERY, RC_INSTALL, STABLE_INSTALL, and RELEASE are
  separate claim levels.
- Role names, tasks, worktrees, source equivalence, or self-reported paths do
  not prove loaded identity.
- Failed or contaminated attempts remain recorded and excluded from claims.
- Generated, ignored, and untracked artifacts are part of before/after
  reconciliation even when Git status omits them.
- Do not claim correctness improvement, token saving, broad trigger accuracy,
  cross-Harness parity, or SHICE validation without pinned reproducible
  evidence.
