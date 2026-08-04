# Repository Handoff

Last updated: 2026-08-04

## Snapshot

- Repository: Agent Workflow Skills
- Integration checkout: branch `main`; active development branch
  `codex/work-charter-v0.2`
- Released package identity: immutable `v0.1.2` at
  `ceed607152849775b981c54add74bfa30d858e4d`
- GitHub Release:
  [`v0.1.2 — Stable three-Skill release`](https://github.com/junwei529/skills/releases/tag/v0.1.2),
  marked Latest
- Stable installed set: Project Docs 6 files, Work Charter 5 files, PowerShell
  5 files, each matching the `v0.1.2` Git blobs
- Rollback identity: immutable `v0.1.1` retained as a separately verified
  three-package backup
- Writer: starting from clean pushed
  `72db7e9dfe920de5e2017421b22446cf5c8c75e6`, the scoped writer completed
  the current same-contract correction across one package source and every
  mapped existing consumer classified `UPDATE` below, ran deterministic offline
  checks, and relinquished. No repository writer is active. The main checkout
  remains integration-only; no model, A16, sealed-evidence edit, Git, RC,
  installation, integration, release, private-global mutation, or cleanup
  authority follows

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
then applies that capability-delta method to target Work Charter `v0.2.0`.
Gate 1 now implements its natural-language entry, first-read authorization,
proportional protection, durable re-entry, managed-workstream and multi-
worktree reconciliation, four routes, and staged eval definitions in the
existing five-file package. Stable behavior and release identity remain
unchanged at `v0.1.2`.

On 2026-08-03, exact candidate `206c497...` returned from incomplete Gate 2
without acceptance after exposing a task-convergence ambiguity. The accepted
correction binds history to the logical Charter subject and stable checkpoint,
separates qualification from evidence consumption, preserves predecessor
history, and keeps Work Charter, delivery/transport, and native-review budgets
independent. That correction became pushed successor
`92a8c04554e4021ad3c998c97fd733f6554e048f`; the old candidate and its events
remain historical.

The successor passed isolated qualification and began its `Sol/high` reference
matrix. A01-A04 consumed four turns. A03 directly named Work Charter and loaded
the exact candidate. A04 used an indirect installed-Skills request, performed
no command or project read, and proposed a bounded scope, but claimed Work
Charter was selected without loading its `SKILL.md`. Gate 2 hard-stopped; A05-
C04, contrasts, and independent assessment never started. The user then
accepted `WC-AR-D25`: indirect intent must remain an honest metadata proposal,
confirmation loads the full Skill, and project inspection still requires an
approved scope. No prior behavior result transfers to the conditional correction.

That two-stage revision was committed and pushed as exact `72db7e9...`. One
later fixed-turn Standard probe crossed its declared one-shot consumption point
once and completed four fresh primary sessions. It created no subagent
activity, sealed `VIOLATION` for the top level and all three roles, left A16
unexecuted, and permits no retry or retrospective rescore. The product gap is
missing conditional package loading; exact-phrase semantic checks, shell-
fragment attribution, and repeated static inventories are prospective
controller-calibration issues rather than reasons to rewrite the sealed result.

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

Gate 0 is committed at clean baseline
`763a15ee76bc71dd5e16fc22f32966cb0c8c3488`. Gate 1 uses branch
`codex/work-charter-v0.2` and one task-dedicated writer. Its committed
implementation and convergence history now culminates in pushed exact SOURCE
`72db7e9...`. The current authorized correction changes only one package file
plus mapped existing decision, design, state, evidence, evaluation, public-entry,
repository-status, and recovery consumers. It adds no file, package component,
case, fixture, or checker. Discovery, installation, stable tag, and release
identities remain untouched.

Retained ignored evaluation workspaces contain descendant discovery roots from
earlier tests. They are not active merely because a task starts at the
repository root, but a future task started inside one can expose historical or
same-named copies. Re-enumerate the exact working-directory-to-root discovery
chain and fail closed before reusing any retained workspace; do not rely on
this snapshot's contents or counts.

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

No release action remains pending for `v0.1.2`. Deterministic offline
verification and documentation-impact closure for the current conditional-role-
read correction are complete, and no repository writer is active. Commit
eligibility and native-review disposition are recovered from the cumulative
attempt record against the exact final bytes rather than echoed in this tracked
handoff. Commit, push, RC materialization, and behavior-model evidence remain
separately user-authorized.

Later user-owned choices include:

- authorize the bounded Work Charter Gate 2 exact-candidate matrix and RC
  effects for one exact accepted commit;
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
- the current correction would add a new file, case, fixture, checker, result,
  fact class, contract, permission, side effect, or existing consumer outside
  the approved same-fact envelope;
- correction history or consumed evidence would be reset through a new task,
  root, epoch, attempt, or candidate label;
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

The 2026-08-02 Gate 1 authorization covers the named task-dedicated branch and
worktree, one writer, accepted five-file SOURCE and eval-definition changes,
mapped documentation, deterministic checks, native review, and local commits.
It also permits two bounded same-contract correction rounds after assessment.
It does not authorize push, model runs, RC or discovery changes, installation,
integration, tag, release, stable update, private-global mutation, external
optimizer execution, provider/data disclosure, or cleanup.

The narrower 2026-08-03 correction authorization reopens that same worktree for
one writer to change only the existing Work Charter SOURCE reference, mapped
design/state/evidence owners, and existing eval definitions/fixtures/checker,
then run offline verification. It does not authorize a model call, native
review, commit, push, RC or discovery change, installation, integration, tag,
release, stable update, private-global mutation, external effect, or cleanup.

The current `WC-AR-D25` authorization supersedes only that writer's immediate
action: starting from clean pushed `92a8c045...`, one writer may change
`skills/work-charter/SKILL.md`, the predeclared mapped Work Charter owners, and
the three existing selection/entry case definitions, then run offline
verification. It authorizes no new file, native review, commit, push, model
call, RC/discovery/install change, integration, release, private-global
mutation, external effect, or cleanup.

That immediate action is complete. Later approvals opened the same commit
attempt for native review, clear same-scope finding handling, affected checks,
and one local commit while preserving all downstream exclusions. Completed
review history exposed and corrected the stale root bilingual activation entry,
fresh-role full-Skill and conditional-reference loading, stale status/recovery
wording, Decision 0018 metadata, Roadmap and Index lifecycle summaries, and the
per-Skill public README status. Detailed finding, cycle, and coverage accounting
remains in the Work Charter verification owner.

The initial 2026-08-04 authorization reopens the existing task-dedicated
worktree from clean pushed `72db7e9...` for one offline correction. It permits
editing exactly `skills/work-charter/SKILL.md`, Work Charter `DESIGN.md`,
`STATE.md`, and `VERIFICATION.md`, Decision 0018, the existing Standard case,
`evals/README.md`, `docs/STATUS.md`, and this handoff, plus deterministic checks
and their task-owned temporary fixture artifacts. It permits no new file,
sealed S3 change, model call, A16, native review, Git action, discovery or
installation change, integration, release, private-global mutation, external
effect, or cleanup outside normal fixture teardown.

The approved reset cycle later found that current status and recovery wording
still described an earlier boundary. Review then paused while the project first
adopted its documentation-impact closure rule and applied it read-only to this
same logical correction. That closure classified three additional existing
consumers as `UPDATE`: the repository verification ledger and the root bilingual
README entry. The user approved one writer to apply the existing-consumer
envelope, edit only the resulting update set, run affected offline checks, and
stop before native review.

A later same-scope review exposed two loading clarifications: a response may
claim direct activation only after the full Skill body is available in its
current context, and an `L3` run may conditionally read the Standard reference
while explicitly evaluating a transition to `L4` without authorizing that
transition. Exact copy identity is separate: preserve `UNKNOWN` when the runtime
does not expose it and make no revision claim, but do not fail an otherwise
loaded ordinary activation. The bounded consumer audit identified the existing
selection case, and its semantic-synonym pass identified the existing two-turn
entry case, as omitted acceptance consumers. The user approved adding both
existing cases to the update set; no new case, lane, fixture, checker, contract,
or permission was added.

At this material recovery checkpoint, the exact dirty update set is:

- `README.md`;
- `README.zh-CN.md`;
- `docs/HANDOFF.md`;
- `docs/INDEX.md`;
- `docs/ROADMAP.md`;
- `docs/STATUS.md`;
- `docs/VERIFICATION.md`;
- `docs/decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md`;
- `docs/skills/work-charter/DESIGN.md`;
- `docs/skills/work-charter/README.md`;
- `docs/skills/work-charter/README.zh-CN.md`;
- `docs/skills/work-charter/STATE.md`;
- `docs/skills/work-charter/VERIFICATION.md`;
- `evals/README.md`;
- `evals/cases/work-charter-entry.md`;
- `evals/cases/work-charter-planner-executor.md`;
- `evals/cases/work-charter-selection.md`;
- `evals/cases/work-charter-standard.md`; and
- `skills/work-charter/SKILL.md`.

All other inspected package files, shared owners, decisions, neighboring evals,
fixtures, and checker remain `CHECKED_NO_CHANGE`; sanitized results and every
release/install surface are `NOT_APPLICABLE`. This same-contract closure adds no
file, fact class, product contract, permission, side effect, evidence target, or
acceptance boundary. Its original checkpoint authorized no native review,
commit, push, behavior matrix, A16, RC, installation, integration, release,
private-global mutation, external effect, or retained-evidence cleanup; later
native-review authority and results remain in the cumulative commit-attempt
record rather than this tracked snapshot.
