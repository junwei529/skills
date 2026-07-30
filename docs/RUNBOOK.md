# Development, Installation, And Release Runbook

Last updated: 2026-07-30

## Quick Navigation

| ID | Section | Use |
|---|---|---|
| RUN-BOUNDARIES | Environment roles | Decide which copy may be edited or tested |
| RUN-DISTRIBUTION | v0.1 distribution | Select the public source, version, and Skill path |
| RUN-PREFLIGHT | Preflight | Confirm source, Git, discovery, and authorization state |
| RUN-DEV | Development loop | Edit and forward-test a working revision |
| RUN-RC | Release candidate | Test an isolated copy produced from an exact commit |
| RUN-RELEASE | Release and stable install | Map a tag, package, install, update, or roll back |
| RUN-EVIDENCE | Evidence record | Prove which revision and copy actually ran |
| RUN-STOP | Stop conditions | Escalate ambiguous or unsafe state |

## Purpose

This is the operational owner for developing, discovering, testing, installing,
and releasing this repository's Skills. The v0.1 distribution mechanism,
public repository identity, and pre-tag candidate visibility policy are
selected. The remote and release tag do not yet exist.

See
[Decision 0003](decisions/0003-source-install-release-boundaries.md) and
[Decision 0005](decisions/0005-v0-1-standalone-github-distribution.md), with
the current account-specific locator in
[Decision 0013](decisions/0013-github-public-identity-update.md),
for the rationale. Product requirements remain in
[`docs/SPEC.md`](SPEC.md), and evidence belongs in
[`docs/VERIFICATION.md`](VERIFICATION.md).

## Environment Roles

| Role | Meaning | Editable? | Valid evidence |
|---|---|---:|---|
| `SOURCE` | `skills/<skill-name>/` in the approved repository checkout | yes | development only unless pinned to an exact commit |
| `DEV_DISCOVERY` | A local discovery entry that resolves directly to `SOURCE` | no separate copy | development and fresh-context tests |
| `RC_INSTALL` | An isolated installed or packaged snapshot produced from one exact commit through a clean candidate source | no | release-candidate smoke and behavior evidence |
| `STABLE_INSTALL` | An installed snapshot from one accepted release tag and commit | no | installed-release smoke and regression evidence |

The repository source is the only editable Skill copy. Treat discovery entries,
installer outputs, caches, release-candidate copies, and stable installations
as derived artifacts. Never repair one of those copies and copy the change back.

A continuity or governance rule that Project Docs is authorized to write into a
target project is target-project content. It is not `DEV_DISCOVERY`, an
installed Skill copy, a cache, or a version identity. Writing that rule follows
the target project's structural authorization boundary; changing Skill
discovery or installation follows this runbook's separate authorization
boundary.

A Codex task or chat is not a version boundary. Identify a revision by checkout,
commit state, and, for a release, tag:

| Label | Required identity |
|---|---|
| Development | branch or checkout plus `unborn` or commit SHA and dirty state |
| Release candidate | exact commit SHA, clean source tree, packaging or install method |
| Release | repository-level version tag plus the exact commit it resolves to |
| Stable installation | release tag and commit plus the actually loaded installed copy |

Use repository-level release tags for v0.1, for example `v0.1.0`. Do not create
independent per-Skill version lines without a later accepted decision.

## v0.1 Distribution Contract

The public v0.1 source is
[`junwei529/skills`](https://github.com/junwei529/skills).
The supported Codex installation interface is a `$skill-installer` request
that identifies:

1. the exact public GitHub repository URL;
2. the immutable release tag for a stable install, or exact commit SHA for an
   isolated release candidate;
3. one or more requested `skills/<skill-name>` directories.

One request may install one Skill or all three. A supported multi-Skill install
must use the same repository tag for every Skill. Do not mix tags and call the
result a verified v0.1 package.

Do not publish `main` as a stable source, expose a bundled helper script path as
the permanent user interface, or treat manual directory copying as the
supported release smoke. The active installer may choose a surface-specific
local destination. Record the actual destination and discovery result instead
of assuming one universal path.

Current
[OpenAI Skill guidance](https://learn.chatgpt.com/docs/build-skills)
describes repository downloads through `$skill-installer` as local setup and
experimentation and prefers Plugins for broader installable distribution. v0.1
accepts that narrower standalone scope. It does not claim Plugin-directory,
workspace, connector, or one-click distribution.

The intended stable PowerShell prompt is:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/v0.1.0/skills/use-powershell-safely.
```

The intended complete-set prompt is:

```text
$skill-installer Install `skills/manage-project-docs`, `skills/work-charter`, and `skills/use-powershell-safely` from https://github.com/junwei529/skills at tag `v0.1.0`.
```

These prompts are not executable release evidence until the remote and named
revision exist. The development `skills/work-charter` SOURCE is not an
installation or loaded-copy proof. For an RC smoke, replace the stable tag
identity with the exact accepted candidate commit SHA and record that SHA in
the evidence ledger.

## Preflight

Before changing or testing a Skill:

1. Read `AGENTS.md`, `docs/INDEX.md`, and the current `STATUS`, `SPEC`,
   `ARCHITECTURE`, and `VERIFICATION` sections relevant to the task.
2. Confirm the repository root, checkout, branch, commit or unborn state,
   worktree list, staged state, and dirty ownership.
3. Name the target Skill and resolve its expected `SOURCE` directory.
4. Identify every discoverable same-named Skill in the intended test
   environment. Resolve links or mappings to their final targets.
5. Select exactly one mode: source-only editing, development discovery,
   release-candidate smoke, or stable-install verification.
6. Confirm that any mapping, install, update, download, elevation, user-level
   configuration change, or release action has the required user authorization.

Do not configure Git trust, change user configuration, or mutate an
installation merely to make a preflight pass. Classify ownership, permission,
sandbox, and discovery failures before proceeding.

## Development Discovery Setup

`DEV_DISCOVERY` is optional. An explicit Skill path supplied to a controlled
test can be sufficient when no persistent development mapping is needed.

When a persistent development discovery entry is useful:

1. Obtain explicit authorization to create or change it.
2. Use a supported local discovery mechanism such as a symbolic link,
   directory junction, or platform-supported mapping that resolves directly to
   `SOURCE`.
3. Keep the mapping local and outside the public package. Do not commit the
   mapping or a host-specific locator.
4. Verify the resolved target before each fresh-context test.
5. Use a test discovery root or profile in which no stable same-named Skill can
   be selected accidentally.
6. Reload or start a fresh Harness context when discovery metadata may be
   cached.

A manually copied Skill directory is not a development mapping. If a copy is
required, classify it as an isolated candidate and pin its source revision.

## Daily Development Loop

1. Edit only `SOURCE`.
2. Keep unrelated user changes intact and record the current dirty boundary.
3. Run the bundled `skill-creator` validator for every changed Skill.
4. Run the repository checker and the relevant deterministic fixtures.
5. For behavior changes, run a fresh-context test with only the intended
   same-named Skill discoverable.
6. Confirm the actually loaded entry resolves to `SOURCE`, not an installed or
   cached copy.
7. Record development evidence with the commit or unborn state, dirty flag,
   logical source locator, loaded-copy role, checks, and known gaps.

Dirty-working-tree evidence is useful development evidence, but it is not
release-candidate or release evidence.

## Private Global-Guidance Migration

Replacing reusable private Project Docs or PowerShell rules is a staged
migration, not a file copy:

1. Review the private source in place. Do not paste it into tracked files,
   evaluation prompts, or public evidence.
2. For Project Docs, first subtract current native Codex behavior: AGENTS
   discovery and precedence, Skill progressive disclosure and invocation
   policy, and technical sandbox/approval controls. For PowerShell, classify
   each candidate as a portable rule, bounded inference, or private host delta
   using
   [Decision 0014](decisions/0014-powershell-portable-guidance-and-private-host-delta.md).
3. For a portable rule, record the interface, prerequisite, and affected
   versions. For a bounded inference, corroborate the failure mechanism and
   write only a conditional diagnostic and safe response.
4. Keep exact paths, installed versions, accounts, environment values,
   distributions, package provenance, sandbox identities, local tool routes,
   and current host results outside the public package.
5. Add or strengthen a positive or negative eval row for each newly public
   behavior. Structural validation alone does not prove the migration.
6. Prove `SOURCE` behavior, then separately prove authorized native selection
   and the actually loaded `DEV_DISCOVERY`, `RC_INSTALL`, and
   `STABLE_INSTALL` identities.
7. Route through the Skill during a bounded shadow period before retiring the
   duplicate private procedure. For explicit-only Project Docs, test both
   explicit invocation and ordinary maintenance through an adopted
   target-project rule. Preserve a recoverable private fallback until
   missed-routing and safety-regression checks pass.

The private global bootstrap may retain only high-signal routing, hard
authorization or destructive-operation invariants that apply before Skill
selection, current host facts, and an unavailable-Skill fallback. Changing
that bootstrap or private reference is a user-configuration mutation and is
not authorized by a SOURCE edit or test.

## Release-Candidate Procedure

Do not create or install a release candidate until the user authorizes the
external change and the exact candidate commit and isolated destination are
known.

1. Choose an exact candidate commit.
2. Require the candidate-producing checkout or archive to contain exactly the
   selected commit and confirm that the intended Skill files are contained in
   it. An unrelated dirty development checkout may remain open only if it is
   not an input to the candidate.
3. Produce the candidate from a clean archive, checkout, or packaging operation
   rooted at that commit. Do not package a dirty working tree or a development
   mapping.
4. Run local package-shape and source checks against that clean candidate. This
   is not yet public installation evidence.
5. After separate authorization for the target remote, visibility, and push,
   make the exact candidate commit reachable at the selected GitHub repository.
   Do not create the stable tag yet.
6. Materialize the candidate as `RC_INSTALL` through the selected
   `$skill-installer` GitHub path in an isolated test root or profile. The
   request must name the exact commit and Skill path; the result must not
   resolve back to the editable source.
7. Ensure no other same-named Skill is discoverable in that test scope.
8. Validate the installed or packaged copy, then run the required
   fresh-context and installed-copy smoke tests.
9. Prove that the actually loaded files correspond to the candidate commit,
   allowing only explicitly documented packaging metadata differences.
10. Record the complete release-candidate evidence in
   `docs/VERIFICATION.md`.

If any candidate file is repaired in place, discard that candidate as evidence,
apply the fix to `SOURCE`, create a new commit, and rebuild the candidate.

## Release, Stable Install, Update, And Rollback

Before release, all M5 gates must be closed: license, distribution form,
supported installation path, current behavior evidence, publication checks,
commit gate, and explicit GitHub publication authorization.

1. Assign one repository-level version tag to the accepted, commit-smoked
   candidate only after the tag and publication action are authorized.
2. Treat a published version tag as immutable; never move it to a different
   commit.
3. Push the tag to the confirmed GitHub repository, then invoke the public
   `$skill-installer` workflow with the exact GitHub
   repository URL, accepted tag, and requested Skill path or paths, not an
   ambient checkout or moving branch.
4. Treat the resulting `STABLE_INSTALL` as a generated snapshot. Never edit it.
5. Run the supported installation smoke and verify the actual loaded copy,
   version tag, and commit.
6. Record the release mapping and residual gaps in
   `docs/VERIFICATION.md`.

If the tag-based smoke fails after publication, do not move or silently replace
the tag. Record the failure and stop for an explicit patch-version or
distribution decision.

An update installs a newer accepted release identity; it does not patch the
stable copy. A rollback reinstalls the previously recorded release identity.
Installation, update, rollback, elevation, downloads, user configuration, and
removal remain explicit external actions and require authorization.

Do not overwrite an existing same-named stable directory blindly. First
materialize and verify the replacement in isolation, record the currently
installed tag for rollback, and then perform any approved replacement according
to the active installer and platform. If the installer refuses an existing
destination, classify that as a replacement boundary rather than repairing the
installed files in place.

Plugin packaging would change discovery and installation mechanics, but not
these source, candidate, identity, and evidence boundaries. Do not add Plugin
packaging until a separate decision accepts it.

## Worktrees And Concurrent Lines

One editable checkout is sufficient while a single development line exists.
Do not create a worktree merely to distinguish `SOURCE` from an installation.

Use a separate branch or worktree only when normal Git isolation is needed,
such as maintaining a released line while developing the next line, preserving
unrelated dirty work, or supporting explicitly authorized parallel work. Every
worktree is still a source checkout and follows the same canonical-source rule.
Record its branch, commit, dirty owner, and intended version line.

## Evidence Record

Use the
[candidate and release evidence template](VERIFICATION.md#candidate-and-release-evidence-template)
for each material development run, release candidate, or release. The
verification ledger owns the field schema; this runbook owns the procedure.

Public records use logical locators and sanitized evidence. Keep private
absolute paths, account data, host identifiers, and raw Harness traces out of
tracked files.

## Stop Conditions

Stop and resolve or escalate when:

- more than one same-named Skill can be selected in the test scope;
- the actually loaded Skill path or resolved target cannot be proved;
- an RC source tree is dirty, has unknown ownership, or does not match the
  selected commit;
- a package, tag, installed copy, or cache does not match its recorded commit;
- a derived copy was edited;
- the release tag would need to move;
- the exact public repository URL, tag or commit, Skill path, or installer
  source cannot be identified for an installation or release action;
- a candidate installer smoke requires a GitHub-visible commit but the remote,
  visibility, or candidate-push decision has not been authorized;
- a command requires an unapproved install, update, download, elevation,
  profile, policy, user configuration, remote, or publication mutation;
- Git ownership, sandbox, permission, or filesystem behavior makes provenance
  uncertain;
- verification unexpectedly changes source files or creates publication
  artifacts.
