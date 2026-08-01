# Project Docs

[简体中文](README.zh-CN.md)

Project Docs helps programmers and technical independent developers make
project truth, authority, evidence, and recovery routes reliable for both
humans and coding agents. It adopts an existing documentation system when that
system is already sufficient and repairs governance without imposing a fixed
file suite.

## Use It When

- project documentation is missing, duplicated, stale, conflicting, generated,
  externally owned, or difficult to resume from;
- a project needs a first documentation-governance adoption;
- a structural split, merge, rename, migration, or canonical-owner change must
  be assessed; or
- the user explicitly requests a project-document audit, repair, pause,
  handoff, or recovery.

## Do Not Use It When

- an ordinary documentation update already has valid project routing;
- the task is only prose editing or generated-output formatting;
- a sufficient mature layout needs no repair; or
- project duration alone is the only reason.

## Install Independently

Choose an accepted immutable repository tag from the live repository refs and
the repository [Verification](../../VERIFICATION.md) ledger, then substitute
it for `<version-tag>`:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/manage-project-docs.
```

Installation is separate from invocation, target-project adoption, writes, and
release authority. Do not use the moving `main` branch as a stable identity.

## Invoke

Project Docs is explicit-only:

```text
$manage-project-docs Audit this repository's project-document governance. Do
not make structural changes without separate approval.
```

After an authorized adoption, ordinary tasks follow the target project's
persisted routing. A broken route may ask the user to invoke Project Docs; that
mention is not itself invocation or authorization.

## Safety Boundaries

Audit is read-only unless an update is separately authorized. First adoption,
new modules, splits, merges, renames, migrations, authority changes, and
canonical-owner changes require explicit structural authorization. Project
Docs stops before unsafe writes when scope, permission, writer ownership, or
evidence is unresolved.

## Verified Capability And Limits

The current six-file package has exact-source behavior evidence, controlled
development loaded-copy evidence, exact-commit candidate identity, and
historical tag-pinned `v0.1.1` loaded-copy `NOOP` smoke. Its current accepted
stable identity is owned by the live repository release ledger. Stable
mutation behavior, broad trigger telemetry, causal efficacy, token savings,
and cross-Harness parity are not established. See
[Verification](VERIFICATION.md) and [State](STATE.md).

## Authoritative Contract

This page is a human entry point, not a second runtime specification. The
repository [product contract](../../SPEC.md), [Project Docs design](DESIGN.md),
accepted decisions, and canonical
[`SKILL.md`](../../../skills/manage-project-docs/SKILL.md) own behavior. If
this page conflicts with them, those sources win.
