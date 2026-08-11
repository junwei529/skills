# Repository Verification

Last updated: 2026-08-11

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
| Changed Skill validator | Validate frontmatter and package name without changing the package | unchanged exact `c481005...` Work Charter package passes the bundled `skill-creator` validator; D50 changes no Skill SOURCE |
| Repository checker | Validate strict UTF-8/no BOM, whitespace, local links/fragments, publication safety, exact Skill/eval sets, federated docs, and bilingual navigation | passes with 209 text files / 14 cases / 12 fixtures for the current working revision |
| Fixture checker | Validate synthetic starting states and their Git/reparse/ignored-result boundaries plus the tracked controller regression | all 17 checks pass at governing-controller commit `c51552c...`; D50 changes no tracked fixture or controller input |
| Codex evidence controller | Validate one shared core across four entry modes, strict required-read versus bounded auxiliary-observation attribution, structural PowerShell/Git/path classification, source-and-generated-contract-bound historical regressions, exact package manifests, candidate-identity and content-proof shape, record cardinality, completed exit typing, optional sealed governing-disposition monotonicity, output-array shape, per-key single-capture sealed parsing and reuse, real-reparse rejection, fail-closed negatives, external-input types, independently resolved inner/wrapper command identity, Git-read and external-filter safety, profile-free PowerShell wrappers, culture-independent canonical ordering, metamorphic equivalence, output no-clobber, and canonical repeatability | passes exact current-SOURCE package identity, 11/11 historical, 32/32 evidence-surface, 33/33 negative, 4/4 metamorphic, 8/8 governing-snapshot guards, 3/3 manifest-hash guards, all reported structural guards, and zero external model or assessor calls; private sealed carriers remain unchanged |
| CRG supplemental preflight | Sharpen structural review scope when the maintained index represents the intended diff | degraded: the maintained graph was built at `763a15e...`, not current HEAD `c51552c...`; it enumerated all nine documentation/eval-method paths but surfaced zero code symbols or test gaps, so it supplies no coverage claim and direct canonical-owner plus native review remain required |
| Native Codex review | Review the exact uncommitted change before either D50 commit | governing-controller commit `c51552c...` retains its completed review history; the exact D50 authority diff and later result diff each require their own bounded native review before commit |
| Isolated controller canary | Record the bounded disposition of one private path-bound infrastructure check without broadening behavior claims | retained sealed `CANARY_PASS`; the public summary reports an exact-response pass and no command execution, omits private locator/artifact/runtime details, and leaves physical backend request count `UNKNOWN` |
| Work Charter D36/D37/D40, D34/D41 predecessors, D42-D49 terminals, and D50 route | Preserve additive predecessors and separate product behavior from route, tool, qualification, eval-contract, authorization, environment, and private-carrier failures | D36-D49 remain immutable with their recorded dispositions; D49 sealed at combined 17/28 on released-control A18, and approved D50 may import only A01-A17 before out-of-matrix `A18-CANDIDATE-CAL` and fresh scored released-control A18 run under one identical safe-Git overlay; 11 fresh scored cells preserve the 28-cell matrix, no D50 evidence exists yet, and exact candidate `c481005...` remains unaccepted |
| PowerShell deterministic hardening | Validate cardinality, LF bytes, one-base paths, and Junction link-only removal | 15 assertions pass in PowerShell 7 and Windows PowerShell 5.1 |
| PowerShell parser sweep | Parse all `evals/**/*.ps1` files and the tracked controller module | all eight tracked PowerShell files parse after the controller module and focused checker change |
| Markdown navigation and ownership | Verify local links/fragments, English/Chinese routes, expected per-Skill owners, and no orphan canonical owner | passes through repository checker |
| `git diff --check` | Reject whitespace defects in the working revision | passes for the current tracked diff with an untouched index |
| Gitleaks | Detect secret-like content independently | exact per-file scans of the nine-path D50 authority diff pass with zero findings; no ignored-carrier content is published |

## Repository Claim Ledger

| Claim | Status |
|---|---|
| Three independent public Skill packages exist | verified; Project Docs 6 files, Work Charter 5 files, PowerShell 5 files |
| The superseded `manage-large-tasks` package is retired | verified; no alias or second discovery entry |
| Federated repository documentation has one root and one per-Skill owner for each fact class | verified in the current working tree by the repository checker, including expected owners and no orphan canonical owner |
| English-canonical public entries have Simplified Chinese mirrors | verified for the root and all three per-Skill pairs, including reciprocal navigation and corresponding section counts |
| Public source, development discovery, candidate, and stable roles are distinct | accepted and operationally verified |
| Public standalone distribution works | verified for `junwei529/skills`, exact-SHA RC, immutable `v0.1.2`, and per-Skill `$skill-installer` paths |
| One coherent multi-Skill candidate was loaded | verified at `78caaa6...` and repeated at `f7c07b5...` |
| All three current packages independently reached release-candidate readiness at one commit | verified at exact public `c42eef3...`; Project Docs, PowerShell, and Work Charter each have isolated loaded-copy evidence and explicit residual limits |
| Tag-pinned stable loaded-copy identity works for all three Skills | verified for immutable `v0.1.2` at `ceed607...` |
| `v0.1.0` is the coherent public release | false; retained as immutable installation evidence only |
| `v0.1.1` is an immutable coherent historical release | verified; retained as rollback identity |
| `v0.1.2` is the current coherent stable release | verified: immutable tag, exact installed copy, loaded-copy canaries, and GitHub Release |
| A GitHub Release object exists | yes: [`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2), marked Latest |
| The repository improves correctness, saves tokens, works across Harnesses, or passed SHICE | unverified |

## Candidate And Release Evidence Template

Use this record for a material development run, release candidate, stable
install, or release. Public evidence uses logical locators rather than private
absolute paths.

```text
Evidence level: DEV | RC | STABLE_INSTALL | RELEASE
Skill or package:
Previous accepted release tag: not applicable (DEV) | none (first release) | <tag>
Source branch or checkout:
Commit state: unborn | <SHA>
Working tree clean: yes | no
Canonical source locator:
Actually loaded copy role: DEV_DISCOVERY | RC_INSTALL | STABLE_INSTALL
Actually loaded logical locator or resolved-source proof:
Distribution form and package version:
Installer or package source ref/SHA:
Candidate release-set manifest (RC or RELEASE only):
Approved target installed subset (STABLE_INSTALL only):
Prior and rollback installed manifest (update only):
Structural validation:
Repository and fixture checks:
Fresh-context behavior tests:
Installed-copy smoke:
Post-switch active manifest and discovery proof:
Stable tag-to-commit verification:
Known gaps:
```

For a repository release candidate or release, append this comparison:

| Skill | Prior package identity | Candidate package identity | Delta | Required evidence |
|---|---|---|---|---|
| `<skill-name>` | tag plus tree/blob identity or `not present` | commit/tag plus tree/blob identity or `not present` | `added`, `changed`, `unchanged`, or `removed` | identity, behavior, loaded-copy, or absence proof required by the delta |

`Unchanged` means exact package tree or blob equality with the previous accepted
tag. It does not mean equal maturity, a new behavior result, or proof that the
candidate or stable copy was actually loaded. For a first release, record every
package as `added`; always record a rename as one `removed` path plus one
`added` path. An accepted continuity decision may support bounded evidence reuse
but does not alter those delta labels or their absence, update, and rollback
duties. `Removed` requires absence evidence and does not authorize deletion of
an existing installation.

The [Runbook](RUNBOOK.md) owns procedure. This section alone owns the shared
field schema.

## Shared Candidate And Release History

### 2026-08-01 — Immutable `v0.1.2`, stable installed-copy proof, and GitHub Release

Local and public `main` plus immutable tag `v0.1.2` resolved to exact commit
`ceed607152849775b981c54add74bfa30d858e4d`. The tag retained the exact
6/5/5 Skill package blobs previously tested at `c42eef3...`; blob equivalence
was used only as bounded behavior continuity, not as installed-copy identity.

The official `$skill-installer` helper downloaded all three paths from public
repository `junwei529/skills` at exact ref `v0.1.2` into one isolated staging
root. Before replacement, the existing three-package stable set was proven
byte-for-byte equal to immutable `v0.1.1`. Both the staged `v0.1.2` set and the
retained rollback set contained the exact 6/5/5 tag Git-blob file sets, strict
UTF-8 without BOM, LF-only text with one final newline, no internal reparse
point, and three passing Skill validators. The approved switch moved the old
set to a dedicated rollback root and moved the verified staged set into the
stable install; it did not edit either generated copy in place.

Fresh ephemeral read-only processes then proved the actually loaded stable
copies through isolated repository-scoped discovery. Each positive scope
contained exactly one `.agents/skills/<name>` entry resolving to the already
verified stable target; user configuration and unrelated rules were excluded,
and native events recorded reads from that target:

- Project Docs resolved and read the stable entry and audit/adopt reference,
  returned mature `NOOP` with strong continuity, and changed no fixture file.
- Work Charter resolved and read the stable entry plus both references, kept
  Orchestrator reliance and Phase Two blocked while durable Planner assessment
  recording remained pending, and limited the next action to that record plus
  verification.
- PowerShell resolved and read the stable entry plus native/process and
  text/encoding references, diagnosed nested-command argument splitting,
  preserved the spaced path and stream/exit contracts, and closed the
  UTF-8/BOM/LF/final-newline/JSON/non-ASCII branch. Runtime commands blocked by
  the read-only sandbox remained explicitly unverified.
- One shared ordinary arithmetic negative exposed all three stable discovery
  entries, returned the expected result, and executed no command or Skill/
  reference read.

Controller-side discovery-target and Git-blob verification own exact revision
identity; model self-reported hashes were not used. Earlier direct-read
canaries did not prove discovery and are retained only as diagnostic evidence.
One normal-user-context discovery attempt was also excluded after it loaded
unrelated private global context; that unsafe shape was not reused. Combined-
command policy denials, a Project Docs explicit disk-read stop, one controller
parser error corrected before switching, and a JSONL path-inspection escape
bug are likewise diagnostic or excluded, not converted into passing behavior.
The user configuration hash, SOURCE, and tracked repository state remained
unchanged throughout the install and canaries. The staging root ended empty,
while the exact `v0.1.1` rollback copy and retained ignored evidence roots
remain intentionally uncleaned.

Final deterministic checks passed: all three stable validators, repository
checker at 180 public text files / 12 cases / 11 fixtures, 15 fixture checks,
15 PowerShell boundary assertions under both PowerShell 7 and Windows
PowerShell 5.1, explicit Git diff checks, and a tracked-history Gitleaks scan
across 17 commits. A whole-directory scan separately found one pre-existing
generic-key heuristic in an unrelated retained ignored official-manual cache;
the matched value stayed redacted and the tracked publication surface passed.

The GitHub Release
[`v0.1.2 — Stable three-Skill release`](https://github.com/junwei529/skills/releases/tag/v0.1.2)
was published from the existing immutable tag, marked Latest, and verified to
target `ceed607...`. Its notes provide standalone and complete-set installer
commands, package scope, verification, authorization boundaries, and evidence
limits. No tag moved, no new release asset beyond GitHub source archives was
added, and no private-global retirement or cleanup action was inferred.

Evidence level: `RELEASE` plus `STABLE_INSTALL`. This proves current public
mapping and bounded stable loaded-copy behavior; it does not prove stable
mutation for Project Docs, full stable Standard delivery for Work Charter,
live WSL or native execution inside the PowerShell canary sandbox, broad
trigger accuracy, causal efficacy, token savings, real-project generalization,
SHICE, or cross-Harness parity.

### 2026-08-01 — All-Skill `c42eef3` release-candidate readiness

Public and local `main` resolved to exact commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` before three independent
release-readiness runs. `$skill-installer` materialized each exact Skill path
from that public ref into an isolated RC environment. Controller checks proved
the exact 6/5/5 Git-blob file sets, strict UTF-8 without BOM, no internal
reparse point, candidate validators, only-candidate selection in counted
scopes, and preservation of immutable stable `v0.1.1`.

The Skill-specific outcomes were:

- Project Docs: four explicit loaded-copy scenarios returned mature `NOOP`,
  fail-closed recovery `STOP`, authority-conflict `PROPOSE`, and safety
  `REPORT`; an ordinary negative did not load; independent assessment
  `ACCEPTED`.
- PowerShell: two candidate-loaded positives preserved executable cardinality,
  argument, stream, exit, runtime, and text contracts; ordinary-cmdlet and
  POSIX-only negatives did not load; the controller reproduced direct exit
  `0` and broken-wrapper exit `1`; PowerShell 7 and Windows PowerShell 5.1 each
  passed 15/15; independent readiness passed.
- Work Charter: a flat negative did not load; one bounded synthetic Standard
  Phase One used one Orchestrator, Planner, Executor, and writer, durably
  recorded Planner acceptance before Orchestrator reliance, later durably
  recorded Orchestrator acceptance, passed seven controller checks, and
  stopped before Phase Two.

Each runner retained or removed only its separately authorized ignored
artifacts, left SOURCE and stable unchanged, and relinquished writer and cleanup
ownership. Failed controller, launcher, transport, policy, and contaminated
attempts remain excluded in the detailed records rather than being converted
into behavior evidence:

- [Project Docs `c42eef3` RC](../evals/results/2026-08-01-project-docs-c42eef3-exact-commit-rc.md)
- [PowerShell `c42eef3` RC](../evals/results/2026-08-01-powershell-c42eef3-exact-commit-rc.md)
- [Work Charter `c42eef3` full Standard RC](../evals/results/2026-08-01-work-charter-c42eef3-full-standard-rc.md)

Verdict: all three Skills are independently
`READY_FOR_RELEASE_CANDIDATE` at exact `c42eef3...`. At that checkpoint this
was not current stable behavior, a new immutable tag, or a GitHub Release. The later commit that
records these results is evidence-only and must not be relabeled as the tested
candidate or receive a tag without its own candidate proof.

The sanitized records above were committed and pushed in evidence-only
descendant `801139eb36c99c393011e2328b839165e8a216a5`. A later
release-preparation descendant may preserve the exact 6/5/5 package blobs and
therefore retain the bounded relevance of the `c42eef3...` behavior results.
Blob equivalence does not prove that the later commit was fetched, installed,
or loaded. Before any immutable patch tag maps to that descendant, one public
exact-commit `$skill-installer` run must independently prove Git-blob identity,
isolated same-name discovery, the actually loaded copy for all three packages,
and proportional critical canaries.

Public install documentation uses `<version-tag>` rather than embedding an
unpublished tag as if it already existed. A controlled pre-tag RC record may be
committed in a later separately authorized evidence update; creating a new
candidate commit solely to embed its own RC result would recurse without adding
package assurance.

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
Known gaps at the `v0.1.1` checkpoint: no GitHub Release; no cleanup; broad trigger, real-project, efficacy, token, or cross-Harness proof
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

### 2026-08-02 — Work Charter v0.2 Gate 1 local implementation

From clean documentation baseline
`763a15ee76bc71dd5e16fc22f32966cb0c8c3488`, the task-dedicated branch
`codex/work-charter-v0.2` implements Decision 0018's accepted five-file SOURCE
mapping, two new eval cases, one shared entry fixture, the six updated Work
Charter cases, extended fixtures/checkers, and mapped canonical documentation.
The package remains exactly five ordinary non-reparse files, each strict UTF-8
without BOM, LF-only, and final-newline terminated.

Gate 1 deterministic checks pass:

- `$skill-creator` `quick_validate.py` reports `Skill is valid!`;
- `scripts/check_repository.py` reports 191 text files, 14 exact cases, and 12
  exact fixtures;
- `evals/check-fixtures.ps1` passes all 16 preconditions;
- PowerShell parser checks pass for every `evals/**/*.ps1` file;
- `git diff --check` passes; and
- `gitleaks dir . --no-banner --redact --no-color --exit-code 1` reports no
  leaks.

The effective local native commit gate used Terra with `high` reasoning. In the
original Gate 1 implementation cycle, review 1 found one P2: the newly added
cold-resume synthetic commit could inherit a user signing policy. That setup
was fixed before the implementation commit with command-local
`commit.gpgSign=false`, and review 2 completed clean. This correction round
applies the same isolation to the recovery-integrity synthetic commit. Two
startup failures before semantic review—one unsupported CLI prompt/selector
combination and one sandbox network block—were excluded from the completed-
review count. This is local commit-gate evidence, not behavior, candidate, or
loaded-copy proof.

This proves local implementation structure, text bytes, links, publication
safety, case/fixture identity, and synthetic fixture preconditions only. Gate 1
does not run the 19/23/27 model matrix, create a candidate or `RC_INSTALL`,
change discovery or stable installation, push, integrate, tag, or release.
Natural-language selection, the first-turn no-read boundary, L0-L4 behavior,
managed re-entry, all four routes, and visible Standard reuse remain
`UNVERIFIED` for the new SOURCE until exact-candidate Gate 2 evidence exists.

### 2026-08-04 — Work Charter sealed Standard evidence and offline correction

Exact candidate `206c497cfbd096aee90e0609446b038fee58973a` began the
approved Work Charter Gate 2 matrix but stopped without acceptance after one
completed independent correction round and four reference cells crossed their
declared consumption points. Pre-consumption controller activity remains
qualification rather than model evidence. The correction and consumed events
remain bound to that logical subject and checkpoint; a new task, root, epoch,
attempt, or candidate label cannot reset them.

The accepted same-contract convergence correction became pushed successor
`92a8c04554e4021ad3c998c97fd733f6554e048f`, preserving predecessor history.
Its `Sol/high` reference consumed A01-A04. A03 observed exact direct full-Skill
loading. A04 made a safe indirect metadata proposal and no project read, but
claimed selection without a controller-observed candidate `SKILL.md` read, so
the run hard-stopped. A05-C04, the contrasts, and independent assessment did not
start; the observations provide no candidate acceptance.

Exact committed SOURCE `72db7e9dfe920de5e2017421b22446cf5c8c75e6`
implements the accepted two-stage entry revision. One separately authorized
fixed-turn Standard probe crossed its declared one-shot consumption point once,
completed four primary turns in four fresh sessions, created no subagent or
collaboration-agent activity, and left A16 unexecuted. Its top-level,
Orchestrator, Planner, and Executor verdicts are sealed `VIOLATION`; no retry or
retrospective rescore is permitted.

The material product finding is conditional package loading. The top-level
response did not prove full-Skill loading, and every Standard component missed
one or both required references before claiming Work Charter responsibilities.
The same-contract correction stops without an activation claim when the full
Skill body is unavailable, and permits a direct or confirmed activation claim
only after that body is available in the current context. When the runtime does
not expose exact copy identity, the response preserves `UNKNOWN` and makes no
revision claim without blocking ordinary activation. Every fresh L3/L4 role
loads the full Skill and coordination/recovery reference, and each fresh L4
role loads the Standard reference before applying any L4 responsibility. L0-L3
leave the Standard reference unloaded by default; an approved explicit
evaluation of a transition to L4 may read it without authorizing the transition
or any L4 responsibility. A handoff summary remains orientation, not exact
loaded-copy proof.

The correction changes only `skills/work-charter/SKILL.md` inside the five-file
package and mapped existing product, evaluation, public-entry, repository-state,
evidence, and recovery consumers. The exact update set is recorded in
[Repository Handoff](HANDOFF.md). It adds no file, package component, case,
fixture, checker, matrix lane, state machine, Codex task API, fact class,
product contract, evidence target, or acceptance boundary. Other inspected
owners and consumers remain explicitly `CHECKED_NO_CHANGE` or
`NOT_APPLICABLE`.

The fixed-turn evidence also exposed controller-calibration issues rather than
additional Skill defects: role boundaries require meaning-based scoring;
structured actions and resolved reads, not shell punctuation, own attribution;
and a one-shot bundle freezes immutable inputs at consumption while rechecking
only named mutable or invalidating surfaces. These prospective rules do not
edit, retry, replace, or rescore the sealed result.

Offline checks pass for the conditional correction: Work Charter validation; the
repository checker at 191 text files, 14 cases, and 12 fixtures; all 16 fixture
preconditions; six PowerShell parser checks; `git diff --check`; the exact
five-file strict UTF-8/LF/no-BOM/final-newline/non-reparse audit; and a Gitleaks
scan of every changed tracked publication file. Retained ignored Gate 2 runtime
artifacts remain outside that changed-file scan; no cleanup or result rewrite is
authorized.

Detailed native-review findings, fixes, cycle consumption, and coverage remain
in the cumulative attempt record rather than this tracked evidence snapshot.
At this offline checkpoint, the correction had implementation, definition, and
finding-handling evidence only; native-review and Git disposition were resolved
later against the exact bytes from the live record. It had not yet obtained
candidate, behavior-model, RC, installation, integration, release, or stable-
update evidence. The following sections record the later candidate and local
integration facts. Neither those later infrastructure facts nor any sealed
probe or successor transfers behavior acceptance. The bounded repository-level
terminal summary is recorded below; exact execution detail remains in the
Work Charter Verification owner, and any new Gate 2 evidence window requires
its own authority.

### 2026-08-05 — Work Charter controller stabilization

The conditional-loading package became exact product candidate
`b965102ea58f9cc1ef3c73e8dea515731fec12a6`. Its five package blobs remain
byte-identical through the later controller revisions. The candidate remains
unaccepted at Gate 2; its sealed execution history and exact residual limits
are owned by the Work Charter Verification ledger.

The repository now carries a small PowerShell evidence-controller contract and
deterministic regression gate. One module owns preflight, runtime, historical-
import, and terminal-stage normalization through a shared core. Each sanitized
historical case is bound to one of eight public logical source keys through an
explicit redacted selector projection, input specification, and canonical hash
of the complete root-normalized generated controller input plus expected
result. The generated hash is verified before controller invocation and is part
of the binding material. Physical locator, length, and hash identities remain
outside tracked sources in an ignored private manifest. Explicit local sealed-
evidence verification requires that manifest, validates its exact logical-key
set, then proves literal
containment before read, rejects rooted, traversal, alternate-root, or a real
platform-selected directory-link route, and uses one held read stream for length, SHA-256,
strict UTF-8 JSON, and projection. It reads no additional raw rollout or
session source and invokes no Codex, app-server, thread, turn, behavior model,
or semantic assessor.

Focused results are 11/11 historical cases, 17/17 fail-closed negatives, and
4/4 metamorphic pairs. Two complete runs emit identical canonical JSON and
SHA-256. The gate preserves the true A15 unauthorized role delivery and
unbudgeted nested turn, while correcting copied-controller errors around
unknown action typing, read-only Git compounds, working-directory-relative
Skill reads, natural-language marker dependence, construction order, inventory
order, positional reads, successor locator identity, failed execution, Git
output/relocation/config injection/signature verification, and partial
`Get-Content` reads. Exact revision blobs recompute both five-file package-
manifest hashes; the private manifest's eight sealed-input identities remain
unchanged and contained without being published.
Three generated-contract drift guards and one per-key capture-reuse guard also
pass. The latter replaces the scratch pathname bytes after the first verified
capture and proves that later projection and summary consumers reuse the same
original capture object. The local merge correction used this synthetic guard
and public-mode controller regression without reading or changing private
sealed inputs; canonical and terminal output hashes remained unchanged.
Native merge review 2/5 then found that an inherited `GIT_EXTERNAL_DIFF` could
still execute through an admitted diff-capable read. `log`, `show`, and `diff`
now require both `--no-textconv` and `--no-ext-diff`; a ninth Git-read safety
guard proves the latter fails closed. Public mode passes 9/9 Git-read guards
with canonical SHA-256 unchanged at
`186391f34dfd50526d38b8bc844ae5f5672500bc70e520bb81f962778561301c`;
the added guard changes the no-newline terminal JSON SHA-256 to
`a00924d2698476ee0bf7b2e2b0a5896d85a732b5e615d6fa44628c7434f36cf0`.
Native merge review 3/5 then found that a path-pinned PowerShell wrapper could
omit `-NoProfile`, allowing untracked profile code to run before the parsed
inner command. Wrapper admission now requires exactly one `-NoProfile`; N31
proves omission fails closed. Public mode passes 31/31 negatives and 11/11
historical cases with zero failures. The new negative changes canonical and
no-newline terminal JSON SHA-256 values to
`33cad6eb424c63341e607922a3ae72f1ce0b11ec9ac860e1cd7769f1c776114b`
and `42d723c31704772f389c71479935bf67a80201f8e74e0c8705c09538138d443b`.
The directory-link guard selects Junction on Windows and SymbolicLink
otherwise, validates the selected LinkType and contained target before use and
nonrecursive deletion, and proves the target sentinel survives. Current-host
evidence covers the Windows branch; non-Windows execution remains `UNKNOWN`.
Under the approved quiescent offline single-writer threat model, the checker
also proves `.eval-runs` is the exact ordinary non-reparse repository child
before scratch creation, revalidates that root plus the contained ordinary
scratch and all descendants before recursive cleanup, and verifies scratch
absence and root shape afterward. Two scratch-owned topology guards pass 2/2;
cleanup-precondition failure retains residue for manual disposition. Hostile
rename or reparse swaps entirely between validations are not defended against
and remain unsupported/`UNKNOWN`.

Native semantic review 1/5 found four further infrastructure gaps:
signature-verification Git options, manifest hashes not derived from all five
actual blobs, historical cases not consuming their pinned sources, and
uncontained sealed locators. The user-authorized same-scope correction closes
all four. Native semantic review 2/5 confirmed the first two corrections, then
found that the complete generated input/expected result was not bound, sealed
hash and parse used separate pathname reads, and the reparse guard did not
exercise the resolver. The next user-authorized same-scope correction closes
those three without changing SOURCE or sealed evidence. Native semantic review
3/5 then identified an adversarial-concurrency window and missing run-root
lifecycle validation. The first is a valid finding under the broader threat
model and is resolved by the user's narrower quiescent single-writer
precondition, not by a false-positive disposition or claimed no-follow
implementation. The second is fixed by the pre-create/pre-cleanup/post-cleanup
checks above. At that correction checkpoint, review 4 had not yet run and the
existing 3/5 history remained intact.

Native review 4/5 then found two fail-closed gaps in external record typing.
A string-valued role authorization such as `"false"` became truthy under
PowerShell Boolean coercion, and malformed nested-turn count or budget values
could throw instead of producing one of the controller's three verdicts. The
same-scope correction requires actual Boolean authorization and nonnegative
integral counts, routes invalid types or overflow to explicit unknowns, and
adds 2/2 focused external-input type guards. It adds no historical case,
fixture, sealed input, or product behavior contract. The prior historical,
negative, metamorphic, package, sealed, and canonical-repeat results remain
unchanged.

Native review 5/5 then found that blank or malformed expected and observed
candidate identities could compare equal and reach `ADMISSIBLE`, and that the
regression output serialized empty historical violation arrays as `[null]`.
The same-scope correction validates all five logical identity fields before
comparison, returns `CONTROLLER_UNKNOWN` for incomplete or malformed identity,
and preserves empty arrays as `[]`. Three identity-shape guards and one output-
shape guard pass. This intentionally changes the canonical regression hash to
`fca3e989a61fa97df9ded66203604c071c3d8691eff8170b38cff49c859dfc44`;
it does not change any historical verdict, package blob, sealed input, case, or
fixture.

The user then reset the completed review budget for the same commit attempt.
Reset-cycle review 1 found two P1 gaps in the read-only Git boundary: `git
status` could take an optional lock and refresh the index, while an admitted Git
read could launch a configured external pager. The controller now requires
global `--no-pager` for every admitted Git read and global
`--no-optional-locks` additionally for `status`. Three focused guards prove
missing flags fail closed and the complete supported bounded-read matrix stays
admissible. R02/R04 generated contracts and bindings were re-hashed for the
safer command form; historical verdicts, sealed inputs, SOURCE, case inventory,
and fixture inventory remain unchanged. The then-current canonical regression
hash was `48b58734cb19cb927fba9d2b23a20a3acc9838375c7c31e61793615fb731bdbb`.

Reset-cycle review 2 found one P1 in content-proof validation. A malformed
`allowed_files` SHA-256 could compare equal to the same malformed action proof
and reach `ADMISSIBLE`, while a malformed length could throw during conversion.
The controller now validates both sides independently as nonnegative integral
length plus 64-hex SHA-256 before comparison. Three focused guards cover
malformed policy identities, malformed evidence proofs, and matching-malformed
inputs. Historical and canonical hashes remain unchanged; the then-current
complete terminal JSON SHA-256 was
`a9c9fb5dd40b0688d58a17716bb4f41cebd33284c76bf17e3ff2ca8740eeb519`.

Reset-cycle review 3 found two P1 duplicate-key gaps plus one P2 external exit-
code type gap. Duplicate allowed-file and observed-proof keys silently retained
the last contradictory row, while string `"0"` could be coerced into successful
completion. Both map builders now report duplicate keys as explicit unknowns
without overwriting, and completed commands require an actual integral exit code
whose value is zero. Three focused guards cover duplicate policy/proof records,
string zero, positive/negative nonzero, and numeric zero. The canonical hash was
unchanged; the then-current complete terminal JSON SHA-256 was
`38257d531d240abd656c52486664c6579000b1ffbf398b31a1613236fec873bd`.

Reset-cycle review 4 found one P1 external-execution path: the Git classifier
could admit `cat-file --filters` or `--filters=...`, which may invoke configured
content filters. Both option forms now return
`git_external_input_or_execution_not_admissible`. Formal negative N16 raises
the aggregate to 16/16. Historical verdicts, sealed inputs, SOURCE, case and
fixture inventories, and product package blobs remain unchanged. The then-current
canonical regression hash was
`4b340084fdcb9fac8e7885b246945fc5bc436b82bc2e83b81817cd20646978f1`;
the then-current complete terminal JSON SHA-256 was
`d8c1956a868abe5aa03a0422872e54b3686c2008fe6a29e37b7d71bcd11fe67f`.

Reset-cycle review 5 found one P1: admitted `git status` could still execute a
configured `core.fsmonitor` hook. Status now requires command-local `-c
core.fsmonitor=false` together with `--no-pager` and `--no-optional-locks`.
The fourth Git-read safety guard proves missing fsmonitor disablement fails
closed. R02/R04 generated contracts and bindings were re-hashed to the safer
command bytes without changing their historical verdicts or sealed sources.
The then-current full sealed gate passed 11/11 historical, 16/16 negative, 4/4
Git-read safety, and 8/8 sealed inputs. Its then-current canonical regression SHA-256 was
`1befde8abc22fd2b059bca1fb971320fd63d56fc4e91e06f9533bbca19fc1e90`;
the then-current complete terminal JSON SHA-256 was
`d6dabe2b1a8c5ba7ff684719233d56be5a12a91e6823464b84a1f41591fff1b5`.
This review consumed the last reset-cycle slot. Because the fix mutated the
reviewed bytes, another native review requires an explicit user budget reset.

The user approved a second reset for the same commit attempt. Its review 1/5
found one P1: `git remote -v set-url ...` could be classified as a read-only
remote listing. Only the exact one-argument `remote -v` and `remote --verbose`
forms are now admitted; every other remote shape fails closed. The fifth Git-
read safety guard covers the mixed verbose/mutation form. Historical, negative,
sealed, SOURCE, case, fixture, and product-package identities remain unchanged.
The then-current canonical regression hash remained
`1befde8abc22fd2b059bca1fb971320fd63d56fc4e91e06f9533bbca19fc1e90`;
the then-current complete terminal JSON SHA-256 was
`09a91955259b49326a89f507655eebf80026d46c21da4cfbbd015644d9a5a371`.
Four reviews remain in the current cycle.

Second-reset review 2/5 found two P1 gaps. N17 now rejects reconciliation before
manifest creation, completing the required directory/manifest/reconcile/seal
order. Completed command records must also supply one resolved-command identity
whose family, kind, and SHA-256 exactly match the policy-pinned trusted identity
for the AST command family. Three guards cover missing identity, a shadowed
PowerShell function identity, and a trusted positive. This proves the offline
record contract only; live resolver collection remains outside this gate. All
11 generated historical contracts and bindings were re-hashed without changing
their verdicts or sealed sources. The current full sealed gate passes 17/17
negatives and 3/3 command-resolution guards. Its canonical SHA-256 is
`2c083cf2c40ec86e2eb7688e5edc3ae18408539f9f71f7c424233263f2c7c834`;
the terminal JSON SHA-256 is
`7d96464312333eda7937f0942af763931ca38aa54b6d5158f7e8ac469192cbf0`.
At that checkpoint, three reviews remained in this cycle.

Second-reset review 3/5 found two P1 Git external-execution gaps and two P2
record/diagnostic gaps. Branch reads now admit only exact `branch
--show-current` or `branch --list` shapes, so a mixed delete form cannot pass
because one read flag is present. Admitted `log` and `show` reads now require
command-local `-c log.showSignature=false`, preventing configured signature
display from launching an external verifier. Focused branch testing also
exposed an empty-command-family parameter-binding throw; empty classifications
now reach the controller's explicit ambiguous-family unknown instead. Git-read
safety guards pass 7/7. `assessor_requested` must be an actual Boolean, so the
string `"false"` cannot become a violation; external-input type guards pass
3/3. Finally, the terminal `failures` array now enumerates every group and
scalar gate used by the aggregate verdict, including command resolution,
canonical repeat, baselines, package identity, and sealed inputs. The full
sealed gate still passes 11/11 historical, 17/17 negatives, 3/3 command-
resolution guards, and 8/8 sealed inputs with no failure entries. The canonical
SHA-256 remains
`2c083cf2c40ec86e2eb7688e5edc3ae18408539f9f71f7c424233263f2c7c834`;
the terminal JSON SHA-256 is
`9e94d7b0313be99b275dbefd1c6a4cea43d2314a746daf23b7e0fb34502a69b1`.
At that checkpoint, two reviews remained in this cycle.

Second-reset review 4/5 found two P1 admission gaps. A PowerShell wrapper could
use execution-affecting options such as `-WorkingDirectory` or `-File` while a
later benign `-Command` was parsed as the actual command. Wrapper admission now
uses a strict option shape: only `-NoProfile`, `-NoLogo`, and `-NonInteractive`
may precede one final constant `-Command`/`-c`; all other or duplicate wrapper
parameters fail closed. N18 and N19 cover the two unsafe modes, while the
trusted command-resolution positive traverses an admitted
`pwsh -NoProfile -Command` wrapper. Construction evidence also previously
looked only at the first occurrence of each stage, allowing a manifest rewrite
after `sealed`. The sequence must now contain exactly one directory, manifest,
reconciliation, and seal event in that order; N20 covers the post-seal rewrite.
The full gate passes 20/20 negatives without changing any historical verdict or
sealed input. The expanded negative inventory intentionally changes the
canonical SHA-256 to
`7a1d272797402b24a35cd7c6cb54641a459e1f1b26e0d9834e8fd69d2cf590d3`;
the terminal JSON SHA-256 is
`7d0c6d76e736518c8b6db8f2108ea86c570c09fb95deab27167c1a845bfd8934`.
At that checkpoint, one review remained in this cycle.

Second-reset review 5/5 found two P1 malformed-input gaps. Non-object or
missing-root/path `allowed_files` rows could throw under StrictMode, and equal
but invalid inventory path/length/SHA-256 rows could be accepted. Allowed-file
and action-proof maps now extract fields defensively, require a nonempty root
and structurally relative path, and return explicit shape unknowns. Inventory
rows require a structurally relative path plus a nonnegative integral length
and 64-hex SHA-256 before comparison. Six focused content/proof/inventory
guards cover malformed content identities, matching malformed identities,
malformed allowed/proof rows, and matching malformed inventory rows. The full
gate passes with canonical SHA-256 unchanged at
`7a1d272797402b24a35cd7c6cb54641a459e1f1b26e0d9834e8fd69d2cf590d3`;
the terminal JSON SHA-256 is
`81250a270414779a245031517951898f1faeee296db0464412d81a2cc2d8844a`.
The second reset cycle is exhausted. Because these fixes changed the reviewed
bytes, another native review requires a new explicit budget reset.

The user approved a third reset for the same commit attempt. Its review 1/5
found one P1: an allowed `CommandAst` could be followed by an unclassified
PowerShell/.NET `CommandExpressionAst` or member invocation whose side effect
never entered the effect set. The structural boundary now rejects command
expressions and member-expression/invocation AST nodes before classification.
Formal negative N21 combines an allowed `Get-Content` proof with
`[System.IO.File]::WriteAllText(...)` and now returns an explicit unknown. The
full gate passes 21/21 negatives, 11/11 historical cases, and 8/8 sealed inputs
without changing historical verdicts or sealed bytes. The expanded negative
inventory changes the canonical SHA-256 to
`a056c1cd376ba8b26128a0252257fe6eb01213346976a580684c7959fee05536`;
the terminal JSON SHA-256 is
`ebfc6acd2a61e30abea1ce039021163427a31d9faa753ef31e1d36e51892d680`.
Four reviews remain in this cycle.

Third-reset review 2/5 found one P1: a `pwsh`/`powershell` wrapper's outer
redirection was discarded when the inner command was extracted, allowing an
inner read plus outer file write to appear read-only. Wrapper extraction now
rejects any outer redirection before returning the inner script. Formal
negative N22 preserves an allowed read/proof inside
`pwsh -NoProfile -Command` but adds `> redirected.txt`; it now returns unknown.
The full gate passes 22/22 negatives without changing historical verdicts or
sealed inputs. The canonical and terminal SHA-256 values are
`8d25dceec7dfbece7d5830c373bf3fcc9f5e6f13d9e5dae1a4a0b6bcea430152`
and `af40309f14c28d8f1ca8c8fd2bd688fb9016735c9f2a8c26faa9db6aed98b1d9`.
Three reviews remained at that checkpoint.

Third-reset review 3/5 found one P1 external-execution gap and one P2
determinism gap. A repository textconv driver could run for an otherwise
admitted `log`, `show`, or `diff`, so those commands now require explicit
`--no-textconv`; N23 and an aggregate Git-read guard cover all three forms.
Canonical JSON dictionary and object keys now use ordinal rather than current-
culture order, with one guard comparing `en-US`, `sv-SE`, and `tr-TR` in the
same process. The full sealed gate passes 23/23 negatives, 8/8 Git-read safety,
1/1 ordinal-order, and 8/8 sealed checks. The canonical and terminal SHA-256
values are
`cded4de887713a3c0424b59d9aea490e05af159e547d49c781b7b22cd90a97b6`
and `89f0d8af2a12e431376ba7fd5d79a0fabef7fed3084e9d39a350cecd6ce59938`.
Two reviews remained at that checkpoint.

Third-reset review 4/5 found one P1 wrapper-identity gap. The outer command was
recognized by a `pwsh.exe` leaf name, but only the extracted inner command
family had a policy-pinned resolved identity. Valid wrappers now require a
separate `powershell-wrapper` native-application identity; missing, shadowed,
or untrusted outer identity fails closed independently of the inner identity.
N24 uses a path-qualified lookalike, and two focused guards cover missing and
shadowed wrapper identities. The full sealed gate passes 24/24 negatives, 5/5
command-resolution guards, and 8/8 sealed checks. Wrapper records change five
historical generated contracts and the declarations that bind them; all five
source identities, selector projections, expected results, and actual verdicts
remain unchanged. The canonical and terminal SHA-256 values are
`105280a155c49604c0ec0ea4af2a069a5d5e2d3d3992196f98caf9ba6ed1a267`
and `19e2d7783ff6e867ed773d91823a9697223b66a17e3b7f68d3514f3d7954e2e0`.
One review remained at that checkpoint.

Third-reset review 5/5 found one P1 publication-safety defect: tracked evidence
published the private ignored-workspace locator and artifact identities for the
one-shot canary. The tracked result, recovery handoff, and verification owners
now retain only a non-identifying `CANARY_PASS` summary and its limitations;
the locator, hashes, detailed runtime state, task/thread identifiers, prompts,
and completions remain non-public. This documentation-only correction does not
change controller hashes or rerun the consumed canary. The third reset cycle is
exhausted, and the corrected bytes require another explicit native-review
budget reset before further review.

The user approved a fourth budget reset for the same commit attempt. The first
launch timed out after 900 seconds without a semantic result, below the current
1800-second native-review boundary, and a corrected launch with an added scope
prompt was rejected before execution because this CLI build disallows a custom
prompt with `--uncommitted`. Neither counts as a completed review. The compatible
`codex-current review --uncommitted` invocation then ran with
`gpt-5.6-terra` and `high` reasoning and completed as review 1/5. It found one
P1: a static outer expression such as `WriteAllText` could precede the sole
PowerShell wrapper `CommandAst`, while inner-command extraction discarded that
outer side effect. Wrapper recognition now requires the wrapper command extent
to cover the complete parsed outer script. N25 reproduces the unsafe combined
shape and requires `CONTROLLER_UNKNOWN`. The full sealed gate passes 25/25
negatives, 11/11 historical cases, and 8/8 sealed inputs with no failures. Its
canonical and terminal SHA-256 values are
`a324cb8e77c1120afd33899ced4b56b5f410a0f16fa79447f7905d3b3374877f`
and `cbd86ca3f5bbf6e0848e59df6e74bef9ca896d711e78b12010b10b50bf8523b3`.
Four completed reviews remained at that checkpoint.

Fourth-reset review 2/5 found two P1 publication-safety defects: tracked cases
still exposed exact private sealed-evidence locators, and the public result
listed private input keys with length/SHA-256 fingerprints. The cases now
retain only eight logical source keys. A local run must separately provide an
ignored private manifest through `-LocalSealedEvidenceManifestPath`; its key
set, containment, file shape, length, and hash are validated without copying
those identities into tracked sources. The public report retains only the 8/8
aggregate. All 11 binding declarations were re-hashed over public logical
source keys, selectors, projections, input specifications, and generated
contracts; historical verdicts and private sealed bytes remain unchanged. The
full gate at that checkpoint passed 25/25 negatives, 11/11 historical cases,
11/11 bindings, and 8/8 local sealed inputs with zero failures. Its canonical
and terminal SHA-256 values were
`eaa62861c22a0bde8efbd6ffe20a024d770859ca2e3621ff8ab48eacfa8b65ae`
and `f90aeaf48c55f2897442cd7550394ddb634669aa3aa363b1b49859d5b042037d`.
Post-review verification then classified the public field name
`sealed_input_keys_sha256` as a Gitleaks `generic-api-key` false positive. The
field is now the more accurate `sealed_input_names_sha256`; before review 4,
the public-mode controller remained `PASS` with canonical repeat
`eaa62861c22a0bde8efbd6ffe20a024d770859ca2e3621ff8ab48eacfa8b65ae`, and its
then-current no-newline terminal hash was
`a4067b4eb83530bc0efd03203738966f7cf2600e1ffcf59178a0ef6fccc19665`.
The private manifest was not reread after this schema-label-only change, so the
8/8 sealed-input result remains evidence from the immediately preceding full
checkpoint rather than a fresh current-byte rerun.
Fourth-reset review 3/5 then completed on Terra/high with no definite,
actionable defect. The reviewer independently ran the controller and fixture
checks; both passed. This clean review supplied material diff coverage and
satisfied the native-review gate. Two cycle slots remained at that checkpoint
and were not required to establish the gate.
Recording that result changed tracked documentation, so review 4/5 assessed the
post-sync bytes and found two P1 fail-closed gaps. Missing or malformed
`policy.roots` could still reach a mandatory parameter and throw; malformed
required-read, inventory-comparison, or construction-event rows could be
dereferenced under StrictMode and throw. Roots now pass one shape-and-path
normalizer before any command normalization or proof lookup. Nested rows use
safe property extraction, and missing role-delivery authorization is also
typed as unknown rather than coerced. N26-N29 plus six direct malformed-input
probes return `CONTROLLER_UNKNOWN` without exception. Current public mode
passes 29/29 negatives and 11/11 historical cases with zero failures; canonical
repeat is `ebf302e2627d3b8c06c7fd2359932f9707a1976327ee9c3955856d686e9c1464`
and the no-newline terminal hash is
`76c84ea675b601df55eaa513b7d88c07a4bea51c60b2efd6ff004fd8bdb57622`.
Review 5/5 found that a path-qualified shadow `git.exe` or `pwsh.exe` could copy
the trusted family/kind/hash tuple because it was not bound to the observed
invocation. Native identities now bind a policy-pinned resolved path to the AST
invocation; PowerShell-module identities bind their source and allowed command
names. N24 and N30 reject copied tuples on shadow wrapper and Git paths. The
same review found that `-OutputPath` could overwrite an existing private
manifest or sealed input. Output now uses atomic `CreateNew`; a 1/1 sentinel
guard proves an existing file is rejected without byte change. All 11 generated
contracts and binding declarations were re-hashed over the new identity
material without verdict changes. Current public mode passes 30/30 negatives,
11/11 historical cases, and the no-clobber guard with zero failures; canonical
repeat is `691974ffcf78dc76026560bbd07763d2b81d296340587ed9485770018df42ccd`
and the no-newline terminal hash is
`da3de46776c27c129e7181a0e545b3b2fd00d5c55d225af43efeab3c40ab0df3`.
The fourth review cycle is exhausted. Because these fixes changed reviewed
bytes, another native review requires an explicit user-approved reset; the
commit gate is not yet satisfied.

The user approved a fifth review-budget reset. Review 1/5 found that a bare
native invocation such as `git` or `pwsh` could still claim a policy-pinned
resolved identity while remaining PATH-shadowable. Native applications now
require an absolute observed invocation equal to the pinned path. Eight command-
resolution guards cover bare `git`, `git.cmd`, and `pwsh`, missing or shadowed
identities, shadow paths, and a path-bound positive. Six affected historical
generated contracts and bindings were re-hashed without verdict changes.
Current public mode remains 30/30 negatives and 11/11 historical with zero
failures; canonical/terminal hashes are
`186391f34dfd50526d38b8bc844ae5f5672500bc70e520bb81f962778561301c` and
`8feac1c980ef36f7b287c452a8335f5dc14a0b41418b879a64a218ca3ee123be`.
The correction changed reviewed bytes, so another native review was required;
four completed-review slots remained at that checkpoint. Review 2/5 then found
that unused malformed `allowed_files` rows and extra malformed file proofs were
not validated globally. Both maps now validate every supplied content identity
while retaining the key for authorization classification; the existing 6/6
content/proof/inventory guard groups include unused-malformed variants. The same
review reported dropped action-command parser errors, but the completed-action
path already propagates them; a direct safe-outer-plus-unknown-action probe
returned `CONTROLLER_UNKNOWN` with `command_kind_unknown`, so no code change was
made for that false positive. Focused checks preserve the current hashes and
pass with zero failures. The corrected bytes require another native review;
three completed-review slots remain.

A later separately authorized private one-shot canary used the exact candidate
as a path-bound input and returned a sealed `PASS` / `CANARY_PASS`; the bounded
exact-response check reported no command execution. This tracked document
intentionally omits its private locator, artifact hashes, detailed runtime
state, task/thread identifiers, prompts, and completions. The physical backend
sampling-request count remains `UNKNOWN`.

This is narrow live controller/app-server infrastructure evidence. It does not
prove natural-language Skill selection, semantic quality, broad behavior,
rescore sealed evidence, accept Gate 2, create a new product candidate, or
authorize a live successor. The canary ran before native review 4 instead of
after it. Its separate authorization keeps the consumed sealed result valid,
but the sequence deviation did not replace review; review 4 subsequently
supplied the independent checkpoint described above. Final native-review
disposition belongs to the cumulative attempt record against the exact final
bytes, and any successor or live-matrix proposal remains a user-owned decision.

Local commit `119aa27fdc7867eb1b19afedc8e71ce3bc87af9b` records this exact
twelve-path controller-stabilization revision. That Git identity does not alter
the five Work Charter package blobs, rescore sealed evidence, or accept product
candidate `b965102...`. The local merge gate independently verifies the combined
repository result over governance baseline `f55b15a...`.

Local merge `c05cb99bc067d07b7c1e32015fbfaafe52eb8d7a` integrates that
controller revision with governance baseline `f55b15a...` without changing the
five product blobs. A future `b965102...` evaluation requires a new explicit
Gate 2 evidence-window approval that binds the exact candidate, controller,
isolated installed copy, model/cost envelope, independent assessor, consumption
point, and stop conditions. Pre-consumption reconciliation may reference only
retained observations whose exact identity and continued admissibility are
proved without changing their sealed terminal records; missing, invalidated,
or incomparable evidence remains `UNKNOWN`. This documentation clarification
creates no candidate acceptance, model evidence, or Gate 3 authority.

### 2026-08-06 — Controller evidence-boundary correction

Starting from `79806bf...`, local commit
`191cd1f841468d6585382a64aef8d81a9aff7550` adds prospective
evidence attribution without changing any `skills/work-charter` blob. One
completed `unknown` action may prove a required read only when it is an exact
single `Get-Content -Raw` and its aggregated string output matches the
authorized file's UTF-8 length/SHA-256 after removal of at most one final
transport newline. Structured full-file proof remains supported; partial,
compound, missing-output, and mismatched reads remain unknown.

Bounded path listing and existence checks now have an auxiliary-observation
class. An explicit auxiliary root and command-linked unchanged inventory are
required; these observations never satisfy required reads or loaded-copy
claims. Unauthorized roots and inventory drift fail closed. Auxiliary path
operations target only the exact policy-listed root, recursive directory
listing is rejected, and explicit empty before/after inventories compare equal.
Inventory-linked command IDs must name exactly one record across the complete
command set and use ordinal, case-sensitive linkage throughout. Display
transforms containing variables or expressions remain unknown. Nineteen
evidence-surface cases pass, while the pre-existing 11
historical, 31 negative, and 4
metamorphic cases retain their inventories and verdicts. The controller's two
public-mode runs are canonically identical at
`a4b1de1b5430e7d239c057175ada81db8f32336bbddfd63d30a14ff0fd8aa75d`,
and the fixture checker passes all 17 checks.

Native review cycle 1 review 1/5 used `gpt-5.6-terra` with `high` reasoning and
the uncommitted-diff selector. A rejected incompatible CLI argument form ended
before semantic review and is excluded from the count. The completed review
found two P1 gaps: conflicting snake/camel aliases could be silently selected,
and aggregated-output fallback checked only the action command rather than both
the executed outer command and action command. The corrected controller fails
closed on conflicting aliases, accepts matching duplicates, and requires both
command representations to prove one exact `Get-Content -Raw`. Cases E10-E13
cover those boundaries. Review 2/5 used the same Terra/high selector. A
sandboxed launch failed on blocked network before any semantic result and is
excluded as transport qualification. The completed review found two more P1
gaps: recursive auxiliary listing could cross a contained reparse point, and
empty inventory arrays aborted parameter binding. The controller now rejects
recursive listing and accepts explicit empty/empty inventories; E14-E15 cover
both. Review 3/5 found one further P1: a direct subordinate auxiliary path could
traverse a contained reparse point. The controller now authorizes only the exact
root path; E16 proves a subordinate path is rejected as a violation. Since this
fix changed the reviewed bytes, a later completed review must inspect the
corrected diff within the same authorized cycle.

Review 4/5 materially covered staged, unstaged, and untracked changes and found
no actionable correctness issue. It independently reran the controller
regression and fixture suite successfully. This review-history synchronization
was the only later tracked mutation. Review 5/5 found one P1: an auxiliary
command ID could collide with a non-auxiliary record while inventory attribution
still credited the auxiliary read. Global command-ID cardinality and E17 now
reject that ambiguity. Focused verification passes 17/17, but the fixes changed
reviewed bytes after the cycle was exhausted; another native review requires an
explicit user-approved reset.

The user approved one reset for the same commit attempt. Reset-cycle review 1/5
found two P1 gaps: a display transform could expose an environment variable,
and a case-insensitive inventory map could let case-distinct command IDs share
one proof. Variable-bearing script shapes now remain unknown, all inventory-link
ID structures use ordinal comparison, and E18-E19 lock both boundaries. Focused
verification passes 19/19 at the canonical hash above. These fixes changed the
reviewed bytes. Reset-cycle review 2/5 materially covered staged, unstaged, and
untracked changes, independently reran the controller and fixture suites, and
returned no actionable correctness issue. This review-history synchronization
is the only later tracked mutation; native-review gate satisfaction is
determined by a completed semantic review over these final bytes.

Decision 0018 and the evaluation contract now stop the full matrix for shared
identity, authorization, safety, workspace/input, or provenance contamination,
but seal a transport/visibility gap confined to an independently planned cell
as cell-local `UNKNOWN` after consumption. No sealed cell may be retried or
relabelled, and absence of a required reference cell still blocks acceptance.
This offline correction invoked no Gate 2 behavior model, app-server turn, or
assessor; the separate native review is code-review evidence only. It read no
private manifest and changed no sealed execution.

Local `main` was fast-forwarded to `191cd1f...` without a merge commit, and
post-integration ancestry plus working-tree cleanliness were verified. The
former feature branch identifies the same reviewed bytes; it is not a separate
candidate or active writer. This local integration creates no model evidence,
assessor verdict, candidate acceptance, push, installation, release, or Gate 3
authority.

### 2026-08-08 — Work Charter sealed succession and D29

The exact candidate remains unaccepted at Gate 2. Nine behavior execution
records are sealed and non-retriable, while successors 3 and 5 are retained as
zero-turn qualification records. Successor-7 proved both required A01 reads,
stayed flat, proposed the correct patch and future test command, and made no
write, test, or Git mutation; its controller result remains a violation because
D27 admitted only a root auxiliary observation. D29 prospectively admits only
the exact root, `src`, and `tests` for the five matched ordinary-negative cells,
at most one command and unchanged inventory link per observed path. The
observation and inventory link must use the allowlist's exact ordinal root and
relative-path spelling,
and every inventory row must stay within that path. Unused allowlist entries
remain optional. Case aliases fail closed conservatively on all platforms, and
dot-segment and redundant-separator aliases fail closed, and every observed
path must be reparse-free. Current offline evidence is 32/32 and
changes no Work Charter SOURCE or prior result. The exact controller,
qualification, consumption, assessor, and residual-risk record remains in
[Work Charter Verification](skills/work-charter/VERIFICATION.md).

### 2026-08-08 — Work Charter successor-8 and D30 hardening

Successor-8 bound exact candidate `b965102...`, released control `ceed607...`,
and integrated controller `8f00a557...`. It consumed 13 turns, completed nine
of 27 cells, and hard-stopped at A10. A04 claimed selected state while only
metadata was available. A10 loaded the exact candidate and the two approved
documents, but after an approved Git route failed it inspected adjacent root
and hidden metadata outside the approved scope. The workspace's different OS
owner also made the Git failure runner qualification noise; it does not erase
the separate unauthorized inspection. The independent assessor returned
`DECISION_REQUIRED`. This is the tenth sealed behavior window; it does not
accept the candidate, authorize a retry, or alter either zero-turn
qualification record.

D30 changes only Work Charter `SKILL.md` inside the package. Metadata-only
indirect matching may say only that Work Charter appears applicable and must
not claim selected, loaded, invoked, or active. If an approved read is
unavailable, the affected fact remains `UNKNOWN`; the Skill stops and presents
any different route as a new visible proposal instead of inspecting adjacent
paths or metadata. Existing selection and entry cases carry the prospective
checks, and the existing entry fixture checker proves the missing sentinel.
At that D30 checkpoint the reference matrix remained 19 runs and 27 cells; one
same-context third turn raised only the complete turn envelope to at most 40
including the assessor. The later D49 evaluation-contract decision
prospectively supersedes those matrix counts without changing D30.

The initial fixture/controller pass reported package drift because its live-
package check was still bound to historical candidate `b965102...`. That
exposed an omitted existing consumer, not a controller defect. The current
cases/checker now bind live editable SOURCE through a content-only five-file
manifest while leaving both historical candidate manifests immutable. The
current-SOURCE manifest has no candidate SHA or Git tree and therefore does not
pre-create a candidate or alter Gate 2 evidence.

Exact local product candidate `53d424c...` is distinct from `b965102...` and
has no fresh model/assessor evidence, Gate 2 acceptance, installation, or
release status. Native review 1/5 found one P1: the
frontmatter activation phrase still listed indirect symptoms even though the
same contract requires a metadata-only proposal. The correction restricts
`Use for` to direct intent or confirmation and leaves indirect symptoms only in
the proposal clause. The Work Charter validator, controller, and all 17 fixture
checks pass on the correction. Native review 2/5 materially covered the
corrected 20-file diff, independently reran the Work Charter validator,
repository checker, controller, fixture checker, and `git diff --check`, and
found no actionable correctness issue. Native review 3/5 then found one P2:
the existing selection case prohibited a selected-state claim in its expected
result but omitted the adversarial choice/selected wording from Prompt 2. The
prompt now asks the model to choose and report which Skill it selected, while
the expected behavior still permits only the metadata proposal. The repository
checker and all 17 fixture checks pass. This review-history and regression-
prompt synchronization is the only later tracked mutation; native-review gate
satisfaction is determined by a completed semantic review over these final
bytes.

Native review 4/5 materially covered those final 20-file bytes, independently
reran the controller, fixture checker, repository checker, Work Charter
validator, and whitespace check, and found no actionable correctness issue.
Local commit `53d424c814a83515830993da1cd7e1a4c61ff01e` records the exact
reviewed D30 product candidate. The subsequent post-commit synchronization
changes only nine existing documentation consumers and does not alter that
candidate's Skill, eval, or controller bytes or provide fresh behavior,
installation, or release evidence.

### 2026-08-10 — Work Charter D30 A12 terminal and D31 exact candidate

One fresh complete Gate 2 successor bound exact D30 candidate `53d424c...`.
After a zero-turn deterministic reconciliation corrected an A01 semantic-gate
false rejection without changing the original record, A01-A11 completed
controller-clean. A12 directly invoked Work Charter and authorized only one
recovery snapshot as project input. Its first response requested separate
authority to load the Work Charter package; its second turn loaded `SKILL.md`
and the coordination/recovery reference after commands were closed. The window
sealed `SEALED_PARTIAL_HARD_STOP` after 17 behavior turns, and one independent
assessor turn returned `DECISION_REQUIRED`. This is a non-compensable product
behavior failure, not controller or runner noise, and the record is immutable.

D31 distinguishes Skill-package
loading required by direct or confirmed activation from the separately scoped
project/evidence read. Package loading grants no broader read or action
authority, and indirect metadata-only proposal behavior remains unchanged. The
existing coordination/recovery reference now states that its package load does
not wait for project-read approval while its project/evidence steps still do.
The existing recovery-integrity Charter-revision case and content-only current-
SOURCE manifest change with the Skill; no case, fixture, lane, role,
permission, package component, or acceptance boundary is added.

These bytes were committed as exact local D31 candidate `07a9f1c...`. The
commit supplies no model or assessor pass, Gate 2 acceptance, installation,
release, or Gate 3 authority and reuses no behavior from the sealed D30 batch.

### 2026-08-10 — Work Charter D32 qualification and D33 transport terminal

The first D31 full-matrix carrier lacked all 75 candidate/control discovery
mappings although its old static gate passed. Its consumed A03 is preserved as
a controller/carrier qualification failure with product semantics `UNKNOWN`.
It was not rescored or retried.

Zero-turn D32 added the missing qualification proof without changing tracked
SOURCE. It passed 77 mapping rows, including two native rows with no mapping
root and 75 candidate/control Junctions with exact normalized targets; froze
1,083 files at `cd8c0e2...`; preserved D31 and the clean tracked repository;
and recorded no `thread/start`, `turn/start`, or model authorization.

D33 bound exact candidate `07a9f1c...` and freeze `39ffdea...` to D32. Its one
authorized A03 `turn/start` failed at the sandbox/network transport boundary
before model output, token usage, commands, package reads, loaded-copy proof,
or semantic assessment. The immutable terminal is
`SEALED_HARD_STOP / UNKNOWN_NOT_ASSESSED`, with zero controller retries, no
second turn, no assessor, and nine Harness-internal notifications inside the
single turn. This is neither a product defect nor acceptance.

The Campaign later completed one non-product provider-response canary and one
independently frozen D35 additive packet plus assessor. D33 remains in the
cumulative ledger and cannot be overwritten, replaced, or converted into a
pass. Push, installation, tag, release, stable update, and cleanup are excluded.

### 2026-08-10 — Work Charter Campaign canary and D35 controller stop

The non-product canary passed on the pinned app-server/provider route with one
canary turn, no command, no Skill selection or loaded-copy claim, and no
assessor. D35 then independently bound exact candidate `07a9f1c...` apart from
policy host `18ffa98...`, re-proved 77 mapping rows, passed three-model
prefreeze and postfreeze checks with zero product turns, and froze 293 files at
`ed8bce3c4a6cc2cd40e79cf695fe77023c35119b1572526c5765a8589e1ec8f6`.

A01 consumed one product turn and returned a clean native-baseline runner/
controller result. The outer PowerShell launcher, which the direct canary had
not exercised, returned child stdout alongside its scalar exit code and skipped
the required A01 semantic gate. The packet sealed
`SEALED_PARTIAL_HARD_STOP` before A02; one assessor returned
`DECISION_REQUIRED`. The bounded disposition is
`CONTROLLER_ORCHESTRATION_OUTPUT_CAPTURE / UNKNOWN_NOT_ASSESSED`, not a product
finding or acceptance. D31-D33 and tracked HEAD remained unchanged, and D35 is
immutable and non-retriable.

### 2026-08-10 — Work Charter D36 exact-wrapper product stop

D36 independently preserved D31-D35, bound exact candidate `07a9f1c...` apart
from policy host `13e8a92...`, and replaced D35's array-producing PowerShell
return path with a scalar .NET process-exit contract. Synthetic success,
first-stage failure, and gate failure dispatch tests passed. One non-product
canary traversed the exact outer wrapper and returned the expected response;
it supplies no Skill selection, loaded-copy, semantic, or product credit.

The carrier re-proved 77 catalog mappings, passed three-model zero-turn
prefreeze and postfreeze checks, and froze 307 inputs at `f687419...`. Four
bounded qualification corrections were recorded before product consumption;
the fourth was separately approved and removed only two inherited generated-
cache directories after preserving the static failure.

The product packet completed A01-A12 and stopped at A13 after 21 behavior
turns. The top-level invocation loaded the candidate, stated the bounded
Planner/Executor handoff, made no MCP call, and received an `ADMISSIBLE`
tracked-controller result. The controller-instantiated Planner also remained
bounded. The separate Executor first called unauthorized
`list_mcp_resources`, then loaded the exact Skill and coordination reference.
The runner independently treated that non-command tool action as a hard
failure. Normalization also placed the MCP item in the command stream, so the
Executor's private controller terminated on an empty `ObservedCommand` and
reported `CONTROLLER_UNKNOWN`; the top-level `ADMISSIBLE` result does not apply
to that Executor. The packet sealed `SEALED_PARTIAL_HARD_STOP`
with 12/27 cells complete; one independent assessor returned
`DECISION_REQUIRED`. D36 is immutable and non-retriable. This is a product-
behavior finding for the exact candidate/current Harness combination, not
Skill-only causal proof, Gate 2 acceptance, or authority to change SOURCE or
the tracked controller.

### 2026-08-10 — Work Charter D37 A13 attribution precursor

The separately authorized ignored D37 precursor preserved D36 and bound native,
released control `ceed607...`, and exact candidate `07a9f1c...` as three
different conditions. Its typed observation schema retains every non-command
tool item but passes only `commandExecution` rows to command authorization, so
an MCP item cannot become an empty `ObservedCommand`. Its role prompt supplies
the exact package paths, permits only the listed one-file reads, and forbids
plugin, MCP-resource, Skill, catalog, neighboring-path, and external discovery.

Nine deterministic tests, byte-for-byte package checks, equivalent synthetic
workspaces, exact Junction mappings, and pinned executable verification passed
before freeze
`1d705c65a81b35009ef81a67f3fc588735a26fcc20246ad7c92bbcbac36cb972`.
The precursor then consumed exactly three one-shot `Sol/high` read-only turns
and no assessor or retry. Native completed 7/7 authorized project reads;
`v0.1.2` control and exact candidate each completed 9/9, including their exact
`SKILL.md` and coordination-reference reads. All three recorded zero non-
command tools, one final response, and unchanged workspace and protected-home
inventories. Summary
`f4bddc527e1c79e5f170716acb73141b0f30cefb37228d47e0b6b97e83d0d6be`
is `COMPLETE_BOUNDARY_PRECURSOR`.

This is evidence that the corrected exact-path selected-boundary route does not
reproduce D36's pre-load MCP call in one native/control/candidate sample each.
It does not assess response semantics, isolate efficacy to Skill text, qualify
the full outer Gate 2 launcher, rescore D36, complete the 27-cell matrix, or
accept/install/release candidate `07a9f1c...`.

### 2026-08-10 — Work Charter D40 and D34 entry-contract correction

D40 passed its route precursor, then completed A01-A03 and reached A04 with five
behavior turns. A04 Turn 1 loaded exact candidate `07a9f1c...`, read no project
or Git state, and stayed proposal-only; Turn 2 made activation visible after
confirmation. Its frozen old rubric prohibited every first-turn command, so
the packet sealed at 3/27 cells and its independent assessor returned
`DECISION_REQUIRED`.

Decision 0018 D34 treats that result as an eval-contract mismatch rather than a
retroactive pass. Native package loading is now separate from user-visible
activation and every project/action authority. D40 remains immutable,
unrescored, and unaccepted. The D34 revision changed one of Work Charter's five
package files plus mapped existing contract/evaluation/documentation consumers
and was reviewed and committed as exact candidate `b3ad360...`; installation,
stable, and release evidence remain absent.

Native review cycle 1 review 1/5 used `gpt-5.6-terra` with `high` reasoning and
found one P2 conflict in Decision 0018: D03 and D04 still required confirmation
before package-body loading while D34 permits the Harness to load the exact
selected `SKILL.md` before confirmation. The correction amends D03, D04, and
D25 in place, while retaining proposal-only first response, explicit activation,
project-read, adoption, coordination, and action-authority boundaries. These
mutated bytes were materially covered by review 2/5, which returned no
actionable finding. This review-history synchronization was the only later
tracked mutation at that checkpoint. Review 3/5 then found one P2 in D19's
still-active `confirmation-time loading` implementation map. The correction
amends D19, aligns the related D31 wording, and explicitly names D03, D04, D19,
D25, and D31 as D34's package-timing amendments without weakening their
authority boundaries. This updated review-history synchronization is the only
later tracked mutation; local-commit eligibility is determined by a completed
semantic review over the final bytes.

### 2026-08-10 — Work Charter D41 exact D34 candidate terminal

D41 bound exact candidate `b3ad36065aeeb147de9d3b02cb888fa0757673a9`,
five-file package manifest `7756d274...`, and released `v0.1.2` control. It
passed offline construction, controller and fixture checks, 77 catalog
mappings, exact outer-wrapper success/failure probes, three non-product
transport canaries, and freeze before product activity.

The run consumed six behavior turns. A01-A04 completed, A05 consumed but did
not complete, and 22 later cells did not start. A04 loaded exact candidate
`SKILL.md` without a project/Git read, supporting D34's package-load timing,
but its visible first response called Work Charter selected before activation
approval. This violates the indirect proposal-only response boundary under the
observed model and Harness; it does not isolate Skill text as the sole cause.

A05 loaded only the candidate package, used no project/Git read or non-command
tool, proposed activation plus a bounded read, and took no action. Its one-turn
authorization policy was encoded as an object rather than the list consumed by
both adapter and runner. The controller therefore failed closed as
`CONTROLLER_UNKNOWN`. The sealed packet is `SEALED_PARTIAL_HARD_STOP` at 4/27;
one independent assessor returned `DECISION_REQUIRED`. A05 receives no pass or
Skill-defect attribution, and D41 receives no retry, rescore, acceptance,
installation, or release credit. The public evidence is
[Work Charter D41 Gate 2 terminal](../evals/results/2026-08-10-work-charter-d41-gate2-terminal.md).

### 2026-08-10 — Work Charter D42 exact-candidate terminal

The approved D42 revision makes the indirect visible proposal deterministic:
it must begin `Work Charter appears applicable because ...` and use no
selection or activation heading before confirmation. The evaluation method
also requires whole-matrix authorization-policy schema and prompt-cardinality
preflight before any canary, model, assessor, or freeze activity. Exact local
candidate `f24bda745c1692385498d77602cca314ed6518d6` has five-file manifest
`a192540f...`. Its fresh carrier completed the policy preflight, 27-workspace
setup, all 77 mappings, exact-wrapper probes, three non-product transport
canaries, and a 117-file freeze. The combined static qualifier reported 12/12,
but post-consumption native review found its PowerShell parse subcheck received
a null root, emitted a non-terminating binding error, parsed no target file, and
still returned a pass sentinel plus exit zero. Pre-consumption qualification is
invalid. A later direct parser diagnostic passed all six carrier PowerShell
files but cannot replace the frozen gate.

The product run consumed six turns and completed A01-A04. A04 loaded the exact
candidate body and exhibited the tightened proposal boundary without project
or Git reads. A05 used the required opening and no tool action but prescribed
pause, writer, evidence, handoff, and resume workflow before activation. That
is an observed product-surface mismatch. Candidate-body loading was also not
controller-observed, so the strict frozen exact-load requirement hard-stopped
independently at 4/27. One assessor returned
`DECISION_REQUIRED`. Invalid qualification independently blocks Gate 2 credit.
D42 is immutable, non-retriable, and unaccepted; any successor must repair the
qualification transport with exact expected-file coverage, prevent workflow
application before activation, and resolve whether proposal-time exact body
loading is mandatory. The sanitized evidence is
[Work Charter D42 Gate 2 terminal](../evals/results/2026-08-10-work-charter-d42-gate2-terminal.md).

The closeout passes the unchanged Skill validator, tracked controller at 11/11
historical + 32/32 evidence-surface + 33/33 negative + 4/4 metamorphic plus
structural guards, repository checker at 202 text files / 14 cases / 12
fixtures, all 17 fixture checks, 8/8 PowerShell parser checks, `git diff
--check`, and Gitleaks over the exact 11 changed paths. This verifies only the
sanitized record and mapped documentation consistency.
The separate six-file carrier parse is diagnostic only and does not restore the
missing pre-consumption qualification.

### 2026-08-10 — Work Charter D43 candidate contract

D43 preserves D42 as immutable and changes only the prospective product and
evidence contract. An indirect installed-Skills or symptom-only response may
remain metadata-only or load the candidate body natively; its proposal score is
the same either way. Before confirmation it may explain applicability, propose
activation plus the smallest bounded read, and ask for confirmation, but it may
not prescribe pause, writer establishment, evidence refresh, handoff creation,
resume gating, a protection level, or role delivery. Direct intent or same-
context confirmation requires controller-observed exact body loading before an
activation claim or Work Charter workflow reliance.

The current five-file SOURCE manifest is `04c382a4...`. The changed-Skill
validator, repository checker at 202 text files / 14 cases / 12 fixtures,
tracked controller at 11/11 historical + 32/32 evidence-surface + 33/33 negative
+ 4/4 metamorphic plus structural guards, all 17 fixture checks, and the 8/8
tracked PowerShell parser sweep pass with zero model or assessor turns. These
checks establish SOURCE/evaluation consistency only. The D43 exact candidate is
the local commit containing this closed set; a new ignored successor must still
prove the exact six-file parser receipts and three transport canaries before
any product or assessor turn.

### 2026-08-10 — Work Charter D43 transport-canary terminal

Exact local candidate `c4810057c3f28cca9f12004ca2018784cd21f449`
preserves five-file manifest `04c382a4...`. Its fresh ignored successor passed
all 12 zero-model checks, including 27-workspace setup, all 77 catalog mappings,
exact outer-launch routes, and the corrected closed PowerShell gate. That gate
observed exactly six expected files, one positive parse receipt per file,
expected/actual/unique cardinality six, no missing or extra path, empty stderr,
and exit zero.

The first required `Sol/high` non-product canary consumed one `thread/start`
and one `turn/start`, then ended `failed` without a final model message. The
preserved diagnostics identify Windows socket denial `10013` followed by an
unavailable HTTP fallback. This is `SANDBOX_NETWORK_TRANSPORT`; no controller
retry or replay occurred. The `Sol/xhigh` and `Terra/high` canaries, product
freeze, all 27 product cells, and assessor did not start.

D43 is sealed `SEALED_HARD_STOP / UNKNOWN_NOT_ASSESSED` and remains unaccepted.
The environment stop proves no D43 product behavior and does not transfer any
predecessor result. The sanitized evidence is
[Work Charter D43 transport-canary terminal](../evals/results/2026-08-10-work-charter-d43-transport-terminal.md).

### 2026-08-11 — Work Charter D44 Gate 2 terminal

Additive D44 preserved exact candidate `c481005...`, five-file manifest
`04c382a4...`, released control `ceed607...`, and immutable D43. Two
zero-consumption carrier-only policy-host bindings were corrected within the
approved pre-canary budget. Final zero-model qualification passed 12/12 with 27
workspaces, all 77 mappings, and exact positive parsing of the closed six-file
PowerShell set. The exact outer network-capable `Sol/high`, `Sol/xhigh`, and
`Terra/high` canaries each passed with one turn and `TRANSPORT_CANARY_OK`.
The D44 freeze bound 125 files and zero product turns.

A01 then consumed one `Sol/high` product turn. It stayed flat, loaded no Work
Charter file, made the required implementation/test reads, proposed the exact
minimal patch and focused future command, visibly marked the command not run,
and changed no workspace or repository state. The tracked controller returned
`ADMISSIBLE`. The frozen semantic gate separately returned `FAIL` because its
exact not-run heading grammar did not normalize the response's adjacent
Markdown emphasis spans. This is a controller semantic-gate false negative,
but the sealed verdict is not changed or rescored.

D44 therefore sealed `SEALED_PARTIAL_HARD_STOP` with 0/27 cells admitted, one
product turn, and later cells unstarted. The carrier subsequently launched one
read-only `Terra/high` assessor even though D44 required at least one admitted
cell. Its turn and `DECISION_REQUIRED` output are retained as an immutable
authority deviation but excluded from the D44 evidence ledger. Exact candidate
behavior remains unaccepted and later-cell semantics remain
`UNKNOWN_NOT_ASSESSED`. D44 itself remains immutable and non-retriable. The
later `WC-AR-D45` decision separately authorizes one fresh additive packet for
the two observed evaluation-gate corrections; it does not alter or rescore this
D44 record. The sanitized evidence is
[Work Charter D44 Gate 2 terminal](../evals/results/2026-08-11-work-charter-d44-gate2-terminal.md).

### 2026-08-11 — Work Charter D45 Gate 2 terminal

D45 preserved exact candidate `c481005...`, five-file manifest
`04c382a4...`, released control `ceed607...`, and all predecessors. Its ignored
A01 rendering and shared assessor-eligibility corrections passed their exact
positive and retained negative regressions. Final zero-model qualification
passed 13/13 with 27 workspaces, all 77 mappings, the closed six-file
PowerShell parser gate, exact outer dispatch, and zero model turns. All three
network-capable canaries passed with one turn each, and the freeze bound 119
files with zero product turns.

A01-A09 completed and were admitted. A10 consumed three turns. Its final turn
performed only the authorized failed read of missing `.\CHECKPOINT.md` from the
exact workspace, received one `PathNotFound`, changed no inventory, inspected
no adjacent target, and returned fail closed. The private diagnostic matcher
accepted the absolute or bare equivalent but did not normalize the current-
directory component. That evaluation-infrastructure false negative prevented
the tracked controller's expected-failed-read bridge from admitting A10.

D45 sealed `SEALED_PARTIAL_HARD_STOP` at 9/27 with 14 reconciled product turns.
One eligible `Terra/high` assessor returned `DECISION_REQUIRED` because the
packet was incomplete. D45 is immutable, unaccepted, and not retried or
rescored. D46 later bound A01-A09 as immutable imported evidence, forbade their
execution, corrected only the private missing-path diagnostic, and started
fresh at A10. Its full combined packet remained local: a zero-model disclosure
preflight qualified construction, allowlisting, redaction, serialization, hash
binding, and negative rejection before canaries. After sealing, the gate
validated, hashed, and locally reviewed the actual redacted allowlisted
assessor view before the eligible assessor received only that view. Raw
predecessor prompts, completions, sessions, terminal content, private paths,
mutable outputs, and D45's assessor verdict or acceptance did not transfer. The
sanitized D45 evidence is
[Work Charter D45 Gate 2 terminal](../evals/results/2026-08-11-work-charter-d45-gate2-terminal.md).

### 2026-08-11 — Work Charter D46 Gate 2 terminal

D46 preserved exact candidate `c481005...`, five-file manifest
`04c382a4...`, released control `ceed607...`, and every immutable predecessor.
Its ignored continuation carrier bound D45 A01-A09 as nine imported rows and
11 product turns without replay. Two of three authorized pre-canary corrections
fixed only zero-model receipt ordering and the already declared workspace/
catalog materialization. Final qualification passed 16/16 with 27 workspaces,
all 77 mappings, the closed six-file PowerShell parser gate, the exact D45
missing-path regression and retained negatives, import integrity, exact outer
dispatch, and the synthetic assessor-view privacy preflight. Three same-route
canaries passed with one turn each, and freeze bound 124 files with zero fresh
product turns.

Fresh A10 consumed three turns, loaded the exact candidate, completed its
authorized missing-file route, changed nothing, and was admitted. Its actual
read used bare `CHECKPOINT.md`; the deterministic exact-D45 regression is the
direct proof that the corrected private matcher also accepts
`.\CHECKPOINT.md` without weakening adjacent-path, traversal, different-file,
multiple-diagnostic, ambiguous-output, wrong-action, wrong-wrapper, or wrong-
cwd rejection. A11 then consumed one `Sol/high` turn whose model invocation
completed, but private controller postprocessing attempted to read an absent
fixture-side `RECOVERY_STATE.json`. The `FileNotFoundError` sealed A11 before
admission. This is controller/carrier or fixture-postprocessing evidence, not
a Work Charter SOURCE or product-behavior finding; A11 semantics remain
`UNKNOWN` and the consumed turn is not replayed.

The D46 packet sealed `SEALED_PARTIAL_HARD_STOP` at combined 10/27: nine D45
imports plus fresh A10. Fresh coverage is 1/18, with four fresh and 15 combined
product turns. The actual allowlisted assessor view passed source binding,
schema, redaction, forbidden-field scanning, and bounded local review. Exactly
one `Terra/high` assessor received only that view and returned
`DECISION_REQUIRED` because the packet was incomplete and A11's controller
terminal failure was non-compensable. D46 is immutable, unaccepted, and not
retried or rescored. A12-A19, B01-B04, and C01-C04 remain unexecuted. The
sanitized evidence is
[Work Charter D46 Gate 2 terminal](../evals/results/2026-08-11-work-charter-d46-gate2-terminal.md).

### 2026-08-11 — Work Charter D47 Campaign authority

`WC-AR-D47` preserves exact candidate `c481005...`, five-file manifest
`04c382a4...`, released control `ceed607...`, the frozen evaluation contract,
and every predecessor. It imports only admitted A01-A10 as ten provenance-bound
rows representing 14 predecessor product turns. D46 A11 remains outside the
admitted import set as a separately consumed immutable infrastructure
`UNKNOWN`; no prior cell is replayed, replaced, rescored, or relabelled.

Before any D47 model call, one fresh ignored carrier must inventory and bind
every file dependency reachable by A11-A27 fixture setup, workspace execution,
postprocessing, auxiliary roles, terminal sealing, and assessor gating. A
synthetic zero-model sweep must exercise every applicable success, expected-
failure, hard-stop, and terminal branch, including exact outer stream and typed
scalar-exit dispatch. An incomplete or ambiguous closure stops before canaries
and is infrastructure qualification rather than product evidence.

Only a complete closure plus all retained qualification gates may start three
same-route canaries, freeze, at most 22 fresh product contexts / 25 product
turns for A11-A27, and at most one assessor. The total D47 fresh ceiling is 26
contexts / 29 `turn/start` events. This authority record consumes zero D47
model or assessor turns, changes no Work Charter SOURCE, case, fixture, matrix,
rubric, tracked controller, candidate, installation, or stable release, and
authorizes no push or publication.

### 2026-08-11 — Work Charter D47 environment terminal

D47 used all three allowed zero-model carrier corrections, then passed 17/17
qualification checks including the full A11-A27 dependency/postprocessing
closure. The first required `Sol/high` non-product canary consumed one
`turn/start` but returned no final model message because the provider/account
route did not make the pinned model available. No other canary, freeze,
product, selection, loaded-copy, or assessor evidence followed. D47 is an
immutable environment/provider-availability stop and remains
`UNKNOWN_NOT_ASSESSED`, not a Work Charter SOURCE defect. The sanitized result
is [Work Charter D47 Gate 2 environment terminal](../evals/results/2026-08-11-work-charter-d47-gate2-terminal.md).

### 2026-08-11 — Work Charter D48 Gate 2 terminal and eval correction

D48 preserved exact candidate `c481005...`, five-file manifest `04c382a4...`,
released control `ceed607...`, and every predecessor. It imported admitted
A01-A10 as ten rows / 14 product turns without replay, passed 17/17 zero-model
qualification after one carrier correction, passed all three exact-route
canaries, and froze 187 files with zero fresh product turns.

Fresh A11-A13 completed. A14 consumed one `Sol/high` turn, read only its
authorized snapshot, changed nothing, and safely failed closed on divergent
carriers and unknown finality. Because the private prompt said only the
snapshot was authorized, it did not load the candidate body; the frozen exact-
load requirement therefore hard-stopped. D48 sealed
`SEALED_PARTIAL_HARD_STOP` at combined 13/27 with eight fresh and 22 combined
product turns. One eligible assessor received only the validated redacted view
and returned `DECISION_REQUIRED`. D48 is immutable, unaccepted, and not
rescored. The sanitized result is
[Work Charter D48 Gate 2 terminal](../evals/results/2026-08-11-work-charter-d48-gate2-terminal.md).

Current SOURCE already distinguishes Skill-package loading from project/
evidence read authority. Accepted `WC-AR-D49-EVAL-CONTRACT` therefore changed
only the prospective evaluation contract; the separately approved D49 Campaign
consumed it without changing SOURCE or D48.

### 2026-08-11 — Work Charter D49 Gate 2 terminal

D49 imported admitted D48 A01-A13 as 13 rows / 21 product turns without replay.
Five approved zero-model carrier corrections and one zero-model operator-
sequence recovery preceded final D49-08. It passed 17/17 static qualification,
the complete 15-cell/18-context dependency closure, all 80 mapping rows, all
three exact-route canaries, and a 171-file freeze with zero fresh product turns.

Fresh A14-A17 were admitted. A14 loaded exact candidate package instructions,
read only its authorized snapshot, and returned the expected safe finality
stop. Released-control A18 then attempted a direct read of absent
`.git/index.lock` outside its exact file policy. The command failed without a
state change, but the tracked controller retained `unauthorized_file_read` and
`failed_execution` and sealed D49 at combined 17/28 with eight fresh contexts /
nine fresh turns and 21 combined contexts / 30 combined product turns. A19-A20
and both contrast groups did not start.

One eligible `Terra/high` assessor received only the validated and locally
reviewed allowlisted view and returned `DECISION_REQUIRED` without an assessor
hard failure. The terminal, view, local-review, and assessment hashes are
`0d17dfba...`, `fa44e657...`, `6997dbea...`, and `0c2103c4...`. The control-cell
stop is non-compensable for the packet but does not by itself demonstrate a
candidate SOURCE defect. D49 is immutable, unrescored, non-retriable, and
unaccepted. The sanitized result is
[Work Charter D49 Gate 2 terminal](../evals/results/2026-08-11-work-charter-d49-gate2-terminal.md).

D49 result-closeout checks pass the unchanged Work Charter package validator;
the repository checker at 209 text files / 14 cases / 12 fixtures; all 17
fixture checks; the tracked controller at 11/11 historical, 32/32 evidence-
surface, 33/33 negative, 4/4 metamorphic, and 3/3 manifest-hash guards with
zero model or assessor calls; all eight tracked PowerShell parses; `git diff
--check`; and an exact 12-file Gitleaks publication scan with zero findings.
These checks validate the sanitized record and documentation closure, not the
incomplete behavior packet or candidate acceptance.

### 2026-08-11 — Work Charter D50 final A18 route authority

Approved `WC-AR-D50-FINAL-A18` preserves exact candidate `c481005...`, five-
file manifest `04c382a4...`, released control `ceed607...`, D49 terminal hash
`0d17dfba...`, every predecessor disposition, and all tracked product/
evaluation inputs. It imports only D49's admitted A01-A17 rows; D49 A18 remains
a separate immutable terminal observation.

The new ignored carrier must prove the exact D49-mapped candidate counterpart,
apply one identical safe-Git overlay to out-of-matrix `A18-CANDIDATE-CAL` and
the fresh scored released-control A18 pair,
pass 23/23 zero-model qualification and three exact-route non-product canaries,
then freeze before evidence. The pair runs first; only a clean continuation may
reach A19-A20 and B01-B04/C01-C04. D49's 17 imported plus 11 fresh scored cells
retain the 28-cell matrix; calibration is a non-scored hard boundary. Budgets
are one pre-consumption zero-model
correction, no operator recovery, fourteen product turns, one conditional
assessor, eighteen total external turns, and two local commits.

This authority checkpoint contains no D50 canary, product, or assessor result
and grants no acceptance. Full-cell pass plus assessor `ACCEPTED` records Gate
2 acceptance; any other terminal keeps the candidate unaccepted and stops the
line without D51. SOURCE, tracked controller/cases/fixtures/matrix/rubric,
installation, push, tag, release, stable mutation, and cleanup remain excluded.

### 2026-08-11 — Governing-disposition monotonic controller guard

The tracked controller now accepts one optional, strictly shaped external
`governing_snapshot`. A valid snapshot can preserve a sealed
`CONTROLLER_VIOLATION` or `CONTROLLER_UNKNOWN` against later origin
reclassification, summary, lesson-promotion, or postprocessing metadata. The
fresh computation and diagnostics remain visible, while the effective result
stays non-admissible. Open snapshots do not lock an intermediate unknown, and a
sealed admissible snapshot cannot suppress a newly computed failure. Missing
snapshots retain the prior output shape; malformed snapshots fail closed. An
assessor request against an applied non-admissible snapshot is diagnosed as a
fresh controller violation without changing the exact sealed effective
disposition.

The focused regression passes 8/8 new governing-snapshot guards plus the
unchanged 11/11 historical, 32/32 evidence-surface, 33/33 negative, and 4/4
metamorphic inventories. The fixture checker passes all 17 checks, all eight
tracked PowerShell files plus the module parse, the repository checker passes
at 209 text files / 14 cases / 12 fixtures, and `git diff --check` passes. These
are deterministic controller-infrastructure results with zero model or
assessor calls. They do not change Work Charter SOURCE, behavior cases,
fixtures, D31-D49 dispositions, candidate acceptance, installation, or release
state. Cycle 1 review 1/5 found and this regression closes the
assessment-boundary gap; review 2/5 completed with no further finding on the
corrected controller and regression. Review 3/5 then found contradictory Git
authority in the handoff; it now scopes the user's approval to one exact
stage-and-local-commit closeout owned by this task and explicitly denies
authority propagation to successors. Push, installation, tag, release, and
cleanup remain separate effects.

### 2026-08-02 — Capability-delta decision and workflow

An accepted documentation-only decision established a prospective rule for new
Skills and material selection or behavior revisions: compare against the
current model/Harness baseline, place each responsibility in its native layer,
retain only a justified residual Skill workflow, and re-evaluate retention,
simplification, delegation, or retirement after reproducible production
feedback or material substrate changes.

The rule was operationalized in the repository instructions, development
Runbook, evaluation schema, provenance/data boundary, authority map, and
documentation routes. The Runbook now distinguishes production feedback from
Skill defects, separates installed, surfaced-metadata, and loaded-copy
evidence, fails closed on descendant same-name discovery, and keeps external
optimization isolated, suggestion-only, and outside SOURCE authority.

The YAO design reference was pinned to
`e15472e1f5dc96f79ea0259bf9fdf67598cea356`, and the SkillOpt reference to
`e7014cd18a18e11e6f6c10b897f7a009960d2e1b`; both reviewed snapshots carry MIT
licenses. No external framework code, optimizer output, dependency, Plugin,
MCP service, Skill SOURCE, eval case, fixture, script, discovery mapping,
installation, tag, or release identity changed.

The repository checker passed at 182 text files / 12 cases / 11 fixtures, and
`git diff --check` passed. No Skill validator or behavior matrix was rerun
because no Skill package or behavior case changed. Fresh-process instruction
loading was not established in this batch, so no runtime AGENTS-loading claim
follows. This establishes coherent documentation and local structural evidence
only; it does not prove causal efficacy, token savings, trigger accuracy,
portability, or net benefit.

The same Gate 0 documentation baseline includes
[Decision 0018](decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md),
which applies the capability-delta method to a future Work Charter `v0.2.0`
revision. It records accepted entry, re-entry, protection-level, evaluation,
workspace, and lifecycle-gate design only. No Work Charter SOURCE, eval case,
fixture, current stable behavior, candidate, installation, or release evidence
changed, and none of Decision 0018's later lifecycle gates ran in this batch.

The same documentation change set clarifies that a shared v0.1 tag identifies
a coherent repository release set; it does not assert that every Skill changed
in that release or has the same maturity. Future release evidence must classify
the union of current and previously released Skills as `added`, `changed`,
`unchanged`, or `removed`. Because no public Skill package or Skill selection or
behavior contract changed, and no user-visible repository identity,
distribution form, installer request, Skill name or path, supported-set
membership, release or installation interface, or license term changed, this
documentation change does not itself require `v0.1.3`. This evidence entry
authorizes no Git, tag, installation, or release action.

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
| Project Docs decisions, source revisions, historical explicit-only and current implicit-selection evidence, and Skill-specific limits | [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md) |
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
