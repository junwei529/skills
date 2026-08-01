# Repository Status

Last updated: 2026-08-01

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Tested candidate identity | public and local `main` resolved to `c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` for all three exact-commit RC runs; a later evidence-only descendant must not replace that identity | [Verification](VERIFICATION.md) |
| Stable release identity | immutable `v0.1.1` at `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`; exact-SHA RC and tag-pinned loaded-copy proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Project Docs | `READY_FOR_RELEASE_CANDIDATE` at `c42eef3...`; exact six-file loaded copy plus four fail-closed explicit canaries and ordinary non-selection independently accepted | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | `READY_FOR_RELEASE_CANDIDATE` at `c42eef3...`; flat non-loading and one complete bounded synthetic Standard Phase One pass | [State](skills/work-charter/STATE.md) |
| PowerShell | `READY_FOR_RELEASE_CANDIDATE` at `c42eef3...`; corrected loaded-copy positives/negatives, executed native/text boundary, and dual-runtime checks pass | [State](skills/use-powershell-safely/STATE.md) |
| Documentation | federated root/per-Skill ownership is active; this evidence-only gate changes repository documents and sanitized results, not installable packages | [Authority](AUTHORITY.md) |

## Current Repository State

Public and local `main` resolved to exact candidate
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` before the three current RC runs.
Immutable `v0.1.1` remains the stable identity and predates all three current
packages.

At a dirty or staged checkout, the bounded evidence-only delta containing the
three current sanitized results and mapped canonical-state updates is the
active commit/push gate. Only when local `HEAD` and public `main` resolve to the
same clean pushed descendant containing those records has that gate completed
and the Release & Git Custodian relinquished. A clean local-only descendant
keeps the push gate active. In every state, `c42eef3...` remains the tested
candidate; the evidence-only descendant is not a new candidate and must not
silently receive a later tag.

The exact scope and recovery order are owned by
[Repository Handoff](HANDOFF.md).

## Current Verification Boundary

All three current candidates were installed from exact public `c42eef3...`,
matched their 6/5/5 Git blobs, passed strict UTF-8/no-BOM and non-reparse checks,
and proved the actually loaded copy while keeping stable `v0.1.1` unchanged.
Project Docs has a bounded fail-closed matrix, PowerShell has corrected
positive/negative boundary evidence, and Work Charter has a complete bounded
synthetic Standard Phase One. Counted and excluded attempts and all residual
limits remain in the per-Skill ledgers and sanitized result files.

Per-Skill evidence and gaps:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

## Next Gate

At a dirty or staged checkout, finish the authorized evidence-only native
review, local commit, and fast-forward push. At a clean pushed descendant
containing the records, the next user-owned lifecycle decision is whether to
create a new immutable repository tag that maps specifically to tested
candidate `c42eef3...`; stable update and loaded-copy proof would follow only
under their own authorization. Private-global retirement, retained-evidence
cleanup, and GitHub Release remain separate decisions.

## Known Repository Gaps

- Project Docs current RC recovery is fail-closed, not a persistent RC
  `UPDATE`; stable mutation, broad triggers, and real-project behavior remain
  unproved.
- PowerShell still lacks current stable, live Bash/WSL, actual sandbox-denial,
  and shadow-use evidence.
- No Skill has a causal correctness or token-saving comparison.
- Work Charter's full Standard evidence remains one synthetic bounded path; it
  does not prove deterministic role delivery or writer locking, current stable,
  broad triggers, real-project efficacy, or standalone causality.
- Cross-Harness parity and SHICE evaluation remain unproved.
- No GitHub Release object exists; tag-based standalone `v0.1.1` remains the
  supported public identity.
