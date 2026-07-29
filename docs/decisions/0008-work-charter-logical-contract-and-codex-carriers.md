# 0008: Work Charter Logical Contract And Codex Carriers

Date: 2026-07-29
Status: accepted

## Context

The current `manage-large-tasks` implementation assumes a Phase Definition and
role-separated Planner/Executor workflow. Product review found that this makes
the artifact and mechanism more prominent than the user's actual need: a
bounded, authorized, verifiable unit of consequential work.

Codex now exposes two useful but different surfaces. `/plan` supports
investigation and planning before implementation. `/goal` keeps a persistent
task objective and its completion criteria while work continues. Treating
either command as the product would couple the contract to one interface and
would not explain how existing project documents or a standalone artifact
participate.

Other Agent Harnesses may not expose Plan mode or Goal mode. v0.1 therefore
needs an honest Codex support boundary without making Codex command names part
of the portable semantic contract.

## Options Considered

1. Require one fixed Work Charter file and schema for every selected task.
2. Define Work Charter as a wrapper around Codex `/plan` and `/goal`.
3. Define Work Charter as a logical contract, then map it to Codex carriers
   according to task durability and recovery needs.

## Decision

Choose option 3.

### Product Layers

- **Work Charter** is the user-facing semantic contract for one bounded unit of
  consequential work.
- **Agent Loop** is the internal execution kernel that advances, checks, stops,
  corrects, and recovers work under an approved Charter. It is not a second
  public product or a mandatory user-visible artifact.
- **Codex carriers** hold the contract at different lifecycle points. They do
  not own or redefine its meaning.

### Minimum Logical Contract

An actionable Work Charter makes five responsibilities explicit:

1. intended outcome and non-goals;
2. scope and hard boundaries;
3. authorization, including material writes and external side effects;
4. acceptance evidence and verification expectations;
5. stop, decision, and recovery conditions.

These are logical responsibilities, not required headings or filenames. One
carrier may hold several responsibilities, and a compact carrier may point to a
durable source for the rest.

### Carrier And Persistence Rules

- A fixed Work Charter file is not required.
- Before approval, `/plan` or an ordinary Codex discussion may draft and refine
  the Charter. A plan remains proposed work and does not itself authorize
  execution.
- After approval, one active canonical Charter or logical locator must be
  identifiable. Do not maintain competing normative copies.
- `/goal` may carry the approved outcome, constraints, completion criteria, and
  a pointer to detailed sources while the run is active. Goal state does not
  replace verification or independent assessment.
- Existing project documentation may own durable Charter details. A standalone
  Charter artifact is used only when the project has no suitable owner or when
  a separate recovery boundary is materially clearer.
- Repository or project persistence is required when work spans sessions,
  faces material interruption or context-recovery risk, or includes material
  external side effects. A bounded single-session run may keep the approved
  contract in the Codex thread or goal without creating a project file.
- Project Docs is optional. Work Charter consumes any sufficient existing
  documentation system and does not require the user to install, invoke, or
  adopt another Skill.

### Codex v0.1 Support Boundary

- Work Charter v0.1 is designed and evaluated for Codex.
- Codex `/plan` is the preferred drafting and clarification carrier when the
  outcome or boundaries are not yet ready for approval.
- Codex `/goal` is the preferred active-run carrier when persistent objective
  tracking is useful.
- Selecting Plan mode, starting a Goal, or invoking Work Charter does not
  expand sandbox, approval, repository-write, role-creation, Git, installation,
  or external-side-effect authority.
- When a Codex surface cannot expose or preserve one preferred carrier, the
  Skill may use the thread plus an existing or standalone durable source and
  must report the reduced capability honestly.

### Future Harnesses

Other Harnesses are deferred. A later adapter maps the five logical
responsibilities and lifecycle transitions to that Harness's native
capabilities. It must not pretend that `/plan`, `/goal`, Codex collaboration
modes, or Codex task APIs exist elsewhere, and it requires separate behavior
evidence before any portability claim.

## Consequences

- The product is no longer defined by a mandatory Phase Definition.
- `/plan` and `/goal` complement rather than conflict with Work Charter:
  `/plan` helps form the contract; `/goal` can carry the authorized active
  objective; Work Charter owns semantics; Agent Loop owns internal progress.
- The current `manage-large-tasks` Skill and phase-definition asset remain the
  implementation of the earlier contract. They must not be described as
  implementing this decision until revised and forward-tested.
- Public naming, role thresholds, Standard-flow stability, acceptance labels,
  concurrency scope, and correction budget remain separate open decisions.
- Forward tests must distinguish proposed planning, approved Charter,
  active-goal state, durable recovery state, and verified assessment. They must
  also test operation without Project Docs and avoid treating Goal completion
  or a role self-report as acceptance proof.

## Re-evaluation Conditions

Revisit the carrier model if Codex materially changes or removes Plan or Goal
mode, if real use shows that one mandatory artifact is necessary for reliable
recovery, or when a specific non-Codex Harness adaptation is proposed with its
own capability and evidence model.

## Related Documents

- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Roadmap](../ROADMAP.md)
- [Current status](../STATUS.md)
- [Verification](../VERIFICATION.md)
- [Decision 0007](0007-independent-skills-and-optional-recipes.md)
- [Codex best practices](https://developers.openai.com/codex/learn/best-practices)
- [Codex long-running work](https://learn.chatgpt.com/docs/long-running-work)
- [Codex slash commands](https://learn.chatgpt.com/docs/reference/slash-commands)
