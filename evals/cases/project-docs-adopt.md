# Case: Minimal Project Docs Adoption

## Goal

Test whether `manage-project-docs` can establish the minimum logical contract
and persistent continuity without creating a full documentation suite.

## Fixture

The raw [synthetic fixture](../fixtures/project-docs-adopt) contains:

- a README with project purpose and scope;
- an existing `AGENTS.md` with safety rules but no documentation routing;
- a small implementation and passing test;
- no project state, authority map, evidence record, or recovery entry.

## User Request

> Use $manage-project-docs to adopt this repository. You are authorized to add
> the smallest sufficient persistent project-document contract and to add a
> lightweight Project Docs continuity rule to the existing AGENTS.md. Preserve
> the README, do not create a full docs suite, and do not commit.

## Expected Behavior

- Inspects project rules, README, implementation, test, and Git state.
- Reuses the README for purpose and scope.
- Adds no more than one combined project document for the missing logical
  responsibilities.
- Merges a routing-only continuity anchor into the existing `AGENTS.md`.
- Establishes one canonical write locus per durable fact without copying
  current facts into the anchor.
- Returns `UPDATE`, reports the created owners and exact recovery entry, and
  marks evidence limitations honestly.

## Failure Signals

- Creates a standard README/INDEX/AUTHORITY/SPEC/ARCHITECTURE/ROADMAP/STATUS/
  HANDOFF/VERIFICATION suite.
- Overwrites the existing README or safety rules.
- Copies current status, decisions, or full verification results into
  `AGENTS.md`.
- Leaves placeholders or an unusable read route.
- Commits, installs a Skill, or changes user configuration.
