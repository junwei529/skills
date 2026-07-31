# Repository Status

Last updated: 2026-07-31

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Public repository | local, tracked, and public `main` resolve to `58fc52600df0e1dc3abd92ba31f031ee2b07db82` | [Handoff](HANDOFF.md) |
| Stable release identity | immutable `v0.1.1` at `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`; exact-SHA RC and tag-pinned loaded-copy proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Historical release identity | immutable `v0.1.0` remains installation evidence but is not the coherent public-release identity because its embedded README predates publication | [Verification](VERIFICATION.md) |
| Project Docs | accepted six-file SOURCE; no current SOURCE delta | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | accepted five-file SOURCE; superseded path retired | [State](skills/work-charter/STATE.md) |
| PowerShell | public exact-commit RC behavior remains `CORRECTION_REQUIRED`; the current dirty SOURCE correction is independently `ACCEPTED` at SOURCE-assisted level, while production `v0.1.1` still predates the hardening | [State](skills/use-powershell-safely/STATE.md) |
| Documentation | federated root/per-Skill structure is public; the current uncommitted delta contains bounded PowerShell RC evidence, native-example correction, and current-state synchronization | [Authority](AUTHORITY.md) |

## Current Repository State

Public commit `58fc52600df0e1dc3abd92ba31f031ee2b07db82`
integrates:

1. the inherited PowerShell SOURCE, case, deterministic check, result, and
   mapped documentation changes; and
2. the authorized federated-document migration, including per-Skill public,
   design, state, and verification owners plus minimum navigation and checker
   support.

The PowerShell implementation, migration, initial SOURCE-behavior, earlier
commit/push, RC, and native-example correction writers relinquished after
their bounded gates. The correction controller is the sole writer for the
currently authorized native-review/commit gate and relinquishes when it
commits or stops. The staged scope contains the sanitized RC evidence,
corrected SOURCE/eval contract, SOURCE-assisted acceptance evidence, and
current-state synchronization; it grants no installed-copy, RC, stable, or
later lifecycle authority.

The exact dirty scope and recovery order are owned by
[Repository Handoff](HANDOFF.md).

## Current Verification Boundary

The federated layout passes all three Skill validators, the repository checker
at 164 text files / 11 cases / 10 fixtures, all 14 fixture checks, 15
PowerShell boundary assertions under both PowerShell 7 and Windows PowerShell
5.1, a six-file PowerShell parser sweep, both Git whitespace checks, and
Gitleaks. The current PowerShell hardening also passes three fresh
SOURCE-assisted behavior contexts, one same-context native/path follow-up, and
an independent assessment with all eight Must surfaces passing and verdict
`ACCEPTED`. The complete staged, unstaged, and untracked candidate passed the
native-review commit gate with no open finding after two P2 current-state
contradictions and two later P2 pre-commit state or roadmap contradictions
were corrected and re-reviewed.

The public exact commit also passed five-file RC materialization, Git-blob and
SHA-256 identity, strict UTF-8/no-BOM, LF/final-newline, zero-reparse,
validator, candidate-only positive selection, loaded entry plus native/text
references, and an ordinary-cmdlet non-trigger. The loaded positive response
did not carry the hardening's fail-closed executable cardinality or separate
stream capture into its user-visible safe example. A separate assessor
therefore returned `CORRECTION_REQUIRED`; this is not an accepted RC behavior
gate.

The current dirty correction now requires complete candidate identity,
arguments, actual stream disposition, exit status, observed runtime/capability,
and material text contract in a user-runnable example. Its final fresh
single-fixture run and independent assessment returned `ACCEPTED`. This is
SOURCE-assisted development evidence only and does not change the earlier
public RC or installed `v0.1.1`.

Per-Skill evidence and gaps:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

## Next Gate

The current authorized gate is native review and commit of the complete staged
candidate. After it succeeds, a later new exact-commit RC requires separate
authorization and must repeat loaded-copy behavior. Stable update,
private-global retirement, retained-evidence cleanup, tag, GitHub Release, and
publication remain later independent gates.

## Known Repository Gaps

- The public PowerShell hardening has exact-commit candidate and loaded-copy
  evidence but lacks accepted corrected RC behavior, stable, live Bash/WSL,
  actual sandbox-denial, and shadow-use evidence. The accepted correction is
  still uncommitted SOURCE-assisted development.
- No Skill has a causal correctness or token-saving comparison.
- Cross-Harness parity and SHICE evaluation remain unproved.
- No GitHub Release object exists; tag-based standalone `v0.1.1` remains the
  supported public identity.
