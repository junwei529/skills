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
- Use repository-level release-set versioning for v0.1. One immutable tag
  identifies one coherent repository candidate; it does not assert that every
  public Skill changed in that release or shares one maturity level. Defer
  independent per-Skill version lines until a separate decision establishes a
  need.
- For each release candidate, compare the union of public Skill packages in the
  candidate and previous accepted tag. Record each as `added`, `changed`,
  `unchanged`, or `removed`; a first release records every package as `added`,
  and a rename is always one `removed` path plus one `added` path. A separate
  accepted continuity decision may support bounded evidence reuse, but it does
  not change those physical deltas or their absence, update, and rollback
  duties. Scope evidence to the delta; exact package equality can support
  bounded continuity for an unchanged Skill but does not create a new behavior
  or maturity claim.
- Keep development, governance, and reference documentation in Git, but do not
  advance the stable release tag solely for changes that leave every public
  Skill package, its selection and behavior contract, and the accepted
  distribution and publication contract unchanged.
- For the pre-1.0 line, use a patch increment only for backward-compatible
  corrections that preserve public Skill names, paths, supported set
  membership, and installation interface. New public functionality, addition,
  removal, rename, an incompatible behavior or selection change, or a
  user-visible distribution or publication-interface change stops for an
  accepted version decision; while the product remains pre-1.0, the normal
  direction is the next minor line. Reaching `v1.0.0` requires its own stability
  decision. Never infer the release-set increment from one Skill's maturity
  alone.
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
- Internal development procedure and evidence-schema changes are not by
  themselves public distribution-interface changes. The public interface
  includes repository identity, distribution form, installer request, public
  Skill names and paths, supported set membership, user-visible release or
  installation behavior, and license terms.
- The exact public installation commands remain blocked on the M5 distribution
  decision.

## Re-evaluation Conditions

Reconsider this decision if the project adopts independent Skill release
cadences, users repeatedly need independent upgrade or rollback identities,
the selected packaging system provides a stronger immutable source mapping, or
repeated supported workflows cannot isolate same-named development, candidate,
and stable copies.

## Related Documents

- [Development, installation, and release runbook](../RUNBOOK.md)
- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Verification](../VERIFICATION.md)
