# Product Specification

Last updated: 2026-07-30

## Goal

Publish a small, understandable, and composable family of independently useful
Codex-first Skills that make project documentation durable, large work bounded,
and Windows shell work less error-prone.

## Audience

- Programmers and technical independent developers who already use Codex,
  Claude Code, Cursor, or Copilot on real projects but lack lightweight,
  reliable governance for project truth, consequential work, or execution
  boundaries.
- Developers who need durable project truth, evidence, and recovery across
  agent sessions without replacing a mature documentation layout.
- Windows users working across PowerShell, native commands, and WSL.
- Interviewers evaluating practical Agent Harness understanding.

## v0.1 Scope

### `manage-project-docs`

Provide a standalone semantic routing and governance-repair workflow for
project truth. It must:

- audit and adopt existing projects before adding structure, preserve mature or
  nonstandard layouts, and return `NOOP` when the current system is sufficient;
- ensure five logical responsibilities are discoverable: project purpose and
  scope, work and verification method, authority and canonical write routing,
  current state and evidence, and next action and recovery entry;
- treat those responsibilities as logical roles rather than fixed files, so one
  file may own several roles and one role may have several read locations;
- keep one canonical write locus for each normative durable fact within one
  scope and lifecycle;
- distinguish explicit selection, first adoption, routine maintenance, and
  structural expansion as separate trigger and authorization surfaces;
- require explicit Project Docs invocation for initial use and later
  reselection; allow ordinary maintenance to follow an adopted target-project
  rule without loading the Skill, and do not activate merely because a project
  is long-lived;
- finish with one primary outcome: `NOOP`, `REPORT`, `UPDATE`, `PROPOSE`, or
  `STOP`;
- preserve `UNKNOWN` and distinguish intended contract, actual implementation,
  current work state, verification evidence, and historical decision before
  resolving conflicts;
- require explicit target-project authorization for first adoption, new
  modules, split, merge, rename, migration, authority changes, or
  canonical-owner changes;
- support pause, handoff, and recovery without requiring a fixed filename;
- when authorized, add a lightweight continuity rule to the target project's
  existing agent-instruction or governance entry, containing only read routing,
  document-impact events, the structural gate, and the recovery entry;
- report weak continuity when that persistent entry cannot be written, loaded,
  or verified;
- stop before a requested mutation when an unowned concurrent writer or
  unresolved canonical-owner conflict makes that action unsafe; keep a
  completed read-only audit as `REPORT` when only a later write is blocked;
  report or propose when write access is absent, route generated documents to
  their editable source, and mark unavailable external sources unverified;
- respect the nearest monorepo scope and preserve the project's existing
  document language without introducing a localization system.

Project Docs is not a document editor, Wiki, project manager, portal, or policy
enforcement platform. The accepted contract is detailed in
[Decision 0006](decisions/0006-project-docs-progressive-governance.md).

### `work-charter`

Provide a Codex-focused contract and proportional coordination workflow for
consequential work whose continuity, authority, recovery, or independent
assessment cannot remain reliable as an ordinary task.

Work Charter is the public product, Skill, and contract name. `work-charter`
is the package, frontmatter, and canonical SOURCE-directory name. The
superseded `manage-large-tasks` source is retired without a compatibility
alias or second discovery entry.

#### Contract And Persistence

- Keep ordinary work flat. Create or reuse a Charter only for observed
  continuity, control, authorization, recovery, or assessment risk.
- Make intended outcome and non-goals, scope and hard boundaries,
  authorization and material side effects, acceptance evidence, and
  stop/decision/recovery conditions discoverable.
- Treat those as logical responsibilities rather than required headings,
  filenames, fields, or a Phase Definition schema.
- Maintain one active canonical Charter or logical locator. A standing policy
  and active Charter are two logical planes that normally share one existing
  durable carrier rather than two required files or state machines.
- Use `/plan` when drafting or clarification is useful and `/goal` when active
  objective tracking is useful. Neither surface owns Charter semantics,
  expands authority, or proves verification or acceptance.
- Require durable project or repository state for multi-session work,
  material interruption or context-recovery risk, or material external side
  effects. A bounded single-session Charter may remain in the active Codex
  context.
- Reuse sufficient existing project documentation. Use a standalone durable
  Charter only when no suitable owner exists or a separate recovery boundary
  is materially clearer.
- Remain independently usable without Project Docs. When Project Docs is
  present, consume its authority and locator results without delegating
  profile, role, or action decisions to it.

#### Activation And Coordination

- Use observable continuity or control symptoms to propose midstream adoption
  or escalation. Do not treat a new task, one failure, a same-scope correction,
  document count, module count, or task duration as sufficient by itself, and
  do not poll in the background.
- Require user approval for initial persistent adoption and the first Standard
  standing policy. Later profile reuse may follow an approved project policy
  and must produce a concise visible change notice.
- Keep that policy subordinate to applicable Harness and project instructions.
  If they require a fresh explicit selection or the required capability is
  unavailable, propose the transition and stop instead of claiming activation.
- Keep `Flat`, bounded single-context, Planner/Executor separation, and
  Standard O/P/E as internal coordination profiles rather than a user-facing
  selection matrix.
- Use the least sufficient profile. Preserve a reliable current session and
  add only the missing responsibility; create a recovery successor only when
  mixed roles, compaction, interruption, or drift makes that context
  unreliable.
- Treat project-document organization, authority, granularity, freshness, and
  evidence as readiness signals, not automatic role-count inputs. Material
  ambiguity may require bounded recovery or a stop instead of more agents.
- Keep Standard O/P/E as a formally supported v0.1 capability for project-level
  multi-phase governance. The Orchestrator owns direction and transition, the
  Planner owns the active Charter and independent assessment, and the Executor
  owns implementation and evidence. The Orchestrator normally remains dormant
  during execution.
- Report unavailable or uncertain role delivery as degraded capability. Do
  not represent a one-agent fallback as Standard.

#### Authority, Recovery, And Handoff

- Keep profile selection separate from action authority. Adoption does not
  authorize role delivery, target writes, project-document or `AGENTS.md`
  changes, worktrees, Git operations, installation, or external side effects.
- Reconcile the canonical Charter, authoritative project sources, actual
  workspace state, evidence freshness, writer ownership, and last approved
  action before materially interrupted or multi-session continuation.
- Stop for material recovery ambiguity rather than inventing a next action.
- For cold or recovery entry, read the durable Charter and authoritative
  state. For warm handoff, send only the receiving role, changed facts,
  evidence pointers, bounded action, stop condition, and return route.
- Treat Anchor, Delta, Role Capsule, Resume Gate, and profile codes as optional
  authoring or evaluation shorthand, not mandatory public artifacts or
  separately persisted state.
- Update durable state for material contract, ownership, assessment, decision,
  interruption, workspace, authority, or evidence events rather than every
  role message.

#### Assessment And v0.1 Bounds

- Use `draft`, `proposed`, `approved`, and `superseded` for contract state and
  `active`, `paused`, and `closed` for run disposition.
- Create a separate assessment only when the Charter requires independent
  assessment. Record its scope, owner, evidence pointers, material residual
  risks, return route, and exactly one verdict: `ACCEPTED`,
  `CORRECTION_REQUIRED`, or `DECISION_REQUIRED`.
- Do not add partial acceptance or separate Result and Evidence state machines.
  Predeclare independently acceptable checkpoints when partial progress must
  be accepted separately.
- Keep one active execution lane, at most one Planner and one Executor for the
  active Charter, one repository writer, and a normally dormant Orchestrator.
  Parallel Executors, automatic multi-worktree routing, and automatic
  integration are deferred.
- Default to at most three completed `CORRECTION_REQUIRED` rounds per
  assessment checkpoint and stop earlier for a repeated material finding, no
  net reduction, specification ambiguity, or unreliable context.
- Keep the Work Charter correction budget wholly separate from native review
  ownership, counters, reset authority, evidence, and completion semantics.
- Treat Work Charter as advisory. It cannot guarantee correct assessment,
  message delivery, role compliance, writer locking, or broader action
  authority.

Work Charter v0.1 is designed and evaluated for Codex. Non-Codex Harnesses are
deferred because their planning, goal, persistence, role, and task capabilities
may differ. [Decision 0012](decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
owns the current rationale and supersession map; Decisions 0008 through 0011
remain historical detail where Decision 0012 does not supersede them.

### `use-powershell-safely`

Provide a focused Windows/PowerShell workflow that combines boundary diagnosis
with safe execution guidance. It must:

- distinguish routine cmdlet semantics from native executable arguments,
  stdout, stderr, and exit status;
- preserve argument, parser, pipeline, redirection, path, and process
  boundaries across PowerShell, native executables, and WSL;
- treat UTF-8, BOM, newline, JSON/schema parsing, and byte-versus-semantic
  hashes as general text-correctness concerns;
- load legacy locale, CJK, or other non-ASCII guidance only when evidence points
  to a locale-sensitive or code-page boundary;
- distinguish PowerShell 7 behavior from Windows PowerShell 5.1, including
  version-sensitive native argument and byte-stream behavior;
- perform read-only runtime-readiness checks only when the task materially
  depends on those version differences;
- prefer a supported PowerShell 7 release for compatible modern text,
  native-command, and WSL workflows while preserving a 5.1 route for required
  legacy modules or hosts;
- when no usable PowerShell 7 exists, explain the task-specific benefit, note
  side-by-side installation, and ask whether the user wants official
  installation guidance;
- require separate explicit authorization before any installation, update,
  elevation, download, profile change, policy change, or host mutation;
- classify application defects, shell transport, encoding, WSL/path semantics,
  environment drift, sandbox or permission failures, cleanup noise, and
  unresolved hypotheses before changing application code;
- verify destructive filesystem targets before mutation.

Detailed native/process, text/encoding, and WSL guidance must remain in three
directly linked, conditionally loaded references. The frontmatter must not
trigger this skill for ordinary version-independent cmdlets without a boundary
symptom or for POSIX-only work.

## Shared Requirements

- Use progressive disclosure: metadata → concise `SKILL.md` → conditional
  references or assets.
- Require every public Skill to solve a recognizable standalone job for a
  defined audience or subsegment and remain independently discoverable,
  installable, selectable, usable, stoppable, and evaluable.
- Treat cross-Skill combinations as optional repository-level recipes, never
  as implicit dependencies, bundled adoption, a shared runtime, or an umbrella
  Skill.
- Do not propagate authorization across Skills or across installation and
  discovery, invocation and adoption, execution and maintenance, or packaging
  and release surfaces.
- Require an observed failure or a user-visible decision for every new public
  concept, role, state, artifact, gate, or required file. Keep each Skill's
  structure proportional to its standalone job, use one canonical owner for
  every durable fact, and keep internal classifications out of the public
  contract unless the user must act on them.
- Any mandatory dependency, shared runtime, umbrella product, or automatic
  composer requires a separate accepted project decision and evidence.
- Treat `skills/<skill-name>/` in an approved checkout as the only editable
  Skill source. Discovery entries, installer outputs, caches, candidates, and
  stable installations are derived artifacts.
- Separate development discovery, isolated release-candidate installation, and
  stable installation. A task or chat is not a version identity.
- Build release candidates from an exact commit through a clean candidate
  checkout or archive, prove which copy was actually loaded, and map stable
  installations to a repository-level version tag and commit.
- Keep v0.1 versioning at repository level unless a later decision accepts
  independent per-Skill release lines.
- Distribute v0.1 from one standalone public GitHub repository. Support
  installing one or more `skills/<skill-name>` directories through
  `$skill-installer` only when the request names the exact repository URL and
  immutable tag or candidate commit.
- Use
  [`junwei529/skills`](https://github.com/junwei529/skills)
  as the public repository identity and permit the accepted candidate commit
  to be visible there before the stable tag for a commit-pinned installation
  smoke.
- Use an immutable repository tag for stable installation. Do not present
  `main`, a development mapping, or manual directory copy as the supported
  stable release source.
- Treat v0.1 as an early standalone Codex distribution. Defer Plugin packaging
  and do not claim Plugin-directory, workspace, connector, or one-click
  distribution.
- License repository-authored public v0.1 material under the MIT License
  through a root `LICENSE` file with explicitly confirmed public attribution.
- Respect system, user, and project-local instructions.
- Keep advisory workflows distinct from deterministic enforcement.
- Avoid private environment traces and unlicensed third-party text.
- Call the design context-budgeted until comparative measurements exist.
- Report limitations and unverified claims plainly.
- Keep target-project continuity rules separate from Skill discovery,
  installation, cache, candidate, and release identities.

## Non-Goals

- A general Agent Harness runtime or generic multi-provider adapter.
- Unbounded or permission-free role-session creation, background orchestration,
  or generic remote coordination.
- Hard security, access control, sandboxing, or concurrency enforcement.
- Automatic Git integration, publication, software installation or update,
  elevation, or system mutation.
- Proven token savings, generalized task improvement, or cross-Harness
  portability in v0.1.
- Organization-wide document catalogs, ownership portals, RBAC, SSO,
  compliance, or deterministic policy enforcement.
- Mandatory mapping databases, automatic invalidation or remapping engines,
  connector-based bidirectional synchronization, or full
  scope/version/locale/lifecycle registries.
- Native Project Docs packages or adapters for every supported coding-agent
  Harness.
- A lead-product hierarchy, implicit cross-Skill dependency, automatic
  composer, or authorization propagation between Skills.
- Work Charter parity, adapters, or command emulation for non-Codex Harnesses
  in v0.1.

## v0.1 Acceptance

- All three skill directories pass the bundled `skill-creator`
  `quick_validate.py` structural check.
- No generated scaffolding markers remain in operative skill files.
- Every reference is linked directly from its `SKILL.md`.
- Target-project templates are clearly separated from repository facts.
- Every active evaluation case definition states explicit pass/fail
  expectations.
- Publication-safety and claim checks report no known violations.
- At least one fresh-context forward test is completed for each skill before a
  public v0.1 release.
- Project Docs forward tests prove mature-layout `NOOP`, authorized minimal
  adoption, fresh-agent continuity, conflict handling without unauthorized
  structural writes, event-triggered expansion, no-write and concurrent-writer
  stops, and generated, external, monorepo, and recovery boundaries.
- Project Docs tests distinguish `SOURCE` or `DEV_DISCOVERY` behavior from an
  isolated `RC_INSTALL` and prove which same-named copy was actually loaded.
- Work Charter forward tests cover five behavior groups: a negative ordinary
  task that remains flat; midstream adoption or escalation that preserves a
  reliable current session; one Planner/Executor loop with a compact warm
  correction and independent assessment; one Standard O/P/E path with a
  normally dormant Orchestrator and project transition; and recovery or
  capability degradation across interruption, ambiguous state, absent Project
  Docs, governing-instruction conflict, or unavailable role delivery.
- Those tests distinguish proposed `/plan` output, an approved Charter,
  optional `/goal` tracking, durable recovery state, and verified assessment;
  prove visible proportional activation and action-authorization separation;
  and do not treat Goal completion, role self-report, task creation, passing
  tests, or document presence alone as acceptance or correct orchestration.
- Work Charter SOURCE fresh-context evidence records the exact canonical SOURCE
  explicitly read by each role. Only separately authorized `DEV_DISCOVERY`,
  `RC_INSTALL`, or `STABLE_INSTALL` testing may claim actual same-named
  loaded-copy identity; candidate evidence must use an isolated `RC_INSTALL`.
  A composed recipe cannot substitute for standalone Work Charter evidence.
- The PowerShell forward-test contract covers runtime-present, runtime-absent,
  5.1 compatibility, user-declined installation, authorized-installation,
  encoding, native-process, WSL, destructive-operation, and non-trigger
  branches.
- At least one supported public `$skill-installer` path is documented with the
  exact GitHub repository URL, immutable tag or candidate commit, and
  `skills/<skill-name>` path, then smoke-tested against the release candidate.
- The supported installation smoke runs against an isolated candidate produced
  from an exact commit through a clean candidate checkout or archive, and its
  evidence proves the actually loaded copy.
- The development, candidate, stable-install, update, rollback, version, and
  release boundaries are documented in the repository runbook.
- A root MIT `LICENSE` file contains the confirmed public copyright-holder
  text before release.

## Open Decisions

No Project Docs, Work Charter v0.1 product-contract, GitHub account-identity,
or v0.1 distribution decision remains open. Decision 0013 owns the current
repository-owner and MIT public-attribution identifiers. Current evidence,
acceptance, and remaining lifecycle gates are owned by
[`docs/STATUS.md`](STATUS.md) and
[`docs/VERIFICATION.md`](VERIFICATION.md); operational procedures are owned by
[`docs/RUNBOOK.md`](RUNBOOK.md).

Commit, remote, push, tag, installation, and release actions retain their
separate authorization gates.
