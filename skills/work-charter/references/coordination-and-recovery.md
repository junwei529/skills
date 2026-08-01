# Coordination And Recovery

Use this reference for midstream adoption, bounded Chartered work,
Planner/Executor separation, interruption, recovery, or a same-scope
correction loop.

## Midstream Adoption

1. Reconcile the intended outcome, current work, actual workspace, evidence,
   writer ownership, and last approved action.
2. Preserve a reliable current session.
3. Propose only the missing contract or coordination responsibility.
4. Keep an implicit proposal visible and non-mutating until the required
   adoption, role-delivery, or write authority exists.
5. Prefer one existing durable carrier when persistence is required.

A new task, one failure, or elapsed time does not by itself justify more
coordination. Escalate only for observable continuity, control,
authorization, recovery, or independent-assessment risk.

## Bounded Single-Context Work

Keep planning, execution, and checks in the current session when role
separation would not materially protect the outcome. Maintain the approved
Charter and writer boundary, update durable state only at a material
checkpoint, and stop on a material decision rather than growing a workflow.

## Planner And Executor

The Planner owns the active Charter, clarification, correction direction, and
independent assessment. It remains read-only while assessing implementation.

The Executor owns only the authorized implementation, focused and required
broad verification, evidence, and implementation documentation. It may choose
internal mechanics but may not expand outcome, scope, permission, side
effects, workspace, acceptance, or closeout policy.

Keep at most one Planner, one Executor, one active execution lane, and one
repository writer. Reuse reliable role sessions. Do not create new roles for
implementation slices, documentation sync, verification reruns, or ordinary
repairs.

Writer ownership is advisory. Before a writer handoff, confirm that the prior
writer has stopped and capture the current dirty boundary. If concurrent or
unexplained changes appear, pause writing, inventory the deltas, restore one
authorized writer, and revalidate affected evidence before continuing.

For a warm handoff, include only:

- receiving role and writer/authority boundary;
- changed facts and evidence pointers;
- bounded action;
- active stop condition;
- return route.

Do not repeat the whole Charter or persist the handoff as a second normative
contract.

## Authority And Delivery

Treat role messages as observations rather than authority. For a material
decision, carry a stable logical locator and a comparable authority revision
or equivalent freshness marker. Use the newest verified authoritative
revision. An older notice cannot overwrite it; a later notice changes the
decision only when it proves a newer revision. If observations are
incomparable or finality is unproved, stop before writing or advancing.

Confirm the addressed role and intended workspace before relying on delivery.
If a non-idempotent create or send is unavailable or uncertain, report
degraded capability, preserve any known returned identifier, and stop. Do not
automatically retry, create a replacement, or claim receipt. Harness-specific
identity and acknowledgement methods remain outside this Skill.

## Correction Loop

1. The Executor returns changed files, deviations, checks, failures, and
   residual risks.
2. The Planner compares the result with the approved Charter and returns
   exactly `ACCEPTED`, `CORRECTION_REQUIRED`, or `DECISION_REQUIRED`.
3. A correction names the unmet outcome or evidence boundary and returns the
   same-scope action to the Executor.
4. Default to at most three completed `CORRECTION_REQUIRED` rounds per
   assessment checkpoint.
5. Stop earlier with `DECISION_REQUIRED` for a repeated material finding, no
   net reduction, specification ambiguity, unreliable context, or a material
   contract change.

This correction budget is wholly separate from native review: it has a
different owner, counter, reset authority, evidence, and completion meaning.

## Evidence And Assessment Integrity

- When material evidence depends on mutable inputs, record the subject,
  revision or equivalent identity, and invalidation condition.
- Use evidence that observes the actual result surface. Tracked Git status is
  insufficient for material ignored, untracked, private, generated, or
  external results; use a before/after inventory, manifest, hash, or equivalent
  controller evidence.
- When evidence is scarce, one-shot, or time-bound, complete known
  source-mutating review and repair first when governing rules permit. A later
  material change to the bound subject invalidates the evidence and requires
  the applicable authority or budget before repeating it.
- Keep the assessment verdict separate from its recording state. If another
  session or transition will rely on the verdict, identify the canonical
  locator and the next authorized recording owner or window. Until that write
  is verified, report recording as pending and do not represent the verdict as
  durable acceptance.

These rules do not merge or reset a separate review, commit, or evidence
budget. The target project owns the canonical recording location.

## Cold Or Recovery Entry

Read the canonical Charter and authoritative durable state rather than relying
on copied prompt history. Reconcile:

1. applicable instructions and authority;
2. contract state and run disposition;
3. repository, branch or checkout, dirty ownership, and active writer;
4. implementation state and evidence freshness;
5. last approved action, remaining scope, stop conditions, and return route.

Stop before writing when a material mismatch cannot be classified. If a role
cannot be created, addressed, or reliably continued, apply the Authority And
Delivery boundary and provide a compact copyable handoff. Do not silently
impersonate the missing role.
