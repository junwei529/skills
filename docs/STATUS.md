# Repository Status

Last updated: 2026-08-01

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Repository identity | current development baseline is local `586d1c45d8630017675a4379a7c91be6ff1cc9d6`; public `main` remains `58fc52600df0e1dc3abd92ba31f031ee2b07db82`; the exact Work Charter candidate is staged at the reviewed checkpoint | [Handoff](HANDOFF.md) |
| Stable release identity | immutable `v0.1.1` at `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`; exact-SHA RC and tag-pinned loaded-copy proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Project Docs | recovery-coherence hardening is independently `ACCEPTED` at SOURCE-assisted level and locally committed at `586d1c45...`; its writer relinquished; public/stable copies predate it | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | the pre-review hardening revision completed a sole-DEV_DISCOVERY matrix and independent bounded `ACCEPTED`; the current candidate adds a narrow review correction with deterministic/review evidence but no exact-current fresh-context rerun | [State](skills/work-charter/STATE.md) |
| PowerShell | local `a150a865...` contains the accepted native-example correction; public `main` and stable `v0.1.1` predate it; the earlier public RC behavior remains `CORRECTION_REQUIRED` | [State](skills/use-powershell-safely/STATE.md) |
| Documentation | federated root/per-Skill ownership is active; Decision 0016 and Work Charter per-Skill owners contain the current product delta | [Authority](AUTHORITY.md) |

## Current Repository State

Local `main` at `586d1c45d8630017675a4379a7c91be6ff1cc9d6` contains the
accepted PowerShell and Project Docs hardening commits. Their writers have
relinquished. Public `main` remains at
`58fc52600df0e1dc3abd92ba31f031ee2b07db82`; no push, corrected RC, stable
update, tag, or release is implied.

At this document's reviewed checkpoint, the Git index contains the exact
30-path Work Charter hardening candidate: four files inside the existing
five-file package, one accepted decision, the Work Charter per-Skill owners and
bilingual entry, focused case/fixture/check/result changes, and minimum root
state/evidence routing. There is no unstaged or additional untracked path. The
implementation writer relinquished, and the authorized Release & Git Custodian
is the sole writer until the local commit succeeds or the gate stops. If this
snapshot is read from a clean descendant containing the candidate, that
transition has completed and the Custodian has relinquished.

Project Docs and PowerShell SOURCE remain outside this completed scope.

The exact scope and recovery order are owned by
[Repository Handoff](HANDOFF.md).

## Current Verification Boundary

Project Docs retains its current-SOURCE acceptance at local commit
`586d1c45...`. PowerShell's local committed correction retains deterministic
dual-runtime and SOURCE-assisted acceptance evidence; its public exact-commit
RC still has accepted identity/loaded-copy proof but a `CORRECTION_REQUIRED`
behavior verdict.

Current Work Charter SOURCE passes its Skill validator, repository checker,
and recovery-integrity fixture precondition. Its pre-review revision exercised
Decision 0016 in fresh contexts and received independent bounded `ACCEPTED`.
The current candidate then received a narrow commit-gate correction that moves
Planner-verdict recording before Orchestrator reliance; it has deterministic
and review evidence but no exact-current fresh-context rerun. Detailed partial
grades and attribution limits remain canonical in its per-Skill verification.
Prior RC and stable results remain valid only for their recorded earlier
revisions.

Per-Skill evidence and gaps:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

## Next Gate

The active Work Charter gate is the separately authorized native review and
local commit for the exact staged candidate. Once live `HEAD` contains the
candidate and the worktree is clean, public push and a new exact-commit Work
Charter RC remain separate later gates. Stable update, private-global
retirement, tag, GitHub Release, and publication are not authorized.

The Project Docs and PowerShell public/candidate paths likewise remain
separate lifecycle decisions.

## Known Repository Gaps

- Project Docs hardening acceptance remains SOURCE-assisted; no current native
  selection, loaded copy, exact-commit RC, or stable mutation proof exists.
- PowerShell's committed correction has no public loaded corrected copy, new
  exact-commit RC, stable, live Bash/WSL, actual sandbox-denial, or shadow-use
  evidence.
- No Skill has a causal correctness or token-saving comparison.
- The pre-review Work Charter Decision 0016 revision has bounded fresh-context
  `DEV_DISCOVERY` proof. The current sequencing correction lacks an
  exact-current rerun, and there is no current RC, stable, real-project,
  broad-trigger, or standalone causal proof.
- Cross-Harness parity and SHICE evaluation remain unproved.
- No GitHub Release object exists; tag-based standalone `v0.1.1` remains the
  supported public identity.
