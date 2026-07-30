# Handoff

Last updated: 2026-07-30

## Snapshot

- Project: Agent Workflow Skills
- Workspace: repository root
- Branch: `main`
- Historical baseline: identity-corrected local commit
  `24714788a4c489620643a58f5651a6a3888a8fd3`; resolve current identity with
  `git rev-parse HEAD`
- First public revision: the coherent PowerShell portable-guidance migration
  and Project Docs official-alignment revision at
  `c5d8e185ea9a9f32a4e98ac8ac364c4ebe915535`
- Accepted PowerShell release-candidate identity:
  `b0099c9d5ad986be5e893ceea13f1fc8b5aea384`; its exact-commit
  `RC_INSTALL` and loaded-copy smoke pass
- Public identity: `junwei529/skills`, selected by Decision 0013 and publicly
  reachable; its public `main` matched the accepted candidate during RC
  preflight
- Active gate: this local evidence revision records the four-file PowerShell
  RC sync; publishing it to public `main` is not authorized
- Candidate boundary: the materialized PowerShell `RC_INSTALL` is a derived
  ignored copy from the exact commit above and is not editable source.
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
loaded-copy gate, but not broad trigger telemetry, `RC_INSTALL`, stable
installation, or release proof. The earlier
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

Confirm the local evidence-only revision and stop; push is not authorized. If
the user later authorizes publication, push only this reviewed documentation
sync without changing the accepted candidate identity.

The next lifecycle decision after that evidence revision is public is whether
to tag exact candidate `b0099c9d5ad986be5e893ceea13f1fc8b5aea384` as
`v0.1.0` and run a tag-pinned `STABLE_INSTALL`. Selecting another candidate
commit requires a new RC smoke.

## Material Risks

- Treating SOURCE-assisted reads as native selection or installed-copy proof.
- Treating Project Docs DEV_DISCOVERY selection as candidate, stable-install,
  or release identity.
- Letting profile or standing-policy selection imply role delivery, write
  authority, execution, acceptance, or lifecycle authorization.
- Recreating the retired `manage-large-tasks` path as an alias.
- Editing discovery, installed, cached, candidate, or stable copies instead of
  canonical SOURCE.
- Treating the Tranche 2 results as native-selection, installed-copy,
  candidate, real-Harness outage, or release evidence.
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
