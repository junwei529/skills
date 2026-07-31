# Architecture

Last updated: 2026-07-31

## System Shape

The repository contains three independent instruction products and one shared
source, evidence, and release envelope:

```text
repository governance and lifecycle
├── Project Docs: project-document semantics and routing
├── Work Charter: consequential-work contract and coordination
└── PowerShell: Windows shell-boundary diagnosis and execution
```

There is no umbrella Skill, shared runtime, automatic composer, or product
hierarchy. Each Skill remains usable alone.

## Federated Documentation Ownership

Documentation is federated by fact type:

| Fact | Canonical owner |
|---|---|
| Repository product goals, shared audience, independent-product and release requirements | [`SPEC.md`](SPEC.md) |
| Cross-Skill composition, source/install topology, release envelope, advisory boundaries | this file |
| Repository integration and release dashboard | [`STATUS.md`](STATUS.md) |
| Repository checks, coherent candidate, tag, stable-install, and release evidence | [`VERIFICATION.md`](VERIFICATION.md) |
| Repository writer, dirty scope, next integration action, and recovery | [`HANDOFF.md`](HANDOFF.md) |
| Project Docs contract, state, and evidence | [`docs/skills/manage-project-docs`](skills/manage-project-docs/README.md) |
| Work Charter contract, state, and evidence | [`docs/skills/work-charter`](skills/work-charter/README.md) |
| PowerShell contract, state, and evidence | [`docs/skills/use-powershell-safely`](skills/use-powershell-safely/README.md) |
| Operational lifecycle procedure | [`RUNBOOK.md`](RUNBOOK.md) |
| Accepted rationale | [`docs/decisions`](decisions/) |
| Canonical executable Skill instructions | `skills/<skill-name>/` |

One durable fact has one canonical write owner. Root dashboards use bounded
summaries and links rather than copying per-Skill ledgers. Detailed sanitized
run evidence remains under `evals/results/` and is indexed by the owning
verification document.

English is canonical. Root and per-Skill public README files have Simplified
Chinese mirrors. The English owner changes first and its mirror changes in the
same change set; deterministic checks verify reciprocal navigation and
corresponding section counts.

## Skill Package Boundary

Each public package keeps:

- one concise `SKILL.md` with trigger behavior in frontmatter;
- optional `agents/openai.yaml`;
- directly linked conditional references; and
- optional adaptable output assets.

The installable package does not contain repository README files,
installation guides, changelogs, design histories, or development evidence.
Those belong under `docs/skills/<skill-name>/`.

Per-Skill internal boundaries are owned by:

- [Project Docs Design](skills/manage-project-docs/DESIGN.md);
- [Work Charter Design](skills/work-charter/DESIGN.md); and
- [PowerShell Design](skills/use-powershell-safely/DESIGN.md).

## Composition Recipes

Composition exists only at repository guidance level:

| Recipe | Handoff |
|---|---|
| Project Docs → Work Charter | Project Docs establishes or repairs document routing; Work Charter may consume the resulting reliable locators for a consequential run |
| Work Charter + PowerShell | Work Charter retains outcome, authority, writer, and assessment ownership; PowerShell is selected only for a material Windows boundary |
| Project Docs + Work Charter + PowerShell | Each Skill keeps its own trigger, owner, stop condition, and evidence in a Windows project with both governance and execution risk |

A recipe does not install, discover, select, invoke, adopt, update, or authorize
another Skill. Sharing a tag, task, role, branch, worktree, or project document
does not prove another Skill copy loaded.

Installation/discovery, invocation/adoption, execution/maintenance, and
packaging/release remain separate authorization surfaces for each operation.

## Canonical Source And Derived Environments

| Role | Owner | Boundary |
|---|---|---|
| `SOURCE` | `skills/<skill-name>/` in an approved checkout | only editable Skill copy |
| `DEV_DISCOVERY` | local symlink, junction, supported mapping, or explicit controlled path | resolves to SOURCE; local and unpackageable |
| `RC_INSTALL` | isolated materialized copy from one exact commit through a clean checkout or archive | does not resolve to editable SOURCE |
| `STABLE_INSTALL` | generated snapshot from one accepted immutable tag and commit | updated or rolled back by reinstalling version identity |

The actual Harness discovery scope is part of the evidence boundary. Only one
same-named Skill may be selectable in a counted scope, and controller evidence
must prove the loaded logical locator and revision.

A Git branch, worktree, task, or chat is not an installation or version.
Development identity includes checkout, commit or unborn state, and dirty
state. Candidate identity uses exact commit plus clean materialization.
Release identity uses repository tag plus exact commit.

## Distribution And Version Envelope

v0.1 uses the standalone public repository
[`junwei529/skills`](https://github.com/junwei529/skills), one immutable
repository-level semantic-version tag, and independent
`skills/<skill-name>` install paths through `$skill-installer`.

A user may install one Skill or several, but every Skill in one supported set
uses the same repository tag. This shared version identity does not imply all
Skills are installed, selected, or adopted. GitHub-generated archives are
derived transport, not a second source tree.

Plugin packaging remains deferred and requires a separate accepted decision.

## Advisory And Deterministic Boundaries

Skills can instruct an agent to stop, preserve one writer, request approval,
or verify evidence. They cannot provide ACLs, process locks, sandbox
capabilities, deterministic role delivery, or permission enforcement.

Deterministic guarantees belong to scripts, hooks, the Harness, or external
systems and must be described separately. The repository checker validates
file shape, navigation, encoding, and configured publication rules; it does
not prove agent behavior.

## Private-To-Public Boundary

Portable rules may be synthesized from documented interfaces or reproducible
mechanisms. Exact host paths, installed versions, accounts, environment
values, distributions, sandbox identities, tool routes, private global files,
task identifiers, prompts, completions, and hidden reasoning remain outside
public source.

Project Docs target-project continuity is target-project content, not a Skill
mapping or installation identity. PowerShell private host guidance may remain
a fallback without becoming a second public source owner.

## Deferred Architecture

Deferred work includes organization catalogs, portals, RBAC, policy engines,
Wiki/issue connectors, databases, mandatory mapping manifests, automatic
invalidation, documentation generators, continuous drift scanners, parallel
Executors, automatic worktree routing, native cross-Harness packages, Plugins,
and MCP services.

[Decision 0015](decisions/0015-federated-repository-documentation.md) owns the
federated-document rationale.
