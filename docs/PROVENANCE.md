# Provenance And Publication Boundary

Last updated: 2026-08-19

## Purpose

This repository extracts portable workflow ideas from a private Codex working environment without publishing that environment itself. This document records source categories, transformations, and release exclusions.

Decision records own their rationale-specific bibliographies. The table below
records sources that materially affect reusable transformation, tooling, or
publication boundaries; it is not a duplicate index of every citation in a
decision.

## Source Categories

| Source | How it was used | Publication treatment |
|---|---|---|
| Author-maintained global Codex guidance | Requirements source for documentation authority, bounded roles, context recovery, and Windows command boundaries | Concepts were rewritten into smaller, trigger-specific skills |
| Author-maintained project documentation practice | Requirements source for specification, status, handoff, verification, and decision responsibilities | Generalized templates use placeholders rather than project facts |
| Approved portable repository-coordination requirements | Requirements source for identity binding, one-writer routing, provider/consumer ownership, callback convergence, and split reconsideration | Rewritten as repository-local rules and Decision 0025; no private repository, prompt, task, path, memory, or session material was inspected or copied |
| Locally bundled `skill-creator` | `<CODEX_HOME>/skills/.system/skill-creator/scripts/init_skill.py` generated the initial directories and metadata; `quick_validate.py` checked package structure | Generated instructional placeholders were removed; the tool revision was not exposed and remains unpinned |
| [OpenAI Build skills guidance](https://learn.chatgpt.com/docs/build-skills) | Primary source for current standalone Skill discovery, `$skill-installer`, and Skill-versus-Plugin distribution boundaries | The v0.1 standalone GitHub choice is documented as a narrower early distribution path; the repository does not claim Plugin-directory availability |
| [OpenAI AGENTS.md guidance](https://learn.chatgpt.com/docs/agent-configuration/agents-md) | Primary source for native global-to-project instruction loading and nearest-scope precedence | Project Docs follows the instruction chain already loaded by Codex; its separate responsibility map and canonical-write rules remain product semantics |
| [OpenAI approval and security guidance](https://learn.chatgpt.com/docs/agent-approvals-security) | Primary source for native sandbox capability and approval-policy behavior | Project Docs structural and authority gates are semantic user-authorization boundaries and are not replaced by workspace write capability |
| [YAO Meta Skill at `e15472e`](https://github.com/yaojingang/yao-meta-skill/tree/e15472e1f5dc96f79ea0259bf9fdf67598cea356) | 2026-08-02 design reference for duplicate-install diagnostics, baseline/candidate comparison, and claim/evidence review; the reviewed commit is MIT-licensed | Patterns were independently summarized; no code, text, Skill OS, compiler, UI, registry, telemetry, Plugin, or MCP dependency was imported |
| [Microsoft SkillOpt at `e7014cd`](https://github.com/microsoft/SkillOpt/tree/e7014cd18a18e11e6f6c10b897f7a009960d2e1b) | 2026-08-02 research reference for an isolated suggestion-only optimizer experiment; the reviewed commit is MIT-licensed | No code, dependency, output, dataset, or provider-supplied artifact entered the repository; no optimizer run or automatic adoption occurred |
| [Microsoft PowerShell documentation](https://learn.microsoft.com/en-us/powershell/) | Primary source for version, parsing, encoding, stream, process, lifecycle, migration, and Windows installation behavior | Technical facts and command interfaces were independently summarized; version-sensitive claims point back to current official guidance |
| [Microsoft WSL documentation](https://learn.microsoft.com/en-us/windows/wsl/) | Primary source for Windows/Linux command, path, working-directory, permission, and state boundaries | Portable boundary rules were summarized without host-specific distribution or path data |
| [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | Public example of packaging agent guidance as a repository artifact | Packaging inspiration only; no text or code copied |
| [mattpocock/skills](https://github.com/mattpocock/skills) | Public example of small, composable skill packages | Packaging inspiration only; no text or code copied |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | Public example of an owner-namespaced `skills` repository for a differentiated Skill collection | Repository-naming inspiration only; no text or code copied |

## Private-Rule Classification

Private global guidance is reviewed without copying it into the repository:

| Classification | Evidence threshold | Publication treatment |
|---|---|---|
| Portable rule | Current first-party interface documentation or a reproducible boundary across the stated versions | Rewrite the mechanism and qualify its versions and prerequisites |
| Bounded inference | A concrete failure plus corroborating interface behavior or a sanitized minimal reproduction | Publish only the conditional diagnostic question and safe response; preserve uncertainty |
| Private host delta | Exact path, installed version, package source, account, environment value, `PATH` order, distribution, registry/WSL state, sandbox identity, tool route, or current probe result | Keep outside the public repository; record only that the category was excluded |

One-machine experience can motivate an eval case. It cannot by itself establish
general efficacy, prevalence, compatibility, or a universal platform rule.

## Transformation Rules

- Do not copy private global guidance or reference files verbatim.
- Keep documented portable principles. Convert corroborated host failures only
  into bounded, conditional diagnostics.
- Remove host-, account-, repository-, model-, environment-, package-, and
  tool-route-specific values.
- Replace private absolute paths and task identifiers with logical locators.
- Exclude session transcripts, memory, rollout data, prompts, completions, hidden reasoning, secrets, and environment dumps.
- Treat repository files under `skills/` as canonical source. Keep local
  discovery mappings and generated indexes out of the public package, and build
  release candidates from an exact commit through a clean candidate checkout
  or archive rather than an installed, cached, or dirty copy.
- Describe advisory behavior as guidance, not deterministic enforcement.
- Keep efficacy, token, portability, and SHICE claims unverified until pinned evaluations support them.

## External Optimization Data

- Use only synthetic or explicitly reviewed and redacted inputs. Never submit
  production sessions, private prompts or completions, memory, rollout data,
  secrets, environment dumps, private repositories, or hidden reasoning.
- Before any provider or telemetry call, record the exact approved payload
  category, destination, retention policy, cost boundary, and tool identity.
  Unknown outbound content or retention is a stop condition.
- Pin input and target hashes and keep optimizer artifacts outside canonical
  `skills/` SOURCE. Treat every output as an untrusted proposal; disable
  automatic source writes, adoption, installation, and release.
- Review imported language or code for license and provenance, rewrite selected
  ideas into this repository's own contract, and route the delta through the
  normal authoring, evaluation, and release gates.

## Third-Party Material

No third-party code, templates, images, optimizer output, datasets, or
long-form text are intentionally included in the current repository. Public
repositories listed above influenced packaging or process decisions only.
Microsoft documentation supplies technical facts and public command/API
shapes; the Skill text is a concise independent synthesis.

## Release Gate

Before public release:

1. retain the accepted root MIT license and confirmed public attribution;
2. repeat the publication-safety and provenance review;
3. complete fresh-context behavior tests and publish their limitations;
4. confirm a publication-safe Git author identity;
5. pin the released skill revision, validator identity or revision, and
   validation evidence;
6. build an isolated candidate from the exact candidate commit and prove which
   copy the Harness actually loaded;
7. document and smoke-test at least one supported public skill-package
   installation path;
8. map the accepted repository-level release tag to the verified candidate
   commit.

Current state:

See [Repository Status](STATUS.md) for the integration dashboard, the linked
per-Skill State and Verification owners for implementation evidence, and
[Repository Verification](VERIFICATION.md) for coherent candidate, tag,
stable-install, and release boundaries. The accepted source transformation and
release rules above remain stable regardless of milestone progress.

This record is not legal advice or a substitute for a license review.
