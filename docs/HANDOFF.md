# Repository Handoff

Last updated: 2026-07-31

## Snapshot

- Repository: Agent Workflow Skills
- Branch: `main`
- Commit-gate baseline `HEAD`:
  `a150a8652111ad7a04b4b8a048e861ee5c91fc93`
- Public `main`: `58fc52600df0e1dc3abd92ba31f031ee2b07db82`
- Public stable identity: immutable `v0.1.1` at
  `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`
- Index at this reviewed checkpoint: the exact 26-path Project Docs candidate
  is staged
- Worktree at this checkpoint: no unstaged or additional untracked path
- Commit-gate owner: the authorized Project Docs commit runner is the sole
  writer until the local commit succeeds or the gate stops

Baseline `a150a865...` contains the accepted PowerShell native-example
correction. Public `main`, its earlier exact-commit RC, and installed
`v0.1.1` predate that correction. No push, new RC, stable update, tag, or
release is implied.

## Project Docs Commit Scope

### Project Docs SOURCE

- `skills/manage-project-docs/SKILL.md`
- `skills/manage-project-docs/references/audit-and-adopt.md`
- `skills/manage-project-docs/references/maintain-and-recover.md`

The entry adds only the reader/session/writer distinction and write-time
recheck. The audit reference owns current/history/result-index/authorization,
unique recovery, and immutable-history rules. The recovery reference owns the
coherent state/writer/gate/next/recovery snapshot and exact recovery-target
stability. Metadata and both assets remain unchanged.

### Project Docs eval and evidence

- the existing continuity, conflict, and safety cases;
- their strengthened existing fixtures and fixture checker;
- one immutable-history safety fixture input;
- `evals/results/2026-07-31-project-docs-recovery-coherence-hardening.md`;
- `evals/results/README.md`; and
- Project Docs `DESIGN.md`, `STATE.md`, and `VERIFICATION.md`.

Fresh current-SOURCE correction runs returned `UPDATE/strong`,
`PROPOSE/weak`, and `REPORT/weak`. The first continuity attempt changed a
valid recovery target and was excluded after `CORRECTION_REQUIRED`. Its
reference correction invalidated the first conflict result's SOURCE identity,
so that attempt was also excluded and rerun. A new final assessor returned
`ACCEPTED` using only current-SOURCE correction evidence.

### Current-state convergence

- `docs/STATUS.md` and this handoff now identify the baseline/public identities,
  exact staged candidate, sole commit-gate owner, conditional post-commit
  route, and the next gate.
- PowerShell `STATE.md` and `VERIFICATION.md` now identify the correction as
  locally committed at `a150a865...`, not current dirty/staged work.
- Root `VERIFICATION.md` and `ROADMAP.md` contain bounded repository-level
  synchronization only.

No Work Charter or PowerShell SOURCE, installed copy, discovery mapping,
private rule, user configuration, remote, branch, worktree, tag, or retained
evidence root belongs to this scope.

## Per-Skill Recovery

| Skill | Current state | Evidence |
|---|---|---|
| Project Docs | [State](skills/manage-project-docs/STATE.md) | [Verification](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter | [State](skills/work-charter/STATE.md) | [Verification](skills/work-charter/VERIFICATION.md) |
| PowerShell | [State](skills/use-powershell-safely/STATE.md) | [Verification](skills/use-powershell-safely/VERIFICATION.md) |

Repository candidate, tag, stable-install, and release history remains in
[Repository Verification](VERIFICATION.md).

## Verification At Handoff

- current Project Docs six-file SOURCE hashes are recorded in its
  [Verification](skills/manage-project-docs/VERIFICATION.md);
- Project Docs validator: pass;
- repository checker and all fourteen fixture checks: pass;
- current continuity/conflict/safety correction runs: pass at exact SOURCE;
- final independent assessor: `ACCEPTED`;
- full PowerShell parser sweep: 6 files parse;
- `git diff --check` and `git diff --cached --check`: pass;
- Gitleaks: no leaks;
- links, fragments, bilingual navigation, package shape, and owner routing:
  pass through the repository checker; and
- Project Docs metadata/assets plus all Work Charter and PowerShell SOURCE:
  unchanged from the frozen `a150a865...` identities.

The accepted Project Docs behavior is dirty SOURCE-assisted development
evidence. It is not native selection, loaded-copy, `DEV_DISCOVERY`,
`RC_INSTALL`, stable behavior, commit, push, tag, or release evidence.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, and `docs/AUTHORITY.md`.
2. Read [Repository Status](STATUS.md), this handoff, and Project Docs
   [State](skills/manage-project-docs/STATE.md) plus
   [Verification](skills/manage-project-docs/VERIFICATION.md).
3. Confirm branch, local/public identities, index, tracked/untracked/ignored
   scope, worktree list, and writer ownership.
4. Recompute the six Project Docs SOURCE hashes and verify Work Charter and
   PowerShell SOURCE remain frozen.
5. Do not treat the ignored raw run root as public evidence; use the sanitized
   result and preserve the two excluded attempts in any review.

## Immediate Next Action

The exact 26-path Project Docs candidate is already staged under a separately
authorized native-review/commit gate. Finish the repository commit policy and
create the local commit only if the staged scope and single-writer boundary
remain intact.

If live `HEAD` is a clean descendant containing this checkpoint, the local
commit gate has completed and its writer has relinquished. Public push and a
new exact-commit Project Docs RC are then separate lifecycle decisions. The
local PowerShell commit also needs separate push and corrected RC authority.

## Stop Conditions

Stop before write if:

- local/public identity, index, worktree, or writer ownership differs from
  this snapshot;
- any Project Docs accepted result no longer matches the recorded current
  SOURCE identity;
- a proposed correction would change an outcome, role, required product file,
  structural authorization boundary, or another Skill SOURCE;
- a root summary would duplicate or contradict a per-Skill canonical owner;
- an action requires staging, native review, commit, install, configuration,
  remote, push, tag, release, or cleanup authority not explicitly granted; or
- private paths, task identifiers, raw prompts/completions, or hidden reasoning
  would enter public source.

## Unauthorized Actions

This handoff does not itself grant action authority. A separate user instruction
authorizes only the current Project Docs native-review, staging, and local
commit gate. It does not authorize amend, branch/worktree changes, remote
changes, push, tag, GitHub Release, `DEV_DISCOVERY`, `RC_INSTALL`, stable
installation or update, user configuration, private-global edits, or cleanup
of inherited or task-owned ignored evidence roots.
