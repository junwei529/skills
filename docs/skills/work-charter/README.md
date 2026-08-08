# Work Charter

[简体中文](README.zh-CN.md)

Work Charter bounds consequential Codex work with an explicit outcome,
authority, evidence, recovery route, and only the coordination needed to
protect the result.

## Use It When

- continuity, authorization, recovery, writer ownership, or independent
  assessment makes flat execution unreliable;
- consequential work needs a current-task or durable Charter;
- Planner/Executor separation would materially protect implementation; or
- an approved standing policy and active Charter support Standard
  Orchestrator/Planner/Executor.

## Do Not Use It When

- work is a small bounded single-session task;
- the only signal is a new task, one failure, elapsed time, or file count;
- the task is ordinary document governance or shell diagnosis; or
- another Harness would need an unverified Codex emulation.

## Install Independently

Choose an accepted immutable repository tag from the live repository refs and
the repository [Verification](../../VERIFICATION.md) ledger, then substitute
it for `<version-tag>`:

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/work-charter.
```

Work Charter does not require Project Docs. It can consume a reliable existing
project route without installing or invoking another Skill. Do not use the
moving `main` branch as a stable identity.

## Invoke

```text
$work-charter Bound this consequential task, its authority, evidence,
recovery, and least sufficient coordination.
```

You do not need to know the exact syntax. For example:

```text
Use Work Charter to decide how this project should continue.
Based on the Skills already installed, recommend the safest way to continue this work.
```

An ordinary-language request that explicitly names Work Charter is direct
activation intent without requiring the `$work-charter` syntax. Codex loads the
full Skill and claims activation only after the body is available in the current
context; otherwise it reports degraded loading and stops without an activation
claim. If the runtime does not expose the exact loaded path or revision, that
identity remains `UNKNOWN` and Codex makes no exact-copy claim; this alone does
not block ordinary activation. A generic installed-Skills request or
symptom-only match first receives a metadata-level proposal (a lightweight
catalog match): Work Charter appears applicable, why it may help, the smallest
proposed project read, and a question asking whether to activate it. That
proposal must not claim the Skill is selected, loaded, invoked, or active.
After the user confirms, the same load-or-stop boundary applies, and only the
separately approved project scope may be inspected. If an approved read cannot complete
through the approved route, the affected fact remains `UNKNOWN`; any different
route is a new visible proposal, not permission to inspect adjacent paths or
metadata.
Initial persistent adoption, the first Standard policy, role delivery, writes,
Git, and external effects remain separately authorized.

It recommends the least sufficient shape in ordinary language: an ordinary
flat task (`L0`, no active Charter), a current-task Charter (`L1`), a durable
single-agent Charter (`L2`), Planner/Executor separation (`L3`), or Standard
O/P/E (`L4`). These codes are internal shorthand; the user chooses after the
benefit and coordination cost are explained.

## Safety Boundaries

Protection choice never expands action authority. Durable work uses one
authoritative carrier and matches one managed workstream rather than treating
the whole repository as adopted. Keep one active execution lane,
one repository writer, and at most one Planner and one Executor for the active
Charter. Stop on material contract, permission, workspace, writer, evidence,
delivery, or recovery ambiguity.

For cross-session continuation, verify the authoritative revision of material
decisions and any required durable assessment recording. Evidence must cover
the actual result surface and becomes stale when its bound subject materially
changes.

## Verified Capability And Limits

The recorded M2R SOURCE behavior, controlled development P/E and Standard
delivery, exact-commit RC recovery canary, and tag-pinned `v0.1.1` Flat smoke
passed for their exact historical revisions. The repository-level
[`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2) stable copy
has exact loaded-copy identity, a flat non-loading canary, and a narrow
fail-closed recovery/assessment-order canary; its exact pre-release control also
passed one bounded synthetic Standard Phase One. The `v0.2.0` line has no
accepted candidate: `206c497...` stopped on convergence, and successor
`92a8c045...` stopped at A04 after a safe indirect proposal claimed selection
without loading the Skill. Exact `72db7e9...` implements two-stage entry, but
its fixed-turn Standard probe sealed `VIOLATION` and did not run A16. The
conditional-role-read correction stops when the full Skill body is unavailable,
preserves unexposed exact identity as `UNKNOWN`, requires
every fresh `L3`/`L4` role to load the full Skill and coordination reference,
and requires `L4` to load the Standard reference before applying its
responsibilities. Exact candidate `b965102...` remains unaccepted. Ten Gate 2
behavior execution windows and two zero-turn qualification records are sealed
and non-retriable. Successor-8 completed nine of 27 cells before A10 hard-
stopped; A04 exposed a metadata-only selected-state claim, while A10 broadened
an approved read after Git access failed. The latter also exposed runner
ownership noise, which is not a product finding. Its independent assessor
returned `DECISION_REQUIRED`. Current SOURCE now narrows metadata wording and
adds an unavailable-read stop, but it has no exact committed candidate or new
behavior evidence yet.
Full staged selection, entry, level, re-entry, and visible
Standard behavior, full Standard delivery at the stable layer, broad implicit
telemetry, independent real-project efficacy, deterministic role delivery or
writer locks, and cross-Harness parity remain unproved. See
[Verification](VERIFICATION.md) and [State](STATE.md).

## Authoritative Contract

This page is a human entry point. The repository
[product contract](../../SPEC.md), [Work Charter design](DESIGN.md), accepted
decisions, and canonical
[`SKILL.md`](../../../skills/work-charter/SKILL.md) own behavior.
