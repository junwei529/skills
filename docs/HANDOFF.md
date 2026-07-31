# Repository Handoff

Last updated: 2026-07-31

## Snapshot

- Repository: Agent Workflow Skills
- Branch: `main`
- Pre-commit local baseline, tracked baseline, and public `main`:
  `58fc52600df0e1dc3abd92ba31f031ee2b07db82`
- Local transition: the authorized commit advances local `main` only after the
  native-review gate passes; public `main` remains at the baseline until a
  separate push authorization
- Public stable identity: immutable `v0.1.1` at
  `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`
- Completed gate: dirty PowerShell native-example correction and fresh
  SOURCE-assisted behavior, with final independent verdict `ACCEPTED`; the
  earlier public exact-commit RC verdict remains `CORRECTION_REQUIRED`
- Writer transition: the correction controller is the sole writer for the
  current native-review/commit gate and relinquishes when that gate commits or
  stops; no lifecycle writer is implied
- Index transition: the eleven paths listed below are expected staged during
  the commit gate and the index is expected empty after a successful commit
- Worktree transition: no unstaged or extra untracked change is expected
  during the commit gate, and the worktree is expected clean after commit

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
process-history document. Both scopes are integrated by public `main`; any
additional worktree change has new ownership.

### Exact-commit PowerShell RC gate

The supported installer materialized `skills/use-powershell-safely` from
public exact commit `58fc52600df0e1dc3abd92ba31f031ee2b07db82`
into one task-owned ignored candidate scope. Controller checks proved five
exact Git blobs, raw and normalized SHA-256 equality, strict UTF-8 without
BOM, LF with one final newline, zero reparse points, validator success, and an
unchanged existing stable installation.

A fresh positive process exposed only the exact-commit same-named candidate,
implicitly loaded its entry plus native/text references, did not load its WSL
reference, stable entry, or private fallback, and diagnosed the nested
argument boundary. An ordinary `Get-Date` process loaded no Skill.

The positive response's safe example omitted the hardening's required
zero/one/many executable cardinality and separate stream capture. A separate
fresh assessor returned `CORRECTION_REQUIRED`. Identity, candidate-only
selection, and loaded-copy evidence stand; accepted RC behavior does not.

### Dirty SOURCE native-example correction

The separately authorized correction changes only the PowerShell entry,
native/process reference, and eval case. It requires a final user-runnable
native command to retain:

- application-only candidate cardinality or one explicit selection rule;
- exact executable and structured arguments;
- truthful and, when material, actually separate stdout/stderr;
- immediate numeric exit status;
- observed runtime/capability evidence for version-specific APIs; and
- every material JSON/text/encoding contract.

The final fresh fixture runner observed a compatible PowerShell 7 runtime with
`ProcessStartInfo.ArgumentList` available, reproduced direct exit `0`, split-argument
exit `2`, and wrapper exit `1`, and provided independent stream capture. A
fresh assessor matched the current five SOURCE hashes and returned
`ACCEPTED`. This is dirty-SOURCE-assisted evidence, not a new commit, native
selection, loaded copy, RC, stable install, or release.

The bounded dirty scope is:

- `docs/HANDOFF.md`;
- `docs/STATUS.md`;
- `docs/VERIFICATION.md`;
- `docs/skills/use-powershell-safely/STATE.md`;
- `docs/skills/use-powershell-safely/VERIFICATION.md`;
- `skills/use-powershell-safely/SKILL.md`;
- `skills/use-powershell-safely/references/native-process-boundaries.md`;
- `evals/cases/powershell-boundary.md`;
- `evals/results/README.md`; and
- `evals/results/2026-07-31-powershell-hardening-exact-commit-rc.md`; and
- `evals/results/2026-07-31-powershell-native-example-correction.md`.

No other Skill SOURCE, fixture, checker, stable installation, discovery
mapping, user configuration, private global guidance, remote, tag, or release
belongs to this dirty scope.

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
- repository checker: 164 text files / 11 cases / 10 fixtures;
- fixture checker: 14 checks pass;
- PowerShell boundary script: 15 assertions pass under PowerShell 7 and
  Windows PowerShell 5.1;
- PowerShell parser sweep: 6 files parse;
- local links, Markdown fragments, bilingual navigation, package shapes, and
  per-Skill owner reachability: pass through repository checker;
- `git diff --check` and `git diff --cached --check`: pass;
- Gitleaks: no leaks;
- inherited index: empty before the authorized commit gate; the current
  eleven-path candidate is staged with no unstaged remainder and is expected
  to leave an empty index after commit; and
- current PowerShell SOURCE behavior: three fresh contexts plus one
  same-context follow-up pass the hardening matrix; independent assessor
  verdict `ACCEPTED`; and
- historical native review for the 38-path hardening/federated candidate now
  at `58fc52600df0e1dc3abd92ba31f031ee2b07db82`: no open finding after two P2
  current-state contradictions were corrected and re-reviewed;
- current eleven-path native review: the controller must obtain a completed
  clean semantic result after the last candidate mutation before commit; this
  handoff does not independently assert that the live gate is satisfied;
- public exact-commit RC identity, validator, candidate-only selection, and
  ordinary-cmdlet non-trigger: pass; and
- independent exact-commit RC behavior: `CORRECTION_REQUIRED` because the
  user-visible example omitted executable cardinality and separate stream
  capture; and
- current dirty native-example correction: final fresh SOURCE-assisted
  single-fixture run and independent assessment `ACCEPTED`.

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

The current authorized action is native review and commit of the complete
eleven-path candidate. After a successful commit, a later fresh RC behavior
gate requires separate authorization and must use the new identity. Stable
update, private-global migration, retained-evidence cleanup, tag, release, and
push remain separate later gates.

## Stop Conditions

Stop before write if:

- local or public `main`, index, worktree, or writer ownership differs from
  the transition state described in this snapshot;
- a further PowerShell correction is needed without new SOURCE authority;
- a root summary would duplicate or contradict a per-Skill canonical owner;
- an evidence claim cannot be mapped to exact SOURCE or loaded-copy identity;
- any action requires staging, commit, install, configuration, remote, push,
  tag, release, or cleanup authority not explicitly granted; or
- a private path, account, host fact, task identifier, raw prompt, completion,
  or hidden reasoning would enter public source.

## Unauthorized Actions

After activation, this handoff does not authorize further SOURCE repair,
staging, native review, commit or amend, branch/worktree changes, remote
changes, push, tag, GitHub Release, DEV_DISCOVERY changes, another RC or stable
installation, user configuration, private-global edits, or cleanup of retained
evidence and rollback roots.
