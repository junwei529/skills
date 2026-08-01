# Repository Handoff

Last updated: 2026-08-01

## Snapshot

- Repository: Agent Workflow Skills
- Branch: `main`
- Exact package-behavior candidate:
  `c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`
- Pushed evidence descendant:
  `801139eb36c99c393011e2328b839165e8a216a5`
- Public stable identity: immutable `v0.1.1` at
  `f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`
- Candidate verdicts: Project Docs, Work Charter, and PowerShell are each
  `READY_FOR_RELEASE_CANDIDATE` for exact `c42eef3...`
- Writer: all three Skill writers, RC runners, and cleanup owners relinquished;
  the separately authorized Release & Git Custodian owns only the bounded
  release-document preparation, native-review, commit, fast-forward push, and
  exact-commit isolated RC window

The release-preparation snapshot changes distribution and lifecycle documents,
not installable packages. Its final commit becomes eligible for a later tag
decision only after local/public identity, clean materialization, and loaded-copy
proof pass for that exact commit. Package-blob equivalence with `c42eef3...`
preserves bounded behavior relevance but cannot substitute for the new
commit's installation and identity proof.

## Intended Release-Preparation Scope

The bounded repository delta contains exactly sixteen tracked documentation
paths and no file under `skills/`, no eval case, fixture, result, deterministic
script, discovery mapping, installation, or user configuration:

- `README.md`
- `README.zh-CN.md`
- `docs/RUNBOOK.md`
- `docs/STATUS.md`
- `docs/VERIFICATION.md`
- `docs/HANDOFF.md`
- `docs/ROADMAP.md`
- `docs/skills/manage-project-docs/README.md`
- `docs/skills/manage-project-docs/README.zh-CN.md`
- `docs/skills/manage-project-docs/STATE.md`
- `docs/skills/work-charter/README.md`
- `docs/skills/work-charter/README.zh-CN.md`
- `docs/skills/work-charter/STATE.md`
- `docs/skills/use-powershell-safely/README.md`
- `docs/skills/use-powershell-safely/README.zh-CN.md`
- `docs/skills/use-powershell-safely/STATE.md`

Any additional staged, unstaged, or non-ignored untracked path is drift and
stops this gate.

## Per-Skill Recovery

| Skill | Current state | Evidence |
|---|---|---|
| Project Docs | [State](skills/manage-project-docs/STATE.md) | [Verification](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter | [State](skills/work-charter/STATE.md) | [Verification](skills/work-charter/VERIFICATION.md) |
| PowerShell | [State](skills/use-powershell-safely/STATE.md) | [Verification](skills/use-powershell-safely/VERIFICATION.md) |

Repository candidate, tag, stable-install, and release history remains in
[Repository Verification](VERIFICATION.md).

## `c42eef3` Candidate Evidence At Handoff

Shared identity and preservation:

- local and public `main` resolved to exact commit `c42eef3...` before the
  three runs;
- `$skill-installer` materialized each exact Skill path from that public ref
  into an isolated candidate environment;
- the candidates contained the exact 6/5/5 Git-blob file sets, strict UTF-8
  without BOM, and no internal reparse point;
- counted processes proved which candidate files loaded while the older stable
  entry was disabled only process-locally; and
- immutable stable `v0.1.1`, tracked SOURCE, persistent configuration, remote
  refs, and other task evidence remained unchanged during each run.

Skill verdicts:

- Project Docs: four explicit candidate-loaded canaries returned mature
  `NOOP`, recovery `STOP`, authority `PROPOSE`, and safety `REPORT`; an ordinary
  negative did not load the Skill; independent assessor `ACCEPTED`.
- PowerShell: two positives loaded only entry plus native/text references and
  preserved cardinality, arguments, streams, exit, runtime, and text contract;
  ordinary-cmdlet and POSIX-only negatives did not load; the controller
  executed exits `0` and `1`; both PowerShell runtimes passed 15/15;
  independent assessor returned `READY_FOR_RELEASE_CANDIDATE`.
- Work Charter: flat non-loading passed; one bounded synthetic Standard Phase
  One used one O/P/E set and one writer, durably recorded Planner acceptance
  before Orchestrator reliance, later durably recorded Orchestrator acceptance,
  passed seven controller assertions, and stopped before Phase Two;
  `READY_FOR_RELEASE_CANDIDATE`.

Excluded attempts and residual limitations remain explicit in the three
sanitized result files. Project Docs did not prove persistent RC `UPDATE`;
PowerShell did not prove live WSL, actual sandbox denial, or shadow use; Work
Charter did not prove deterministic delivery or locks. No result proves current
stable behavior, causal efficacy, token savings, real-project generalization,
cross-Harness parity, a new tag, or a GitHub Release.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, and `docs/AUTHORITY.md`.
2. Read [Repository Status](STATUS.md), this handoff, and the three linked
   per-Skill State and Verification owners.
3. Confirm live branch, HEAD, public `main`, worktree list, exact dirty or
   staged scope, and sole-writer ownership.
4. Confirm either the exact sixteen-path release-preparation delta or its clean
   public descendant, and verify every file under `skills/` remains outside the
   diff.
5. If the descendant has not received exact-commit RC proof, materialize all
   three packages through `$skill-installer` from that public SHA and prove the
   actually loaded copies. If it has, preserve the controlled RC record for
   the later tag decision.
6. Keep tested behavior identity `c42eef3...`, the release-preparation commit,
   and stable `v0.1.1` distinct.

## Immediate Next Action

Use the release-preparation state machine. At a dirty or staged checkout,
finish deterministic checks, native review, local commit, and fast-forward push
for the exact sixteen paths. At its clean public descendant, run the authorized
isolated exact-commit three-Skill RC and proportional loaded-copy canaries. If
that proof passes, stop: `v0.1.2` tag creation/push, stable update, tag-pinned
loaded-copy proof, private-global retirement, retained-evidence cleanup, and
GitHub Release each require a separate authorization.

## Stop Conditions

Stop before write or publication if:

- local/public identity, index, worktree, intended scope, or writer ownership
  differs from this snapshot;
- any file under `skills/` or any eval case, fixture, or script enters the diff;
- a proposed correction changes a trigger, role, verdict, package file,
  deterministic guarantee, or lifecycle identity;
- a release-preparation descendant is about to be tagged without its own
  exact-commit installer and loaded-copy proof;
- a root summary duplicates or contradicts a per-Skill canonical owner;
- a tag, stable, configuration, installation, cleanup, or GitHub Release action
  lacks its own explicit authorization; or
- private paths, task identifiers, raw prompts/completions, secrets, or hidden
  reasoning would enter public source.

## Unauthorized Actions

This handoff does not itself grant action authority. The active user approval
covers the exact sixteen-path release-preparation edit, deterministic
verification, staging, native-review gate, one local commit, fast-forward push,
and one isolated exact-commit three-Skill RC with proportional loaded-copy
smoke. It does not authorize amend, branch/worktree or remote configuration
change, a tag, stable installation/update, persistent user configuration,
private-global edits, retained-evidence cleanup, or GitHub Release.
