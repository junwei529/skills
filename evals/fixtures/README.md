# Evaluation Fixtures

These fixtures are synthetic repositories used for fresh-context behavior
tests. They contain task inputs only. Expected outcomes and scoring rules stay
outside the copied run workspace so the agent under test does not receive the
answer through the fixture.

For each run:

1. copy one fixture into an ignored `.eval-runs/` workspace; use
   `evals/setup-project-docs.ps1` for Project Docs cases and
   `evals/setup-cold-resume.ps1` for cold resume so Git state is reproducible;
   use ordinary isolated copies for the shared Work Charter loop and Standard
   fixtures;
2. copy only the selected skill into a separate directory beside it;
3. give a fresh agent the skill path, workspace path, and user request;
4. for Project Docs, use `evals/inspect-project-docs-run.ps1` before and after
   the task, then inspect the resulting files and commands;
5. for Work Charter, keep expected verdicts, diagnoses, and role prompts
   outside the copied workspace and record role delivery separately from role
   self-report;
6. publish a sanitized result summary, not the raw conversation or runtime
   identifiers.

The fixtures use only synthetic names, data, and code. They must not contain
private repositories, real credentials, host paths, or copied session material.
