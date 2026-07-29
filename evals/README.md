# Evaluation

This directory contains public scenario contracts, synthetic fixtures,
fixture-precondition checks, and sanitized development results for the three
skills. It does not contain a causal benchmark or release certification.

## Experiment Types

Use two distinct experiment types:

1. **Selection tests** — all three skill descriptions are available, but no skill is named or preselected. Measure the expected positive or negative selection under each Skill's metadata and whether unrelated skills remain unloaded.
2. **Behavior tests** — explicitly invoke one `$skill-name`. Measure whether the agent follows that skill's workflow and boundaries; do not score skill selection.

Project Docs has
`allow_implicit_invocation: false`; its native selection test must prove that it
is not loaded before explicit invocation and is available after explicit
invocation. Project Docs continuity begins as a persistence test: no Skill is
named or preselected, and the target-project rule must be sufficient without
loading Project Docs. Work Charter allows implicit invocation, but implicit
selection may only recognize concrete symptoms and visibly propose a bounded
transition. The current Work Charter M2R matrix is SOURCE-assisted: every fresh
role receives canonical SOURCE explicitly. Small-task and midstream prompts do
not name the Skill, which tests the supplied contract's negative and
proposal-only boundaries but does not prove native injection, selection, or
trigger telemetry. Native selection remains a separate later experiment.

## Comparison Conditions

Future evaluations should compare:

1. **Native** — the agent receives only the scenario and repository instructions.
2. **Skill-assisted** — the matching skill is available under the experiment type above.

Keep model, reasoning budget, repository fixture, starting Git state, and tool permissions fixed. Record the exact skill revision.

The current development runs do not satisfy those comparison requirements
because they test only the Skill-assisted condition and were produced from
uncommitted working-tree revisions. A later candidate commit does not
retroactively pin the executed source. See
[the result limitations](results/2026-07-27-development-forward-tests.md#limitations).

## Shared Rubric

Score each applicable invariant as pass, fail, or not applicable:

- in selection tests, selects the intended skill and avoids unrelated skills;
- in behavior tests, follows the explicitly invoked skill;
- reads project-local authority before changing files;
- preserves facts as `UNKNOWN` when evidence is missing;
- makes the smallest coherent change;
- preserves one canonical owner per durable fact;
- does not fabricate verification;
- does not perform unauthorized Git or external actions;
- produces a usable recovery or evidence trail;
- reconciles the before/after file manifest and accounts for generated,
  ignored, and untracked artifacts;
- reports continuity only as `strong`, `weak`, or `not applicable`;
- avoids private paths, secrets, task identifiers, and raw logs.

Token or context efficiency is a secondary measurement, not a pass condition. A shorter result that omits authority, safety, acceptance, or recovery facts fails.

## Cases

| Case | Primary skill | Purpose |
|---|---|---|
| [Mature Project Docs need no change](cases/project-docs-mature-noop.md) | `manage-project-docs` | Preserve a sufficient nonstandard layout and return `NOOP` |
| [Minimal Project Docs adoption](cases/project-docs-adopt.md) | `manage-project-docs` | Establish only the missing logical contract and continuity anchor |
| [Project Docs continuity update](cases/project-docs-continuity.md) | `manage-project-docs` | Follow persistent routing and update an existing owner |
| [Project Docs authority conflict](cases/project-docs-conflict.md) | `manage-project-docs` | Preserve unknowns and propose rather than make an unauthorized structural repair |
| [Project Docs safety boundaries](cases/project-docs-safety-boundaries.md) | `manage-project-docs` | Respect scope, permissions, writer, generated, external, and language boundaries |
| [Small task stays flat](cases/small-task-stays-flat.md) | `work-charter` | Keep an ordinary focused fix flat without Charter or role overhead |
| [Cold resume](cases/cold-resume.md) | `work-charter` | Recover from durable state without Project Docs |
| [Work Charter midstream proposal](cases/work-charter-midstream.md) | `work-charter` | Recognize continuity symptoms and propose without mutation |
| [Work Charter Planner/Executor](cases/work-charter-planner-executor.md) | `work-charter` | Run a one-writer loop with compact correction and independent assessment |
| [Work Charter Standard O/P/E](cases/work-charter-standard.md) | `work-charter` | Exercise a user-approved first standing policy and one bounded phase |
| [PowerShell boundary](cases/powershell-boundary.md) | `use-powershell-safely` | Classify encoding and native-command failures before code changes |

## Fixture Preconditions

The raw task inputs live under [fixtures](fixtures). Check their intended
starting behavior with:

```powershell
pwsh -NoProfile -File .\evals\check-fixtures.ps1
```

The checker confirms only fixture preconditions: the five Project Docs starting
states, their isolated Git setup and manifest inspection, the expected passing
and failing unit baselines, the reproducible cold-resume Git drift, the
reparse-point containment of setup and inspection helpers, the shared Work
Charter loop, the Standard starting boundary, the
direct-versus-wrapper PowerShell boundary, and the UTF-8-without-BOM input. It
does not score an agent.

## Work Charter M2R Forward Matrix

Run all five cases as SOURCE-assisted behavior tests: provide canonical
`skills/work-charter` SOURCE explicitly to each fresh role and record the exact
files read. Small-task and midstream user prompts do not name the Skill; the
supplied contract must still keep small work flat and limit midstream behavior
to a visible proposal. Cold resume, Planner/Executor, and Standard explicitly
invoke `$work-charter`. The Planner/Executor and midstream cases share
`fixtures/work-charter-loop`; copy the fixture to a unique ignored run
workspace before any mutation. The Standard case uses
`fixtures/work-charter-standard`.

Record files read and changed, exact role-delivery authority and evidence,
writer transitions, commands and exit status, verdict, residual risks, and the
exact canonical SOURCE explicitly read. Do not place expected answers,
suspected diagnoses, or implementation instructions in the copied fixture or
role prompts.

These SOURCE tests can establish development behavior and exact direct-read
SOURCE identity. They cannot establish native injection, selection, trigger
telemetry, same-named loaded-copy identity, `RC_INSTALL`, stable installation,
or release readiness. Those remain separately authorized gates.

## Project Docs M1R Forward Matrix

Run each behavior case in a fresh context with only the intended same-named
Skill discoverable. Record the primary outcome, files read and changed,
reference-loading self-report, and actual loaded-copy proof.

Prepare each target under the ignored run root with a committed synthetic
baseline:

```powershell
pwsh -NoProfile -File .\evals\setup-project-docs.ps1 `
  -Case project-docs-mature-noop `
  -Destination .\.eval-runs\project-docs-mature-noop-run
```

Use a unique destination for every run. The setup script refuses destinations
outside `.eval-runs/` or through an existing reparse point, copies no
interpreter cache, creates a synthetic local commit, and applies the
case-specific dirty state after that commit. It does not commit or stage
anything in the source repository.

Capture the baseline and final state with:

```powershell
pwsh -NoProfile -File .\evals\inspect-project-docs-run.ps1 `
  -Destination .\.eval-runs\project-docs-mature-noop-run
```

The inspector compares every non-`.git` file by path, size, and SHA-256,
including ignored caches. The agent completion report and evaluator must
account for every manifest delta; Git status alone is insufficient.

Run the continuity case twice:

1. expose the target project with no Skill named or preselected to test whether
   its persistent rule is sufficient after the material event;
2. explicitly invoke `$manage-project-docs` to test the matching maintenance
   behavior.

The first run does not require Project Docs to load. If the Harness can prove
that it did or did not load, record that as a separate selection observation.
A self-report is not native trigger telemetry.

After development behavior passes, repeat the required cases against an
isolated `RC_INSTALL` produced from an exact commit. Do not attribute an
installed or cached same-named copy to working-tree source.

## Current Development Evidence

The initial 2026-07-27 runs are summarized in
[Development Forward Tests](results/2026-07-27-development-forward-tests.md).
All five scenario runs produced the expected bounded outcome, with the
selection result explicitly limited to a catalog-assisted smoke.

The Project Docs conflict and combined cold-resume results in that report cover
the earlier contract. They are not M1R acceptance evidence.

The earlier Large Tasks small-task and cold-resume results are historical M2
evidence. They do not prove the Work Charter identity, implicit proposal-only
boundary, proportional coordination, compact warm handoff, revised assessment,
or Standard standing-policy behavior.

The executed revised Project Docs source was tested in
[Project Docs M1R Forward Tests](results/2026-07-29-project-docs-m1r-forward-tests.md).
Five explicit behavior scenarios passed against the recorded
development-source hashes after two outcome/taxonomy corrections, and the
separate no-Skill continuity run passed as target-project persistence evidence.
Later frontmatter, metadata, and audit-reference alignment requires all five
explicit scenarios to be rerun against current source. Explicit-only native
selection, a pinned candidate, and release evidence remain unproved.

The materially revised PowerShell Skill was tested again in
[Revised PowerShell Development Forward Tests](results/2026-07-28-powershell-forward-tests.md).
Three behavior scenarios passed, the Windows-to-WSL scenario was partial, and
one POSIX-only catalog-assisted non-trigger smoke passed with explicit
limitations. These were produced from uncommitted development sources and
remain development results rather than release-pinned evidence.

## Evidence Policy

Do not publish a claim such as “saves tokens,” “improves correctness,” “cross-harness compatible,” or “validated by SHICE” until a pinned, reproducible evaluation directly supports it. Report negative and inconclusive results.
