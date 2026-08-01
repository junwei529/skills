# Repository Status

Last updated: 2026-08-01

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Repository identity | local and public `main` resolve to `d7812408fc55a3fad79ae02a8d31665a2255b99c`; the exact fifteen-path Work Charter RC evidence and canonical-state synchronization delta is staged for an authorized local commit gate | [Handoff](HANDOFF.md) |
| Stable release identity | immutable `v0.1.1` at `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`; exact-SHA RC and tag-pinned loaded-copy proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Project Docs | public `main` contains recovery-coherence hardening accepted at SOURCE-assisted level; stable `v0.1.1` predates it | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | public `d781240...` has exact five-file RC identity, an explicit current-Standard loaded-copy canary, and a flat non-loading canary; stable `v0.1.1` predates it | [State](skills/work-charter/STATE.md) |
| PowerShell | public `main` contains the accepted native-example correction; the earlier public RC behavior remains `CORRECTION_REQUIRED`, and stable `v0.1.1` predates the correction | [State](skills/use-powershell-safely/STATE.md) |
| Documentation | federated root/per-Skill ownership is active; Decision 0016 and Work Charter per-Skill owners contain the current product delta | [Authority](AUTHORITY.md) |

## Current Repository State

Local and public `main` now resolve to
`d7812408fc55a3fad79ae02a8d31665a2255b99c`, which contains the accepted
PowerShell, Project Docs, and Work Charter hardening commits. Immutable
`v0.1.1` remains the stable identity and predates all three corrections.

At this reviewed checkpoint, the index contains exactly the fifteen-path Work
Charter RC evidence and canonical-state synchronization delta, with no unstaged
or additional untracked path.
The ignored isolated RC root is retained evidence and is not a source or Git
candidate. The RC evidence runner relinquished, and the separately authorized
Release & Git Custodian is the sole writer until the local commit succeeds or
the gate stops. If this snapshot is read from a clean descendant containing the
delta, that commit gate has completed and the Custodian has relinquished.

The exact scope and recovery order are owned by
[Repository Handoff](HANDOFF.md).

## Current Verification Boundary

Project Docs and PowerShell retain their recorded SOURCE/development evidence;
their current public corrections still lack new exact-commit RC proof.

Current Work Charter SOURCE and its isolated `d781240...` RC match all five Git
blobs. The RC is strict UTF-8 without BOM, has no internal reparse point, and
passes its validator. A fresh explicit process loaded the candidate entry plus
current Standard reference and enforced Planner-verdict recording before
Orchestrator reliance or Phase Two. A separate flat process did not load the
Skill. One process-local TOML quoting attempt failed before Codex execution and
is excluded. The earlier stable five-file manifest remained unchanged.

Per-Skill evidence and gaps:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

## Next Gate

The active repository gate is the authorized evidence-only native review and
one local commit for the exact fifteen paths. Push, stable update, private-global
retirement, tag, GitHub Release, cleanup, and publication remain separate
decisions.

## Known Repository Gaps

- Project Docs hardening acceptance remains SOURCE-assisted; no current native
  selection, loaded copy, exact-commit RC, or stable mutation proof exists.
- PowerShell's committed correction has no public loaded corrected copy, new
  exact-commit RC, stable, live Bash/WSL, actual sandbox-denial, or shadow-use
  evidence.
- No Skill has a causal correctness or token-saving comparison.
- Work Charter now has a narrow exact-current RC canary, but no current stable,
  full Standard role-delivery, implicit Standard selection, real-project,
  broad-trigger, or standalone causal proof.
- Cross-Harness parity and SHICE evaluation remain unproved.
- No GitHub Release object exists; tag-based standalone `v0.1.1` remains the
  supported public identity.
