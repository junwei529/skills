# 0010: Compact Role Handoff And Event Checkpoints

Date: 2026-07-29
Status: accepted

## Context

Planner/Executor and Standard O/P/E separation protects context and assessment
boundaries, but a long prompt on every cross-session exchange creates its own
failure modes:

- stable context is repeatedly copied and consumes tokens;
- small corrections trigger disproportionate handoff work;
- shortening messages without a contract can blur role, authority, writer
  ownership, and return routing.

The handoff design therefore needs a small invariant safety envelope while
moving stable detail into authoritative sources.

## Decision

Use an **Anchor + Delta + Role Capsule** protocol. Full orientation is reserved
for cold start and recovery. Warm continuation, bounded correction, and result
return carry only the stable anchor plus the current delta.

### Role Capsule

Every cross-role message repeats a compact Role Capsule that identifies:

- the receiving role;
- whether it owns the active repository-writer window;
- the scope of its current authority;
- the material actions it must not take;
- the role or user to which it returns results or decisions.

This small repetition is intentional. The complete Charter and unchanged
project rules are not repeated with it.

### Anchor

The Anchor provides portable logical locators for the approved Charter, its
current revision or equivalent freshness marker, the authoritative project
state, relevant evidence, and the selected workspace identity. The receiver
reads the authoritative sources instead of treating copied prompt text as a
second normative contract.

Durable Anchors do not embed private absolute Skill installation paths, cache
paths, or task identifiers as product state. Runtime routing details remain
separate from the portable logical contract.

### Delta

The Delta contains only information that changed since the Anchor:

- the new fact, finding, or result;
- the exact bounded action requested from the receiver;
- new or invalidated evidence;
- any newly active stop condition;
- the required return destination.

An unchanged outcome, constraint, permission, acceptance condition, or project
history is referenced through the Anchor rather than copied again.

### Message Classes

| Class | Use | Required shape |
|---|---|---|
| Cold or recovery handoff | A role enters without reliable context, or interruption or drift invalidates prior context | Role Capsule, Anchor, authoritative read order, current state, exact first action, and stop/return route |
| Warm continuation | The same role and session remain reliable | Role Capsule, Anchor, and Delta |
| Correction or result notice | The same Planner/Executor pair exchanges a bounded correction or result | Minimal Role Capsule, Anchor, evidence/action Delta, and return route |

Cold and recovery messages provide complete orientation, but still point to
durable sources instead of copying their full contents.

### Session Reuse And Correction

- Reuse the same physical role session while its context and routing remain
  reliable.
- An approved Charter permits a bounded same-scope correction loop between the
  same Planner and Executor without creating a new session for each
  implementation slice, test failure, documentation sync, verification rerun,
  or local repair.
- The Planner states the unmet outcome or acceptance boundary and its evidence;
  it does not take over implementation ownership.
- The Executor chooses implementation mechanics inside the Charter; it does
  not change project direction, scope, authorization, acceptance, or role
  ownership.
- A material change to contract, permission, workspace, external side effect,
  acceptance, role, or project direction exits the correction loop and returns
  to the responsible user or upstream role.

This decision accepts the bounded correction shape but does not set a numeric
or qualitative correction budget. That remains a separate product decision.

### Event-Based Checkpoints

Durable state is updated for material lifecycle events rather than every role
message. Checkpoint events include:

- Charter approval or material revision;
- formal role or writer-ownership transfer;
- completion or assessment of an independently valuable stage;
- a user-decision or recovery stop;
- interruption or context-loss preparation;
- material workspace, authority, or evidence drift.

Ordinary same-scope repairs may remain in the active role exchange until the
next material checkpoint. A checkpoint records the resulting state and
evidence, not a transcript of every correction.

### Capability Degradation

When Codex can reliably address an existing role task, continue that task. If
role delivery is unavailable or uncertain, produce a compact copyable packet
using the same protocol and report that delivery is unproved. Do not silently
create a replacement task or claim that the receiver obtained the message.

## Consequences

- Role separation no longer implies repeated full-context prompts.
- Role identity and authority remain explicit even in short corrections.
- Small repairs stay within one approved Planner/Executor loop.
- Durable project documents are not churned for every message.
- The protocol is context-budgeted by design, but no token-saving claim is
  accepted until comparative evaluation exists.
- Exact public outcome and acceptance labels, Standard-flow stability,
  concurrency scope, and correction budget remain open.
- The current `manage-large-tasks` Skill and evidence predate this contract.

## Re-evaluation Conditions

Revisit the protocol if receivers repeatedly fail to resolve Anchors, if Delta
messages omit material state, if Role Capsules still permit ownership
confusion, or if comparative tests show that full orientation is needed more
often than the three message classes predict.

## Related Documents

- [Decision 0008](0008-work-charter-logical-contract-and-codex-carriers.md)
- [Decision 0009](0009-work-charter-role-profiles-and-resume-gate.md)
- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Roadmap](../ROADMAP.md)
- [Current status](../STATUS.md)
- [Verification](../VERIFICATION.md)
