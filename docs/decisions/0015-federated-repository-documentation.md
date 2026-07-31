# 0015: Federated Repository Documentation

Date: 2026-07-31
Status: accepted

## Context

The repository began with root-level product, architecture, status, evidence,
and handoff documents that described all three public Skills in detail. As
Project Docs, Work Charter, and PowerShell became independently installable and
evaluable products, their detailed contracts and evidence accumulated in the
same root files. Current state, writer, next gate, and verification history
then became difficult to keep coherent without duplicating facts.

The installable Skill packages cannot own human README, installation,
changelog, or process-history files. Repository documentation therefore needs
a structure that gives each Skill a clear public and development owner while
preserving repository-level composition, versioning, and release truth.

## Options Considered

1. Keep every detail in the root documents.
2. Copy a complete project-document suite into each Skill package.
3. Use federated repository documentation: root owners for shared contracts and
   lifecycle, per-Skill repository docs for product, design, state, and
   evidence, and unchanged minimal installable packages.

## Decision

Choose option 3.

### Root Owners

- `docs/SPEC.md` owns repository product goals, shared audience, independent
  Skills, composition and authorization boundaries, version and release
  contract, repository non-goals, and shared acceptance.
- `docs/ARCHITECTURE.md` owns cross-Skill composition, canonical ownership,
  optional recipes, source/install roles, release envelope, and
  advisory-versus-deterministic boundaries.
- `docs/STATUS.md` is a short repository dashboard.
- `docs/VERIFICATION.md` owns repository checks, coherent multi-Skill
  candidates, tags, stable installs, release evidence, and shared evidence
  limitations.
- `docs/HANDOFF.md` owns repository writer custody, dirty scope, repository next
  action, recovery order, and unauthorized actions.

### Per-Skill Owners

For each public Skill under `docs/skills/<skill-name>/`:

- `README.md` is the English-canonical human entry for purpose, usage,
  independent installation, invocation, safety, and evidence limits.
- `README.zh-CN.md` is its Simplified Chinese mirror and links back to the
  English canonical.
- `DESIGN.md` owns that Skill's purpose, audience, triggers, non-goals,
  behavior contract, and internal SOURCE/reference/asset/eval boundaries.
- `STATE.md` owns current implementation, writer, next gate, and recovery
  entry.
- `VERIFICATION.md` owns the Skill claim ledger, forward tests, SOURCE,
  DEV_DISCOVERY, RC_INSTALL, and STABLE_INSTALL evidence and limitations.

Detailed sanitized run reports remain under `evals/results/` and are linked
from the owning verification ledger. A historical fact that cannot be assigned
without loss remains in the root release ledger with an explicit link.

### Canonicality And Language

One persistent fact has one canonical write owner. Root files link to Skill
owners and use only bounded summaries. Per-Skill README files do not become a
second runtime specification; accepted decisions, root `SPEC`, per-Skill
`DESIGN`, and canonical `skills/<skill-name>/` SOURCE retain contract
precedence.

English is canonical. Root and per-Skill public README files have Simplified
Chinese mirrors. The English owner changes first; the same change set updates
the mirror. Deterministic repository checks verify expected mirror files,
reciprocal navigation, and corresponding section counts.

### Package And Release Boundary

No README, installation guide, changelog, or process-history file is added
inside `skills/<skill-name>/`. The three Skills remain independent products,
while v0.1 continues to use one immutable repository tag and one public
repository envelope.

## Consequences

- A maintainer can recover one Skill without reading unrelated Skill history.
- Repository release truth remains coherent across all three packages.
- More documentation files exist, but each has a narrow owner and deterministic
  shape check.
- Migration must preserve dates, source identities, excluded attempts, and
  evidence limitations through the new ledgers and linked sanitized results.
- No generator, database, registry, Plugin, or independent version line is
  introduced.

## Re-evaluation Conditions

Revisit this structure if a fourth or later Skill makes manual navigation
materially unreliable, if per-Skill release cadences are accepted, or if
repeated drift demonstrates the need for a small deterministic generator.
Do not add one preemptively.

## Related Documents

- [Authority map](../AUTHORITY.md)
- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Repository status](../STATUS.md)
- [Repository verification](../VERIFICATION.md)
