# 0003: Source, Install, And Release Boundaries

Date: 2026-07-28
Status: accepted

## Context

The same Skill can appear as repository source, a local development discovery
entry, an isolated release candidate, or a stable installation. Without an
explicit boundary, developers can edit a derived copy, test the wrong
same-named Skill, or publish evidence that cannot be mapped to a commit.

A Codex task or chat also does not identify the files it loaded. The project
therefore needs a version and environment model that remains valid whether v0.1
uses a standalone Skill installation or a later accepted Plugin package.

## Options Considered

1. Edit whichever installed or discovered copy is convenient and synchronize
   changes manually.
2. Keep one repository source, use a direct local mapping only for development,
   test an isolated candidate from a clean commit, and map stable installs to
   immutable release identities.
3. Maintain separate editable source trees for repository, local installation,
   and each published Skill.

## Decision

- Treat `skills/<skill-name>/` in an approved repository checkout as the only
  canonical editable source.
- Treat a local symbolic link, junction, or supported discovery mapping as a
  development convenience only. It must resolve to canonical source, remain
  local, and stay outside the public package.
- Treat a release candidate as an isolated installed or packaged snapshot
  produced from one exact commit through a clean candidate checkout or archive.
  It must not resolve to the editable checkout.
- Treat a stable installation as a generated snapshot from an accepted release
  tag and commit. Never edit or reverse-synchronize it.
- Prevent ambiguous tests by making only one same-named candidate discoverable
  in the test root or profile.
- Identify development evidence by checkout, commit or unborn state, and dirty
  state; identify release-candidate evidence by exact commit and clean
  candidate source; identify a release by repository-level version tag and
  commit.
- Use repository-level versioning for v0.1. Defer independent per-Skill version
  lines until a separate decision establishes a need.
- Require release evidence to record both the intended revision and proof of
  which copy was actually loaded.
- Use a worktree only for ordinary Git isolation needs, not as a substitute for
  an install or release-candidate environment.
- Keep the standalone-Skill versus skill-only-Plugin packaging choice separate.
  This decision governs both and does not authorize Plugin work.
- Require explicit authorization before creating or changing local discovery
  mappings, installing or updating Skills, altering user configuration,
  downloading or elevating, or performing GitHub publication actions.

## Consequences

- Daily edits have one direction: repository source to derived environments.
- Development mapping remains fast, while release smoke tests cannot
  accidentally pass against the working tree.
- Candidate and release claims require more provenance evidence.
- A working tree may be useful for development while dirty, but it cannot serve
  as a release candidate.
- The exact public installation commands remain blocked on the M5 distribution
  decision.

## Re-evaluation Conditions

Reconsider this decision if the project adopts independent Skill release
cadences, the selected packaging system provides a stronger immutable source
mapping, or repeated supported workflows cannot isolate same-named
development, candidate, and stable copies.

## Related Documents

- [Development, installation, and release runbook](../RUNBOOK.md)
- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Verification](../VERIFICATION.md)
