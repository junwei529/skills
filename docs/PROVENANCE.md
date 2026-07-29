# Provenance And Publication Boundary

Last updated: 2026-07-28

## Purpose

This repository extracts portable workflow ideas from a private Codex working environment without publishing that environment itself. This document records source categories, transformations, and release exclusions.

## Source Categories

| Source | How it was used | Publication treatment |
|---|---|---|
| Author-maintained global Codex guidance | Requirements source for documentation authority, bounded roles, context recovery, and Windows command boundaries | Concepts were rewritten into smaller, trigger-specific skills |
| Author-maintained project documentation practice | Requirements source for specification, status, handoff, verification, and decision responsibilities | Generalized templates use placeholders rather than project facts |
| Locally bundled `skill-creator` | `<CODEX_HOME>/skills/.system/skill-creator/scripts/init_skill.py` generated the initial directories and metadata; `quick_validate.py` checked package structure | Generated instructional placeholders were removed; the tool revision was not exposed and remains unpinned |
| [OpenAI Build skills guidance](https://learn.chatgpt.com/docs/build-skills) | Primary source for current standalone Skill discovery, `$skill-installer`, and Skill-versus-Plugin distribution boundaries | The v0.1 standalone GitHub choice is documented as a narrower early distribution path; the repository does not claim Plugin-directory availability |
| [Microsoft PowerShell documentation](https://learn.microsoft.com/en-us/powershell/) | Primary source for version, parsing, encoding, stream, process, lifecycle, migration, and Windows installation behavior | Technical facts and command interfaces were independently summarized; version-sensitive claims point back to current official guidance |
| [Microsoft WSL documentation](https://learn.microsoft.com/en-us/windows/wsl/) | Primary source for Windows/Linux command, path, working-directory, permission, and state boundaries | Portable boundary rules were summarized without host-specific distribution or path data |
| [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | Public example of packaging agent guidance as a repository artifact | Packaging inspiration only; no text or code copied |
| [mattpocock/skills](https://github.com/mattpocock/skills) | Public example of small, composable skill packages | Packaging inspiration only; no text or code copied |

## Transformation Rules

- Do not copy private global guidance or reference files verbatim.
- Keep reusable principles; remove host-, account-, repository-, model-, and tool-route-specific policy.
- Replace private absolute paths and task identifiers with logical locators.
- Exclude session transcripts, memory, rollout data, prompts, completions, hidden reasoning, secrets, and environment dumps.
- Treat repository files under `skills/` as canonical source. Keep local
  discovery mappings and generated indexes out of the public package, and build
  release candidates from an exact commit through a clean candidate checkout
  or archive rather than an installed, cached, or dirty copy.
- Describe advisory behavior as guidance, not deterministic enforcement.
- Keep efficacy, token, portability, and SHICE claims unverified until pinned evaluations support them.

## Third-Party Material

No third-party code, templates, images, or long-form text are intentionally
included in the current repository. Public repositories listed above influenced
packaging decisions only. Microsoft documentation supplies technical facts and
public command/API shapes; the Skill text is a concise independent synthesis.

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

See [Current Status](STATUS.md) for implementation and writer state and
[Verification](VERIFICATION.md) for evidence and remaining claim boundaries.
The accepted source transformation and release rules above remain stable
regardless of milestone progress.

This record is not legal advice or a substitute for a license review.
