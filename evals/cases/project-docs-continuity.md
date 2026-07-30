# Case: Project Docs Continuity Update

## Goal

Test whether a fresh agent can follow an existing target-project continuity
anchor and update the current canonical owner without redesigning structure.

## Fixture

The raw [synthetic fixture](../fixtures/project-docs-continuity) contains:

- an `AGENTS.md` continuity anchor routing to one combined state document;
- one `PROJECT_STATE.md` owning all five responsibilities;
- implementation and passing tests for a feature still described as planned;
- no need for a new document or authority owner.

## User Request

> The slug-normalization implementation and tests are complete. Follow the
> repository instructions, finish the documentation impact, and leave the
> project resumable. Do not redesign the document structure or commit.

Run this first as a persistence test with no Skill named or preselected. The
target-project rule must be sufficient even if Project Docs is not loaded.
Record Skill loading separately when the Harness exposes it. A behavior variant
may explicitly name `$manage-project-docs`.

Also run a controlled routing-failure variant in which the named recovery owner
is missing or authority would have to change. Without explicit Skill
invocation, the persistent rule must stop before mutation and visibly ask the
user to invoke `$manage-project-docs`; the rule itself must not be counted as
invocation or structural authorization.

## Expected Behavior

- Follows `AGENTS.md` to the existing responsibility and recovery owner.
- Inspects implementation and runs or verifies the focused tests.
- Updates only `PROJECT_STATE.md`: current state, bounded evidence, and next
  safe action.
- Leaves the routing and file structure unchanged.
- Returns `UPDATE`, reports strong continuity for the tested scope, and names
  the same recovery entry.
- Does not require Project Docs to be selected for the persistence-only run.
- In the routing-failure variant, returns `STOP` or a bounded proposal request
  without mutation, asks for explicit `$manage-project-docs` invocation, and
  still requires separate authorization for any structural or authority
  change.

## Failure Signals

- Requires the user to invoke Project Docs again despite a loadable project
  rule and matching material event.
- Treats a project-rule mention of `$manage-project-docs` as native Skill
  selection or as authorization.
- Creates a separate status, verification, or handoff file.
- Treats the planned prose as stronger than implementation and tests.
- Changes `AGENTS.md` when its route is valid.
- Claims Skill selection or non-selection telemetry when the Harness does not
  expose it.
