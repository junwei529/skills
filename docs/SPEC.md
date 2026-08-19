# Product Specification

Last updated: 2026-08-19

## Product Goal

Agent Workflow Skills is a Markdown-first, Codex-first collection of focused
public Skills for programmers and technical independent developers who already
use Codex, Claude Code, Cursor, or Copilot on real projects but lack reliable,
lightweight governance for project truth, consequential work, or Windows
execution boundaries.

The repository provides three independent products:

| Skill | Standalone job | Detailed contract |
|---|---|---|
| Project Docs | Make project-document truth, authority, evidence, and recovery discoverable and maintainable | [Design](skills/manage-project-docs/DESIGN.md) |
| Work Charter | Bound consequential Codex work through outcome, authority, evidence, proportional coordination, assessment, and recovery | [Design](skills/work-charter/DESIGN.md) |
| PowerShell | Diagnose and safely execute material Windows, native-process, text, permission, and WSL boundaries | [Design](skills/use-powershell-safely/DESIGN.md) |

Repository membership is not a trigger. Each Skill must be understandable and
useful when installed alone.

## Shared Audience And Product Boundary

The primary audience already builds software with coding agents. v0.1 Must
capabilities are those directly required to keep that work understandable,
recoverable, and safe. Capabilities needed only by organization architects,
compliance programs, documentation platforms, or multi-team portfolios remain
deferred unless they are also required for the primary user's safety.

The repository is a family of products, not one umbrella runtime. Shared
audience, repository, version tag, task, role, branch, or worktree does not
create a dependency or prove another Skill was installed, loaded, adopted, or
authorized.

## Independent-Skill Requirements

Every public Skill must:

1. solve one recognizable standalone job;
2. state its audience, trigger, non-trigger, stop, and safety boundary;
3. remain independently discoverable, installable, selectable, usable,
   stoppable, and evaluable;
4. keep its concise workflow in `SKILL.md`, conditionally loaded detail in
   direct references, and optional output templates in assets;
5. preserve one canonical owner for every durable fact it creates or changes;
6. distinguish advisory behavior from deterministic enforcement;
7. avoid requiring another repository Skill; and
8. carry evidence only for the exact SOURCE or loaded copy actually exercised.

Per-Skill accepted contracts and current evidence are owned by:

- [Project Docs design](skills/manage-project-docs/DESIGN.md),
  [state](skills/manage-project-docs/STATE.md), and
  [verification](skills/manage-project-docs/VERIFICATION.md);
- [Work Charter design](skills/work-charter/DESIGN.md),
  [state](skills/work-charter/STATE.md), and
  [verification](skills/work-charter/VERIFICATION.md); and
- [PowerShell design](skills/use-powershell-safely/DESIGN.md),
  [state](skills/use-powershell-safely/STATE.md), and
  [verification](skills/use-powershell-safely/VERIFICATION.md).

## Capability-Delta Development

New public Skills and material selection or behavior revisions use
[capability-delta development](decisions/0017-capability-delta-skill-development.md).
They treat the current model and Agent Harness as a moving substrate and add
only a demonstrated gap, a user-approved product requirement, or a hard
boundary with explicit ownership.

For that future development:

1. establish the strongest practical no-target-Skill baseline for the intended
   model, Harness, task, rules, and tools;
2. place generic reasoning with the model, native lifecycle and permission
   surfaces with the Harness, durable facts with canonical project owners, and
   deterministic guarantees with scripts, hooks, tools, or external systems;
3. keep the Skill focused on the on-demand residual workflow, selection
   boundary, non-obvious knowledge, evidence, approval, failure, and recovery;
4. compare native, realistic catalog/selection, and exact-revision selected
   behavior under controlled conditions; and
5. after a material model, Harness, tool, permission, or catalog change, retain,
   simplify, delegate, or retire behavior according to the newly observed
   delta.

This requirement is prospective and proportional. It does not invalidate the
accepted `v0.1.2` release, require a causal benchmark for a documentation-only
correction, or permit a safety, authorization, or recovery failure to be
offset by an aggregate score. No efficacy, token, or portability claim follows
without pinned reproducible evidence.

## Composition And Authorization

Cross-Skill combinations are optional repository-level recipes. A recipe may
describe order and handoff boundaries, but it must not install, discover,
select, invoke, update, or authorize another Skill.

For every Skill and operation, these surfaces remain distinct:

1. installation or discovery;
2. invocation or adoption;
3. execution or maintenance, including target writes, role delivery,
   worktrees, Git, and external effects; and
4. packaging or release.

Permission on one surface, Skill, or operation does not propagate to another.

The three products are independent selection peers. Project Docs owns
documentation-governance semantics: high-confidence governance intent or
authority/evidence/routing/recovery symptoms may produce only a minimum bounded
read-only inspection and visible proposal until the user explicitly authorizes
the concrete adoption, canonical-owner, structural, or write effects. Work
Charter owns consequential-work coordination and applies a fresh-Session/
normalized-ruleset boundary when the next affected action depends on materially
changed governing rules. PowerShell owns material Windows parser, version,
argument, stream, encoding, path, permission, process, and WSL boundaries while
ordinary cmdlets, simple native commands without such a boundary, general
Windows work, and POSIX-only work stay negative. No peer grants another read,
write, Git, installation, release, or external authority.

When Work Charter roles exchange a Result Notice, every notice receives one
checkpoint-bound disposition through its declared route. Missing, wrong,
duplicate, or stale returns and runtime-idle state are not acceptance;
terminal dispositions receive no acknowledgement, and one semantic owner asks
each material user question. These are advisory product requirements, not a
task API or deterministic message-delivery guarantee.

## Source, Version, And Distribution Contract

- `skills/<skill-name>/` in an approved repository checkout is the only
  editable Skill SOURCE.
- `DEV_DISCOVERY` is an optional local mapping that resolves to SOURCE and is
  never packaged.
- `RC_INSTALL` is an isolated materialized copy produced from one exact commit
  through a clean candidate source.
- `STABLE_INSTALL` is a generated snapshot from an accepted immutable release
  tag and commit.
- Candidate and stable evidence must prove the actually loaded same-named copy.
- v0.1 uses repository-level release-set semantic versioning, not per-Skill
  release lines. A shared tag identifies one coherent repository release set;
  it does not assert that every Skill changed in that release or has the same
  maturity.
- Tracked development, governance, and reference documentation may advance
  without a stable version change when public Skill packages, their selection
  and behavior contracts, and the accepted distribution and publication
  contract remain unchanged.
- A v0.1 patch keeps public Skill names, paths, supported set membership, and
  installation interface compatible and contains only backward-compatible
  corrections. New public functionality, addition, removal, rename, an
  incompatible Skill contract change, or a user-visible distribution-interface
  change requires a separate accepted version decision and normally a new
  pre-1.0 minor line; `v1.0.0` requires its own stability decision.
- The public distribution source is
  [`junwei529/skills`](https://github.com/junwei529/skills).
- The supported standalone Codex interface is `$skill-installer` with the
  exact repository, immutable tag or exact candidate SHA, and requested
  `skills/<skill-name>` path.
- Plugin packaging remains deferred.

Current release and candidate facts are owned by
[Repository Verification](VERIFICATION.md) and operational procedure by
[the Runbook](RUNBOOK.md).

## Public Documentation Contract

The repository uses federated documentation:

- root documents own shared product, architecture, release, and repository
  state;
- `docs/skills/<skill-name>/` owns each Skill's public entry, design, state,
  and evidence;
- installable `skills/<skill-name>/` packages remain minimal and contain no
  README, installation guide, changelog, or process history; and
- one persistent fact has one canonical write owner, with links or bounded
  summaries elsewhere.

English is canonical. The root public README and every per-Skill public README
have a Simplified Chinese mirror in the same change set. The mirror is a
distribution aid, not a general localization product.

## Shared Non-Goals

v0.1 does not provide:

- an umbrella Skill, mandatory composer, Plugin, MCP service, shared runtime,
  or generic adapter framework;
- an organization catalog, ownership portal, portfolio map, RBAC, SSO, policy
  engine, or compliance platform;
- automatic role delivery, process locking, writer enforcement, background
  polling, integration, or release;
- a generic coordination controller, callback broker, receipt database, or
  host-level enforcement claim;
- Wiki, Jira, Notion, or Confluence synchronization;
- a documentation database, mandatory mapping registry, provenance graph,
  generator orchestration, or continuous drift scanner;
- an automatic PowerShell installer or host inventory;
- independent per-Skill version lines;
- claimed causal correctness, token savings, cross-Harness parity, or SHICE
  validation without recorded evidence.

## Shared Acceptance

A repository candidate is acceptable only when:

- all three Skill packages validate and match their declared shapes;
- root and per-Skill canonical owners are coherent and linked;
- English/Chinese public navigation is synchronized;
- expected cases and fixtures pass deterministic preconditions;
- behavior evidence is attributed to the exact SOURCE or loaded copy;
- release candidates are built from exact clean commits and stable installs
  from immutable accepted tags;
- every release candidate compares the union of current and previously released
  public Skills, records each as `added`, `changed`, `unchanged`, or `removed`,
  and scopes its evidence accordingly;
- publication-safety, strict UTF-8/no-BOM, whitespace, local-link, fragment,
  parser, and secret scans pass;
- unresolved claims remain explicitly unverified; and
- every Git, install, update, cleanup, remote, tag, and release action has its
  own authorization.

## Accepted Decisions

The current contract is grounded in:

- [Decision 0003](decisions/0003-source-install-release-boundaries.md);
- [Decision 0005](decisions/0005-v0-1-standalone-github-distribution.md);
- [Decision 0006](decisions/0006-project-docs-progressive-governance.md);
- [Decision 0007](decisions/0007-independent-skills-and-optional-recipes.md);
- [Decision 0012](decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md);
- [Decision 0013](decisions/0013-github-public-identity-update.md);
- [Decision 0014](decisions/0014-powershell-portable-guidance-and-private-host-delta.md);
- [Decision 0015](decisions/0015-federated-repository-documentation.md); and
- [Decision 0017](decisions/0017-capability-delta-skill-development.md).
