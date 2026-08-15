# Work Charter v0.2.0 RC Install And Minimal Smoke

Date: 2026-08-15

## Subject And Evidence Level

This record covers `RC_INSTALL` evidence for branch
`codex/work-charter-v0.2-release-prep` at exact public commit
`67a764a34992772b5ad85625f4703b1f1babf6a3`. The remote branch resolved back
to that exact commit after push. The commit is an RC candidate identity, not a
tag, stable installation, GitHub Release, or release-acceptance verdict.

The public package set remains:

| Skill | Release-set class | Exact identity |
|---|---|---|
| Work Charter | `changed` | five files equal to `c4810057c3f28cca9f12004ca2018784cd21f449`; manifest `04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44` |
| Project Docs | `unchanged` | six files equal to `v0.1.2` / `ceed607152849775b981c54add74bfa30d858e4d` |
| PowerShell | `unchanged` | five files equal to `v0.1.2` / `ceed607152849775b981c54add74bfa30d858e4d` |

## RC Materialization And Identity

The official `skill-installer` workflow materialized all three package paths
from the exact public commit into one isolated RC root. For each package, the
selected file set and every file's Git blob match the candidate tree. All 16
files are ordinary non-reparse files with strict UTF-8, no BOM, LF-only line
endings, and a final newline. The bundled Skill validator passes for all three
packages.

Candidate-only zero-model discovery exposed exactly one same-named Work Charter
entry and resolved its locator to the isolated RC package. The existing stable
same-named entry was disabled only for the child process. No persistent user or
repository configuration changed.

## Minimal Fresh-Process Smoke

| Cell | Result | Bounded observation |
|---|---|---|
| Indirect recovery proposal | `PASS` | One ephemeral read-only process proposed the smallest activation/read scope, requested confirmation, ran no command, and did not claim activation or inspect the project before confirmation. |
| Direct body load and fail-closed scope | `PASS` with historical `UNKNOWN_NOT_ASSESSED` subclaim | A separate process loaded the exact RC `SKILL.md`. The test prompt ambiguously associated its synthetic snapshot with the package directory, so the intended snapshot recommendation was not assessed. The process preserved that fact as `UNKNOWN`, did not search adjacent paths, and returned one fail-closed route. This is a test-scope mismatch, not a product failure. |
| Corrected snapshot recovery | `PASS` / Main-Session review `ACCEPT` | Under one later explicit authorization, one fresh read-only product turn loaded the exact RC coordination reference and only the authorized synthetic snapshot. It returned one fail-closed route, preserved unexposed workspace/writer/evidence facts as `UNKNOWN`, requested only the missing conflict/source-revision facts, recommended `L1`, and rejected Planner/Executor or Standard coordination as unnecessary. |

The corrected cell does not retry, overwrite, or reinterpret the immutable
ambiguous predecessor. The runtime did not expose exact model identity, so the
model remains `UNKNOWN` rather than inferred.

## Terminal Disposition And Limits

- `RC_INSTALL_IDENTITY`: `PASS`
- `CANDIDATE_ONLY_DISCOVERY`: `PASS`
- `IMPLICIT_PROPOSAL_SMOKE`: `PASS`
- `DIRECT_BODY_LOAD_AND_FAIL_CLOSED`: `PASS`
- `SNAPSHOT_RECOVERY_RECOMMENDATION`: `PASS`; the predecessor remains
  historical `UNKNOWN_NOT_ASSESSED`
- Overall: `RC_INSTALL_MINIMAL_SMOKE_PASS`

This result does not claim the full 28-cell Gate 2, a native causal comparison,
broad trigger accuracy, cross-model behavior, real-project efficacy,
deterministic permission/locking/routing, stable installation, tag, GitHub
Release, or final release acceptance. D55 remains sealed historical
`QUALIFICATION_FAILED / PRODUCT_UNKNOWN`; it was not repaired, retried, or used
as product evidence.

The authorized external effects ended at the public branch push and isolated
RC materialization. No persistent configuration change, merge, tag, stable
update, GitHub Release, cleanup, or publication beyond that branch occurred.
