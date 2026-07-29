---
name: manage-project-docs
description: Audit, adopt, repair, and maintain a repository's project-document governance so humans and coding agents can find authoritative scope, working rules, current evidence, and recovery state. Use only when the user explicitly invokes Project Docs, including to establish, audit, repair, or maintain project-document governance or project-level handoff and recovery; or when an adopted target-project instruction explicitly invokes Project Docs for a governance failure or structural change. Applicable problems include missing, conflicting, duplicated, stale, generated, externally owned, or hard-to-resume documentation. Preserve sufficient mature layouts, require authorization before structural changes, and do not use merely because a project is long-lived, for ordinary canonical-document updates already covered by a valid project rule, ordinary prose editing, or generated-document formatting that does not affect governance.
---

# Manage Project Docs

Maintain reliable project truth without imposing a fixed file suite.

## Workflow

1. Establish the target scope, requested outcome, write permission, current
   writer, and whether structural change is authorized.
2. Read the nearest project instructions and existing navigation, then inspect
   relevant code, tests, Git state, and external evidence. Do not infer current
   behavior from prose alone.
3. Map existing sources to five logical responsibilities:

   | Responsibility | Required answer |
   |---|---|
   | Purpose and scope | What is this project or scope for, and what is excluded? |
   | Work and verification | How is work performed and proved? |
   | Authority and write routing | Where is each durable fact read, and where is it canonically written? |
   | Current state and evidence | What is true now, and what evidence supports it? |
   | Next action and recovery | Where and how does a later session resume? |

4. Classify the surface:
   - explicit audit or repair;
   - first adoption;
   - routine maintenance under an existing project rule; or
   - structural expansion or migration.
5. Load only the detailed reference needed:
   - read [Audit And Adopt](references/audit-and-adopt.md) for inventory,
     conflicts, missing responsibilities, first adoption, or structural change;
   - read [Maintain And Recover](references/maintain-and-recover.md) for a
     focused durable update, continuity, pause, handoff, or recovery;
   - use both only when adoption also needs a recovery entry.
6. End with one primary outcome:
   - `NOOP` when the existing system is sufficient;
   - `REPORT` for read-only findings that need no structural or authority
     decision;
   - `UPDATE` for an authorized change to an existing canonical owner;
   - `PROPOSE` when structure or authority needs approval, even if the current
     audit is read-only;
   - `STOP` when permission, writer ownership, scope, or evidence is unsafe.
     Use `STOP` only when the requested action itself cannot continue safely;
     a completed read-only audit remains `REPORT` even when a later write is
     blocked.
7. Verify links, status and evidence claims, recovery routing, placeholders,
   generated-source ownership, and publication safety. After any command that
   may write, reconcile the actual target file and Git state, including
   generated, ignored, and untracked artifacts.
8. Report the outcome, inspected scope, every actual file change, changed
   canonical owners, unresolved facts, continuity strength, and exact recovery
   entry. Use only `strong`, `weak`, or `not applicable` for continuity.
   `Strong` requires a verified durable anchor and recovery path with no known
   permission, writer, routing, or required-owner block; report `weak` when
   recovery was assessed and any such block remains.

## Canonical Write Rule

Allow several read locations, but keep one canonical write locus for each
normative durable fact within one scope and lifecycle. Link or summarize
elsewhere instead of copying the full fact.

Distinguish intended contract, actual implementation, current work state,
verification evidence, and historical rationale. Preserve `UNKNOWN` when those
sources do not resolve a conflict.

## Output Assets

- Use the [single-file Starter](assets/templates/project-doc-starter.md) only
  when an authorized first adoption is missing several responsibilities and
  one combined document is the smallest coherent result.
- Use the [Continuity Anchor](assets/templates/continuity-anchor.md) only when
  the user authorizes a persistent target-project rule. Merge it into the
  project's existing instruction or governance entry and replace every
  placeholder with actual routing.

Assets are adaptable output resources, not mandatory filenames. Do not copy
facts from this Skill repository into a target project.

## Boundaries

- Project-specific instructions and existing authority rules override this skill.
- Treat audit as read-only unless the request separately authorizes an update.
- Require explicit authorization for first adoption, new modules, split, merge,
  rename, migration, authority changes, and canonical-owner changes.
- Preserve a sufficient mature layout and return `NOOP`; do not upgrade named
  maturity levels or create a parallel documentation tree.
- Stop before writing when another writer's ownership is unresolved.
- With no write permission, return `REPORT` or `PROPOSE`.
- Edit the source of generated documentation, not the generated output.
- Treat an unavailable external source as unverified.
- Use the nearest applicable scope in a monorepo and preserve the project's
  existing document language.
- Persist continuity in target-project sources, not chat, private memory,
  discovery mappings, installed Skill copies, or caches.
- Do not modify Git history, commit, push, merge, or clean a worktree unless separately authorized.
- Do not publish secrets, private paths, task identifiers, raw logs, hidden reasoning, or personal environment details.
- Do not claim implementation or verification from prose alone.
- Do not activate the large-task workflow merely because project documentation is being updated.
