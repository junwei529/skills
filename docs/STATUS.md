# Repository Status

Last updated: 2026-08-02

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Tested package identity | all three package byte sets independently reached exact-commit RC readiness at `c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` and were re-proved at tag/stable identity `v0.1.2` | [Verification](VERIFICATION.md) |
| Stable release identity | immutable [`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2) at `ceed607152849775b981c54add74bfa30d858e4d`; exact tag, stable loaded-copy, and GitHub Release proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Project Docs | released six-file `v0.1.2` stable copy; exact loaded identity and mature `NOOP` canary pass | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | released five-file `v0.1.2` stable copy remains active; target `v0.2.0` Gate 1 has a five-file local SOURCE and eval-definition implementation on `codex/work-charter-v0.2`, with behavior and candidate evidence pending | [State](skills/work-charter/STATE.md) |
| PowerShell | released five-file `v0.1.2` stable copy; corrected loaded identity and guarded native/text diagnosis pass; live WSL remains unproved | [State](skills/use-powershell-safely/STATE.md) |
| Release lifecycle | `v0.1.2` tag, stable update, tag-pinned canaries, and Latest GitHub Release complete; `v0.1.1` retained as rollback identity | [Runbook](RUNBOOK.md) |

## Current Repository State

Exact package behavior was tested at public commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`; its sanitized evidence was later
committed and pushed in descendant
`801139eb36c99c393011e2328b839165e8a216a5`. Release-preparation commit
`ceed607152849775b981c54add74bfa30d858e4d` preserved all 6/5/5 package blobs,
passed its own exact public installer and loaded-copy gate, and is now the
immutable `v0.1.2` tag, verified stable installation, and Latest GitHub
Release. Immutable `v0.1.1` remains retained as rollback identity.

The Gate 1 branch contains a later five-file Work Charter SOURCE revision and
eval definitions only. Version-neutral README installer commands remain the
supported interface; the live release ledger still selects `v0.1.2` as the
current accepted tag and installed identity.

[Decision 0018](decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md)
records the accepted rationale, level model, adoption and re-entry behavior,
evaluation design, and separately authorized lifecycle gates for target Work
Charter `v0.2.0`. Gate 1 implements the SOURCE and eval definitions locally;
it does not change the stable installation, candidate evidence, or release
identity.

The exact scope and recovery order are owned by
[Repository Handoff](HANDOFF.md).

## Current Verification Boundary

All three current candidates were installed from exact public `c42eef3...`,
matched their 6/5/5 Git blobs, passed strict UTF-8/no-BOM and non-reparse checks,
and proved the actually loaded candidate copy while keeping stable `v0.1.1`
unchanged. The later exact tag `v0.1.2` repeated 6/5/5 Git-blob and installed
identity, preserved `v0.1.1` as rollback, and ran fresh stable loaded-copy
canaries through isolated repository-scoped discovery plus a shared non-loading
negative.
Project Docs has a bounded fail-closed matrix, PowerShell has corrected
positive/negative boundary evidence, and Work Charter has a complete bounded
synthetic Standard Phase One. Counted and excluded attempts and all residual
limits remain in the per-Skill ledgers and sanitized result files.

Per-Skill evidence and gaps:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

## Next Gate

No release action remains pending for `v0.1.2`. Gate 1 local implementation is
bounded to branch `codex/work-charter-v0.2` from baseline `763a15ee...` and
awaits source-task assessment. The separately authorized correction loop may
return to that writer at most twice. Gate 2 model/candidate evaluation, push,
installation, integration, release, stable update, and cleanup remain
unapproved.

## Known Repository Gaps

- Project Docs current stable proof is mature `NOOP`, not persistent `UPDATE`;
  stable mutation, broad triggers, and real-project behavior remain
  unproved.
- PowerShell still lacks live Bash/WSL, native execution inside the stable
  canary sandbox, actual sandbox-denial injection, and shadow-use evidence.
- No Skill has a causal correctness or token-saving comparison.
- Work Charter's full Standard evidence remains one synthetic bounded RC path;
  its stable proof is narrower and does not prove deterministic role delivery
  or writer locking, broad triggers, real-project efficacy, or standalone
  causality. Decision 0018's entry, level, and re-entry behavior is implemented
  in local SOURCE but remains behavior-untested; its model matrix is definition-
  only and unrun.
- Cross-Harness parity and SHICE evaluation remain unproved.
- Private-global retirement and retained rollback/evidence cleanup remain
  separately authorized lifecycle work.
