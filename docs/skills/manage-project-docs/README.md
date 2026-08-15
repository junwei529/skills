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
- the user explicitly asks to use Project Docs for a project-document audit,
  repair, pause, handoff, or recovery, including through
  `$manage-project-docs`.

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

Codex uses Project Docs only after the user explicitly asks to invoke it. A
documentation-governance request that does not name or explicitly invoke
Project Docs, authority/evidence/routing/recovery symptoms, and a persisted
project rule do not load the Skill.

Invoke it explicitly:

```text
$manage-project-docs Audit this repository's project-document governance. Do
not make structural changes without separate approval.
```

After a concrete proposal is visible, an unambiguous natural-language approval
authorizes only its listed target-project changes. After authorized adoption,
ordinary tasks follow the target project's persisted routing without loading
Project Docs. A broken route may ask the user to invoke Project Docs, but the
route does not itself invoke the Skill or authorize its repair.

For a new project, Project Docs starts with the five minimum logical
responsibilities and may use one combined starter when that is the smallest
authorized adoption. For an existing project, it maps the current documents
and preserves their layout when the routing is sufficient.

## Safety Boundaries

Audit is read-only unless an update is separately authorized. First adoption,
new modules, splits, merges, renames, migrations, authority changes, and
canonical-owner changes require explicit structural authorization. Project
Docs stops before unsafe writes when scope, permission, writer ownership, or
evidence is unresolved. It does not run as a daemon or scan every task in the
background.

## Verified Capability And Limits

The released six-file `v0.1.2` package has exact-source behavior evidence,
controlled development loaded-copy evidence, exact-commit candidate identity,
and
tag-pinned `v0.1.2` stable loaded-copy identity plus a mature-layout `NOOP`
canary. The coherent `v0.2.0` release-set candidate keeps those exact
six `v0.1.2` package files and makes no new Project Docs behavior, installation,
or loaded-copy claim. The later Decision 0019 implicit-selection and demand-
driven-module development revision remains preserved but excluded. The current
accepted release remains the repository-level
[`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2). Stable
mutation behavior, broad trigger telemetry, causal efficacy, token savings,
and cross-Harness parity are not established. See
[Verification](VERIFICATION.md) and [State](STATE.md).

## Authoritative Contract

This page is a human entry point, not a second runtime specification. The
repository [product contract](../../SPEC.md), [Project Docs design](DESIGN.md),
accepted decisions, and canonical
[`SKILL.md`](../../../skills/manage-project-docs/SKILL.md) own behavior. If
this page conflicts with them, those sources win.
