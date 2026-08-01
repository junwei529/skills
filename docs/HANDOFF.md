# Repository Handoff

Last updated: 2026-08-01

## Snapshot

- Repository: Agent Workflow Skills
- Branch: `main`
- Development baseline `HEAD`:
  `586d1c45d8630017675a4379a7c91be6ff1cc9d6`
- Public `main`: `58fc52600df0e1dc3abd92ba31f031ee2b07db82`
- Public stable identity: immutable `v0.1.1` at
  `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`
- Index at this reviewed checkpoint: the exact 30-path Work Charter candidate
  is staged
- Worktree at this reviewed checkpoint: no unstaged or additional untracked
  path
- Writer: the Work Charter implementation task relinquished; the authorized
  Release & Git Custodian is the sole writer until the local commit succeeds or
  the gate stops

If this snapshot is read from a clean descendant commit containing the staged
candidate, the commit gate has completed and the Custodian has relinquished.

Baseline `586d1c45...` contains the accepted local PowerShell and Project Docs
hardening commits. Their writers relinquished. Public `main`, exact-commit RC,
and installed `v0.1.1` predate both corrections and the current Work Charter
delta. No push, new RC, stable update, tag, or release is implied.

## Work Charter Writer Scope

### Work Charter SOURCE

- `skills/work-charter/SKILL.md`
- `skills/work-charter/references/coordination-and-recovery.md`
- `skills/work-charter/references/standard-ope.md`
- `skills/work-charter/assets/work-charter.md`

The entry adds one cross-session finality invariant. The coordination reference
owns comparable authority, uncertain non-idempotent delivery, actual-result
evidence, source invalidation, assessment recording, and advisory writer
recovery. The Standard reference applies the recording boundary to read-only
assessment; commit-gate review reordered Planner-verdict recording before
Orchestrator reliance. The existing asset adds conditional prompts. Metadata,
trigger, package shape, roles, verdicts, and correction budget remain
unchanged.

### Product, eval, and evidence

- `docs/decisions/0016-work-charter-authority-assessment-and-evidence-integrity.md`;
- Work Charter `README.md`, `README.zh-CN.md`, `DESIGN.md`, `STATE.md`, and
  `VERIFICATION.md`;
- `evals/cases/work-charter-recovery-integrity.md` and its four-variant
  fixture;
- focused Planner/Executor and Standard case corrections;
- `evals/README.md`, `evals/check-fixtures.ps1`, and the repository checker's
  expected case/fixture sets; and
- minimum `INDEX`, `STATUS`, `HANDOFF`, `ROADMAP`, and repository verification
  synchronization.

No Project Docs or PowerShell SOURCE, installed copy, discovery mapping,
private global rule, user configuration, remote, branch, worktree, tag, or
retained evidence root belongs to this scope.

## Per-Skill Recovery

| Skill | Current state | Evidence |
|---|---|---|
| Project Docs | [State](skills/manage-project-docs/STATE.md) | [Verification](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter | [State](skills/work-charter/STATE.md) | [Verification](skills/work-charter/VERIFICATION.md) |
| PowerShell | [State](skills/use-powershell-safely/STATE.md) | [Verification](skills/use-powershell-safely/VERIFICATION.md) |

Repository candidate, tag, stable-install, and release history remains in
[Repository Verification](VERIFICATION.md).

## Verification At Handoff

- current Work Charter raw SOURCE hashes are recorded in its
  [Verification](skills/work-charter/VERIFICATION.md);
- Work Charter validator: pass;
- repository checker: pass for 175 text files, twelve cases, and eleven
  fixtures before result recording, then pass for 176 public text files,
  twelve cases, and eleven fixtures after result recording and private-run
  cleanup;
- all fifteen fixture checks: pass, including actual ignored-result omission
  from ordinary temporary-repository Git status;
- all three Skill validators, PowerShell parser sweep, and PowerShell 7 plus
  Windows PowerShell 5.1 deterministic boundary checks: pass;
- `git diff --check` and `git diff --cached --check`: pass for the recorded
  delta;
- Gitleaks: pass with no leaks;
- a sole-`DEV_DISCOVERY` pre-review SOURCE matrix and independent assessment
  exercised Decision 0016; the current Standard sequencing correction has
  deterministic and commit-gate review evidence but no fresh-context rerun;
  detailed pass/partial grades are in Work Charter Verification; current RC
  and stable behavior remain untested.
- the temporary development entry was removed, the pre-test stable installation
  was restored byte-for-byte, and a fresh probe observed only the restored
  stable identity; this does not transfer current-SOURCE behavior evidence.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, and `docs/AUTHORITY.md`.
2. Read [Repository Status](STATUS.md), this handoff, and Work Charter
   [State](skills/work-charter/STATE.md) plus
   [Verification](skills/work-charter/VERIFICATION.md).
3. Confirm branch, baseline/public identities, the exact staged checkpoint or
   its clean descendant, ignored scope, worktree list, and writer ownership.
4. Recompute the five Work Charter SOURCE hashes and verify Project Docs and
   PowerShell SOURCE remain outside the diff.
5. Read the current sanitized Work Charter result and preserve its partial
   grades and attribution limits; do not upgrade development evidence to RC or
   stable proof.

## Immediate Next Action

The exact 30-path Work Charter candidate is staged under a separately
authorized native-review and local-commit gate. Finish the repository commit
policy and create the local commit only if the staged scope and single-writer
boundary remain intact.

If live `HEAD` is a clean descendant containing this checkpoint, the local
commit gate has completed. Public push and a new exact-commit Work Charter RC
then remain separate lifecycle decisions.

## Stop Conditions

Stop before write if:

- local/public identity, index, worktree, or writer ownership differs from
  this snapshot;
- Work Charter SOURCE no longer matches its recorded current hashes;
- a proposed correction would add a trigger, role, verdict, package file,
  deterministic guarantee, lifecycle identity, or another Skill SOURCE;
- a root summary would duplicate or contradict a per-Skill canonical owner;
- an action requires staging, native review, commit, install, configuration,
  remote, push, tag, release, or cleanup authority not explicitly granted; or
- private paths, task identifiers, raw prompts/completions, or hidden reasoning
  would enter public source.

## Unauthorized Actions

This handoff does not itself grant action authority. A separate user
instruction authorizes only staging, native review, same-scope finding repair,
verification, and one local commit for the exact 30-path candidate. It does not
authorize any additional role task, amend, branch/worktree change, remote
change, push, tag, GitHub Release, `DEV_DISCOVERY`, `RC_INSTALL`, stable
installation or update, user configuration, private-global edit, or cleanup.
