# 0004: Public MIT License

Date: 2026-07-28
Status: accepted

## Context

The repository is intended for public reuse, but no public license was
selected. Without a license, publication alone would not grant downstream
users clear permission to copy, modify, or redistribute the Skills,
documentation, and supporting scripts.

The repository also has a publication-safe local Git author identity, but that
identity is not a public copyright-holder decision and must not be copied into
a tracked license file by inference.

## Options Considered

1. Use the MIT License as a short permissive license.
2. Use Apache License 2.0 for permissive terms with a more detailed patent and
   notice framework.
3. Publish without an open-source license and retain the default copyright
   restrictions.

## Decision

- Use the OSI-approved MIT License for the public v0.1 repository.
- Put the standard MIT text in a root `LICENSE` file.
- Use the user-confirmed public attribution:
  `Copyright (c) 2026 matsuri1987`.
- Apply that license to repository-authored Skills, documentation, fixtures,
  and supporting scripts unless a file or third-party notice explicitly states
  otherwise.
- Preserve the copyright and permission notice in redistributed copies or
  substantial portions.
- The confirmed attribution is the only identity copied into the root license;
  do not replace it with local Git configuration, a private account, or a
  workspace-derived identity.

## Consequences

- The license family is no longer an open release decision.
- The root license and public copyright-holder text are materialized.
- Publication and installation remain separately gated; accepting MIT does not
  authorize a commit, remote, push, tag, release, or installation.
- Third-party material is not automatically relicensed and must remain covered
  by the provenance and publication review.

## Re-evaluation Conditions

Reconsider this decision only if a future distribution includes material whose
license is incompatible with MIT, a legal review requires different terms, or
the project adopts a materially different contribution or patent policy.

## Related Documents

- [Product specification](../SPEC.md)
- [Provenance and publication boundary](../PROVENANCE.md)
- [Current status](../STATUS.md)
- [Development, installation, and release runbook](../RUNBOOK.md)
- [OSI MIT License](https://opensource.org/license/mit)
