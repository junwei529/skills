# Repository Status

Last updated: 2026-08-01

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Tested package identity | all three package byte sets independently reached exact-commit RC readiness at `c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`; the pushed evidence descendant is `801139eb36c99c393011e2328b839165e8a216a5` | [Verification](VERIFICATION.md) |
| Stable release identity | immutable `v0.1.1` at `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`; exact-SHA RC and tag-pinned loaded-copy proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Project Docs | `READY_FOR_RELEASE_CANDIDATE` at `c42eef3...`; exact six-file loaded copy plus four fail-closed explicit canaries and ordinary non-selection independently accepted | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | `READY_FOR_RELEASE_CANDIDATE` at `c42eef3...`; flat non-loading and one complete bounded synthetic Standard Phase One pass | [State](skills/work-charter/STATE.md) |
| PowerShell | `READY_FOR_RELEASE_CANDIDATE` at `c42eef3...`; corrected loaded-copy positives/negatives, executed native/text boundary, and dual-runtime checks pass | [State](skills/use-powershell-safely/STATE.md) |
| Release preparation | public READMEs use a version-neutral `<version-tag>` interface; any patch tag requires its own clean public exact-commit RC proof even when the 6/5/5 package blobs are unchanged | [Runbook](RUNBOOK.md) |

## Current Repository State

Exact package behavior was tested at public commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`; its sanitized evidence was later
committed and pushed in descendant
`801139eb36c99c393011e2328b839165e8a216a5`. Immutable `v0.1.1` remains the
recorded stable identity and predates all three current package revisions.

A release-preparation descendant may change only the mapped distribution and
lifecycle documents while preserving all 6/5/5 package blobs. It is not a tag
candidate merely because those blobs match `c42eef3...`: its own exact commit
must be clean, public, installed through `$skill-installer`, and proven as the
actually loaded copy. The version-neutral README interface remains valid both
before and after a later immutable tag is created.

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

Use the release-preparation state machine: if the version-neutral descendant
does not yet have clean public exact-commit RC and loaded-copy proof, complete
that gate; if it does, the next user-owned lifecycle decision is whether to
create immutable patch tag `v0.1.2` at that exact commit. Stable update,
tag-pinned loaded-copy proof, private-global retirement, retained-evidence
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
