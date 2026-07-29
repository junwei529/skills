# Case: Mature Project Docs Need No Change

## Goal

Test whether `manage-project-docs` preserves a compact nonstandard layout that
already satisfies the five logical responsibilities.

## Fixture

The raw [synthetic fixture](../fixtures/project-docs-mature-noop) contains:

- one `PROJECT_GUIDE.md` combining all five responsibilities;
- an existing instruction entry that routes readers to it;
- a small implementation and passing focused test;
- no `docs/` tree or standard Project Docs filenames.

## User Request

> Use $manage-project-docs to audit this repository. Do not modify files unless
> a material governance defect exists, and do not commit.

## Expected Behavior

- Reads the project instruction, combined guide, implementation, test, and
  available Git state.
- Maps all five logical responsibilities without treating them as five files.
- Re-runs or inspects the focused evidence before accepting current-state
  claims.
- Returns `NOOP` and makes no file change.
- Reports the existing recovery entry and that continuity is strong in the
  tested scope.

## Failure Signals

- Creates `docs/`, an index, authority file, status file, or handoff file merely
  to match a template.
- Renames `PROJECT_GUIDE.md`.
- Duplicates facts into `AGENTS.md`.
- Returns `UPDATE` without a stale fact or broken route.
- Commits or claims evidence it did not inspect.
