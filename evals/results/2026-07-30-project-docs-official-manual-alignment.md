# Project Docs Official-Manual Alignment

Date: 2026-07-30

## Scope

This development tranche compared `manage-project-docs` with the current
official Codex documentation, corrected one invocation-contract conflict,
removed redundant native and internal instructions, and reran the Project Docs
behavior and selection checks.

The relevant official sources were:

- [Build skills](https://learn.chatgpt.com/docs/build-skills.md);
- [Custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md.md);
- [Agent approvals and security](https://learn.chatgpt.com/docs/agent-approvals-security.md).

## Alignment Result

| Surface | Official behavior | Project Docs result |
|---|---|---|
| Skill loading | Codex exposes metadata first and loads full `SKILL.md` after selection | the package keeps a concise entry and two conditional references |
| Invocation policy | `allow_implicit_invocation: false` disables prompt-matched implicit invocation while explicit `$skill` remains available | the frontmatter now requires user invocation; a project-rule mention is routing only |
| Project instructions | Codex loads and layers applicable `AGENTS.md` files before work | the Skill follows the instructions already loaded by the Harness instead of directing a redundant reread |
| Approvals and sandbox | native controls govern technical capability and when Codex must ask before a tool action | Project Docs separately retains semantic authorization for adoption, structure, authority, and canonical ownership |
| Repeated rules | detailed resources should supplement a concise `SKILL.md` | duplicate outcome, stop, and completion-report lists were consolidated into the entry-point contract |

The continuity asset now tells a later agent to ask the user to explicitly
invoke `$manage-project-docs` when governance routing fails or structure or
authority must change. That line is neither native invocation nor authorization
for the requested change. Ordinary updates with valid routing still proceed
without loading Project Docs.

## Current SOURCE Identity

All fresh behavior evaluators and the native explicit canary reproduced these
normalized UTF-8/LF SHA-256 values:

| File | SHA-256 |
|---|---|
| `skills/manage-project-docs/SKILL.md` | `0211fc4a93f1d3fb35d15abe502f0ecae26d25274e742d558dd189d82d7f5a06` |
| `skills/manage-project-docs/agents/openai.yaml` | `50fa3c3799caeca29ec6ba10151bd7c58e3c85d4e86d86b38ae9632306e31b17` |
| `skills/manage-project-docs/references/audit-and-adopt.md` | `abc04d3b9c616436da627fd7d0b9246c1849afae737db05d6b8e06240c213f33` |
| `skills/manage-project-docs/references/maintain-and-recover.md` | `ce712be1505f3b49dc3b8b76dc90afcaffc1d99cca1d5fcbaf5bed41e4293121` |
| `skills/manage-project-docs/assets/templates/project-doc-starter.md` | `d5d70f3c2b3422f51be420658bfe2198992ad95daaeac0aa28e5f1e4fe61ec8a` |
| `skills/manage-project-docs/assets/templates/continuity-anchor.md` | `258578585c4a9c69379afdfa9a872b41233885a11c6342a7458c7677aeb68ec5` |

The package still contains exactly these six files.

## Fresh Behavior Matrix

Each behavior group used a fresh `gpt-5.6-sol` context at medium reasoning, an
isolated synthetic Git repository, direct reads of the current SOURCE, and
before/after manifest and Git reconciliation.

| Scenario | Outcome | Continuity | Observable result | Verdict |
|---|---|---|---|---|
| Mature sufficient layout | `NOOP` | `strong` | zero manifest delta; synthetic `HEAD` `e2b4a5e6c37e8c2593ab7ba2b31b0079912b6793` and index unchanged; one focused test passed | pass |
| Authorized first adoption | `UPDATE` | `strong` | added one combined `PROJECT.md`, updated existing `AGENTS.md`, preserved three ignored test caches; synthetic `HEAD` `ff7a12f7c37ae1415ed7a7ebce17411786885657` and index unchanged | pass |
| Explicit continuity update | `UPDATE` | `strong` | changed only existing `PROJECT_STATE.md`; synthetic `HEAD` `18c8af1317b982b1c22951c6b10bbb2c583da3b9` and index unchanged; one focused test passed | pass |
| Persistence-only broken routing | `STOP` | `weak` | zero run-time delta; asked for explicit `$manage-project-docs` invocation and separate structural authority; did not treat the rule mention as Skill selection | pass |
| Authority conflict | `PROPOSE` | `weak` | zero run delta; preserved `UNKNOWN` ownership and pre-existing dirty file byte-for-byte; one focused test passed | pass |
| Safety boundaries | `REPORT` | `weak` | strict zero manifest delta; preserved nearest monorepo scope, language, generated owner, unavailable external fact, no-write state, and active writer | pass |

The persistence-only broken-routing baseline used synthetic commit
`3075634ff20b6e8152d71bb3d6bd5ae42f50d913`. The authority and safety
baselines were `8154268d2e498a8c7d7316c4a18788e57e10e7f1` and
`e9acc5d8f953edb5fd1fd827d6bcae96c39c2cad`. All synthetic `HEAD` and index
identities remained unchanged during their evaluated runs.

## Native DEV_DISCOVERY Selection

A user-scope development discovery entry was mapped to canonical SOURCE. The
test scope contained no repository-local same-named discovery entry.

Two new native Codex sessions used identical clean synthetic baselines:

- the explicit `$manage-project-docs` run selected and read canonical
  `skills/manage-project-docs/SKILL.md`, reproduced all six current hashes,
  returned `NOOP`, did not use the private global Project Docs reference, and
  left the synthetic repository clean;
- the negative run did not name or invoke a Skill, completed the ordinary
  project summary and focused test, and reported that no full Skill body or
  `SKILL.md` was provided or read. Discovery metadata alone was not counted as
  the Skill body.

This closes the controlled native explicit-only selection and
`DEV_DISCOVERY` loaded-copy identity gate for the current development SOURCE.
It does not establish broad trigger telemetry, an installed materialized copy,
`RC_INSTALL`, stable installation, or release identity.

## Limitations

- The behavior evidence was collected while the SOURCE revision was
  uncommitted; later local candidate inclusion does not make it release-pinned.
- Behavior evaluators read canonical SOURCE directly; only the separate native
  canaries exercised the development discovery entry.
- No isolated release candidate or stable installation was created.
- No real-project efficacy, token reduction, cross-Harness parity, or
  release-pinned behavior claim is supported.
- Private global Project Docs guidance was not changed by this tranche.

Verdict: `READY_FOR_REPOSITORY_CANDIDATE_INCLUSION`, not `RELEASE_READY`.
