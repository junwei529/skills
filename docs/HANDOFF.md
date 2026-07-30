# Handoff

Last updated: 2026-07-30

## Snapshot

- Project: Agent Workflow Skills
- Workspace: repository root
- Branch: `main`
- Accepted candidate basis:
  `78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`; local `main` and its
  `origin/main` tracking ref matched at the candidate gate. Resolve current
  branch `HEAD` with Git because a later evidence-only commit is not a new
  candidate identity
- First public revision: the coherent PowerShell portable-guidance migration
  and Project Docs official-alignment revision at
  `c5d8e185ea9a9f32a4e98ac8ac364c4ebe915535`
- Accepted shared release-candidate identity:
  `78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`; its exact-commit
  `RC_INSTALL` identity and representative loaded-copy positive/negative smoke
  pass for Project Docs, Work Charter, and PowerShell
- Historical PowerShell-only release-candidate identity:
  `b0099c9d5ad986be5e893ceea13f1fc8b5aea384`; its earlier evidence
  remains valid at that gate but is not the shared v0.1 candidate
- Public identity: `junwei529/skills`, selected by Decision 0013 and publicly
  reachable; its public `main` matched the accepted candidate during RC
  preflight
- Active gate: this evidence-only revision records Work Charter native DEV/RC
  canaries and the later three-Skill shared-candidate result in the public
  README and three canonical documents. Its local commit gate is separately
  authorized; push, tag, installation, release, cleanup, and private-global
  changes are not
- Candidate boundary: the materialized historical and shared `RC_INSTALL`
  roots are derived ignored copies from their exact commits and are not
  editable source.
  Development mappings, candidates, installations, caches, private-global
  files, ignored runs, and interpreter caches remain excluded from repository
  source. No stable installation or tag exists

## Authoritative Pointers

- Work Charter contract:
  [Decision 0012](decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
- Independent-Skills boundary:
  [Decision 0007](decisions/0007-independent-skills-and-optional-recipes.md)
- PowerShell public/private boundary:
  [Decision 0014](decisions/0014-powershell-portable-guidance-and-private-host-delta.md)
- Stable requirements and ownership:
  [`docs/SPEC.md`](SPEC.md) and
  [`docs/ARCHITECTURE.md`](ARCHITECTURE.md)
- Current state and evidence:
  [`docs/STATUS.md`](STATUS.md) and
  [`docs/VERIFICATION.md`](VERIFICATION.md)
- Lifecycle procedures:
  [`docs/RUNBOOK.md`](RUNBOOK.md)

## Current M2R State

The superseded `manage-large-tasks` SOURCE is retired without an alias.
`skills/work-charter/` is the sole Work Charter SOURCE and has exactly:

- `SKILL.md`
- `agents/openai.yaml`
- `references/coordination-and-recovery.md`
- `references/standard-ope.md`
- `assets/work-charter.md`

The public eval contract has five Work Charter cases and two shared fixtures.
Correction rounds 1 and 2 now:

- separately authorizes exact Planner/Executor or O/P/E delivery, profile
  selection, and bounded write scope in positive cases;
- labels direct canonical reads as SOURCE-assisted evidence, not native
  selection or trigger telemetry;
- describes the small-task result as flat behavior without Charter or role
  overhead, not as a native load-state observation;
- reserves loaded-copy identity claims for separately authorized lifecycle
  surfaces; and
- removes duplicated milestone and historical ledgers from current-state
  documents.

Tranche 1 was accepted after correction round 2. Tranche 2 then ran five fresh
SOURCE-assisted behavior groups plus two controlled negative variants with
fresh role contexts:

- small work stayed flat and passed two focused tests;
- midstream adoption remained a non-mutating proposal using the existing
  durable owner;
- cold recovery classified branch/commit/index drift and stopped before write;
- separate Planner/Executor completed one bounded correction and independent
  `ACCEPTED`, with five focused tests passing;
- separate Standard O/P/E completed one bounded correction, independent
  Planner `ACCEPTED`, and an Orchestrator transition that stopped before Phase
  Two; and
- stricter standing-policy selection and unavailable/uncertain role delivery
  degraded visibly without silent Standard activation.

The sanitized
[Work Charter M2R report](../evals/results/2026-07-29-work-charter-m2r-forward-tests.md)
owns source hashes, role settings, manifests, tests, cleanup, and limitations.
The independent Planner recomputed all five normalized SOURCE identities,
reran the required checks, and returned `ACCEPTED`. The unique ignored run root
was removed after evidence capture. This acceptance is exact-hash development
behavior evidence, not native selection, installed-copy, candidate, or release
proof. The M2R writer has relinquished.

Two later controlled native DEV_DISCOVERY canaries explicitly invoked
`$work-charter` through a repository-scoped discovery entry that resolved to
canonical SOURCE. Every Planner, Executor, and Orchestrator selection record
identified the same five-file SOURCE; the controller independently resolved
the discovery target and rechecked its hashes.

The P/E canary used one read-only Planner and one sole-writer Executor, changed
only its four expected fixture files, passed all five tests independently, and
ended `ACCEPTED` without correction. The Standard canary completed the
O-to-P-to-E route with a dormant read-only Orchestrator, one read-only Planner,
one sole-writer Executor, only four expected fixture changes, four passing
tests, no correction, and a stop before unapproved Phase Two. Both
task-specific discovery and fixture copies were removed, and repository SOURCE
and Git state remained unchanged.

This closes controlled native explicit selection, DEV_DISCOVERY loaded-copy
identity, and positive P/E and Standard role delivery for the recorded hashes.
It remains development evidence: the one-time legacy native route does not
prove general Harness routing, and no implicit trigger telemetry,
`RC_INSTALL`, stable installation, real-project shadow use, or release is
established.

The separately authorized Work Charter RC gate selected exact public commit
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`. `$skill-installer`
downloaded `skills/work-charter` by that SHA into an ignored isolated
candidate. The actually loaded native-scope copy was an ordinary five-file
directory, the only same-named Skill in scope, and matched the selected
commit's Git blobs and the recorded raw SHA-256 values.

The counted positive canary contained no Work Charter name or expected profile
in its prompt or project rules. It implicitly selected the installed entry
from continuity and recovery symptoms, used only the recovery reference,
proposed P/E cold recovery, and stopped before role delivery or writes. The
counted flat arithmetic canary returned `703` without loading the Skill. A
network-blocked attempt and a name-contaminated, agent-side-hash attempt are
excluded from trigger and cost claims. Full evidence and limitations belong in
[`docs/VERIFICATION.md`](VERIFICATION.md).

The later shared-candidate gate retained this Work Charter candidate unchanged
and aligned Project Docs and PowerShell to the same exact commit. It did not
rerun Standard Work Charter behavior or broaden the earlier Work Charter
canaries.

## Current Project Docs M1R State

The current six-file SOURCE is aligned with the official Codex Skill,
AGENTS, and approval contracts. It treats project-rule mentions as routing
only, avoids redundant project-instruction rereads, consolidates duplicated
outcome/report rules, and persists a visible explicit-reselection route.

Five fresh `gpt-5.6-sol` contexts at medium reasoning passed the explicit
mature, adoption, continuity, authority-conflict, and safety-boundary groups at
the new hashes. A separate persistence-only broken-routing variant stopped
without mutation and requested explicit `$manage-project-docs` invocation
without treating the routing line as invocation or authorization.

The
[official-alignment report](../evals/results/2026-07-30-project-docs-official-manual-alignment.md)
also records controlled native DEV_DISCOVERY positive and negative canaries.
The explicit run selected canonical SOURCE; the negative run did not load the
full Skill body. This closes the development explicit-only selection and
loaded-copy gate, but not broad trigger telemetry. The later shared-candidate
gate separately closes representative `RC_INSTALL` loaded-copy behavior, but
not stable installation, mutation behavior at the candidate layer, or release
proof. The earlier
[M1R report](../evals/results/2026-07-29-project-docs-m1r-forward-tests.md)
remains historical evidence for superseded hashes.

## Current PowerShell Migration State

Decision 0014 classifies candidate global rules as documented portable rules,
bounded inference, or private host delta. The current SOURCE adds high-signal
trigger terms, conditional native error-preference guidance, stronger WSL
identity and stream checks, destructive parser boundaries, and explicit
host-value exclusions while retaining exactly three references.

The sanitized
[PowerShell migration check](../evals/results/2026-07-30-powershell-portable-guidance-migration.md)
records the five normalized SOURCE hashes. The Skill validator, metadata
assertion, repository checker, all fourteen fixture checks, PowerShell parser
check, whitespace check, and Gitleaks pass. No private global file was changed,
and the source writer has relinquished.

Seven isolated boundary-sensitive scenarios pass against the revised
development SOURCE, including 5.1, 7.3/7.4, WSL, legacy CJK, PowerShell 7
recommendation, sandbox, and destructive-operation boundaries. Two
catalog-assisted canaries correctly declined an ordinary cmdlet and POSIX-only
task without loading the Skill body. No SOURCE correction was required.
A user-scope DEV_DISCOVERY junction now resolves directly to canonical SOURCE.
One native implicit-selection canary loaded and hashed the entry plus the two
relevant references, reproduced the fixture diagnosis, and avoided the WSL
reference. A second native canary completed an ordinary cmdlet without reading
the Skill body.

The separately authorized RC gate selected exact public commit
`b0099c9d5ad986be5e893ceea13f1fc8b5aea384` and installed
`skills/use-powershell-safely` by exact SHA into an isolated test root. A first
test-home attempt was rejected because the development copy remained
discoverable and is not counted as RC evidence. The corrected repository-scoped
test exposed only the five-file materialized candidate.

All five candidate files matched the selected commit's Git blobs and recorded
raw SHA-256 values, decoded as strict UTF-8 without BOM, and were not reached
through a reparse point. The copied fixture remained byte-identical. The
positive native canary implicitly selected the candidate, read only the entry
plus native/process and text/encoding references, and diagnosed parser and
argument transport. The negative ordinary-cmdlet canary did not load the
Skill. Controller runs reproduced exit `0`, `1`, and `2` for the direct,
broken-wrapper, and deliberately split-argument contracts.

The installed validator, repository and fixture checks, whitespace check, and
Gitleaks passed. This closes PowerShell `RC_INSTALL` and loaded-copy smoke only.
Stable-install, shadow-period, private-global retirement, and release proof
remain absent. The ignored RC evidence roots remain retained pending separately
authorized cleanup.

## Shared Candidate State

The user authorized public exact commit
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09` as the shared repository
candidate. One exact-SHA multi-Skill `$skill-installer` download materialized
Project Docs and PowerShell beneath an ignored isolated discovery root; Work
Charter's retained candidate already used the same commit.

Controller audits proved 6/5/5 expected files, candidate-to-SOURCE and
SOURCE-to-commit equality, strict UTF-8 without BOM, ordinary non-reparse
directories, one same-named Skill per candidate directory, an exact 27-file
shared native scope, and canonical fixture provenance. Both newly installed
Skills passed the bundled validator. Excluded preflight artifacts remained
outside tracked source and were not used as candidate evidence.

Potential same-named Skill conflicts were handled with process-local
candidate-only exclusions; no persistent user configuration or discovery
state changed. PowerShell then passed implicit candidate selection, correct
native-argument diagnosis, ordinary-cmdlet non-loading, and independent
separate-stream exit reproduction. Project Docs passed an explicit standalone
mature-project `NOOP`, one focused test, and ordinary-routing non-loading.

Preflights that failed candidate-only discovery, complete prompt transport,
standalone Skill isolation, or semantic completion are excluded from behavior
and cost claims. The counted canaries establish loaded candidate identity;
role separation, source equivalence, or task names alone do not.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, Decisions 0002, 0003, 0007, 0012, and
   0014.
2. Read `docs/SPEC.md`, `docs/ARCHITECTURE.md`, `docs/STATUS.md`, and
   `docs/VERIFICATION.md`.
3. Inspect `git status --short --branch`; preserve the inherited index and all
   unrelated dirty ownership.
4. Read the five current PowerShell SOURCE files, its public case, and the
   portable-guidance migration result before evaluating or changing it.
5. Read `docs/RUNBOOK.md` before any discovery, installation, candidate,
   version, or release action.

## Immediate Next Action

Use the separately authorized local commit gate only to disposition the
public-and-canonical shared-candidate evidence sync, then stop. No private
global rule, Skill SOURCE, user discovery mapping, further installation, push,
tag, release, or cleanup action is authorized by this handoff.

The shared-candidate evidence writer has completed its authorized writes and
relinquished. Any later modification of this diff belongs to a separately
authorized writer window.

Shared candidate alignment is complete at
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`. A later
evidence-only commit is not automatically a new candidate. The next lifecycle
decision, after separate disposition of this documentation diff, is whether to
tag the accepted commit and run a tag-pinned `STABLE_INSTALL` for all three
Skills. Private-global semantic retirement must still wait for stable
loaded-copy evidence and a bounded real-project shadow period with rollback
available.

## Global Replacement Readiness

Current verdict: **conditionally replaceable**. Work Charter can eventually
replace duplicated public coordination semantics, but it cannot replace the
native control plane that discovers, selects, delivers, authorizes, or releases
the Skill.

| Class | Current disposition |
|---|---|
| Work Charter coverage | Consequential-work contract; proportional Flat, P/E, and Standard profiles; O/P/E responsibilities; one active writer as an advisory coordination rule; cold/recovery reconciliation; compact warm handoff; three assessment verdicts; bounded correction; stop before an unapproved next phase |
| Minimal global bootstrap | Pre-selection trigger routing; first adoption or standing-policy decision; user decision-gate integrity; missing-Skill fallback; separation of selection from role creation, writes, Git, and external-effect authorization |
| Separate global control planes | Native task delivery and exact workspace routing; Plan Mode durability and context telemetry; Git branch/worktree/integration/cleanup; native review and commit budgets; documentation authority; installation, release, permissions, and general safety |
| Host-private state | Saved-project and task identifiers; local paths; installed or cached copies; supported model/tool schema; sandbox state; route exceptions and current-host observations; none belongs in the public Skill |

All three shared-candidate `RC_INSTALL` gates now pass. Retire duplicated global
P/E and Standard semantic guidance only after stable loaded-copy and shadow-use
gates also pass. Retain a rollback that restores the former semantic fallback
without deleting project Charters or editing derived installed copies.

## Material Risks

- Treating controlled DEV_DISCOVERY selection as `RC_INSTALL`, stable-install,
  or release proof.
- Treating role names, separate tasks, source equivalence, or worktree
  separation as proof that every role loaded the expected Skill revision.
- Treating Project Docs DEV_DISCOVERY or shared-candidate `NOOP` evidence as
  stable-install, mutation, real-project, or release proof.
- Letting profile or standing-policy selection imply role delivery, write
  authority, execution, acceptance, or lifecycle authorization.
- Recreating the retired `manage-large-tasks` path as an alias.
- Editing discovery, installed, cached, candidate, or stable copies instead of
  canonical SOURCE.
- Treating the SOURCE-assisted Tranche 2 results as native evidence, or the
  later native canaries as implicit-trigger, general-routing, real-project,
  candidate, or release evidence.
- Treating the first name-contaminated RC canary as implicit-trigger or token
  cost evidence; only the corrected minimal canary counts.
- Treating the historical PowerShell-only RC as the current shared candidate,
  or treating an evidence-only follow-up commit as candidate-smoked.
- Treating catalog-assisted PowerShell negative canaries as native Harness
  trigger telemetry.
- Treating the discarded test-home canary as RC evidence even though a
  development copy remained discoverable.
- Treating the evidence-only working-tree diff as a new candidate or moving
  the eventual release tag away from the commit-smoked candidate without a
  new RC gate.
- Copying private paths, accounts, environment values, installed state,
  distribution identity, or sandbox details into public source or evidence.
- Removing the private fallback before stable loaded-copy and shadow-use
  evidence pass.
- Disturbing inherited staged or unrelated dirty ownership.

## Prohibited Without Separate User Authorization

- Any further discovery-mapping change, installation, update, rollback, or
  user configuration.
- Any further commit or amend without a new explicit authorization.
- Any further remote change or push, new `RC_INSTALL`, tag, stable
  installation, release, or cleanup.
- Private global guidance or fallback edits.
- Plugin, MCP, cross-Harness package, or other deferred product surface.
- Native-selection or lifecycle progression not separately authorized.
