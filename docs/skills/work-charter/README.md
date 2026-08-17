# Work Charter

[简体中文](README.zh-CN.md)

Keep consequential Codex work recoverable—without turning every task into a
workflow.

Work Charter recognizes complexity, continuity, authority, writer, evidence,
recovery, and collaboration signals. On an indirect applicability match, it
explains when additional protection appears useful and asks before activation;
after activation, it recommends the least sufficient coordination. Small,
ordinary tasks stay flat.

## What It Automates

These are advisory capabilities. Work Charter may recommend and stop its own
work, but it cannot lock writers, reroute other tasks, or enforce permissions.

- recognizes strong applicability signals and explains them in plain language;
- proposes the smallest read needed to choose a protection shape;
- keeps material outcome, authority, evidence, recovery, and coordination
  boundaries visible after activation;
- recommends the least sufficient protection and identifies material re-entry
  gates; and
- preserves `UNKNOWN` when identity, state, evidence, or authority cannot be
  verified.

## What You Own

You explicitly own activation, the first persistent adoption, project-read
scope, role delivery, writes, Git, installation, release, and external effects.
You also own any material change to the outcome, permissions, workspace,
writer, evidence standard, recovery route, or acceptance boundary.

Availability is not activation. A direct `$work-charter` invocation or an
ordinary-language request explicitly asking to use Work Charter requests
activation without a second confirmation, but activation may be claimed only
after the full Skill body loads.

An indirect symptom or catalog match remains proposal-only and requires
confirmation. Before confirmation, Work Charter only says why it appears
applicable, proposes activation plus the smallest useful read, and asks. It
does not inspect the project, claim activation or body/workflow use, or
prescribe pause, writer, evidence, handoff, resume, protection, or role
workflow.

## Protection Shapes

Work Charter uses internal `L0`–`L4` shorthand to keep decisions compact. These
labels are not a general maturity standard.

| Shape | User-visible use |
|---|---|
| Ordinary flat task (`L0`) | Complete a small bounded task without an active Charter. |
| Current-task Charter (`L1`) | Keep authority, evidence, and recovery visible in the current task without creating a durable owner. |
| Durable single-agent Charter (`L2`) | Use one agent plus a durable anchor when continuity must survive the current task. Prefer a suitable existing authoritative owner; create a new durable anchor only with explicit authority. |
| Planner/Executor (`L3`) | Inherit L2 durable recovery and add an independent Planner/assessor plus a sole-writer Executor for bounded consequential delivery. |
| Repository-defined Standard (`L4`) | Inherit L3 and add Orchestrator responsibility, an applicable approved standing policy, and multi-phase governance. |

Before any fresh L3 or L4 role applies Work Charter responsibilities, it loads
the full Skill plus the Coordination And Recovery guidance. A fresh L4 role
also loads Standard O/P/E before applying any L4 responsibility.

In the repository-defined Standard shape, the Orchestrator owns cross-phase
direction and Phase Mandates; the Planner owns phase definition, boundaries,
and independent acceptance; the Executor owns implementation, verification,
and evidence. This is repository-specific terminology, not an industry
standard.

## The Five-Part Charter

1. **Outcome** — the concrete result and acceptance boundary.
2. **Authority** — what may be read, changed, executed, or affected, and what
   still requires the user.
3. **Evidence** — the proof required for claims and the conditions that make it
   stale.
4. **Recovery** — the authoritative state, stop conditions, and safe next
   action after interruption or failure.
5. **Coordination** — only the roles, writer discipline, and handoff needed to
   protect the result.

## Authoritative Carrier And Workstream

A durable Charter has one authoritative carrier and one matching managed
workstream. A branch, task, label, or replacement carrier does not erase prior
attempts, consumed evidence, approvals, findings, or stops. Keep one active
execution lane and one repository writer. Do not treat the whole repository as
adopted when only one workstream is governed.

## Re-entry

Re-entry is required when a material outcome, authority, permission,
workspace, writer, evidence subject, recovery path, delivery route, or
acceptance boundary changes. Re-entry checks the current authoritative
revision and asks for the smallest missing decision; it does not silently
resume from stale chat or rename an old attempt into a new budget.

## Evidence And Assessment

Evidence must identify the actual subject and result surface. A test for one
revision, copy, route, role, or workspace does not prove another. Preserve
`UNKNOWN` for unavailable or conflicting facts.

Planner acceptance is not durable closeout by itself. When the project requires
recorded assessment, the authoritative owner must record it before the work is
treated as closed. A new material change invalidates only the evidence it
actually affects.

## Safety

- Protection never expands action authority.
- A proposal never implies activation.
- Skill loading never grants project-read or write authority.
- One failure, elapsed time, file count, or a new task is not enough by itself
  to require a Charter.
- Ordinary document governance and shell diagnosis stay with their own
  product routes.
- Stop on material contract, permission, workspace, writer, evidence,
  delivery, or recovery ambiguity.

## Install And Invoke

Choose an accepted immutable tag from the repository
[Verification](../../VERIFICATION.md) ledger:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/work-charter.

$work-charter Bound this consequential task, its authority, evidence, and recovery.
```

An ordinary-language request that explicitly names Work Charter is also direct
intent. Installation, invocation, activation, project reads, writes, Git, and
external effects remain separate.

## Verified Today

- Immutable release `v0.2.0` contains the exact five-file Work Charter tree
  `97f0d9de...` and canonical manifest `04c382a4...`.
- Exact-copy installation and loaded-copy evidence exists for the bounded
  release surfaces recorded in the [Verification ledger](VERIFICATION.md).
- Admitted synthetic evidence supports five narrow behaviors: proposal is not
  activation, small work stays flat, bounded adoption stays bounded, material
  re-entry asks again, and the repository-defined Standard shape requires an
  explicit policy.

## Not Yet Proven

Full comparative product validation, broad trigger accuracy, deterministic
role or writer enforcement, complete Standard delivery, real-project efficacy,
token savings, and cross-Harness parity are not proven. The WC-PV1 paired pilot
is `INCONCLUSIVE / PRODUCT_UNKNOWN` because all eight one-shot roots ended in
provider-stream transport failure before any admissible response; it supplies
no efficacy claim. See [State](STATE.md), [Verification](VERIFICATION.md), and
the [sanitized PV1 result](../../../evals/results/2026-08-17-work-charter-pv1-terminal.md).

## Design And Evidence

- [Design](DESIGN.md)
- [State](STATE.md)
- [Verification](VERIFICATION.md)
- [Repository evaluation policy](../../../evals/README.md)
