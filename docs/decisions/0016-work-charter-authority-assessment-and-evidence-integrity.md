# 0016: Work Charter Authority, Assessment, And Evidence Integrity

Date: 2026-07-31
Status: accepted

## Context

Recent consequential Codex work exposed four related failures that the
minimum Work Charter contract did not make operationally explicit:

- a late or out-of-order role notice could appear to reverse an already
  recorded approval;
- uncertain role delivery could invite a duplicate replacement;
- a read-only assessment could remain only in chat while durable state still
  described it as pending; and
- ignored results or a later source change could make apparently passing
  evidence incomplete or stale.

The existing stop-on-ambiguity, material-checkpoint, evidence-freshness, and
one-writer rules point in the right direction, but they do not tell a fresh
agent how to distinguish stale observations from authoritative state or when
an assessment can support cross-session continuation.

A mandatory receipt file, fourth verdict, message state machine, writer lock,
or fixture-specific public template would add more concepts than the observed
failures require.

## Decision

### Authority Finality

- A material cross-session decision carries a stable logical locator and a
  comparable authoritative revision or equivalent freshness marker.
- Message arrival order is not authority order. An older observation cannot
  overwrite a newer verified revision. A later observation changes the
  decision only when it proves a newer authoritative revision.
- If observations cannot be compared or finality cannot be proved, Work
  Charter stops before writing or advancing. It does not add a new public
  verdict or mandatory Decision Receipt artifact.

### Delivery Degradation

- A role or message is not treated as delivered until the applicable Harness
  can correlate the intended receiver and workspace.
- An unavailable or uncertain non-idempotent create or send is reported as
  degraded and stops. Work Charter does not automatically retry, create a
  replacement role, or claim receipt.
- Exact task, host, workspace, acknowledgement, retry, and tool-routing
  mechanics remain Harness or private-control-plane responsibilities.

### Assessment Recording

- Assessment verdict and assessment recording are separate facts. The verdict
  remains exactly `ACCEPTED`, `CORRECTION_REQUIRED`, or `DECISION_REQUIRED`.
- A verdict that another session, recovery, or phase transition will rely on
  must identify its canonical locator and be durably recorded by the next
  authorized governance writer or window.
- Until that write is verified, the verdict is reported as recording pending
  and is not represented as durable acceptance. Work Charter owns this
  continuation boundary; the target project's documentation governance owns
  the canonical location.

### Evidence Integrity

- Material evidence that depends on mutable inputs records its subject,
  revision or equivalent identity, and invalidation condition.
- Evidence must observe the actual result surface. Tracked Git status alone
  cannot account for material ignored, untracked, private, generated, or
  external results.
- When evidence is scarce, one-shot, or time-bound, known source-mutating
  review and repair occur first when governing rules permit. A later material
  change to the bound subject invalidates the evidence and requires the
  applicable authority or budget before repetition.
- Work Charter evidence and correction semantics remain independent of native
  review, commit, installation, or release budgets and gates.

### Advisory Writer Recovery

- One-writer guidance remains advisory rather than a deterministic lock.
- Before handoff, record the dirty boundary and confirm the outgoing writer
  has stopped. Concurrent or unexplained changes pause writing, trigger a
  delta inventory and one-writer reassignment, and invalidate affected
  evidence until it is rechecked.

### Public And Private Boundary

- The public Skill owns the portable semantics above.
- Codex thread APIs, exact role titles, models, reasoning settings, task and
  host identifiers, worktree routing, native-review policy, and installation
  identity remain outside the public package.
- `SOURCE`, `DEV_DISCOVERY`, `RC_INSTALL`, and `STABLE_INSTALL` remain
  repository lifecycle identities rather than Work Charter states. A role or
  task name is not loaded-copy proof.

## Consequences

- Work Charter can fail closed on stale authority and unrecorded acceptance
  without becoming a message broker or persistence system.
- The five-file package, three assessment verdicts, proportional role model,
  correction budget, and independent-Skill boundary remain unchanged.
- One existing coordination reference owns the detailed behavior; no third
  reference, script, schema, lock, or required file is added.
- Existing SOURCE, DEV, RC, and stable evidence predates this revision and
  cannot prove the new behavior.

## Re-evaluation Conditions

Revisit this decision if comparable authority revisions cannot be expressed
without a new user action, if pending recording repeatedly blocks safe
continuation without protecting it, if no portable evidence-binding rule can
survive real projects, or if a supported Harness introduces deterministic
idempotent delivery or writer enforcement that materially changes the safe
fallback.

## Related Documents

- [Decision 0010](0010-compact-role-handoff-and-event-checkpoints.md)
- [Decision 0012](0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
- [Work Charter Design](../skills/work-charter/DESIGN.md)
- [Work Charter State](../skills/work-charter/STATE.md)
- [Work Charter Verification](../skills/work-charter/VERIFICATION.md)
