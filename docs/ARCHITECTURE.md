# Architecture

Last updated: 2026-07-29

## Overview

The repository separates four ownership layers:

| Layer | Owner | Responsibility |
|---|---|---|
| Repository governance | Root docs and `AGENTS.md` | Define this project's scope, status, and evidence. |
| Skill discovery | Frontmatter and `agents/openai.yaml` | Tell the Harness when and how to present a skill. |
| Skill workflow | `SKILL.md`, references, and assets | Provide reusable procedures and output resources. |
| Target-project truth | The target repository's code and documents | Remain authoritative for the project using a skill. |

A skill never becomes more authoritative than the project into which it is
introduced.

Target-project content produced by Project Docs remains part of target-project
truth. An agent-instruction entry written there is not a Skill discovery
mapping, installed copy, cache, candidate, or release identity.

The repository is a family of independent Skill products, not a lead product
with subordinate companions. Shared repository governance and release
packaging do not create a runtime dependency between Skills.

## Progressive Disclosure

1. Skill name and description are available for discovery.
2. `SKILL.md` loads only after the skill is selected.
3. Detailed references load only for the relevant branch of work.
4. Assets are copied or adapted as output resources rather than loaded as
   general context.

This structure is the repository's primary context-budget mechanism. Token
savings are a measurement question, not an architectural claim.

## Skill Boundaries

### Project Docs

`manage-project-docs` owns project-document semantics, canonical placement,
governance repair, continuity routing, pause, and recovery. It is a standalone
product intentionally thinner than a complete document platform.

Its minimum model has five logical responsibilities:

| Responsibility | Required result |
|---|---|
| Purpose and scope | A reader can tell what the project is and is not. |
| Work and verification method | A writer can find how changes are made and proved. |
| Authority and write routing | A writer can find the canonical owner for a durable fact. |
| Current state and evidence | A reader can distinguish current fact from intention or history. |
| Next action and recovery | A new session can resume from a bounded entry point. |

These responsibilities do not imply five files. Existing documents may combine
roles, and several locations may be valid reads. Within one scope and lifecycle,
a normative durable fact has one canonical write locus.

Project Docs produces one primary outcome per run:

| Outcome | Meaning |
|---|---|
| `NOOP` | The existing project contract is sufficient. |
| `REPORT` | Findings are returned without target-project mutation. |
| `UPDATE` | An authorized existing canonical owner is maintained. |
| `PROPOSE` | A structural or authority change requires user approval. |
| `STOP` | The requested action itself cannot continue safely because scope, ownership, permission, or evidence is insufficient. |

A completed read-only audit remains `REPORT` when only a later write is
blocked; `STOP` does not erase useful findings from an action that already
completed safely.

### Project Docs Trigger And Continuity Model

Project Docs has four distinct surfaces:

1. Explicit Project Docs invocation inspects or repairs the project within the
   user's request. Skill metadata disables implicit invocation.
2. First adoption creates the minimum contract and continuity anchor only with
   explicit structural-write authorization.
3. Routine maintenance follows an already adopted target-project rule after a
   material project event and updates the existing owner.
4. Structural expansion proposes a new module, split, merge, rename, migration,
   authority change, or owner change and waits for explicit authorization.

The continuity anchor is a small routing rule in the target project's existing
agent-instruction or governance entry. It points to read order, document-impact
events, the structural gate, and recovery entry without copying project facts.
This makes ordinary later tasks independent of chat history and agent private
memory. If the active Harness cannot load or verify the entry, the design
degrades honestly to weak continuity.

Routine maintenance can follow the durable rule without loading Project Docs.
The Skill is explicitly re-invoked only when governance fails or structure
changes; project duration alone is not a trigger.

Named maturity levels are not stored project state and do not trigger
whole-layer upgrades. Modules expand only when concrete events make the
existing responsibility routing insufficient.

### Work Charter

Work Charter is the accepted public product, Skill, and contract identity.
`work-charter` is the v0.1 package and canonical SOURCE name. The superseded
`skills/manage-large-tasks/` source is retired, with no compatibility alias or
second discovery entry.

The minimum package surface is one concise `SKILL.md`, `agents/openai.yaml`,
two directly linked conditional references for coordination/recovery and
Standard O/P/E, and one adaptable Work Charter asset. It has no scripts,
adapter, profile schema, or Project Docs dependency.

The product keeps three ownership layers:

| Layer | Owner | Responsibility |
|---|---|---|
| Charter semantics | One approved Charter or logical locator | Outcome, boundaries, action authority, acceptance evidence, and stop or recovery conditions |
| Codex carrier | `/plan`, `/goal`, the active context, or one durable source | Hold or point to the contract without redefining it |
| Coordination behavior | The Work Charter Skill under the active contract | Choose the least sufficient role separation, recover state, route assessment, and stop on ambiguity |

“Agent loop” may describe bounded progress in the third layer, but it is not a
separate product, artifact, or state machine.

A standing policy and active Charter are logical planes that normally share one
durable carrier. Before approval, `/plan` or discussion may hold a proposal.
After approval, one canonical Charter or locator owns normative state. `/goal`
may track the active objective but does not replace verification, assessment,
or authority. Multi-session, interruption-prone, or materially side-effecting
work requires durable state; a bounded single-session Charter may remain in the
active Codex context.

### Coordination And Readiness

Work Charter uses two internal questions rather than a user-facing profile
matrix:

1. What is the least coordination structure that protects the current work?
2. Is durable state coherent enough to continue, or is recovery or a stop
   required?

The implementation may label coordination as Flat, bounded single-context,
Planner/Executor, or Standard O/P/E for selection, debugging, and evaluation.
Those codes are not durable user state. Document organization, authority,
granularity, freshness, and evidence inform readiness but do not select a role
count by themselves.

Observable continuity or control symptoms may cause a midstream adoption or
profile-change proposal. Initial persistent adoption and the first Standard
standing policy require user approval. Later reuse may follow that policy and
must remain visible. The policy cannot override applicable Harness or project
instructions; when they require fresh explicit selection, Work Charter can
only propose the transition. A new task, one failure, or a same-scope
correction does not trigger escalation by itself, and no background polling is
part of v0.1.

Roles are responsibilities before they are sessions. Preserve a reliable
current session and add only a missing responsibility; create a successor only
when mixed roles, compaction, interruption, or drift makes the context
unreliable. Standard formally supports:

- Orchestrator ownership of project direction and transition;
- Planner ownership of the active Charter and independent assessment;
- Executor ownership of implementation and evidence.

The Orchestrator normally remains dormant during execution. v0.1 has one active
execution lane, at most one Planner and one Executor for the active Charter,
and one repository writer. Parallel Executors, automatic multi-worktree
routing, and automatic integration are deferred.

### Recovery, Handoff, And Assessment

Cold or recovery entry reads the canonical Charter, authoritative project
state, actual workspace, evidence freshness, writer ownership, and last
approved action. Material ambiguity stops for bounded recovery or a user
decision. Warm handoff carries only the receiving role, changed facts, evidence
pointers, bounded action, stop condition, and return route. Anchor, Delta, Role
Capsule, Resume Gate, and profile codes may remain internal authoring or
evaluation shorthand, but they are not mandatory persisted objects.

Contract state uses `draft`, `proposed`, `approved`, and `superseded`; run
disposition uses `active`, `paused`, and `closed`. A separate assessment exists
only when the Charter requires independent assessment and returns exactly one
of `ACCEPTED`, `CORRECTION_REQUIRED`, or `DECISION_REQUIRED`. Result and
evidence remain notices and pointers rather than additional state machines.

The same Planner and Executor may use at most three completed
`CORRECTION_REQUIRED` rounds per assessment checkpoint by default. Repeated
material findings, no net reduction, specification ambiguity, or unreliable
context stop earlier. This budget is unrelated to native review ownership,
counters, reset authority, evidence, or completion.

Profile selection never grants role delivery, target writes, document or
`AGENTS.md` changes, worktrees, Git, installation, or external-side-effect
authority. Skills remain advisory and cannot guarantee delivery, role
compliance, writer locking, correct assessment, or permissions.

Project Docs and Work Charter are technical peers and remain independently
installable and usable. Project Docs may provide canonical document routing;
Work Charter alone owns coordination, role, action, and assessment semantics.
Their combination is a recipe, not an umbrella Skill.

[Decision 0012](decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
owns the current simplification and supersession map.

## Composition Recipes

Composition exists only at the repository guidance layer:

| Recipe | Handoff |
|---|---|
| Project Docs → Work Charter | Project Docs establishes or repairs document routing; Work Charter may consume those pointers for a consequential run. |
| Work Charter + PowerShell | Work Charter retains work-control ownership; PowerShell is selected only for a material Windows, native-process, text, or WSL boundary. |
| Project Docs + Work Charter + PowerShell | Each Skill keeps its own job, trigger, stop conditions, and evidence in a Windows project with both governance and execution risk. |

Every Skill must also work alone. A recipe does not install, discover, select,
invoke, update, or authorize another Skill. Sharing a repository tag, task,
role, branch, or worktree is not proof that the same or intended Skill copies
were loaded.

Installation or discovery, invocation or adoption, execution or maintenance,
and packaging or release are separate authorization surfaces. Permission does
not cross from one Skill, operation, or surface to another.

## Project Docs Safety Boundaries

- Audit does not authorize structural mutation.
- Missing write access returns `REPORT` or `PROPOSE`.
- An unowned concurrent writer or unresolved canonical owner returns `STOP`
  before a requested mutation. A completed read-only audit still returns
  `REPORT` when only the future mutation is blocked.
- Generated output is not patched when an editable source owns it.
- External sources may own facts, but unavailable evidence remains unverified.
- The nearest target-project scope governs monorepo work.
- Existing document language is preserved; translation publishing is not part
  of v0.1.
- Cross-Harness use shares one canonical project anchor. Thin adapters may
  reuse it only when they already exist or are separately authorized.

Organization catalogs, ownership portals, policy engines, connector sync,
mapping databases, automatic invalidation, generator orchestration, and native
multi-Harness packages are deferred architecture, not hidden v0.1 modules.

### PowerShell

`use-powershell-safely` owns Windows shell boundary diagnosis and safe execution
guidance. It is independent of project governance and should not load for
ordinary POSIX shell work or a routine version-independent cmdlet without a
boundary symptom.

Its progressive-disclosure layers are:

| Layer | Owner | Load condition |
|---|---|---|
| Core workflow and authorization gate | `SKILL.md` | Skill is selected |
| Runtime, native process, streams, paths, permissions, and installation recommendation | `references/native-process-boundaries.md` | Native/process/version/system boundary is material |
| General text correctness plus conditional legacy locale/CJK guidance | `references/text-encoding-boundaries.md` | Text bytes, encoding, newline, hash, or legacy locale is material |
| Windows-to-WSL execution, paths, streams, and state | `references/windows-wsl-boundaries.md` | The task crosses the WSL boundary |

Runtime readiness is a conditional diagnostic branch, not a global startup
probe. The skill may detect and recommend PowerShell 7 without mutation.
Installation or update remains an external state change that requires explicit
authorization and current official guidance. No deterministic installer is
bundled in v0.1.

## Source And Release Environments

Skill lifecycle uses four distinct roles:

| Role | Owner | Boundary |
|---|---|---|
| Canonical source | `skills/<skill-name>/` in an approved checkout | only editable Skill copy |
| Development discovery | local link, junction, supported mapping, or explicit test path | resolves to canonical source and is never packaged |
| Release candidate | isolated materialized copy produced from one exact commit through a clean candidate checkout or archive | does not resolve to the working tree |
| Stable installation | generated copy from one accepted release tag and commit | updated or rolled back by reinstalling a release identity, never by editing |

The actual Harness discovery scope is part of the test boundary. Behavioral
evidence must prove which same-named Skill was loaded; release tests isolate the
candidate from development and stable copies.

Git branch or worktree selection controls source isolation. It does not create
an installation environment. A chat or task is likewise not a version:
development identity includes checkout, commit or unborn state, and dirty
state; release identity uses a repository-level version tag and exact commit.

v0.1 uses
[`matsuri1987/eddie-skills`](https://github.com/matsuri1987/eddie-skills)
as the standalone GitHub distribution envelope. The supported Codex
installation interface is `$skill-installer` with that exact repository URL,
an immutable repository tag, and one or more
`skills/<skill-name>` paths. All Skills in one supported installed set resolve
to the same repository tag, but that shared version identity does not imply
that every Skill was installed, loaded, or adopted. GitHub-generated archives
are transport derived from that tag rather than a second source tree.

Plugin packaging remains a later alternative around the same lifecycle. It is
not part of v0.1 and would require a separate accepted change in product and
release scope.

## Advisory And Deterministic Boundaries

Skills can advise an agent to stop, preserve a writer boundary, or verify a
target. They cannot themselves provide an ACL, process lock, sandbox, or
permission system. Deterministic guarantees require separate scripts, hooks, or
Harness capabilities and must be described as such.

## Portability

The initial implementation is Codex-first. Work Charter v0.1 explicitly maps
to Codex Plan mode, Goal mode, threads, and durable project sources. Its five
logical responsibilities may later be adapted to another Harness, but command
names and Codex task capabilities are not part of that portable contract.

Any later Harness adapter must map its real planning, persistence, approval,
role, and recovery capabilities and gain separate behavior evidence. v0.1 does
not claim identical triggering, tools, modes, or behavior elsewhere.
