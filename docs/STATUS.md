# Repository Status

Last updated: 2026-07-31

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Public repository | `junwei529/skills`; local `main` contains the reviewed change set, while public `main` remains at `af4cdb243a66bad5b8f23bffff4cb48348b8a95c` | [Verification](VERIFICATION.md) |
| Stable release identity | immutable `v0.1.1` at `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`; exact-SHA RC and tag-pinned loaded-copy proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Historical release identity | immutable `v0.1.0` remains installation evidence but is not the coherent public-release identity because its embedded README predates publication | [Verification](VERIFICATION.md) |
| Project Docs | accepted six-file SOURCE; no current SOURCE delta | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | accepted five-file SOURCE; superseded path retired | [State](skills/work-charter/STATE.md) |
| PowerShell | local `main` contains boundary hardening with accepted current-SOURCE behavior, independent assessment, and native review; public `main` and production `v0.1.1` do not contain it | [State](skills/use-powershell-safely/STATE.md) |
| Documentation | federated root/per-Skill structure implemented, reviewed, deterministically verified, and locally committed under Decision 0015 | [Authority](AUTHORITY.md) |

## Current Local State

The reviewed local change set integrates:

1. the inherited PowerShell SOURCE, case, deterministic check, result, and
   mapped documentation changes; and
2. the authorized federated-document migration, including per-Skill public,
   design, state, and verification owners plus minimum navigation and checker
   support.

The PowerShell implementation writer relinquished before the federated
migration. The migration writer and later SOURCE-behavior gate controller also
relinquished after their bounded verification and handoff. The commit-gate
controller is authorized only through the bounded current-state amend; no
writer remains after local closeout.

Any working-tree or index delta after local closeout is a new dirty scope.
Recovery is owned by [Repository Handoff](HANDOFF.md).

## Current Verification Boundary

The federated layout passes all three Skill validators, the repository checker
at 162 text files / 11 cases / 10 fixtures, all 14 fixture checks, 15
PowerShell boundary assertions under both PowerShell 7 and Windows PowerShell
5.1, a six-file PowerShell parser sweep, both Git whitespace checks, and
Gitleaks. The current PowerShell hardening also passes three fresh
SOURCE-assisted behavior contexts, one same-context native/path follow-up, and
an independent assessment with all eight Must surfaces passing and verdict
`ACCEPTED`. The complete staged, unstaged, and untracked candidate passed the
native-review commit gate with no open finding after two P2 current-state
contradictions and two later P2 pre-commit state or roadmap contradictions
were corrected and re-reviewed.

Per-Skill evidence and gaps:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

## Next Gate

Any push of local `main` is a later user-authorized action. After the exact
commit is public, RC installation and loaded-copy proof for the PowerShell
hardening remain separate candidate gates. Stable update, private-global
retirement, retained-evidence cleanup, tag, GitHub Release, and publication
remain later independent gates.

## Known Repository Gaps

- The local PowerShell hardening lacks native selection, loaded-copy,
  candidate, stable, live Bash/WSL, actual sandbox-denial, and shadow-use
  evidence.
- No Skill has a causal correctness or token-saving comparison.
- Cross-Harness parity and SHICE evaluation remain unproved.
- No GitHub Release object exists; tag-based standalone `v0.1.1` remains the
  supported public identity.
