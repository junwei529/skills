# Repository Status

Last updated: 2026-07-31

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Repository identity | Project Docs commit-gate baseline is local `a150a8652111ad7a04b4b8a048e861ee5c91fc93`; verify live local `HEAD` at recovery; public `main` remains `58fc52600df0e1dc3abd92ba31f031ee2b07db82` | [Handoff](HANDOFF.md) |
| Stable release identity | immutable `v0.1.1` at `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`; exact-SHA RC and tag-pinned loaded-copy proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Project Docs | recovery-coherence hardening is independently `ACCEPTED` at SOURCE-assisted level and fully staged at the reviewed commit checkpoint; public/stable copies predate it | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | accepted five-file SOURCE; superseded path retired; no current SOURCE delta | [State](skills/work-charter/STATE.md) |
| PowerShell | local `a150a865...` contains the accepted native-example correction; public `main` and stable `v0.1.1` predate it; the earlier public RC behavior remains `CORRECTION_REQUIRED` | [State](skills/use-powershell-safely/STATE.md) |
| Documentation | federated root/per-Skill ownership is active; the reviewed staged scope is Project Docs hardening, its evidence, and post-PowerShell-commit state convergence | [Authority](AUTHORITY.md) |

## Current Repository State

Commit-gate baseline `a150a8652111ad7a04b4b8a048e861ee5c91fc93`
contains the accepted PowerShell native-example correction and its evidence.
Its writer relinquished after the local commit. Public `main` remains at
`58fc52600df0e1dc3abd92ba31f031ee2b07db82`; no push, corrected RC, stable
update, tag, or release is implied.

At this document's reviewed checkpoint, the Git index contains one authorized,
exact 26-path Project Docs hardening candidate: canonical entry/reference
changes, strengthened existing cases/fixtures/checks, a sanitized result,
per-Skill contract/state/evidence, and the minimum repository current-state
synchronization. There is no unstaged or additional untracked path. No other
Skill SOURCE belongs to this delta, and the authorized commit-gate runner is
the sole writer until the local commit succeeds or the gate stops. If this
snapshot is read from a clean descendant commit, that transition has completed
and the writer has relinquished.

The exact scope and recovery order are owned by
[Repository Handoff](HANDOFF.md).

## Current Verification Boundary

Project Docs now passes its validator, the repository and fixture checks,
fresh current-SOURCE continuity/conflict/safety runs, and a final independent
assessment with verdict `ACCEPTED`. The first continuity run exposed a recovery
target drift and the first conflict result later became stale after a reference
correction; both remain visible and excluded. Current acceptance uses only
fresh correction runs at the final six-file hashes.

PowerShell's local committed correction retains its deterministic dual-runtime
and SOURCE-assisted acceptance evidence. Its public exact-commit RC still has
accepted identity/loaded-copy proof but a `CORRECTION_REQUIRED` behavior
verdict. Work Charter evidence is unchanged.

Per-Skill evidence and gaps:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

## Next Gate

While live `HEAD` remains the baseline and the exact candidate is staged, the
active Project Docs gate is the separately authorized native review and local
commit. Once live `HEAD` contains the candidate and the worktree is clean,
public push and an exact-commit Project Docs RC with actual loaded-copy behavior
are separate later gates.

The next PowerShell lifecycle path likewise requires separate authorization to
push local `a150a865...` and then build a new exact-commit RC. Stable update,
private-global retirement, retained-evidence cleanup, tag, GitHub Release, and
publication remain independent later decisions.

## Known Repository Gaps

- Project Docs hardening acceptance remains SOURCE-assisted; no current native
  selection, loaded copy, exact-commit RC, or stable mutation proof exists.
- PowerShell's committed correction has no public loaded corrected copy, new
  exact-commit RC, stable, live Bash/WSL, actual sandbox-denial, or shadow-use
  evidence.
- No Skill has a causal correctness or token-saving comparison.
- Cross-Harness parity and SHICE evaluation remain unproved.
- No GitHub Release object exists; tag-based standalone `v0.1.1` remains the
  supported public identity.
