# Project Docs Verification

Last updated: 2026-08-01

## Claim Ledger

| Claim | Status |
|---|---|
| The current package has six canonical files | verified structurally |
| The five logical responsibilities work without fixed filenames | passed in mature, adoption, continuity, conflict, and safety fixtures |
| Explicit-only selection is enforced | controlled DEV_DISCOVERY positive and negative canaries pass |
| A sufficient mature layout is preserved | explicit SOURCE, RC, and stable `NOOP` smoke pass |
| Authorized first adoption makes the minimum coherent change | exact-source synthetic behavior passes |
| Broken authority or structure fails closed | conflict, safety, and broken-routing variants pass |
| Reader/session/writer distinction and coherent recovery snapshot | current-SOURCE continuity correction passes; writer rechecked before write and exact recovery target preserved |
| Current/history/index/authorization and immutable-history audit | current-SOURCE conflict and safety runs pass |
| Candidate and stable loaded-copy identity | exact-commit shared RC and tag-pinned `v0.1.1` entry pass |
| Stable mutation, broad trigger telemetry, causal efficacy, token savings, or cross-Harness parity | unverified |

## Current SOURCE Identity

The official-manual-aligned six-file SOURCE was decoded as strict UTF-8,
normalized to LF with one final newline, and hashed with SHA-256:

```text
SKILL.md
  cc536a35c7bbba6f293193849b98db85923de8fe0d73c106feed405bfc4b448b
agents/openai.yaml
  50fa3c3799caeca29ec6ba10151bd7c58e3c85d4e86d86b38ae9632306e31b17
references/audit-and-adopt.md
  b4af599f3838868db9479a6321a1f1aa82a8ff29cc492afa15b7e5de26078321
references/maintain-and-recover.md
  5c774b699d832ce0f52f68e6ef0b355d9ca79bc6c3407064276bf3638c5fb9ba
assets/templates/project-doc-starter.md
  d5d70f3c2b3422f51be420658bfe2198992ad95daaeac0aa28e5f1e4fe61ec8a
assets/templates/continuity-anchor.md
  258578585c4a9c69379afdfa9a872b41233885a11c6342a7458c7677aeb68ec5
```

These exact hashes are contained in current public
`d7812408fc55a3fad79ae02a8d31665a2255b99c`. The immutable `v0.1.1`
stable copy predates the recovery-coherence hardening.

## Recovery-Coherence Hardening

Three fresh medium-reasoning contexts exercised the existing continuity,
conflict, and safety surfaces against the then-dirty canonical SOURCE at the
exact hashes above:

| Scenario | Outcome | Continuity | Target effect |
|---|---|---|---|
| Routine continuity correction | `UPDATE` | `strong` | only the existing state owner changed; writer was rechecked; frozen history and `PROJECT_STATE.md#next-action-and-recovery` were preserved |
| Authority and recovery conflict | `PROPOSE` | `weak` | zero manifest delta; current evidence owner and unique recovery entry remained unresolved; existing dirty work was preserved |
| Read-only safety audit | `REPORT` | `weak` | zero manifest delta; nearest scope, generated source, unavailable external owner, language, active writer, and immutable history remained bounded |

The first continuity attempt changed the recovery target while claiming the
route was unchanged; an independent assessor returned `CORRECTION_REQUIRED`.
The reference, fixture, and deterministic check were tightened, and a fresh
correction run preserved the exact target. That later SOURCE change invalidated
the first conflict run's reference identity, so a fresh current-SOURCE
conflict run replaced it. Both excluded attempts remain recorded rather than
being rewritten as passing evidence.

The final independent assessor read the contract, current six-file SOURCE,
raw artifacts, complete manifests, deterministic checks, and excluded-attempt
boundaries, independently recomputed the identities, and returned `ACCEPTED`.
The [sanitized result](../../../evals/results/2026-07-31-project-docs-recovery-coherence-hardening.md)
owns the detailed scope and limits.

These runs are historical dirty-SOURCE-assisted development behavior. Their
exact hashes were later committed and are now public at `d781240...`; that
current Git identity does not upgrade the runs to native selection, a loaded
current copy, `DEV_DISCOVERY`, a new exact-commit candidate, stable behavior,
broad telemetry, or real-project efficacy.

## Development Behavior History

### 2026-07-30 — Official-manual alignment

Five fresh explicit groups returned:

| Group | Outcome | Continuity | Mutation |
|---|---|---|---|
| Mature layout | `NOOP` | strong | none |
| First adoption | `UPDATE` | strong | one combined owner plus existing instruction route |
| Explicit continuity | `UPDATE` | strong | existing state owner only |
| Authority conflict | `PROPOSE` | weak | none; inherited dirty state preserved |
| Safety boundaries | `REPORT` | weak | none |

A persistence-only broken-routing variant returned `STOP`, made no change,
requested explicit `$manage-project-docs` invocation, and did not treat the
route as invocation or structural authorization.

Two controlled native canaries then proved the sole development-discovery copy:
the positive explicit run loaded canonical SOURCE and matched all six hashes;
the ordinary negative run did not receive or read the full Skill body. This is
DEV_DISCOVERY evidence, not broad telemetry, RC, stable, or release proof.
Detailed evidence and cleanup boundaries are in the
[official-alignment result](../../../evals/results/2026-07-30-project-docs-official-manual-alignment.md).

### 2026-07-29 — Current-source rerun before alignment

Five fresh medium-reasoning contexts exercised the same behavior groups at the
following superseded normalized identities:

```text
SKILL.md
  b8e56368a6d135b612820ed2771d7c6637a48dfd3a5f96390c5df5e80d774df0
agents/openai.yaml
  50fa3c3799caeca29ec6ba10151bd7c58e3c85d4e86d86b38ae9632306e31b17
references/audit-and-adopt.md
  6e4eb3d22dd1bb07bb6540e8e2784c4b4a84e5271dabf5a5039e8d87031e1927
references/maintain-and-recover.md
  228c56a7a52b3321d718b50b52012acdb9e81f58649e46d93d3a5d1b1a100c8a
assets/templates/project-doc-starter.md
  d5d70f3c2b3422f51be420658bfe2198992ad95daaeac0aa28e5f1e4fe61ec8a
assets/templates/continuity-anchor.md
  8742efac0c84f6e6997601cbc29b73da47f492ea73a822632f61bfd37fbb0329
```

All groups conformed, complete manifests included ignored caches, synthetic
HEAD/index values remained unchanged, and the task-specific run root was
removed without touching older roots. The verdict was
`READY_FOR_REPOSITORY_CANDIDATE_INCLUSION` for those exact hashes. Later
alignment superseded them as current evidence. The
[M1R result](../../../evals/results/2026-07-29-project-docs-m1r-forward-tests.md)
also preserves the earlier `EEDAC9...` entry identity and its source
corrections; it is historical rather than current acceptance.

## Candidate And Stable Evidence

At shared public candidate
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`, an isolated materialized
six-file `RC_INSTALL` matched SOURCE and commit blobs, decoded as strict UTF-8
without BOM, was the only same-named candidate in scope, and returned explicit
standalone mature-project `NOOP`. An ordinary routing question did not load the
Skill. Failed preflights involving candidate-only discovery, prompt transport,
standalone isolation, or semantic completion were excluded.

The coherent `v0.1.1` candidate
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42` repeated exact-commit file and
loaded-copy proof. Immutable tag `v0.1.1` resolved to that commit, and the
tag-pinned stable entry returned explicit `NOOP` in a fresh read-only process.
The earlier immutable `v0.1.0` tag remains valid installation evidence but not
the coherent public-release identity because its embedded README predates
publication.

Repository-level multi-Skill candidate, tag, installation, and release evidence
is owned by [root Verification](../../VERIFICATION.md).

## Required Checks

For any Project Docs change:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/manage-project-docs
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
PowerShell parser check across evals/**/*.ps1
git diff --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

Behavior changes require fresh explicit contexts and exact loaded-copy
attribution. SOURCE-assisted, DEV_DISCOVERY, RC_INSTALL, and STABLE_INSTALL
claims must remain distinct.
