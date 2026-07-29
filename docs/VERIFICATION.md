# Verification

Last updated: 2026-07-29

## Required Checks

| Check | Purpose | Current Result |
|---|---|---|
| Bundled skill validator | Validate frontmatter and directory naming | pass for all three public Skills, 2026-07-29 |
| Scaffolding-marker scan | Ensure operative files contain no generated placeholder markers | pass, 2026-07-27 |
| Repository checker | Check links, strict UTF-8, BOM, trailing whitespace, scaffolding, direct references, exact public Skill/package shape, exact eval sets, and publication patterns | pass across 139 text files, eleven cases, and ten fixtures after Project Docs current-source evidence sync, 2026-07-29 |
| Fixture preconditions | Confirm all ten synthetic repositories start in the intended state, including Project Docs M1R, isolated Git/manifest inspection, reparse-point containment, cold-resume drift, the shared Work Charter loop, and the Standard boundary | pass for fourteen precondition checks, 2026-07-29 |
| Direct-reference check | Ensure every reference is linked from its skill entry | pass for all Skills, including three revised PowerShell references, 2026-07-28 |
| Publication-safety scan | Detect private paths, IDs, credentials, and copied host data | configured repository patterns pass, 2026-07-28 |
| Gitleaks directory scan | Detect secret-like content independently | pass after Project Docs current-source evidence sync, no leaks found, 2026-07-29 |
| Native Codex candidate-diff review | Inspect the complete first candidate baseline beyond deterministic checks | cycle 1 used five reviews and found one P1 plus seven P2 issues; after the user-approved reset, cycle 2 review one found the ninth P2, review two was clean but could not certify later concurrent M1R/M2R changes, review three found the tenth P2, and review four found an eleventh P2 in reparse-point containment; all eleven findings are corrected and the latest fix requires a later clean review before commit, 2026-07-29 |
| Fresh-context forward tests | Observe actual skill behavior | original baseline and revised PowerShell results retained; five Project Docs M1R explicit scenarios passed against current exact SOURCE; Work Charter M2R five SOURCE-assisted groups plus two controlled negative variants were independently accepted for their recorded hashes, 2026-07-29 |
| Revised Project Docs contract | Prove the accepted minimum responsibilities, trigger surfaces, continuity, authorization, and safety boundaries | current exact-hash SOURCE-assisted matrix passed all five explicit scenarios; persistence-only continuity remains separately unattributed; explicit-only native selection, candidate, and release proof remain absent |
| Revised Work Charter contract | Prove the accepted identity, proposal-only boundary, proportional coordination, compact recovery, assessment, correction, and Standard behavior | independent Planner accepted the exact-hash SOURCE-assisted matrix; separate P/E and O/P/E role delivery was observed in the evaluation environment; native implicit selection and loaded-copy proof remain absent |
| Recovery and selection boundary | Check recovery drift and flat-task selection behavior | pass for one recovery run and one catalog-assisted smoke; native trigger telemetry unverified, 2026-07-27 |
| PowerShell runtime probe | Validate the documented read-only 5.1-to-`pwsh` discovery and launch shape | pass on one development host with `pwsh` present; absent/install branches not exercised, 2026-07-28 |
| Source/install identity | Prove canonical source, actual loaded copy, exact candidate commit with clean candidate source, and stable tag mapping | lifecycle specified; no development mapping, RC install, or stable install exercised |
| Distribution contract | Confirm a supported v0.1 source, version, per-Skill path, and installer interface | `matsuri1987/eddie-skills`, immutable tag, per-Skill paths, and `$skill-installer` prompts accepted; Work Charter SOURCE exists, but remote, tag, and installation behavior do not |
| Git publication preflight | Check writer identity, intended source scope, derived-file exclusions, candidate identity, and remotes | publication-safe local identity revalidated without publishing account data; no candidate exists while `HEAD` is unresolved; derived paths excluded and no remote exists, 2026-07-28 |

## Claim Ledger

| Claim | Status |
|---|---|
| Three current source packages exist | verified structurally; `work-charter` is the sole current Work Charter package and the superseded `manage-large-tasks` path is retired without an alias |
| Earlier Project Docs templates and workflow exist | verified structurally; passed one synthetic explicit behavior test for the superseded baseline |
| Revised Project Docs progressive-governance contract works | passed five explicit synthetic behavior scenarios against the current six-file development SOURCE; historical persistence-only continuity remains separately unattributed; explicit-only native selection is unproved; not release-pinned |
| Historical Large Tasks kept one small task flat | passed one explicit M2 behavior test and one catalog-assisted selection smoke; this does not prove current Work Charter native selection |
| PowerShell applies explicit command-boundary checks | revised scope produced three synthetic behavior passes and one partial WSL result; not release-pinned |
| PowerShell runtime readiness detects and launches an existing `pwsh` | command shape passed on one development host |
| PowerShell conditionally recommends 7 without unauthorized installation | passed one synthetic answer-level recommendation/stop scenario; actual installation and post-install verification untested |
| Cold recovery stops on material workspace drift | passed one synthetic combined-skill behavior test |
| Development, candidate, stable-install, and release identities are separated | specified in the accepted lifecycle and runbook; operational isolation unverified |
| Public v0.1 license | root MIT `LICENSE` materialized with user-confirmed public attribution; exact header, standard clauses, repository checks, and Gitleaks pass |
| v0.1 has a defined distribution form | verified as an accepted design: `matsuri1987/eddie-skills`, repository tag, per-Skill paths, `$skill-installer`, and pre-tag candidate visibility; Plugin deferred |
| Each public Skill is an independent product and composition is optional | accepted project design; source packages are structurally separate, but standalone real-world adoption and composed-recipe behavior are unverified |
| Work Charter is the unified product, contract, and `work-charter` package identity | accepted design, structurally implemented SOURCE, and independently accepted exact-hash SOURCE-assisted matrix; loaded-copy identity unverified |
| Work Charter uses proportional symptom-based activation and internal coordination/readiness diagnostics | SOURCE-assisted small-task, midstream, correction, and controlled-negative behavior passed; native selection unverified |
| Work Charter uses durable cold/recovery orientation and compact warm handoff | SOURCE-assisted recovery drift and same-session correction routing passed; token effect unmeasured |
| Standard O/P/E is formally supported under an approved Work Charter standing policy | separate O/P/E complete path passed in the evaluation environment; native role delivery and independent real-project behavior unverified |
| A supported public skill-package installation path works | unverified; release blocker |
| The package improves task correctness | unverified |
| The package saves tokens | unverified |
| The package works across Harnesses | unverified |
| SHICE has evaluated this package | not evaluated |

## Evaluation Cases

- [Mature Project Docs need no change](../evals/cases/project-docs-mature-noop.md).
- [Minimal Project Docs adoption](../evals/cases/project-docs-adopt.md).
- [Project Docs continuity update](../evals/cases/project-docs-continuity.md).
- [Project Docs authority conflict](../evals/cases/project-docs-conflict.md).
- [Project Docs safety boundaries](../evals/cases/project-docs-safety-boundaries.md).
- [Small task that must remain flat](../evals/cases/small-task-stays-flat.md).
- [Work Charter cold resume with owned dirty state](../evals/cases/cold-resume.md).
- [Work Charter midstream proposal](../evals/cases/work-charter-midstream.md).
- [Work Charter Planner/Executor loop](../evals/cases/work-charter-planner-executor.md).
- [Work Charter Standard O/P/E](../evals/cases/work-charter-standard.md).
- [PowerShell encoding and native-exit trap](../evals/cases/powershell-boundary.md).

The five Project Docs M1R cases have passing development behavior evidence for
the current six-file hashes recorded in the sanitized result. They cover mature
`NOOP`, authorized minimal adoption, explicit maintenance, conflict handling
without unauthorized structural writes, and no-write, concurrent-writer,
generated, external, monorepo, and language boundaries. The historical
persistence-only continuity result remains separately unattributed to Project
Docs. Event-driven expansion is exercised by the conflict proposal and must
gain a separately authorized mutation variant before release.

Development behavior tests must prove the actual `SOURCE` or authorized
`DEV_DISCOVERY` copy. Later candidate tests must repeat required cases against
an isolated `RC_INSTALL`; a same-named installed or cached copy cannot be
attributed to working-tree source.

The five Work Charter behavior groups have current public cases and passing
SOURCE-assisted results for the exact hashes recorded in the sanitized report.
They cover small-task flat behavior, midstream proposal-only behavior,
standalone cold recovery, Planner/Executor assessment and correction, and
Standard O/P/E. Two controlled variants also cover stricter standing-policy
selection and unavailable or uncertain role delivery. This does not prove
native implicit selection, loaded-copy identity, or real-Harness outage
behavior.

## Candidate And Release Evidence Template

Use this record for a material development run, release candidate, or release.
Public evidence must use logical locators rather than private absolute paths.

```text
Evidence level: DEV | RC | RELEASE
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

## Evidence Log

### 2026-07-29 — Project Docs M1R current-SOURCE rerun

Five new `gpt-5.6-sol` contexts at medium reasoning independently exercised
the mature, adoption, explicit-continuity, authority-conflict, and
safety-boundary cases. Each context read the required canonical SOURCE
directly, independently normalized strict UTF-8 text to LF for identity, and
reproduced all six package hashes:

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

The current exact-source matrix passed:

- mature layout: `NOOP`, `strong`, no durable or governance delta;
- first adoption: `UPDATE`, `strong`, one combined `PROJECT.md` added and the
  existing `AGENTS.md` route updated;
- explicit continuity: `UPDATE`, `strong`, only the existing
  `PROJECT_STATE.md` durable owner updated;
- authority conflict: `PROPOSE`, `weak`, no durable run delta and pre-existing
  dirty state preserved; and
- safety boundaries: `REPORT`, `weak`, strict zero manifest delta.

Complete before/after manifests in the
[sanitized result](../evals/results/2026-07-29-project-docs-m1r-forward-tests.md)
include every ignored Python cache generated by the four focused-test runs.
All five synthetic `HEAD` and index identities remained unchanged. The unique
task-specific ignored run root was verified under `.eval-runs`, removed after
evidence capture, and verified absent; both older run roots remained.

Final checks passed:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/manage-project-docs
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
PowerShell parser check across evals/**/*.ps1
git diff --check
git diff --cached --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The validator returned `Skill is valid!`; the repository checker covered 139
text files, eleven cases, and ten fixtures; all thirteen fixture preconditions
and all five PowerShell parses passed; both whitespace checks passed; and
Gitleaks found no leaks. The canonical package still contained exactly six
files at the recorded hashes. The inherited repository index remained 90
entries with normalized listing SHA-256
`f1a9a5b2f0fcca81449640e1e11782861b51590a6267917cd8d18098ff5a5801`;
the pre/post staged boundary remained 90 staged, 41 unstaged, and 29 untracked
status entries.

No canonical Project Docs SOURCE correction was required. Verdict:
`READY_FOR_REPOSITORY_CANDIDATE_INCLUSION` for current exact-hash
SOURCE-assisted development behavior. This does not establish native
explicit-only selection, trigger telemetry, loaded-copy identity,
`RC_INSTALL`, candidate, stable installation, or release evidence.

### 2026-07-29 — Work Charter M2R independent acceptance

An independent Planner recomputed all five normalized UTF-8/LF SOURCE hashes
and matched the report manifest. It also confirmed the Work Charter validator,
metadata assertion, repository checker at 139 text files / eleven cases / ten
fixtures, all thirteen fixture checks, PowerShell parser, both Git whitespace
checks, and Gitleaks. The five behavior groups, two controlled negative
variants, and separate P/E and O/P/E topologies were accepted without another
product correction.

Verdict: `ACCEPTED` for M2R SOURCE-assisted development behavior at the exact
recorded hashes. This does not establish native selection, trigger telemetry,
loaded-copy identity, `RC_INSTALL`, candidate, or release evidence.

### 2026-07-29 — Work Charter M2R Tranche 2 SOURCE-assisted matrix

The
[sanitized result](../evals/results/2026-07-29-work-charter-m2r-forward-tests.md)
records five conforming behavior groups and two controlled negative variants.
Fresh roles explicitly read canonical SOURCE and independently reproduced the
controller's normalized UTF-8/LF hashes. Separate P/E and O/P/E topologies
used the accepted model/reasoning settings, one writer, one bounded correction,
same-session reassessment, independent Planner verdicts, and a dormant
Orchestrator during Standard implementation.

Controller manifests found only the intended isolated-copy deltas: one source
file for the flat fix, four allowed files for P/E, four allowed files for
Standard, and no delta for proposal, recovery, or controlled negatives.
Focused controller reruns passed 2, 5, and 4 tests. The unique ignored run root
was resolved under `.eval-runs`, removed after evidence capture, and verified
absent.

This is exact-hash SOURCE-assisted synthetic behavior evidence. It does not
establish native injection or selection, trigger telemetry, a discovery
mapping, loaded-copy identity, real-Harness outage behavior, candidate,
release, generalized efficacy, or token savings.

### 2026-07-29 — Work Charter M2R Tranche 1 SOURCE and eval contract

The approved M2R Tranche 1 retired `skills/manage-large-tasks/` without an
alias and materialized the sole public Work Charter SOURCE as exactly:

- `SKILL.md`;
- `agents/openai.yaml`;
- `references/coordination-and-recovery.md`;
- `references/standard-ope.md`;
- `assets/work-charter.md`.

The metadata permits implicit invocation, while frontmatter and workflow text
limit implicit behavior to symptom recognition and a visible proposal.
Profile selection remains separate from role delivery, writes, project
governance, worktrees, Git, installation, and external effects.

The public eval contract now covers five Work Charter behavior groups. The
small-task and cold-resume cases were revised; midstream proposal,
Planner/Executor, and Standard cases were added. Midstream and
Planner/Executor share one loop fixture, and Standard has one fixture. No
per-role prompt, expected answer, or implementation diagnosis is stored in the
fixtures.

The final deterministic checks were:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/work-charter
Python YAML parse and implicit-invocation/default-prompt assertion
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
PowerShell parser check across evals/**/*.ps1
git diff --check
git diff --cached --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The Skill validator returned `Skill is valid!`. Metadata confirmed
`policy.allow_implicit_invocation: true` and a `$work-charter` default prompt.
The repository checker passed across 138 text files, eleven cases, and ten
fixtures, including the exact public Skill set and exact five-file Work Charter
shape. All thirteen fixture preconditions passed. PowerShell files parsed,
both whitespace checks passed, and Gitleaks found no leaks.

These checks establish current SOURCE shape, links, UTF-8 and publication
safety, metadata, eval definitions, and reproducible fixture preconditions.
The planned SOURCE-assisted matrix can record the exact canonical SOURCE
explicitly read by each role; it cannot establish native implicit selection or
same-named loaded-copy identity. Current checks also do not establish
fresh-context Work Charter results, actual role delivery, a discovery mapping,
`RC_INSTALL`, stable installation, commit, remote, tag, or release. Those
remain later gates.

### 2026-07-29 — Work Charter M2R Tranche 1 correction rounds 1 and 2

Round 1 independent assessment required three bounded contract corrections:

- positive Planner/Executor and Standard cases now authorize exact role
  delivery separately from profile selection and limit the sole writer to the
  named implementation, verification, status, and evidence scope;
- small-task and midstream cases, the eval plan, specification, and evidence
  wording now call direct canonical reads `SOURCE`-assisted evidence rather
  than native selection or trigger telemetry; and
- acceptance reserves same-named loaded-copy identity for separately
  authorized `DEV_DISCOVERY`, `RC_INSTALL`, or `STABLE_INSTALL` evidence.

Round 2 replaced one residual case-table claim that the ordinary task remained
unloaded with the SOURCE-assisted behavioral outcome: it remains flat without
Charter or role overhead. Native injection, selection, and telemetry remain
unproved.

Current-state documentation was also deduplicated without changing its
topology. `ROADMAP.md` was reduced from 85 to 53 lines, `STATUS.md` from 188
to 82, and `HANDOFF.md` from 219 to 101. Milestone direction remains in the
roadmap; current state and evidence route to their canonical owners.

The correction rerun was:

```text
single-shell PowerShell metadata assertion
python scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
git diff --check
git diff --cached --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

Metadata, repository shape, all thirteen fixture preconditions, both
whitespace checks, and Gitleaks passed. The Work Charter SOURCE and
`evals/**/*.ps1` files did not change during correction, so the Skill validator
and separate PowerShell parser sweep were not rerun; their preceding results
remain tied to unchanged files. One discarded nested-PowerShell metadata
attempt expanded variables in the outer shell and was not treated as evidence;
the valid result came from the recorded single-shell assertion.

These corrections do not add fresh-context, native-selection, role-delivery,
installed-copy, candidate, or release evidence.

### 2026-07-29 — Project Docs and repository-document alignment

A cross-document audit found and repaired four current-contract conflicts:

- Project Docs `REPORT`/`STOP` precedence differed between the concise entry,
  direct audit reference, specification, architecture, accepted decision, and
  safety case.
- Decision 0006 required explicit initial selection, while frontmatter still
  allowed project duration alone to trigger the Skill and metadata permitted
  implicit invocation.
- `STATUS` and `HANDOFF` still described an undelivered M1R packet and an active
  independent M2R writer after the packet was delivered and both SOURCE writer
  windows had closed.
- Public and operational documents still used the superseded
  `manage-large-tasks` name as the intended future Work Charter invocation and
  installation interface, and one acceptance check retained the obsolete
  four-case count.

The repair keeps the current `manage-large-tasks` directory explicitly labeled
as the superseded M2 SOURCE until a separately authorized M2R rename. It does
not implement Work Charter or create its intended directory.

The final deterministic checks were:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/manage-project-docs
Python YAML parse and explicit-only metadata assertion
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
PowerShell parser check across evals/**/*.ps1
git diff --check
git diff --cached --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The Skill validator returned `Skill is valid!`. The YAML parse confirmed the
default prompt names `$manage-project-docs` and
`policy.allow_implicit_invocation` is false. The repository checker covered 119
text files, eight cases, and eight fixtures. All eleven fixture preconditions
passed, all five PowerShell files parsed, both whitespace checks passed, and
Gitleaks found no leaks.

No fresh agent, discovery mapping, installation, candidate, commit, remote,
tag, or release action was used at that checkpoint. Because `SKILL.md`,
`agents/openai.yaml`, and both direct references had changed after the recorded
M1R matrix, all five explicit behavior scenarios then required a current-source
rerun, and native selection still had to prove the explicit-only policy. The
later current-SOURCE entry above records the completed behavior rerun.

### 2026-07-29 — Work Charter identity and minimum-sufficient design

The user accepted
[Decision 0012](decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md).
It unifies the product, contract, and intended package identity as Work Charter
/ `work-charter`; keeps Standard O/P/E as a supported but proportional
capability; replaces per-activation explicit opt-in with an approved
standing-policy boundary; and closes assessment, one-lane concurrency, and
correction defaults. It also demotes profile codes, Resume Gate, Anchor, Delta,
Role Capsule, and “Agent Loop” to internal shorthand or descriptive language
rather than required public artifacts.

This is accepted product design and documentation synchronization only. The
current `skills/manage-large-tasks/` source, metadata, references, assets,
evals, and existing behavior evidence are unchanged and predate Decision 0012.
No package rename, Skill behavior test, loaded-copy proof, discovery mapping,
installation, candidate, commit, remote, tag, or release action was performed.

The synchronized design and governance surfaces passed:

```text
python -B scripts/check_repository.py
git diff --check
git diff --cached --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The repository checker covered 119 text files, eight cases, and eight fixtures.
Both whitespace checks passed, and Gitleaks found no leaks. No Skill validator
or fixture behavior check was rerun because no Skill, eval, or fixture changed.

### 2026-07-29 — Formal Standard O/P/E support

The user accepted
[Decision 0011](decisions/0011-standard-ope-is-a-supported-advanced-profile.md).
Standard O/P/E is a formally supported, explicit opt-in v0.1 advanced profile
for consequential, multi-phase, long-lived project work. Positive full-role,
negative non-upgrade, recovery, handoff, writer, authorization, delivery
degradation, and loaded-copy behavior are now Work Charter release-readiness
requirements.

This is an accepted product and evaluation contract, not implementation or
behavior evidence. The current `manage-large-tasks` source and existing
development results implement the earlier M2 Standard model. No revised
Standard run, role delivery, Skill-copy proof, installation, candidate, commit,
or release action was performed by recording the decision.

### 2026-07-29 — Compact role handoff and event checkpoints

The user accepted
[Decision 0010](decisions/0010-compact-role-handoff-and-event-checkpoints.md).
Cross-session communication uses Anchor + Delta + Role Capsule; cold and
recovery entry add complete authoritative routing, while warm continuation,
bounded correction, and result return avoid repeating unchanged contract
content. Reliable role sessions are reused and durable checkpoints update for
material lifecycle events.

This is accepted product design, not token, delivery, or behavior evidence.
The current `manage-large-tasks` source, prompt assets, role references, evals,
and existing results predate Decision 0010. No role message was delivered and
no Skill, installation, candidate, commit, or release state changed.

### 2026-07-29 — Work Charter role profiles and Resume Gate

The user accepted
[Decision 0009](decisions/0009-work-charter-role-profiles-and-resume-gate.md).
The product keeps O/P/E as responsibility boundaries while using Flat, L1,
L2, and explicit Standard profiles to control when separate sessions are worth
their token and communication cost. Multi-session or materially interrupted
work must reconcile authoritative sources, workspace facts, evidence
freshness, and approval state before recommending the next action.

This is an accepted product design, not behavior evidence. The current
`manage-large-tasks` source, role messages, assets, evals, and existing
development results predate Decision 0009. No role delivery, recovery run,
Skill-copy load proof, installation, candidate, commit, or release action was
performed by recording it.

### 2026-07-29 — Work Charter logical contract and Codex carriers

The user accepted
[Decision 0008](decisions/0008-work-charter-logical-contract-and-codex-carriers.md).
Work Charter owns five logical responsibilities rather than a mandatory file;
Codex `/plan` may draft the contract, `/goal` may carry the active objective,
and existing or standalone durable sources may own details when recovery risk
requires persistence. Agent Loop is the internal execution kernel. v0.1 is
limited to Codex, with other Harness mappings deferred.

A current official Codex manual snapshot confirmed the bounded carrier claims:

- [Codex best practices](https://developers.openai.com/codex/learn/best-practices)
  describes `/plan` as planning before implementation;
- [long-running work](https://learn.chatgpt.com/docs/long-running-work)
  describes `/goal` as a persistent objective and completion-criteria surface;
- [Codex slash commands](https://learn.chatgpt.com/docs/reference/slash-commands)
  documents viewing, editing, pausing, resuming, and clearing a goal;
- starting a Goal keeps the existing sandbox and approval policy rather than
  granting broader access.

The project inference is that Work Charter semantics must remain separate from
those carriers so a future Harness can map equivalent responsibilities without
pretending Codex commands exist there.

After synchronizing the accepted product documents:

```text
python -B scripts/check_repository.py
git diff --check
git diff --cached --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The repository checker passed across 112 text files, eight case definitions,
and eight fixtures. Both whitespace checks passed, and Gitleaks found no leaks.
These checks prove documentation and repository shape only. No Skill,
reference, asset, eval, fixture, discovery mapping, installation, candidate,
commit, or release state changed, and no Work Charter behavior was exercised.

### 2026-07-29 — Independent Skills and optional recipes

The user accepted
[Decision 0007](decisions/0007-independent-skills-and-optional-recipes.md).
Every public Skill must solve a standalone job and remain independently
discoverable, installable, selectable, usable, stoppable, and evaluable.
Cross-Skill combinations are optional repository-level recipes, and
authorization does not propagate between Skills or between installation,
adoption, execution, and release surfaces.

This partially supersedes the Project Docs primary-product hierarchy in
Decisions 0001 and 0006. It does not change a Skill implementation, create an
umbrella product or runtime, prove independent Harness behavior, or authorize a
mapping, installation, role task, target-project write, commit, remote, tag, or
release.

After the repository authority surfaces were synchronized:

```text
python -B scripts/check_repository.py
git diff --check
git diff --cached --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The repository checker passed across 111 text files, eight case definitions,
and eight fixtures. Both working-tree and staged whitespace checks passed, and
Gitleaks found no leaks. These are document and repository-shape checks only;
no files were staged by this decision and no Skill behavior was exercised.

### 2026-07-28 — Project Docs progressive-governance decision

The user accepted the primary audience, Must-versus-Deferred boundary, five
logical responsibilities, four trigger and authorization surfaces, five
outcomes, target-project continuity anchor, and event-driven expansion model in
[Decision 0006](decisions/0006-project-docs-progressive-governance.md).

This is design and governance evidence only. No Project Docs Skill,
reference, asset, template, eval case, fixture, result, discovery mapping,
installation, or release candidate was changed or created by the decision.
The 2026-07-27 Project Docs conflict run and combined cold-resume run remain
evidence for their earlier bounded behaviors; they do not prove the revised
contract.

After the authority surfaces were synchronized:

```text
python -B scripts/check_repository.py
git diff --check
```

The repository checker passed across 91 text files, four case definitions, and
four fixtures, including the new decision and its local links. The tracked
unstaged diff check reported no whitespace errors. These checks prove document
shape and consistency only; they are not Project Docs behavior evidence.

### 2026-07-28 — Project Docs M1R source implementation

The accepted contract was implemented only in canonical repository source:

- `SKILL.md` now contains the five logical responsibilities, four surfaces,
  five outcomes, canonical-write rule, structural gate, and bounded asset
  routing;
- two conditionally loaded references replace the earlier broad document
  system and update/recovery references;
- one combined Starter and one continuity anchor replace the eleven-file fixed
  template suite;
- four new Project Docs cases and four new fixtures join the revised conflict
  case, producing an eight-case/eight-fixture repository set;
- the continuity case distinguishes target-project persistence from Skill
  selection and does not require Project Docs to load.

The following checks passed:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/manage-project-docs
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
git diff --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The repository checker covered 110 text files, eight case definitions, and
eight fixtures. All ten fixture preconditions passed, including the four added
Project Docs starting states. Gitleaks found no leaks.

These results prove structure, links, fixture shape, baseline code behavior,
and publication checks. They do not prove trigger selection, output quality,
continuity behavior, conflict judgment, or any revised Project Docs outcome.
No fresh-context agent, discovery mapping, installation, or candidate was used.

### 2026-07-29 — Project Docs M1R fresh-context matrix

Fresh `gpt-5.6-sol` contexts at medium reasoning exercised the five explicit
Project Docs behavior cases. A sixth fresh context tested only the persisted
target-project continuity rule without naming or exposing Project Docs.

The first conflict and safety runs exposed outcome and continuity-taxonomy
defects. A later safety rerun also exposed an over-broad `STOP` rule. The source
was corrected so structural or authority decisions use `PROPOSE`, completed
read-only audits remain `REPORT` when only future writes are blocked, `STOP`
applies to a requested action that cannot safely continue, and continuity uses
only `strong`, `weak`, or `not applicable`. The affected cases were rerun.

The final exact-source matrix passed:

- mature layout: `NOOP`, `strong`, zero file delta;
- first adoption: `UPDATE`, `strong`, one combined `PROJECT.md` added and the
  existing `AGENTS.md` route updated;
- persistence-only continuity: existing `PROJECT_STATE.md` updated without
  Project Docs attribution;
- explicit continuity: `UPDATE`, `strong`, existing `PROJECT_STATE.md` updated;
- authority conflict: `PROPOSE`, `weak`, zero run delta and pre-existing dirty
  state preserved;
- safety boundaries: `REPORT`, `weak`, zero file delta.

The two test-running mutation cases generated three ignored Python caches each.
All were present in the final manifest and agent report; none was hidden by Git
status or retained as repository evidence. Synthetic `HEAD` values remained
unchanged in every run.

The explicit runs reported reading
`skills/manage-project-docs/SKILL.md` at SHA-256
`EEDAC9E81542B6BFEB52E21A74ECF905D746254DF106765B8F6EF8D86F94A014`;
direct reference and asset hashes are recorded in the
[sanitized result](../evals/results/2026-07-29-project-docs-m1r-forward-tests.md).
This proves direct working-tree source identity, not native Harness discovery.

After this run, a repository-document alignment repair repeated the accepted
`REPORT`/`STOP` precedence in the audit reference, narrowed the frontmatter
trigger to an explicit request or adopted project route, and disabled implicit
invocation in metadata. At that point, all five explicit scenarios required a
current-source rerun. The later current-SOURCE evidence entry above closes that
behavior-attribution gap while preserving this matrix as historical evidence.
Native discovery must still separately prove explicit-only selection.

Final deterministic checks covered the revised source, eight cases, eight
fixtures, isolated Git/manifest setup, repository links and publication
patterns, PowerShell syntax, whitespace, and secret-like content. The evidence
is development-only: no comparison condition, discovery mapping, installed
copy, exact candidate commit, `RC_INSTALL`, stable installation, or
release-pinned loaded-copy smoke was used.

### 2026-07-27 — Structural validation

The locally bundled `skill-creator` `quick_validate.py` returned
`Skill is valid!` for:

```text
python "<CODEX_HOME>/skills/.system/skill-creator/scripts/quick_validate.py" skills/manage-project-docs
python "<CODEX_HOME>/skills/.system/skill-creator/scripts/quick_validate.py" skills/manage-large-tasks
python "<CODEX_HOME>/skills/.system/skill-creator/scripts/quick_validate.py" skills/use-powershell-safely
```

The bundled tool did not expose a version or revision in this run, so this is
local structural evidence rather than a pinned release-reproducibility claim.

### 2026-07-27 — Repository scan

A read-only PowerShell scan checked 40 Markdown/YAML files for local link
targets, strict UTF-8 decoding, BOM, trailing whitespace, generated operative
placeholders, direct reference routing, and configured publication-unsafe
patterns. All configured checks passed; four evaluation case files were found.

The scan was a one-off development command, not a checked-in deterministic
verifier. Reproducible fixtures and verifier design remain M4 work.

### 2026-07-27 — Fresh-context development runs

Fresh Codex subagents with no prior conversation turns received copied skills
and synthetic workspaces. The runs covered:

- Project Docs authority conflict repair;
- a small task explicitly invoking Large Tasks but remaining flat;
- a PowerShell spaced-path argument-transport diagnosis;
- combined Project Docs and Large Tasks recovery with branch and commit drift;
- a catalog-assisted small-task selection smoke with no preselected skill.

The resulting workspaces and focused checks produced the expected bounded
outcomes. A separate read-only agent reviewed the first-round workspaces
against the public rubrics and found no concrete skill defect or publication
leak. Process-only facts that could not be proved from workspace evidence
remain unknown.

The sanitized prompts, evidence, verdicts, and limitations are recorded in
[`evals/results/2026-07-27-development-forward-tests.md`](../evals/results/2026-07-27-development-forward-tests.md).
The ignored run directories, raw conversations, runtime identifiers, and
absolute paths are not publication artifacts.

These runs did not pin the exact model build, Provider configuration, or
committed skill revision. They are development evidence, not a native trigger
evaluation, causal comparison, token benchmark, SHICE result, or release
certification.

### 2026-07-27 — Reproducible repository and fixture checks

```text
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
```

The repository checker passed across 80 public-candidate text files, four case
definitions, and four synthetic fixtures. It checked strict UTF-8 decoding,
BOM, trailing whitespace, local Markdown links, operative scaffolding markers,
direct Skill-to-reference links, configured publication-unsafe patterns, and
expected case and fixture counts.

The fixture checker passed six preconditions: the Project Docs passing partial
suite, the Small Task intended failing baseline, the Cold Resume historical
baseline, the PowerShell direct success, the broken-wrapper failure, and the
UTF-8-without-BOM input.

The bundled `skill-creator` validator was rerun for all three skill directories
and returned `Skill is valid!` for each.

### 2026-07-27 — Secret and Git publication preflight

```text
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

Gitleaks scanned approximately 0.26 MB and reported no leaks.

A sanitized Git preflight confirmed the then-current publication boundary:

- branch `main` has no `HEAD` commit;
- no remote is configured;
- ignored `.eval-runs/` workspaces are not publication candidates;
- a repository-local Git identity is present and uses a GitHub noreply
  address.

The concrete identity was not printed or copied into tracked files. No commit,
remote creation, push, or publication occurred.

### 2026-07-27 — Adversarial checker and release-candidate review

Two fresh read-only reviews challenged the evidence layer and public release
contract. The checker review found four false-green paths:

- the intended Small Task failure accepted any nonzero test exit;
- the two passing fixture baselines did not verify test identity or count;
- the publication scanner missed several path, identifier, credential, and
  text-file forms;
- the direct-reference check accepted a path string without proving a rendered
  Markdown link.

The checks were strengthened to require named tests, exact counts, the expected
assertion failure, and absence of collection errors; scan all non-binary public
candidate files; detect drive paths with either separator, UNC paths, broad
UUID forms, modern secret prefixes, and private Codex paths; exercise synthetic
scanner probes; and require real Markdown links outside code and comments.

The same reviewer reran both deterministic checks and confirmed all four
findings resolved. All self-test identifiers are synthetic.

The public-candidate review found one release-contract mismatch: README treated
a supported skill-package installation path as a release gate, while the
authority documents did not. `docs/SPEC.md`, roadmap, status, handoff,
verification, and provenance now consistently require a documented and
smoke-tested public skill-package installation path before v0.1. A focused
re-review confirmed the mismatch resolved.

### 2026-07-28 — PowerShell runtime-readiness revision

The PowerShell Skill was restructured from one general detail file into a
concise entry point plus three directly linked conditional references:
native/process, text/encoding, and Windows/WSL. The stable contract now:

- probes runtime readiness only for version-sensitive tasks;
- prefers a supported PowerShell 7 release when compatible;
- preserves Windows PowerShell 5.1 for required legacy workloads;
- recommends current official installation guidance when 7 is absent and
  materially useful;
- requires a separate explicit authorization for installation, update,
  elevation, downloads, or system mutation;
- keeps UTF-8 correctness general and legacy locale/CJK guidance conditional.

The following deterministic checks passed:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/use-powershell-safely
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The repository checker covered 83 text files, four case definitions, four
fixtures, strict UTF-8/BOM/formatting, local links, direct Skill-to-reference
routing, configured publication patterns, and its scanner self-tests. The
fixture checker passed its existing six preconditions. Gitleaks scanned the
current directory and reported no leaks.

A read-only probe launched from Windows PowerShell 5.1 found `pwsh`, invoked the
resolved executable with `-NoProfile` and `-NonInteractive`, and observed exit
code `0`. A second probe confirmed the PowerShell 7 host and the side-by-side
presence of Windows PowerShell. Concrete host paths and unrelated environment
state were not recorded.

These checks prove package structure, command shape, and the existing fixture
baseline. They do not prove behavior when PowerShell 7 is absent, unsupported,
or incompatible; when a user declines or approves installation; across WSL or
legacy locales; or under native Harness trigger selection. The 2026-07-27
PowerShell forward test predates this material revision and is not reused as
current-scope acceptance.

### 2026-07-28 — Source, installation, and release governance

The accepted lifecycle now distinguishes canonical repository source, optional
development discovery, an isolated candidate produced from an exact commit
through a clean candidate source, and a stable installation mapped to a
repository-level version tag and commit.
`docs/RUNBOOK.md` is the single procedural owner; Skill directories do not
contain installation or process-history documents.

This is specification and governance evidence only. No local discovery mapping,
candidate or stable installation, distribution package, commit, tag, or release
was created, and no loaded-copy identity smoke has yet been run.

The repository checker was updated to exclude the ignored `.codegraph/` local
index alongside other non-source caches. The cache was not deleted. The
following checks then passed:

```text
python -B scripts/check_repository.py
gitleaks dir . --no-banner --redact --no-color --exit-code 1
git check-ignore -v .codegraph/codegraph.db
```

The repository checker covered 85 public-candidate text files, four case
definitions, and four fixtures. Gitleaks reported no leaks, and Git confirmed
that the local index database is ignored. These results validate document
links, formatting, configured publication patterns, and cache exclusion; they
do not provide the still-missing loaded-copy or installation behavior proof.

### 2026-07-28 — Revised PowerShell fresh-context forward tests

Four fresh behavior agents received synthetic PowerShell scenarios and an
explicit route to the canonical repository source. They covered:

- a safe Windows PowerShell 5.1 route when `pwsh` is absent but not required;
- a required 5.1 legacy tool with UTF-8 stdout, CP936 stderr, exit `2`, and a
  user-declined PowerShell 7 installation;
- a working WSL 2 direct probe followed by a failing nested Bash/path
  transport;
- a process-control contract where modern
  `ProcessStartInfo.ArgumentList` makes PowerShell 7 materially useful but
  installation is not authorized.

The first, second, and fourth answers passed the existing public rubric. The
WSL answer was partial: it chose the safe direct-execution and Linux-path
direction, but did not explicitly retain the unknown PowerShell 7 minor
version/native argument mode or separately isolate WSL user, working
directory, stdout, and stderr.

A fifth fresh agent received a catalog-assisted POSIX-only task. It returned a
direct `grep` command, applied no PowerShell guidance, and self-reported
reading no Skill file. This is a bounded non-trigger outcome, not native
Harness selection telemetry.

A separate read-only reviewer compared the answer summaries with the existing
case rubric, confirmed these verdicts, and found no failed safety boundary or
concrete Skill-contract defect. No Skill file was changed.

The sanitized prompts, per-case evidence, progressive-reference self-reports,
and limitations are recorded in
[`evals/results/2026-07-28-powershell-forward-tests.md`](../evals/results/2026-07-28-powershell-forward-tests.md).
At the time of the run, the source was uncommitted, the exact model and
Provider were not pinned, and proposed commands were not executed against real
native tools. The later local candidate baseline does not retroactively turn
this into release-pinned evidence. It remains development evidence, not a
causal comparison, trigger audit, installation smoke, SHICE result, or release
certification.

After the evidence and canonical status documents were updated, the following
stable-source checks passed:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/use-powershell-safely
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The repository checker covered 86 public-candidate text files, four cases, and
four fixtures; all six fixture preconditions passed; Gitleaks found no leaks.

### 2026-07-28 — MIT license decision

The user selected MIT for public v0.1. The accepted decision is recorded in
[`docs/decisions/0004-public-mit-license.md`](decisions/0004-public-mit-license.md).

The user subsequently confirmed the exact public attribution
`Copyright (c) 2026 matsuri1987`. The standard MIT text was materialized in the
root `LICENSE`. The configured repository-local Git identity was neither
printed nor copied into tracked files.

After recording the decision:

```text
python -B scripts/check_repository.py
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The repository checker passed across 87 public-candidate text files, four
cases, and four fixtures. Gitleaks found no leaks.

After the exact public attribution was confirmed and the root license was
materialized, a focused check verified the header and standard MIT grant and
warranty clauses. The stable license-inclusive source then passed:

```text
python -B scripts/check_repository.py
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

The repository checker covered 88 public-candidate text files, four cases, and
four fixtures. Gitleaks found no leaks.

### 2026-07-28 — Standalone GitHub distribution decision

The user accepted one standalone GitHub repository as the v0.1 distribution
source, with independently installable `skills/<skill-name>` directories,
repository-level immutable tags, and Plugin packaging deferred. The accepted
decision is recorded in
[`docs/decisions/0005-v0-1-standalone-github-distribution.md`](decisions/0005-v0-1-standalone-github-distribution.md).

A current Codex manual snapshot sourced from
[OpenAI Build skills guidance](https://learn.chatgpt.com/docs/build-skills)
confirmed that standalone local Skills are supported and that
`$skill-installer` can download Skills from other repositories. It also states
that this route is for local setup and experimentation and prefers Plugins for
broader installable distribution. The v0.1 documentation preserves that
limitation rather than claiming Plugin-directory availability.

The locally bundled installer help exposed repository or URL, subpath, ref,
destination, and transport-method inputs:

```text
python <skill-installer>/scripts/install-skill-from-github.py --help
```

This was a read-only interface check. No repository download, discovery
mapping, installation, user configuration, remote, tag, or publication action
occurred. At that point the public repository identity, release prompt,
candidate installation, and loaded-copy proof remained release gates.

The user then confirmed
[`matsuri1987/eddie-skills`](https://github.com/matsuri1987/eddie-skills)
as the public repository identity and accepted pre-tag visibility of the exact
candidate commit for a commit-pinned installer smoke. The intended
single-PowerShell and complete-set `v0.1.0` prompts were materialized. Because
the remote and tag do not yet exist, these remain specified release interfaces,
not successful installation evidence.

The three Skill validators, repository checker, fixture preconditions, and
Gitleaks were repeated after that exact identity and prompt sync. All three
Skills remained valid; the repository checker passed across 89 text files,
four cases, and four fixtures; all six fixture preconditions passed; and
Gitleaks found no leaks.

After synchronizing the decision through the public entry point, authority
documents, runbook, current state, handoff, provenance, and evidence ledger:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/<skill-name>
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

All three Skill validations passed. The repository checker covered 89
public-candidate text files, four cases, and four fixtures; all six fixture
preconditions passed; Gitleaks found no leaks.

The pre-commit scope check confirmed that the candidate contained only intended
public source and excluded discovery mappings, installed copies, caches, and
ignored evaluation runs. The publication-safe writer identity was revalidated
without copying account data into tracked files.

### 2026-07-28 — First local candidate commit gate

The user explicitly authorized creation of the first repository-level
candidate commit for all three Skills. The intended scope was the complete
public baseline; discovery mappings, installed copies, caches, and ignored
evaluation runs remained excluded.

Before review, the diff check exposed inconsistent extra final blank lines in
34 files. The public source was normalized to UTF-8 without BOM, LF line
endings, and one final newline. The repository checker, all three Skill
validators, all six fixture preconditions, Gitleaks, and the diff check passed.

Native Codex review inspected the complete candidate with the `--uncommitted`
selector, `gpt-5.6-terra`, and high reasoning. Its first semantic result found
one P2 issue: current-state documents still described the pre-commit
repository. After those records were synchronized, the second semantic result
found two P2 issues: local host/Git detail remained in public records, and the
cold-resume case lacked a public way to reproduce its Git preconditions.

The local details were removed, the public status surfaces were made portable,
and `evals/setup-cold-resume.ps1` was added with deterministic coverage in
`evals/check-fixtures.ps1`. The third review found that the deliberately broken
PowerShell fixture also split the verifier path when the checkout path
contained spaces. The verifier path is now quoted independently while the
fixture's input path remains deliberately unquoted. The fourth review found
that the repository checker did not validate Markdown fragments and that
cold-resume setup could stage local Python cache artifacts. Fragment validation
and a negative scanner self-test were added; fixture setup now excludes Git and
interpreter caches, with deterministic coverage of the staged index. The fifth
review found one P1 premature candidate-state claim and one P2 inaccurate
PowerShell fixture contract. The state surfaces now defer candidate identity to
Git, and the case distinguishes the successful direct verifier from the
deliberately failing wrapper. All eight findings are corrected; the user
approved a review-cycle budget reset. The sixth review found that the fixture
README's command could not run from its stated repository-root working
directory. The command now uses the correct root-relative path. All nine
findings are corrected. The second review in cycle 2 returned clean, but
Project Docs M1R, Decision 0007, Work Charter M2R, and their current evidence
then changed the working tree before a commit. That clean result therefore
could not certify the later complete candidate and did not reset the
cumulative attempt. Before current restabilization, cycle 2 had used two of
five reviews; the user then authorized coherent candidate reconciliation,
staging, continuation of native review, and one local root commit.

The third review in cycle 2 inspected the restabilized 139-file candidate and
found that `evals/setup-cold-resume.ps1` accepted destinations outside the
ignored `.eval-runs` root. The helper now requires a child of that root, and
the fixture checker proves an out-of-root destination is rejected without
being created while retaining the valid isolated setup path. This tenth
finding is corrected; the correction requires a later clean review before
commit.

The fourth review in cycle 2 found that lexical containment still allowed an
existing junction or symbolic link inside `.eval-runs` to redirect setup or
inspection to another location. Both setup helpers and the inspector now
reject any existing reparse-point component between `.eval-runs` and the
destination. A deterministic junction or symbolic-link probe covers both setup
paths and the inspector while keeping all test artifacts under the ignored run
root. This eleventh finding is corrected; the correction requires the final
review in the current cycle before commit.

A first local candidate exists only after repository `HEAD` resolves to the
reviewed root commit. No remote, GitHub candidate installation, stable tag, or
release has been created by this gate.
