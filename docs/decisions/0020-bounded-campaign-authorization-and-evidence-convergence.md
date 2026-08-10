# 0020: Bounded Campaign Authorization And Evidence Convergence

Date: 2026-08-10
Status: accepted

## Context

Recent Skill development and evaluation repeatedly stopped for narrow
authorizations, retried a carrier without first reducing the relevant risk, or
consumed scarce behavior evidence before the exact transport boundary had been
qualified. A new task, run root, successor, or attempt label sometimes made the
activity look new even though the candidate, acceptance target, and cumulative
history were unchanged.

The repository already separates qualification from evidence consumption,
keeps sealed evidence immutable, and requires explicit authority for writes,
model/provider calls, Git, installation, and release. Those safeguards remain
correct. The missing piece is a bounded project-level execution contract that
can authorize an entire coherent sequence once and then advance automatically
within declared limits.

## Options Considered

1. Continue asking for approval before every carrier, correction, model turn,
   assessment, and closeout action.
2. Grant open-ended standing authority until the Skill is accepted or released.
3. Use one bounded Campaign authorization with declared tranches, budgets,
   consumption points, automatic transitions, and material stop conditions.
4. Add a public lifecycle meta-Skill, Plugin, or remote controller to own the
   process.

## Decision

Choose option 3. A **Campaign** is an optional repository-development envelope
for one stable work subject. It is not a public Skill, runtime dependency,
background process, or new authorization surface.

### Campaign Identity And Authorization

A Campaign declaration binds:

- the stable work subject and exact current candidate or control identity;
- the acceptance target and hard failure boundaries;
- the ordered `qualification`, `evidence`, `assessment`, and `closeout`
  tranches that are in scope;
- allowed reads, writes, ignored artifacts, model/provider calls, costs,
  external effects, Git actions, and release actions;
- the evidence-consumption point for every scarce or one-shot action;
- correction, turn, assessment, review, and cost budgets;
- cell-local continuation rules, terminal sealing, and stop conditions; and
- the required result and recovery record.

One explicit user approval of that complete declaration authorizes every
listed action and conditional transition. Within the approved boundary, the
writer does not ask again for each reversible qualification correction,
deterministic verification rerun, evidence cell, assessor trigger, or closeout
step. Unlisted effects remain unauthorized. Authority does not transfer across
Skills, stable subjects, candidates, repositories, workspaces, providers, or
release targets.

### Qualification Before Product Evidence

Qualification proves that the intended evidence route is capable of carrying
the planned run before any product-behavior turn is consumed. It may construct
task-owned ignored carriers, isolate catalogs and homes, validate mappings and
fixtures, run deterministic controllers, freeze inputs, and perform declared
read-only preflight.

When a Campaign depends on a live model/provider route, qualification also
requires an explicitly budgeted **same-boundary transport canary**. It must use
the materially same executable/version, authentication mode, model/provider
endpoint, network and sandbox route, process-local configuration, and request
transport as the later product evidence. The route also includes the exact
outer launcher, stdout/stderr capture, exit-status transport, and conditional
phase-dispatch path used by the product batch. A catalog listing, capability
read, `thread/start`, or successful local controller run does not prove that
the responses path can complete.

Child output is evidence data and must remain separate from one typed scalar
exit status; the next phase may branch only on that status. If a non-product
model canary uses a more direct launcher than the product batch, it qualifies
only the inner provider response path. The Campaign must additionally exercise
the exact outer wrapper with a non-product response or a deterministic
synthetic child that proves output capture, nonzero propagation, scalar status,
and intended next-phase dispatch before a product turn is consumed.

A transport canary is deliberately non-product evidence. Its prompt and
scoring must not be used to accept or reject the Skill, prove selection,
attribute a loaded copy, or replace a required matrix cell. If the exact route
cannot be canaried without a model call, that call and its cost must be present
in the Campaign authorization. A failed canary or launcher-dispatch
qualification stops before candidate evidence is consumed.

### Evidence, Assessment, And Closeout

The evidence tranche consumes only the frozen cells and turn budgets named in
the Campaign. Each consumed cell is sealed automatically. A Harness-internal
reconnect inside one submitted turn is recorded separately from a controller-
initiated retry or second `turn/start`; neither changes the declared
consumption count by relabelling it.

A cell-local transport or visibility failure may leave later independent cells
eligible only when that continuation policy was declared in advance. Shared
candidate, controller, authorization, safety, workspace/input, or provenance
drift stops the Campaign. A required reference cell that remains absent blocks
acceptance even when independent cells continue.

A consumed infrastructure-blocked cell is never retried. A later run against
the same candidate may exist only as a separately authorized **additive
replication packet**: it receives a new frozen identity, preserves and cites the
blocked predecessor, consumes a new declared budget, and cannot overwrite,
replace, rescore, or relabel the predecessor. The replication may supply new
evidence for its own exact cells, but acceptance must still disclose every
applicable predecessor and may not claim that an infrastructure `UNKNOWN`
passed. Approving one replication is an evidence-treatment decision for that
stable subject, not a standing retry policy.

The authorized assessor runs automatically only after at least one product-
behavior cell is admitted and the required product packet is complete or
terminally sealed. A qualification-only or transport-canary-only stop records
zero assessor turns and skips assessment. Closeout may then synchronize mapped
canonical owners, run deterministic checks and native review, and perform an
explicitly listed commit. Push, candidate publication, installation, tag,
release, stable update, and cleanup remain separate effects unless the Campaign
declaration names them and their targets precisely.

### Convergence And Material Stops

Qualification corrections use a finite budget. Unless a Campaign declares a
smaller limit, at most three pre-consumption correction rounds may address the
same stable subject. Before each repeat, record the concrete uncertainty
removed or risk reduced. Repeating the same action against unchanged relevant
state is not progress.

Task, run-root, carrier, successor, epoch, and attempt labels are physical
locators, not new work subjects. They do not reset prior corrections,
authorizations, evidence consumption, review findings, or open decisions. A
candidate change creates a new evidence identity but does not erase the
predecessor ledger.

Automatic advancement stops for one user decision when any of these changes:

- product contract, candidate semantics, acceptance target, or hard boundary;
- permission, provider, network route, cost ceiling, workspace, or side effect;
- evidence replay, replacement, rescore, or treatment of a consumed event;
- correction, turn, assessor, or review budget beyond the approved ceiling;
- release, installation, public visibility, or cleanup disposition; or
- an ambiguity whose alternatives would materially change user-visible
  behavior, risk, reversibility, or evidence meaning.

The stop report must give one cumulative ledger for the stable subject, explain
why further work reduces a new risk rather than repeating an old attempt, and
ask one complete decision rather than a sequence of narrow approvals.

## Consequences

- Routine single-session work remains flat and needs no Campaign.
- Consequential evaluation can advance through a preapproved sequence without
  approval chatter while retaining explicit authority for material effects.
- Qualification failures no longer consume candidate behavior merely to test
  the carrier, and transport canaries do not become product evidence.
- Sealed outcomes remain immutable, including inconclusive and infrastructure-
  blocked outcomes.
- The repository gains no fourth public Skill, umbrella workflow, Plugin, MCP
  service, daemon, remote registry, or generic adapter framework.
- `$skill-creator` remains the authoring and package-validation baseline after
  capability-delta intake; it neither creates nor approves a Campaign.

## Re-evaluation Conditions

Revisit this decision if native Codex exposes a reliable first-class campaign
or evidence lifecycle, if three-round qualification budgets repeatedly stop
useful progress despite documented risk reduction, if Campaign declarations
become routine overhead for small tasks, or if repeated cross-repository use
demonstrates a justified deterministic residual beyond project procedure.

## Related Documents

- [Decision 0017](0017-capability-delta-skill-development.md)
- [Decision 0018](0018-work-charter-adoption-levels-and-reentry-checkpoint.md)
- [Development and release Runbook](../RUNBOOK.md)
- [Evaluation contract](../../evals/README.md)
