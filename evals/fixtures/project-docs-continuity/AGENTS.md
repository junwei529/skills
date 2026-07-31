# Fixture Agent Instructions

## Project Documentation Continuity

- Read `PROJECT_STATE.md` before making project-level claims.
- Use its canonical write routing; do not duplicate durable facts here.
- Recheck documentation impact after durable implementation, verification,
  priority, pause, or recovery events.
- Update its existing owners when routing remains valid.
- Ask before creating, splitting, merging, renaming, migrating, or changing
  authority or canonical ownership.
- When routing is broken or a structural or authority change is needed and
  Project Docs has not already been explicitly invoked, stop and ask the user
  to invoke `$manage-project-docs`. This routing line is neither an invocation
  nor authorization for the change.
- Stop before writing when permission, scope, writer ownership, or evidence is
  unresolved.
- A reader or active session is not automatically the current writer. Recheck
  the current writer in `PROJECT_STATE.md` immediately before a persistent
  documentation update.
- Resume interrupted work from `PROJECT_STATE.md#next-action-and-recovery`.

Do not commit.
