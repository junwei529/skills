# 0025: Monorepo Coordination And Skill Contract Hardening

Date: 2026-08-19
Status: accepted

## Context

Agent Workflow Skills has one repository-level source, evidence, and release
envelope for three independently useful Skills. Recent coordination work
showed that directory, repository, saved Codex Project, branch, worktree, and
task or Session labels were sometimes treated as interchangeable. It also
showed that an active reader could be mistaken for the repository writer, and
that a dependency could be mistaken for authority to edit another component.

The repository already has Git, canonical documentation owners, one-writer
guidance, Work Charter Result Notices, and deterministic repository checks.
A parent workspace, broker, database, lock service, or repository split would
add a control plane before the observed problems require one.

## Decision

Keep Eddie-skills as one Git repository, one saved Codex Project, and one
shared release and evaluation envelope. Adopt the following logical contract.

### Bind Identities Explicitly

Directory, repository, saved Project, branch, worktree, and task or Session
identity are separate dimensions. Bind the dimensions that matter to the
current operation and do not infer one from another. A task name does not prove
its checkout, a worktree does not prove its branch or writer, and a directory
inside a repository is not an independent repository or release line.

### Separate Readers, Active Sessions, And The Writer

Readers, active Sessions, and the repository writer are distinct. Shared reads
are allowed within each reader's authority. Exactly one repository writer owns
the current write window; activity, a branch, a worktree, or a dependency does
not itself grant write authority. Upstream or integration changes are applied
by, or explicitly routed through, that exact writer.

### Keep Contract Ownership Local

A provider owns its public contract. Each consumer owns its compatibility
declaration and the assembled integration tests that prove its use of that
contract. Dependency grants neither cross-write authority nor permission to
rewrite the provider. When compatibility needs an upstream or integration
change, the consumer reports the required delta and evidence to the current
repository writer instead of editing across the ownership boundary.

### Converge At Checkpoints

Compact callback-first Result Notices receive independent verification and one
checkpoint-bound disposition. The sender stops after dispatch rather than
polling or creating acknowledgement traffic. A terminal disposition grants no
new action. Missing or uncertain delivery remains unresolved and does not
activate a replacement writer or imply acceptance.

## Non-Goals

- no non-Git coordination parent;
- no per-Skill repository, saved Project, or independent version line;
- no Plugin, MCP service, controller, broker, generic adapter, lock, receipt
  database, or host enforcement; and
- no malicious-same-user or host-level security claim.

The contract is repository-development guidance. It does not change public
Skill behavior, install or release anything, or provide deterministic access
control.

## Re-evaluation Conditions

Reconsider a hybrid or split only when evidence meets at least one threshold:

| Trigger | Evidence threshold | Decision owner |
|---|---|---|
| Incompatible release or evaluation lifecycles | Two completed planning or release cycles show that an accepted per-Skill version, provenance, or acceptance requirement cannot be represented in the shared envelope without blocking an unrelated Skill twice | repository-level product decision owner, after independent assessment |
| Incompatible permission or ownership boundary | One approved requirement needs an ACL, legal/data boundary, or independent write authority that a shared Git repository cannot provide, plus a documented failed containment analysis | repository-level authority owner |
| Repeated coordination failure | At least three independently recorded wrong-worktree, ambiguous-writer, cross-owner-write, duplicate-decision, or missing-disposition incidents across at least two Phases after this contract is active | repository-level workflow decision owner, after root-cause review |
| Persistent parallel-writer need | At least three blocked handoffs across two Phases show that exact-owner routing prevents two independently valuable, non-overlapping changes whose acceptance and integration cannot share one writer window | repository-level workflow decision owner |

Directory count, task count, Phase duration, and repository size alone do not
meet a trigger. A triggered review chooses among a narrower coordination fix,
a hybrid boundary, or a repository split; it does not make the split automatic.

## Consequences

- The existing monorepo, saved Project, release tags, and evaluation envelope
  remain authoritative.
- Provider and consumer responsibilities become explicit without a new
  runtime abstraction.
- Git and repository documentation remain the coordination substrate.
- Deterministic checks validate the recorded contract and navigation only;
  they do not enforce writer exclusivity or Session delivery.

## Related Documents

- [Architecture](../ARCHITECTURE.md)
- [Development and release runbook](../RUNBOOK.md)
- [Repository handoff](../HANDOFF.md)
- [Decision 0015](0015-federated-repository-documentation.md)
- [Decision 0016](0016-work-charter-authority-assessment-and-evidence-integrity.md)
- [Decision 0017](0017-capability-delta-skill-development.md)
