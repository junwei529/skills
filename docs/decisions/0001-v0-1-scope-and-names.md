# 0001: v0.1 Scope And Names

Date: 2026-07-27
Status: accepted
Partial supersession: Decision 0007 replaces the primary-versus-companion
product hierarchy; the remaining decision stays accepted.

## Context

The initial concept was to publish reusable lessons from global Codex rules as
a Markdown-first interview artifact. A single broad skill risked hiding the
project documentation system and mixing unrelated triggers.

## Options Considered

1. One umbrella skill containing project docs, role control, context guidance,
   and Windows shell rules.
2. One primary documentation skill plus two focused companion skills.

## Decision

- Use the public project title `Agent Workflow Skills`.
- Keep the existing checkout folder name; the public display title does not depend on it.
- Make `manage-project-docs` the primary skill and include the complete
  agent-oriented project documentation system.
- Add `manage-large-tasks` for optional large-work role and recovery control.
- Add `use-powershell-safely` for Windows-specific command boundaries.
- Treat context budgeting as a shared design constraint and evaluation metric,
  not a fourth skill.
- Keep full Orchestrator workflow explicit opt-in.
- Start Markdown-first and defer Plugin packaging.

## Consequences

- Triggering and platform boundaries remain understandable.
- The Project Docs system is visible as the main product rather than hidden as
  generic state management.
- More than one skill must be validated, but each skill remains smaller and
  easier to test independently.
- The repository must not claim hard enforcement or measured improvement
  without separate evidence.
