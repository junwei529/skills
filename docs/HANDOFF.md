# Repository Handoff

Last updated: 2026-08-06

## Snapshot

- Repository: Agent Workflow Skills
- Branch: `main`
- Released package identity: immutable `v0.1.2` at
  `ceed607152849775b981c54add74bfa30d858e4d`
- GitHub Release:
  [`v0.1.2 — Stable three-Skill release`](https://github.com/junwei529/skills/releases/tag/v0.1.2),
  marked Latest
- Stable installed set: Project Docs 6 files, Work Charter 5 files, PowerShell
  5 files, each matching the `v0.1.2` Git blobs
- Rollback identity: immutable `v0.1.1` retained as a separately verified
  three-package backup
- Writer: no Skill SOURCE writer is active. One bounded repository writer owns
  the four-file governance/checker correction on `main`, then the authorized
  semantic integration of `codex/work-charter-v0.2`; the final local merge
  commit relinquishes the writer, and no push authority follows

The `v0.1.2` tag remains fixed at the release-preparation commit. The later
documentation commit records already-completed tag, stable-install, canary, and
GitHub Release facts; it is an evidence descendant and must not move or replace
the released tag.

## Release Completion

The public release lifecycle is complete for `v0.1.2`:

1. all three current package revisions independently reached exact-commit RC
   readiness at public `c42eef3...`;
2. release-preparation commit `ceed607...` preserved the exact 6/5/5 package
   blobs and passed its own clean public exact-commit installer and loaded-copy
   gate;
3. immutable tag `v0.1.2` was created and pushed at `ceed607...`;
4. `$skill-installer` materialized all three tag paths into isolated staging,
   with exact Git-blob, UTF-8/no-BOM/LF/final-newline, non-reparse, and validator
   checks;
5. the prior `v0.1.1` stable set was verified and retained as rollback before
   the staged `v0.1.2` set replaced it;
6. isolated repository-scoped discovery entries resolved to the verified
   stable targets; fresh identity and behavior canaries passed for all three
   Skills, and a shared ordinary-task negative loaded none; and
7. GitHub Release `v0.1.2` was published from the immutable tag and verified as
   Latest.

No package was edited in an RC, staging, stable, or rollback environment.
Persistent Codex configuration, Skill SOURCE, tracked repository state, and the
tag did not change during the stable installation or canaries.

## 2026-08-02 Documentation Decisions And Gate 0 Baseline

The 2026-08-02 user-authorized documentation task accepted and operationalized
[Decision 0017](decisions/0017-capability-delta-skill-development.md) as a
prospective capability-delta rule for new Skills and material selection or
behavior revisions. It also clarified [Decision 0003](decisions/0003-source-install-release-boundaries.md):
the shared v0.1 version is a repository release-set identity, while per-Skill
package deltas, maturity, and evidence remain independent. It synchronized the
repository instructions, public entry points, shared specification,
architecture, development Runbook, evaluation contract, provenance/data
boundary, authority map, index, repository verification, and this handoff.

[Decision 0018](decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md)
then applies that capability-delta method to a future Work Charter `v0.2.0`
revision. It records accepted natural-language entry, proportional protection,
durable re-entry, evaluation, workspace, and lifecycle-gate design while
leaving the current Work Charter Design, SOURCE, State, stable behavior, and
release identity unchanged.

The accepted documentation change set comprises:

- `AGENTS.md`;
- `README.md`;
- `README.zh-CN.md`;
- `docs/AUTHORITY.md`;
- `docs/ARCHITECTURE.md`;
- `docs/HANDOFF.md`;
- `docs/INDEX.md`;
- `docs/PROVENANCE.md`;
- `docs/ROADMAP.md`;
- `docs/RUNBOOK.md`;
- `docs/SPEC.md`;
- `docs/STATUS.md`;
- `docs/VERIFICATION.md`;
- `docs/decisions/0003-source-install-release-boundaries.md`;
- `docs/decisions/0017-capability-delta-skill-development.md`;
- `docs/decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md`;
- `docs/skills/work-charter/STATE.md`;
- `evals/README.md`.

The repository checker passes at 182 text files / 12 cases / 11 fixtures, and
`git diff --check` passes. No installable Skill, eval case, fixture, script,
discovery mapping, installation, tag, or release identity changed. Gate 0
authorizes review, same-scope documentation corrections, deterministic checks,
native review, staging, and one local commit for this exact set. It grants no
continuing writer authority and does not authorize push or publication.

Retained ignored evaluation workspaces contain descendant discovery roots from
earlier tests. They are not active merely because a task starts at the
repository root, but a future task started inside one can expose historical or
same-named copies. Re-enumerate the exact working-directory-to-root discovery
chain and fail closed before reusing any retained workspace; do not rely on
this snapshot's contents or counts.

## 2026-08-04 Documentation-Impact Closure Rule

After repeated native-review corrections added existing documentation
consumers that an early file list had omitted, the user authorized a separate
project-governance correction before resuming the paused Work Charter change.
The correction distinguishes the authorized change envelope, intended change
set, and actual review target, and requires a fact-first documentation-impact
closure before the first native review.

The governance correction started with three existing documentation files.
Current pre-review qualification also found that the repository checker was
incorrectly treating the ignored `.code-review-graph` cache as publication
source. The complete intended change set is therefore four existing files:

- `AGENTS.md` for the short mandatory repository rule;
- `docs/RUNBOOK.md` for the owner/consumer matrix, closure procedure, and the
  clarified canonical-SOURCE development step;
- this handoff for writer, dirty-scope, and recovery continuity; and
- `scripts/check_repository.py` for the minimal generated-cache exclusion.

The impact audit classified `AUTHORITY`, Decisions 0015 and 0017, `INDEX`,
`SPEC`, `ARCHITECTURE`, `STATUS`, `VERIFICATION`, `ROADMAP`, the root README
pair, per-Skill documents, and `evals` as `CHECKED_NO_CHANGE` or
`NOT_APPLICABLE`: this correction changes development procedure and the
checker's non-source traversal boundary, not a public Skill, product contract,
navigation route, milestone, evaluation contract, evidence claim, candidate,
installation, or release state. It adds no file or product behavior.

The current task owns only this uncommitted four-file governance/checker delta
on `main`. The clean `codex/work-charter-v0.2` branch remains at `119aa27...`
and is an integration input, not an active writer. The user authorized one
local governance/checker commit followed by one local semantic merge commit,
including deterministic checks and native review for each attempt. No push,
new Work Charter product delta, behavior-model call, installation, tag,
release, or cleanup is authorized.

## Per-Skill Recovery

| Skill | Current state | Evidence |
|---|---|---|
| Project Docs | [State](skills/manage-project-docs/STATE.md) | [Verification](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter | [State](skills/work-charter/STATE.md) | [Verification](skills/work-charter/VERIFICATION.md) |
| PowerShell | [State](skills/use-powershell-safely/STATE.md) | [Verification](skills/use-powershell-safely/VERIFICATION.md) |

Repository candidate, tag, stable-install, rollback, and GitHub Release history
is owned by [Repository Verification](VERIFICATION.md).

## Evidence Boundaries

- Project Docs stable behavior proves one mature-layout `NOOP`; it does not
  prove stable mutation or broad real-project adoption.
- Work Charter stable behavior proves flat non-loading and one narrow
  fail-closed recovery/assessment-order boundary; the complete Standard role
  path remains RC evidence rather than stable-layer delivery proof.
- PowerShell stable behavior proves loaded entry plus native/text references
  and one guarded boundary diagnosis. Live WSL, native execution inside the
  stable canary sandbox, actual sandbox-denial injection, and shadow use remain
  unproved.
- No result proves causal efficacy, token savings, broad trigger accuracy,
  deterministic role enforcement, real-project generalization, SHICE, or
  cross-Harness parity.
- Controller and Harness failures remain classified and excluded rather than
  converted into positive evidence. Exact identity is controller-owned, not
  based on model self-reported hashes.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, and `docs/AUTHORITY.md`.
2. Read [Repository Status](STATUS.md), this handoff, and the relevant per-Skill
   State and Verification owners.
3. Resolve live `main`, remote `main`, tag `v0.1.2`, GitHub Release state,
   worktrees, dirty scope, and writer ownership rather than assuming this
   snapshot is still current.
4. Keep `c42eef3...` RC behavior, `ceed607...` release identity, the later
   evidence descendant, and the generated stable/rollback copies distinct.
5. Before any future SOURCE, installation, cleanup, tag, or release action,
   obtain its own explicit authority and re-enter the corresponding Runbook
   procedure.

## Immediate Next Action

No release action remains pending for `v0.1.2`. Complete and locally commit the
four-file governance/checker correction, then merge
`codex/work-charter-v0.2` into `main` with semantic reconciliation of current
state and recovery owners. Verify and native-review both stable diffs. Stop
immediately after the clean local merge, before any new Work Charter product
delta. Other later user-owned choices remain:

- authorize the bounded Work Charter Gate 1 implementation from the clean
  documentation baseline;
- begin another separately scoped development or evaluation cycle;
- authorize a bounded external-optimizer feasibility experiment only after its
  data, isolation, provider, cost, and artifact-write contract is approved;
- retire superseded private-global guidance after its own evidence review;
- remove the retained rollback or ignored evidence only under explicit cleanup
  authorization; or
- leave the verified release state unchanged.

## Stop Conditions

Stop before write or publication if:

- live local/public identity, worktree, dirty scope, or writer ownership differs
  from the expected state;
- a documentation-only evidence update would enter `skills/`, eval cases,
  fixtures, deterministic scripts, discovery, installation, or user config;
- a root summary would duplicate or contradict a per-Skill canonical owner;
- a proposed action would move immutable tag `v0.1.2` or edit a generated
  installed or rollback copy;
- a new install, update, rollback, private-global change, cleanup, tag, or
  release lacks explicit authorization; or
- private paths, task identifiers, raw prompts/completions, secrets, or hidden
  reasoning would enter public source.

## Authorization Boundary

The completed user authorization covers the `v0.1.2` stable update, GitHub
Release, this mapped evidence synchronization, deterministic verification,
native-review gate, one local evidence commit, and fast-forward push. It does
not authorize amend, tag movement, branch/worktree or remote reconfiguration,
private-global edits, retained-evidence cleanup, rollback-copy cleanup, or a
future release.

The 2026-08-02 content authorization covers the capability-delta workflow and
Work Charter design documentation listed above. The subsequent Gate 0
authorization additionally covers same-scope corrections, deterministic
checks, native review, staging, and one local commit of that exact set. Neither
authorization covers push, installation, release, Skill SOURCE or eval-case
changes, branch/worktree creation, private-global mutation, external optimizer
installation or execution, provider/data disclosure, cleanup, or automatic
adoption.

The current closeout authorization supersedes the earlier 2026-08-04
three-file stop only for this bounded sequence: the four-file
governance/checker correction, its deterministic checks and native review, one
local commit, semantic integration of the existing
`codex/work-charter-v0.2` branch, its deterministic checks and native review,
and one local merge commit. It does not authorize push, a new Work Charter
product or eval delta, behavior-model calls, installation, release, global-rule
mutation, external effects, or cleanup.
