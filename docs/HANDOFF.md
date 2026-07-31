# Repository Handoff

Last updated: 2026-07-31

## Snapshot

- Repository: Agent Workflow Skills
- Branch: `main`
- Local `main`: contains the reviewed PowerShell hardening and federated
  documentation change set; its parent baseline is
  `af4cdb243a66bad5b8f23bffff4cb48348b8a95c`
- Public `origin/main`: `af4cdb243a66bad5b8f23bffff4cb48348b8a95c`
- Public stable identity: immutable `v0.1.1` at
  `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`
- Handoff activation: this snapshot becomes current when the bounded
  current-state amend succeeds; the commit-gate controller then relinquishes
  and no writer remains
- Custody after activation: a release custodian may recover the repository
  read-only until a separate push, candidate, install, or release action is
  authorized
- Index and worktree: expected clean at activation

## Integrated Scope And Ownership

### Inherited PowerShell development scope

The PowerShell implementation writer relinquished and transferred these
changes without authorizing further SOURCE repair:

- `skills/use-powershell-safely/SKILL.md`
- `skills/use-powershell-safely/references/native-process-boundaries.md`
- `skills/use-powershell-safely/references/text-encoding-boundaries.md`
- `evals/cases/powershell-boundary.md`
- `evals/check-powershell-boundaries.ps1`
- `evals/results/2026-07-31-powershell-boundary-hardening.md`
- mapped repository documentation and evaluation navigation

These changes add executable-discovery cardinality and identity, one-base path
resolution, cross-shell newline contracts, task-local sandbox remediation, and
a strictly bounded confirmed-Junction fallback. The stable installed
`v0.1.1` copy does not contain them.

Three fresh SOURCE-assisted contexts plus one same-context native/path
follow-up now cover the current hashes, and a separate fresh assessor returned
`ACCEPTED` with all eight Must surfaces passing. The behavior gate changed no
PowerShell SOURCE, discovery, installation, configuration, Git index, remote,
or release state.

### Federated-document migration scope

The authorized Project Docs migration:

- creates five repository-document owners for each Skill under
  `docs/skills/<skill-name>/`;
- records Decision 0015;
- reduces root `SPEC`, `ARCHITECTURE`, `STATUS`, `VERIFICATION`, and `HANDOFF`
  to their repository-level ownership;
- updates root and per-Skill English/Chinese public navigation;
- synchronizes `INDEX`, `AUTHORITY`, `AGENTS`, `ROADMAP`, `RUNBOOK`,
  `PROVENANCE`, and eval result navigation only as required; and
- adds minimum deterministic structure and bilingual-navigation checks.

No installable package receives a README, installation guide, changelog, or
process-history document. Both scopes are integrated by local `main`; any
additional worktree change has new ownership.

## Per-Skill Recovery

| Skill | Current state | Evidence |
|---|---|---|
| Project Docs | [State](skills/manage-project-docs/STATE.md) | [Verification](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter | [State](skills/work-charter/STATE.md) | [Verification](skills/work-charter/VERIFICATION.md) |
| PowerShell | [State](skills/use-powershell-safely/STATE.md) | [Verification](skills/use-powershell-safely/VERIFICATION.md) |

Repository release and shared-candidate history remains in
[Repository Verification](VERIFICATION.md).

## Verification At Handoff

- all three bundled Skill validators: pass;
- repository checker: 162 text files / 11 cases / 10 fixtures;
- fixture checker: 14 checks pass;
- PowerShell boundary script: 15 assertions pass under PowerShell 7 and
  Windows PowerShell 5.1;
- PowerShell parser sweep: 6 files parse;
- local links, Markdown fragments, bilingual navigation, package shapes, and
  per-Skill owner reachability: pass through repository checker;
- `git diff --check` and `git diff --cached --check`: pass;
- Gitleaks: no leaks;
- inherited index: empty and unchanged; and
- current PowerShell SOURCE behavior: three fresh contexts plus one
  same-context follow-up pass the hardening matrix; independent assessor
  verdict `ACCEPTED`; and
- native review: the complete staged, unstaged, and untracked candidate has no
  open finding after two P2 current-state contradictions were corrected and
  re-reviewed.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, `docs/AUTHORITY.md`, and
   [Decision 0015](decisions/0015-federated-repository-documentation.md).
2. Read root [Specification](SPEC.md), [Architecture](ARCHITECTURE.md), and
   [Status](STATUS.md).
3. Inspect live branch, `HEAD`, staged, unstaged, untracked, worktree, and
   writer ownership without changing Git configuration.
4. For one Skill, read its `DESIGN`, `STATE`, and `VERIFICATION` before
   canonical SOURCE or eval results.
5. Read [the Runbook](RUNBOOK.md) before discovery, installation, candidate,
   tag, stable, update, rollback, or release work.
6. Recompute identity and rerun required checks before attributing behavior to
   local SOURCE or a later derived copy.

## Immediate Next Action

The next possible repository action is a separately authorized push of local
`main`. RC installation and loaded-copy proof may follow only after the exact
commit is public and receive their own authorization. Stable update,
private-global migration, retained-evidence cleanup, tag, and release remain
later gates.

## Stop Conditions

Stop before write if:

- local `HEAD` does not contain this handoff, or the index, worktree, or writer
  ownership differs from this snapshot;
- a PowerShell correction is needed without new SOURCE authority;
- a root summary would duplicate or contradict a per-Skill canonical owner;
- an evidence claim cannot be mapped to exact SOURCE or loaded-copy identity;
- any action requires staging, commit, install, configuration, remote, push,
  tag, release, or cleanup authority not explicitly granted; or
- a private path, account, host fact, task identifier, raw prompt, completion,
  or hidden reasoning would enter public source.

## Unauthorized Actions

After activation, this handoff does not authorize amend, branch/worktree
changes, remote changes, push, tag, GitHub Release, DEV_DISCOVERY changes, RC
or stable installation, user configuration, private-global edits, or cleanup
of retained evidence and rollback roots.
