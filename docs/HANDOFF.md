# Repository Handoff

Last updated: 2026-08-03

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
- Writer: one scoped writer in `codex/work-charter-v0.2` owns only native
  review, approved finding handling, affected checks, and one local commit
  over the 18-path dirty boundary that starts from clean pushed
  `92a8c04554e4021ad3c998c97fd733f6554e048f`. It relinquishes on the first
  successful commit or a blocking stop. The main checkout remains integration-
  only; no push, new model matrix or RC, installation, release, private-global
  mutation, or cleanup authority follows

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
approved scope. No prior behavior result transfers to the current dirty bytes.

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
implementation and convergence history culminates in pushed candidate
`92a8c045...`. The current authorized revision changes only one package file
plus mapped documentation and existing eval definitions; it creates no new
package, case, fixture, or checker. Discovery, installation, stable tag, and
release identities remain untouched.

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

No release action remains pending for `v0.1.2`. Complete the authorized native
review, same-scope finding handling, affected checks, and one local commit for
the existing two-stage lazy-entry dirty boundary. On success, relinquish the
writer and stop. Only a later approval naming the resulting exact SHA may
authorize push, RC materialization, or another Gate 2 matrix.

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
- the current correction would add a package file, case, fixture, checker,
  result file, or document outside the predeclared scope;
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

That immediate action is complete. A later explicit approval opened native
review, finding handling, affected checks, and one local commit. After review 1
found a stale activation description, the user approved adding only the root
English/Chinese README pair, expanding the same attempt from 16 to 18 paths.
It does not authorize any other file, push, behavior model calls, RC/discovery/
install changes, integration, release, private-global mutation, external
effects, or cleanup.
