# Repository Handoff

Last updated: 2026-08-01

## Snapshot

- Repository: Agent Workflow Skills
- Branch: `main`
- Development baseline `HEAD` and public `main`:
  `d7812408fc55a3fad79ae02a8d31665a2255b99c`
- Public stable identity: immutable `v0.1.1` at
  `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`
- Index at this reviewed checkpoint: the exact fifteen-path Work Charter RC
  evidence and canonical-state synchronization delta is staged
- Worktree at this reviewed checkpoint: no unstaged or additional untracked
  path
- Ignored evidence: retained isolated Work Charter `RC_INSTALL` and synthetic
  native scope for exact commit `d781240...`
- Writer: the RC evidence runner relinquished; the separately authorized
  Release & Git Custodian is the sole writer until the local commit succeeds or
  the gate stops

If this snapshot is read from a clean descendant commit containing the staged
evidence delta, the commit gate has completed and the Custodian has
relinquished.

Public `main` contains the accepted PowerShell, Project Docs, and Work Charter
hardening commits. Immutable `v0.1.1` and its stable installation predate those
corrections. The current Work Charter-only RC does not imply a stable update,
tag, GitHub Release, or publication.

## Work Charter RC Evidence Scope

### Work Charter SOURCE

- `skills/work-charter/SKILL.md`
- `skills/work-charter/agents/openai.yaml`
- `skills/work-charter/references/coordination-and-recovery.md`
- `skills/work-charter/references/standard-ope.md`
- `skills/work-charter/assets/work-charter.md`

These files are unchanged at public `d781240...`. The RC evidence runner may
read and validate them but must not edit SOURCE or any derived installed copy.

### Product, eval, and evidence

- `docs/HANDOFF.md`;
- `docs/ROADMAP.md`;
- `docs/STATUS.md`;
- root repository `docs/VERIFICATION.md`;
- Project Docs `STATE.md` and `VERIFICATION.md`;
- PowerShell `STATE.md` and `VERIFICATION.md`;
- Work Charter `README.md`, `README.zh-CN.md`, `STATE.md`, and
  `VERIFICATION.md`;
- `evals/README.md`;
- `evals/results/README.md`; and
- `evals/results/2026-08-01-work-charter-d781240-exact-commit-rc.md`.

The ignored RC root and its task-specific junction are retained evidence, not
Git candidates. No Skill SOURCE, Project Docs or PowerShell owner, stable
installation, persistent discovery/configuration, private global rule, remote,
branch, worktree, tag, or release change belongs to this scope.

## Per-Skill Recovery

| Skill | Current state | Evidence |
|---|---|---|
| Project Docs | [State](skills/manage-project-docs/STATE.md) | [Verification](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter | [State](skills/work-charter/STATE.md) | [Verification](skills/work-charter/VERIFICATION.md) |
| PowerShell | [State](skills/use-powershell-safely/STATE.md) | [Verification](skills/use-powershell-safely/VERIFICATION.md) |

Repository candidate, tag, stable-install, and release history remains in
[Repository Verification](VERIFICATION.md).

## RC Evidence At Handoff

- public and local `main` resolve to exact commit `d781240...`;
- `$skill-installer` materialized an isolated five-file Work Charter candidate;
- all five files match the selected Git blobs and raw SHA-256, decode as strict
  UTF-8 without BOM, contain no internal reparse point, and pass the Skill
  validator;
- an ephemeral explicit positive process directly read candidate `SKILL.md`
  plus the current Standard reference and passed the Planner-recording order;
- an ephemeral flat negative process returned `703` without loading the Skill;
- one malformed process-local TOML transport failed before Codex execution and
  is excluded; and
- the synthetic workspace stayed clean, repository SOURCE remained unchanged,
  and the complete earlier `v0.1.1` stable manifest remained byte-identical.

- all three Skill validators pass;
- repository checker passes for 177 text files, twelve cases, and eleven
  fixtures;
- all fifteen fixture checks pass;
- PowerShell 7 and Windows PowerShell 5.1 each pass all fifteen boundary
  checks;
- all six tracked eval PowerShell files parse;
- working and cached diff checks pass;
- Gitleaks reports no leaks; and
- the exact staged fifteen-path evidence scope, absence of unstaged or additional
  untracked paths, five candidate Git blobs, clean synthetic workspace, and
  ignored RC root are reverified.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, and `docs/AUTHORITY.md`.
2. Read [Repository Status](STATUS.md), this handoff, and Work Charter
   [State](skills/work-charter/STATE.md) plus
   [Verification](skills/work-charter/VERIFICATION.md).
3. Confirm local/public `d781240...`, the exact staged fifteen-path evidence
   delta or its clean descendant, retained ignored RC root, worktree list, and
   writer ownership.
4. Recompute the candidate's five Git-blob and SHA-256 identities and verify
   all Skill SOURCE remains outside the diff.
5. Read both 2026-08-01 Work Charter results. Preserve the earlier partial
   development grades and the new RC's narrow behavior limits; do not upgrade
   either to current stable or release proof.

## Immediate Next Action

The exact fifteen-path evidence and canonical-state synchronization delta is
staged under the separately authorized native-review/local-commit gate. Finish
the repository commit policy
and create one local commit only if the scope and single-writer boundary remain
intact.

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

This handoff does not itself grant action authority. A separate user instruction
authorizes only staging, native review, same-scope finding repair, verification,
and one local commit for the exact fifteen-path evidence delta. It does not
authorize amend, branch/worktree or remote change, push, tag, GitHub Release,
stable installation/update, persistent configuration, private-global edit, or
cleanup.
