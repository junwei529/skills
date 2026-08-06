# Development, Installation, And Release Runbook

Last updated: 2026-08-04

## Quick Navigation

| ID | Section | Use |
|---|---|---|
| RUN-BOUNDARIES | Environment roles | Decide which copy may be edited or tested |
| RUN-DISTRIBUTION | v0.1 distribution | Select the public source, version, and Skill path |
| RUN-PREFLIGHT | Preflight | Confirm source, Git, discovery, and authorization state |
| RUN-DELTA | Capability-delta intake | Decide whether a Skill residual should exist or change |
| RUN-DOCS | Documentation impact closure | Close mapped owners and consumers before review |
| RUN-DEV | Development loop | Edit and forward-test a working revision |
| RUN-OPT | External optimizer experiment | Isolate an authorized suggestion-only optimization run |
| RUN-RC | Release candidate | Test an isolated copy produced from an exact commit |
| RUN-RELEASE | Release and stable install | Map a tag, package, install, update, or roll back |
| RUN-EVIDENCE | Evidence record | Prove which revision and copy actually ran |
| RUN-STOP | Stop conditions | Escalate ambiguous or unsafe state |

## Purpose

This is the operational owner for developing, discovering, testing, installing,
and releasing this repository's Skills. The v0.1 distribution mechanism,
public repository identity, and pre-tag candidate visibility policy are
selected. Immutable `v0.1.0` through `v0.1.2` history, exact candidates, stable
installs, GitHub Release state, and residual limits remain in
`docs/VERIFICATION.md`; this procedure does not duplicate their live status.
Public install examples use a version-neutral placeholder so the same source
snapshot remains truthful before and after an immutable tag is created.

See
[Decision 0003](decisions/0003-source-install-release-boundaries.md) and
[Decision 0005](decisions/0005-v0-1-standalone-github-distribution.md), with
the current account-specific locator in
[Decision 0013](decisions/0013-github-public-identity-update.md),
for distribution rationale. The development intake and external-tool boundary
follow
[Decision 0017](decisions/0017-capability-delta-skill-development.md).
Product requirements remain in
[`docs/SPEC.md`](SPEC.md). Per-Skill behavior and identity evidence belongs in
the matching `docs/skills/<skill-name>/VERIFICATION.md`; coherent candidate,
tag, stable-install, and release evidence belongs in
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

Use repository-level release-set tags for v0.1, for example `v0.1.0`. A tag
identifies one coherent repository candidate; it does not mean that every Skill
changed in that release or has the same maturity. Do not create independent
per-Skill version lines without a later accepted decision.

Within the pre-1.0 line, increment the patch only for backward-compatible
corrections that preserve public Skill names, paths, supported set membership,
and installation interface. New public functionality, addition, removal,
rename, an incompatible selection or behavior change, or a user-visible
distribution or publication-interface change stops for an accepted version
decision; while the product remains pre-1.0, the normal direction is the next
minor line. `v1.0.0` requires its own stability decision. Select the exact tag
from the release-set delta and accepted release decision, never from one Skill's
maturity alone.

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

Before treating a candidate as a supported release set, compare the union of
public `skills/<skill-name>/` subtrees in the candidate and previous accepted
tag, then record this matrix in `docs/VERIFICATION.md`:

| Skill | Package delta | Contract or selection change | Required evidence |
|---|---|---|---|
| `<skill-name>` | `added`, `changed`, `unchanged`, or `removed` | bounded summary or `none` | exact checks required for this delta |

For a changed Skill, run the validator and the focused selection, behavior, and
installed-copy checks required by the change. For an unchanged Skill, prove
exact Git tree or blob equality and retain proportional candidate and stable-set
installation and loaded-copy regression evidence. Treat every package in a
first release as `added`. Always record a rename as one `removed` path plus one
`added` path. An accepted continuity decision and exact evidence may support
bounded behavior or maturity-evidence reuse, but they do not change those
physical deltas or their absence, update, and rollback duties. Addition or
removal also requires its own accepted product scope. An added Skill follows
the full new-Skill acceptance route. A removed Skill requires absence and
near-neighbor selection checks plus explicit update, rollback, and cleanup
treatment; release exclusion does not authorize deletion of an existing
installation. Equality supports bounded continuity only; it does not prove new
behavior, equal maturity, or a newly loaded copy.

Do not cut a new stable tag solely because tracked development, governance, or
reference documentation changed. A release requires at least one public Skill
package delta, public Skill selection or behavior-contract change, or accepted
distribution or publication-contract change. Keep the documentation in Git and
leave the current stable tag fixed when none applies.

For this gate, a user-visible distribution or publication interface means the
repository identity, distribution form, supported installer request, public
Skill name or path, supported set membership, release or installation behavior,
or license terms. An internal development procedure, decision rationale, or
evidence schema is not such a change unless it alters one of those surfaces.

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

The version-neutral single-Skill release interface is:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/use-powershell-safely.
```

The version-neutral complete-set interface is:

```text
$skill-installer Install `skills/manage-project-docs`, `skills/work-charter`, and `skills/use-powershell-safely` from https://github.com/junwei529/skills at tag `<version-tag>`.
```

Replace `<version-tag>` only with an accepted immutable tag whose exact commit,
RC, and stable evidence appear in the live release ledger. Do not substitute
`main`. A new tag must contain release documentation that remains valid before
and after publication, then pass a repeated tag-pinned installed-copy smoke.
Development SOURCE still is not installation or loaded-copy proof. For an RC
smoke, replace the stable tag identity with the exact accepted candidate commit
SHA and record that SHA in the evidence ledger.

## Preflight

Before changing or testing a Skill:

1. Read `AGENTS.md`, `docs/INDEX.md`, and the current root `STATUS`, `SPEC`,
   and `ARCHITECTURE`. For one Skill, also read its `DESIGN.md`, `STATE.md`,
   and `VERIFICATION.md`.
2. Confirm the repository root, checkout, branch, commit or unborn state,
   worktree list, staged state, and dirty ownership.
3. Name the target Skill and resolve its expected `SOURCE` directory.
4. Record the exact test working directory and every discovery scope it
   activates from that directory to the repository root, then identify every
   discoverable same-named Skill and resolve links or mappings to their final
   targets. Include retained eval or worktree directories when the test starts
   inside them; a clean repository-root scope does not prove a descendant scope
   is clean.
5. Select exactly one mode: source-only editing, development discovery,
   release-candidate smoke, or stable-install verification.
6. Confirm that any mapping, install, update, download, elevation, user-level
   configuration change, or release action has the required user authorization.

Do not configure Git trust, change user configuration, or mutate an
installation merely to make a preflight pass. Classify ownership, permission,
sandbox, and discovery failures before proceeding.

## Capability-Delta Intake

Complete this intake before creating a public Skill or materially changing its
selection or behavior. First classify the proposed change:

| Class | Minimum route |
|---|---|
| Editorial | No claimed trigger, workflow, boundary, or outcome change; use the normal documentation and validation route |
| Selection | Name, frontmatter, description, catalog interaction, or implicit/explicit invocation changes; run the affected catalog and negative cases |
| Material behavior | Instructions, references, assets, scripts, authority, evidence, recovery, or user workflow changes; run the full proportional intake |
| New public Skill | New selection surface or installable package; run the full intake and require an accepted product scope |

Calling a change editorial does not waive validation. If it changes what the
Skill can select, do, require, claim, or recover from, reclassify it.

When intake starts from production feedback, bind the observation to the exact
stable tag, installed-copy identity, test working directory, catalog, and
loaded-copy evidence that are actually known. Classify it first as Skill
behavior, selection/discovery/cache, model or Harness, permission or
environment, project rule or documentation, installation/version identity,
outside the accepted contract, or `UNKNOWN`. Reproduce an in-contract Skill
case against the exact stable baseline and reduce it to a sanitized minimum
case before proposing SOURCE changes. Keep raw production evidence only in its
authorized private owner; do not copy it into this repository or an external
optimizer. Do not convert an unclassified or unreproduced observation into a
Skill defect.

For Selection, Material behavior, and New public Skill work:

1. Freeze the intended task, success and hard-failure criteria, repository
   state, model and Harness identity, tools, permissions, reasoning budget, and
   realistic installed catalog. Preserve `UNKNOWN` where the runtime does not
   expose an identity.
2. Identify every discoverable same-named Skill and the exact current control
   revision, if one exists. Do not compare against an ambiguous or moving copy.
3. Run the strongest practical native baseline with the target Skill and
   target-derived duplicate guidance absent from every applicable discovery and
   instruction scope. Default to a synthetic, isolated, read-only case. Any
   write, production access, provider or network call, external effect, or
   cost-bearing action needs its own authority. If a clean safe baseline cannot
   run, record `UNKNOWN` and why; an ambient-guidance condition must be labelled
   as such and cannot support a causal claim.
4. Allocate each proposed responsibility to the model, Harness, project rules
   or durable documents, deterministic scripts/hooks/tools, external systems,
   or the residual Skill. Do not reproduce an already-owned layer in prose.
5. For every material Skill concept, record the observed gap, accepted product
   requirement, or hard boundary that justifies it and the case that can
   falsify it.
6. Stop the Skill path when no material residual remains. Simplify, delegate,
   or retire existing behavior instead of manufacturing a package-shaped need.
7. Only after the target scope is authorized, invoke `$skill-creator` for
   authoring or revision and package validation. It does not accept the product
   decision or authorize source, installation, or release actions, and its
   invocation does not itself authorize a write.
8. Route the resulting revision through the proportional conditions in
   [`evals/README.md`](../evals/README.md) and then the ordinary development,
   candidate, and release gates below.

After reproducible production feedback or a material model, Harness, tool,
permission, or catalog change, repeat the affected baseline and
selection/behavior conditions. Record one explicit disposition: retain,
simplify, delegate, or retire. Safety, authorization, evidence, and recovery
cases remain independent hard gates.

Reuse an existing baseline only when its exact identity and all relevant
conditions remain unchanged. Mark genuinely irrelevant dimensions as not
applicable and rerun only affected conditions; proportional evaluation does
not require an unrelated full matrix or a net-benefit claim for a bounded
safety correction.

## Documentation Impact Closure

Complete this closure before the first native review for a new Skill or a
material Skill selection, behavior, package, evaluation, or lifecycle change.
Use it as well for a repository-governance change that can affect more than one
existing owner. The purpose is to find all existing consumers of the changed
facts once, without forcing unrelated documents into the diff.

Keep three sets distinct:

- **Authorized change envelope**: the existing paths or fact classes the user
  has permitted the writer to modify if the closure shows they need an update.
  Membership permits a change; it does not require an edit, staging, or commit.
- **Intended change set**: the files currently classified `UPDATE` because
  their owned or bounded public facts actually change.
- **Review target**: the exact stable diff presented to native review. It may
  be smaller than the authorized envelope and must match the bytes actually
  reviewed.

Start from the changed facts and inspect this existing-owner matrix:

| Changed fact | Inspect | Update only when |
|---|---|---|
| Installable instructions, metadata, references, assets, or scripts | affected `skills/<skill-name>/` files and the Skill `DESIGN`, `STATE`, and `VERIFICATION` owners | executable behavior, package boundary, implementation state, or evidence changes |
| User-visible purpose, invocation, workflow, safety, or evidence limit | the matching per-Skill English README and Simplified Chinese mirror | the public user surface changes |
| Selection, behavior, acceptance, or reproducible evidence contract | applicable decisions, `evals/README.md`, affected cases, fixtures, and sanitized results | the accepted rationale, test contract, starting state, or recorded evidence changes |
| Repository writer, dirty scope, gate, recovery, checks, candidate, or release state | `docs/HANDOFF.md`, `docs/STATUS.md`, and `docs/VERIFICATION.md` according to their fact ownership | the corresponding repository-level fact changes |
| Navigation or milestone direction | `docs/INDEX.md` and `docs/ROADMAP.md` | a route, document identity, milestone, or future direction changes |
| Shared product, architecture, authority, development procedure, provenance, distribution, or public repository surface | root README pair, `SPEC`, `ARCHITECTURE`, `AUTHORITY`, `RUNBOOK`, `PROVENANCE`, and applicable decisions | that shared fact class changes |

For every matrix entry, record one disposition in the active task, Phase
definition, or existing handoff owner; do not create a new required file:

- `UPDATE`: the file owns or intentionally publishes a changed fact;
- `CHECKED_NO_CHANGE`: it was inspected and remains truthful, with a short
  reason; or
- `NOT_APPLICABLE`: the fact class is outside the change.

Then:

1. Obtain one authorization for the proposed envelope before writing. An exact
   file list may be used when genuinely complete, but do not derive it only
   from the first finding or implementation slice.
2. Edit only `UPDATE` files and preserve one canonical owner per durable fact.
   When a public English README changes, update its Chinese mirror in the same
   change set.
3. Before native review, rescan the mapped consumers for stale terminology,
   identities, counts, lifecycle state, and authorization language. Run the
   applicable deterministic checks, then freeze the actual review target.
4. Treat an omitted existing consumer of the same changed facts inside the
   approved envelope as a same-scope correction. Return to the user for a new
   file, fact class, product or acceptance change, authority expansion,
   workspace change, or external effect.
5. Prefer stable semantic lifecycle wording. Do not mutate tracked files only
   to echo a native-review ordinal, a clean-review result, or a future commit
   identity. Record an exact dirty path list in `HANDOFF.md` only at a material
   recovery checkpoint; keep detailed review accounting in the applicable
   completion record.

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

1. Confirm the capability-delta intake, target edit, documentation-impact
   closure, and authorized change envelope are in scope.
2. Edit only canonical `SOURCE` for installable package bytes and only the
   documentation classified `UPDATE`. The canonical-SOURCE rule excludes
   derived copies; it does not exclude mapped repository documentation.
3. Keep unrelated user changes intact and record the current dirty boundary.
4. Run the bundled `skill-creator` validator for every changed Skill.
5. Run the repository checker and the relevant deterministic fixtures.
6. For behavior changes, run a fresh-context test with only the intended
   same-named Skill discoverable.
7. Confirm the actually loaded entry resolves to `SOURCE`, not an installed or
   cached copy.
8. Reconcile the impact dispositions after implementation and assessment
   findings, scan all mapped consumers, and freeze the actual diff before
   native review.
9. Record development evidence in the matching per-Skill verification ledger
   with the commit or unborn state, dirty flag, logical source locator,
   loaded-copy role, checks, and known gaps.

Dirty-working-tree evidence is useful development evidence, but it is not
release-candidate or release evidence.

## External Optimizer Experiment

An optimizer is optional research tooling, not part of the default development
loop. Before a run, separately authorize every required download or install,
provider or network call, data disclosure, cost-bearing action, persistent
configuration change, and task-owned experiment-artifact write. This does not
authorize a canonical SOURCE write. A dry-run label alone does not prove that
no provider call, retention, or cost occurs.

For an authorized experiment:

1. Pin the optimizer version or commit, license, dependency environment, target
   Skill revision, and complete input manifest. Materialize only the reviewed
   inputs into a dedicated disposable root outside the canonical checkout,
   without `.git`, credentials, writable remotes, user configuration, private
   files, or hidden holdout data. Run untrusted tooling under a least-privilege
   sandbox whose read/write allowlist and network policy are verified. A clone,
   worktree, or ignored directory alone is not containment.
2. Use only synthetic or explicitly reviewed and redacted tasks and artifacts.
   Do not provide production sessions, private prompts, memory, rollout data,
   secrets, private repositories, environment dumps, or hidden reasoning. If a
   provider receives any content, record the authorized payload category,
   destination, and retention policy; stop when any is unknown.
3. Freeze disjoint optimization, selection, and hidden holdout sets; the
   scoring rubric and evaluator; model, Harness, tools, permissions, reasoning
   budget, seed when exposed, and experiment budget. Keep expected answers and
   hidden cases outside the optimizer's readable boundary and expose them only
   to the independent evaluator.
4. Preserve hard safety, authorization, evidence, and recovery checks as
   independent gates. Do not let an aggregate score trade them away.
5. Compare the exact accepted control, exact proposed candidate, and native
   baseline where applicable. For a multi-file Skill, hash and evaluate every
   package file even when the tool optimizes a single document.
6. Retain the output outside canonical SOURCE as an untrusted proposal. Disable
   auto-adoption and automatic release. A tool-generated `best` result is not
   product acceptance or promotion evidence.
7. After review selects a specific proposal, confirm that the current request
   or a separate approval authorizes that exact SOURCE change. Then manually
   translate only that delta through `$skill-creator`, provenance and license
   review, the repository checker, relevant fixtures, fresh-context evaluation,
   and the normal candidate/release procedure.

The external reference identities and data-publication boundary are recorded
in [`docs/PROVENANCE.md`](PROVENANCE.md). Results belong in `evals/results/`
only after sanitization and must state negative and inconclusive outcomes.

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
10. Record Skill-specific release-candidate identity and behavior in the
    matching per-Skill verification ledger. Record coherent multi-Skill
    candidate and release-lifecycle evidence in `docs/VERIFICATION.md`.

When the candidate itself is a release-documentation snapshot, retain the
pre-tag RC record in a controlled non-source artifact and make it available to
the tag decision. Commit its sanitized ledger entry only in a later authorized
evidence update; do not create a new candidate commit merely to embed evidence
about the candidate being tested. Package-byte equivalence with an earlier
candidate may preserve bounded behavior relevance, but it does not replace the
new commit's installer, Git-blob, and actually-loaded-copy proof.

If any candidate file is repaired in place, discard that candidate as evidence,
apply the fix to `SOURCE`, create a new commit, and rebuild the candidate.

## Release, Stable Install, Update, And Rollback

Before release, all M5 gates must be closed: license, distribution form,
supported installation path, current behavior evidence, publication checks,
commit gate, and explicit GitHub publication authorization.

1. Compare the union of public Skill packages in the candidate and previous
   accepted tag and record the release-set change matrix in
   `docs/VERIFICATION.md`.
2. Use the matrix to close the required identity, behavior, loaded-copy, and
   absence evidence for `added`, `changed`, `unchanged`, and `removed` entries
   without weakening the shared acceptance gates.
3. Select the exact patch or minor tag under the pre-1.0 compatibility rules
   above, or stop for a separately accepted `v1.0.0` stability decision.
4. Assign that repository-level version tag to the accepted, commit-smoked
   candidate only after the tag and publication action are authorized.
5. Treat a published version tag as immutable; never move it to a different
   commit.
6. Push the tag to the confirmed GitHub repository, then materialize the full
   target manifest for the release smoke in an empty isolated staging root
   through `$skill-installer`, using the exact repository, tag, and public Skill
   paths rather than an ambient checkout or moving branch. Prove that the staged
   manifest contains exactly the requested candidate paths and no prior-only or
   old rename path.
7. For an environment update, derive the target installed subset as the
   intersection of its approved current subset and the candidate release set,
   plus only explicitly selected additions. Record the complete current
   manifest and preserve its verified tag and copies outside active discovery
   as the rollback manifest.
   Obtain explicit authority for every install, replacement, move, quarantine,
   or removal needed to reach the target. If a previously installed removed or
   renamed entry has no approved disposition, stop before switching and do not
   call a partial result a coherent update.
8. Switch only after the target subset is completely staged. Prove afterward
   that the governed release-set entries in active discovery equal the target
   manifest, every entry resolves to the accepted tag, and every removed or old
   rename path is no longer discoverable. Treat the resulting `STABLE_INSTALL`
   as a generated snapshot; never edit it.
9. Run the supported installation smoke and verify each actual loaded copy,
   version tag, and commit.
10. Record the shared release mapping in `docs/VERIFICATION.md` and each
   Skill's loaded-copy behavior and residual gaps in its verification ledger.

If the tag-based smoke fails after publication, do not move or silently replace
the tag. Record the failure and stop for an explicit patch-version or
distribution decision.

An update installs a newer accepted release identity; it does not patch the
stable copy. A rollback restores the complete recorded prior manifest, including
the reverse disposition of entries added, removed, or renamed by the update.
Installation, update, rollback, elevation, downloads, user configuration, move,
quarantine, and removal remain explicit external actions and require
authorization.

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
- documentation-impact closure reveals an unapproved new file, fact class,
  contract, authority, acceptance boundary, workspace change, or side effect;
- verification unexpectedly changes source files or creates publication
  artifacts.
