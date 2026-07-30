# 0013: GitHub Public Identity Update

Date: 2026-07-30
Status: accepted

## Context

The user changed the public GitHub account identifier used for this project
from `matsuri1987` to `junwei529`. Decisions 0004 and 0005 recorded the former
identifier in the MIT attribution and intended GitHub repository locator.

Public Skill collections such as
[`mattpocock/skills`](https://github.com/mattpocock/skills) and
[`emilkowalski/skills`](https://github.com/emilkowalski/skills) use the account
owner as the namespace, the generic repository slug `skills` as the collection
boundary, and README content for the collection's differentiated positioning.
This project similarly contains multiple independent Skill products rather
than one product named after the repository.

The reviewed local root commit already exists, but no remote, public candidate,
tag, installation, or release exists. The current public identity therefore
needs to be corrected before any publication action without rewriting the
historical decision record or implying that the new repository is already
available. The public repository slug, local checkout directory, README product
title, and individual Skill names also need distinct ownership.

## Options Considered

1. Use `junwei529/eddie-skills` for local-directory continuity and a more
   distinctive slug.
2. Use `junwei529/skills` as a concise owner-namespaced Skill collection.
3. Use `junwei529/agent-workflow-skills` for a more descriptive but narrower
   repository slug.

## Decision

- Use
  [`junwei529/skills`](https://github.com/junwei529/skills)
  as the exact public repository identity for current v0.1 distribution
  instructions and future lifecycle evidence.
- Keep **Agent Workflow Skills** as the README product title and keep each
  `skills/<skill-name>` name unchanged. The generic repository slug identifies
  the collection, not one umbrella runtime or product dependency.
- Keep the current local checkout directory unchanged. The existing
  repository-root checkout is a development locator, not the public repository
  identity, and moving an active checkout is outside this decision.
- Use the updated user-confirmed public attribution
  `Copyright (c) 2026 junwei529` in the root MIT `LICENSE`.
- Treat Decisions 0004 and 0005 as historical records. This decision
  supersedes only their `matsuri1987` public-attribution and repository-owner
  locator clauses; their license, packaging, versioning, installation, and
  authorization boundaries remain accepted.
- Preserve old identifiers only where they are necessary to explain historical
  evidence or supersession. Do not present them as current installation or
  publication interfaces.
- Keep remote creation, push, candidate installation, tag, stable installation,
  and release behind their existing separate user-authorization gates.

## Consequences

- Current documentation and installer prompts use `junwei529/skills`
  consistently.
- The root license names the current public attribution rather than inferring
  identity from local Git configuration.
- A read-only check on 2026-07-30 found the intended new GitHub repository was
  not publicly reachable. The URL remains a selected distribution contract,
  not evidence of a configured remote or published repository.
- The existing reviewed root commit remains valid as a local candidate
  baseline. This identity correction requires its own reviewed follow-up commit
  before publication.

## Re-evaluation Conditions

Reconsider the public identity if the GitHub account or repository owner
changes again, or if a generic repository slug creates a demonstrated
discovery or collision problem. Reconsider the broader distribution design
under Decision 0005's existing conditions.

## Related Documents

- [Public MIT License decision](0004-public-mit-license.md)
- [Standalone GitHub distribution decision](0005-v0-1-standalone-github-distribution.md)
- [Provenance and publication boundary](../PROVENANCE.md)
- [Development, installation, and release runbook](../RUNBOOK.md)
- [Product specification](../SPEC.md)
- [Verification](../VERIFICATION.md)
