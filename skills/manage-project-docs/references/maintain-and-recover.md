# Maintain And Recover

Use this reference for routine documentation impact, persistent continuity,
pause, handoff, and recovery.

## Contents

- [Maintain Existing Owners](#maintain-existing-owners)
- [Maintain The Continuity Anchor](#maintain-the-continuity-anchor)
- [Pause And Handoff](#pause-and-handoff)
- [Recover](#recover)
- [Completion Report](#completion-report)

## Maintain Existing Owners

Treat these as common document-impact events:

| Event | Update |
|---|---|
| Durable behavior or interface changes | Intended contract and acceptance owner |
| Architecture, trust, or operational boundary changes | Boundary owner and related decision |
| Implementation or test state changes | Current-state and evidence owner |
| A material decision is accepted | Decision record and current contract |
| Priority or dependency changes | Future-work owner |
| Work pauses, transfers, or context becomes unreliable | Recovery owner |

For a routine event:

1. Follow the target project's existing read and write routing.
2. Revalidate the relevant code, tests, Git state, and external evidence.
3. Update only the existing canonical owners whose facts changed.
4. Replace stale duplicates with links or bounded summaries.
5. Use `PROPOSE` instead of redesigning structure when routing is insufficient.
6. Record actual verification and its limitations.

## Maintain The Continuity Anchor

The continuity anchor belongs in an existing target-project instruction or
governance entry. Keep only:

- the read order or responsibility-map entry;
- events that require documentation impact;
- the structural authorization gate;
- the recovery entry;
- the stop route for missing permission, writer conflict, or broken mapping.

Do not copy current status, product facts, decisions, or full verification
results into the anchor.

On later tasks, validate that every referenced owner still serves the named
responsibility. Refresh only a broken route, re-map only an affected owner, and
run full rediscovery only when scope or authority is broadly unreliable.

If the active Harness cannot load or verify the anchor, report weak continuity;
installing this Skill does not make the target-project rule persistent.

Classify continuity for the inspected scope:

- `strong` only when the active Harness verified the durable anchor and
  recovery entry, the owners needed for the stated recovery path are available,
  and no known permission, writer, or mapping boundary blocks that path;
- `weak` when the persistent entry cannot be written, loaded, or verified, a
  required owner is unavailable, or permission, writer, or routing state blocks
  the claimed recovery path;
- `not applicable` when the run did not assess or promise persistent recovery.

## Pause And Handoff

Maintain or create a recovery entry only when no equivalent exists and
structural writes are authorized. Record:

- goal and current bounded scope;
- completed and incomplete work;
- publish-safe workspace and writer state;
- last verified checkpoint and evidence;
- blocker or unresolved decision;
- next safe action and required read order;
- actions that remain unauthorized.

Do not require a `HANDOFF.md` filename, paste raw logs, or treat chat history as
the recovery source.

## Recover

1. Read the nearest project instructions and routed recovery entry.
2. Revalidate scope, branch or checkout, commit state, dirty ownership, active
   writer, and the last cheap evidence checkpoint.
3. Compare the durable record with current state.
4. Resume only when the next action remains inside the recorded authority.
5. Use `UPDATE` for a verified stale status or recovery fact.
6. Use `PROPOSE` for broken structure or owner routing.
7. Use `STOP` for material contract, permission, writer, workspace, or external
   state drift.

## Completion Report

After the last command that may write, inspect the actual target file and Git
state. Account for generated, ignored, and untracked artifacts as well as
intentional edits. Remove only artifacts created by this run when cleanup is
authorized and safe; otherwise report them. Do not infer “no file changes” from
the intended edit list.

State:

- primary outcome: `NOOP`, `REPORT`, `UPDATE`, `PROPOSE`, or `STOP`;
- scope and canonical owners inspected;
- every actual file change and its disposition;
- evidence checked and limitations;
- unresolved facts and their owners;
- continuity strength: strong, weak, or not applicable;
- exact recovery entry and next safe action.
