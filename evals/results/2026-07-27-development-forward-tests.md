# Development Forward Tests

Date: 2026-07-27

## Evidence Boundary

Each behavior test used a fresh Codex subagent with no prior conversation
turns. The selected skill and synthetic fixture were copied into an ignored,
isolated run directory. The agent received a synthetic user request and could
modify only its copied workspace.

The exact model build, Provider configuration, and released skill commit were
not independently pinned. These are development tests of the current working
tree, not release-reproducible or causal evidence.

The PowerShell Skill was materially revised after these runs on 2026-07-28.
Its result below remains evidence for the earlier spaced-path
argument-transport branch only. It does not validate the revised
runtime-readiness gate, three-reference routing, PowerShell 7 recommendation or
installation boundary, or the expanded version/text/WSL matrix.

The result summaries below were reconstructed from the final workspace,
focused command results, and a sanitized completion summary. Raw conversations,
runtime identifiers, absolute paths, and temporary workspaces are excluded.

## Results

| Test | Invocation | Verdict | Material evidence |
|---|---|---|---|
| Project Docs conflict | Explicit behavior test | pass | Existing filenames preserved; six documentation files changed; implementation, tests, and the user-owned dirty file preserved; one existing test passed; partial coverage and unimplemented priority parsing remained explicit. |
| Small task stays flat | Explicit behavior test | pass | One source file changed by one focused correction; two tests passed; no Phase, Planner, Executor, Orchestrator, or handoff artifact appeared. |
| PowerShell boundary | Explicit behavior test | pass | Direct argument-preserving invocation exited `0`; the nested command-string wrapper exited nonzero after splitting a spaced path; the workspace remained unchanged and the agent reported no system mutation. |
| Cold resume drift | Two explicit skills | pass | Recorded branch and commit were absent from the actual unborn `main`; the owned dirty implementation remained unchanged; the agent stopped before writing or testing. |
| Small-task selection smoke | Catalog-assisted; no skill preselected | pass with limitation | The agent reported applying no skill, made the same focused correction, passed two tests, and created no coordination artifact. Native trigger telemetry was unavailable. |

## Normalized Prompts

Paths were replaced with logical locators. The task content is otherwise
preserved.

### Project Docs conflict

```text
Use $manage-project-docs at <isolated-skill-copy> to audit and repair the
documentation in <fixture-workspace> so another agent can resume safely.
Do not change implementation or commit anything.
```

### Small task stays flat

```text
Use $manage-large-tasks at <isolated-skill-copy> to fix the off-by-one error in
<fixture-workspace> and verify it. Do not commit.
```

### PowerShell boundary

```text
Use $use-powershell-safely at <isolated-skill-copy> to diagnose why the
verifier says the JSON is invalid only when run from PowerShell in
<fixture-workspace>. Do not modify system configuration.
```

### Cold resume drift

```text
Use $manage-project-docs and $manage-large-tasks from <isolated-skill-copies>
to resume the approved phase in <fixture-workspace> from the repository
documentation. Verify the current state before writing. Do not commit.
```

### Small-task selection smoke

```text
Optional workflow skills are available under <isolated-skill-catalog>. Without
assuming that a skill is required, fix the off-by-one error in
<fixture-workspace> and verify it. Read only the skill descriptions needed to
decide whether one applies, and do not commit.
```

## Per-Test Evidence

### Project Docs conflict

- The starting README claimed all of Feature A was complete.
- Source and tests established only label normalization; priority parsing raised
  `NotImplementedError` and had no test coverage.
- The resulting diff changed `README.md`, `docs/MAP.md`, `docs/PRODUCT.md`,
  `docs/NOW.md`, `docs/CONTINUE.md`, and `docs/CHECKS.md`.
- Existing nonstandard document names remained in place.
- The authority map assigned product contract, current state, recovery, and
  evidence responsibilities without creating a parallel documentation tree.
- The unrelated dirty `src/user_notes.py` content was byte-for-byte preserved.
- The focused unit suite passed its one existing test. The result was recorded
  as partial evidence, not Feature A acceptance.
- No commit was created.

### Small task stays flat

- The baseline focused suite failed on inclusive endpoint counting.
- The resulting unstaged diff contained only `src/range_utils.py`, changing
  `end - start` to `end - start + 1`.
- The focused suite passed both tests after the change.
- No coordination or phase artifact was created.
- No commit was created.

### PowerShell boundary

- The JSON input decoded as strict UTF-8 and had no BOM.
- Calling the Python verifier directly with separate arguments returned
  `valid` and exit code `0`.
- The wrapper flattened the verifier path, option, and spaced input path into a
  command string, then sent it through another `pwsh -Command` parser.
- The wrapper reported an extra `file.json` argument and exited nonzero.
- The agent identified argument transport as the failing boundary and proposed
  a direct argument-array invocation.
- The workspace had no unstaged or untracked change after diagnosis.
- No independent host-state audit was performed, so the absence of system
  mutation relies on the agent report rather than filesystem evidence from the
  fixture.

### Cold resume drift

- Durable documents recorded branch `phase/retry-delay`, commit `7d3c0de`, and
  one owned dirty implementation file.
- The actual fixture was on unborn `main`; the recorded branch, commit object,
  and `HEAD` did not exist.
- The only unstaged file remained the pre-existing owned implementation.
- The agent reported recovery drift and stopped before writing, switching,
  staging, running acceptance tests, or committing.

### Small-task selection smoke

- All three skill descriptions were available in a catalog, but no skill was
  named in the task.
- The agent self-reported applying no skill.
- The resulting code and verification matched the focused flat behavior test.
- This demonstrates a useful no-overhead outcome in one catalog-assisted run.
  It does not prove which descriptions a native Harness would load or expose.

## Demonstrated Skill Changes

No concrete workflow defect was demonstrated by these runs, so the skill
instructions were not changed merely to create a diff. The evidence and
fixture system were strengthened instead.

This statement describes the 2026-07-27 run. A later independent design review
and user decision changed the PowerShell product scope; that change requires a
new forward test rather than retroactive reinterpretation of this result.

## Independent Read-Only Review

A separate agent compared the three first-round workspaces with their public
case rubrics and reran cheap focused checks. It confirmed the material
observable outcomes as passing and found no publication-unsafe path, task
identifier, Codex data, or secret in the edited fixture documents.

The review kept process-only claims unknown where filesystem evidence could not
prove them. In particular, it could not prove every file read, parser-boundary
count, external role-session absence, or unchanged host profile and policy.
Those unknowns are evidence limits, not demonstrated skill defects.

## Limitations

- No Native-versus-Skill control comparison was run.
- No token or context-use measurement was recorded.
- The exact model build, Provider configuration, and working-tree revision were
  not pinned.
- The selection smoke relied on an explicit catalog and agent self-report; it
  is not native trigger telemetry.
- Fixtures are synthetic and do not establish behavior across real projects.
- The PowerShell case did not test Windows PowerShell 5.1 or alternate Python
  launchers.
- The PowerShell case predates and does not test runtime-absent, runtime-update,
  user-declined installation, authorized-installation, WSL, legacy-locale, or
  POSIX non-trigger branches.
- No SHICE evaluation was performed.
