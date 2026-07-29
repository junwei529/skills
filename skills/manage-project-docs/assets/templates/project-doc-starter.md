# <Project Name> Working Contract

> Adapt this document to the project's existing names and sources. Delete
> guidance text after replacing it. Split a responsibility only when a concrete
> ownership, cadence, risk, or navigation problem justifies the change.

## Purpose And Scope

- Purpose: <user problem and durable outcome>
- In scope: <included capabilities or project boundary>
- Out of scope: <explicit non-goals>

## Work And Verification

- Working method: <how changes are made>
- Required checks: <commands, prerequisites, and pass conditions>
- Safety or permission boundaries: <actions that require approval or a stop>

## Authority And Write Routing

| Durable fact | Read locations | Canonical write locus |
|---|---|---|
| Purpose and scope | <paths or external sources> | <one owner> |
| Work and verification method | <paths or external sources> | <one owner> |
| Current state and evidence | <paths or external sources> | <one owner> |
| Next action and recovery | <paths or external sources> | <one owner> |

When sources conflict, distinguish intended contract, actual implementation,
current work state, verification evidence, and historical rationale. Preserve
`UNKNOWN` until evidence or an authorized decision resolves the conflict.

## Current State And Evidence

- Verified now: <narrow fact and evidence>
- In progress: <owned work>
- Blocked or unknown: <fact, impact, and owner>
- Last check: `<command or evidence locator>` — <date and bounded result>

## Next Action And Recovery

- Next safe action: <one concrete action>
- Read first: <ordered sources>
- Current writer or owner: <owner, none, or unknown>
- Stop conditions: <permission, writer, contract, workspace, or evidence drift>
- Unauthorized actions: <commit, deploy, migration, or other gated action>
