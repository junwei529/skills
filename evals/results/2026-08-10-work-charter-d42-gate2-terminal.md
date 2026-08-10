# Work Charter D42 Gate 2 Terminal Result

Date: 2026-08-10

## Scope

This report records the sanitized terminal result for exact Work Charter
candidate `f24bda745c1692385498d77602cca314ed6518d6`, whose five-file package
manifest is `a192540f53e57f0a70721e8220970e064fef7e9a82f7459c726834ea0b778fb1`.
It compares that candidate with released control `v0.1.2` at `ceed607...` in a
fresh 27-cell Gate 2 packet. It does not publish raw prompts or responses,
private paths, task or session identifiers, ignored carrier artifacts, or
reasoning traces.

D42 is additive to D31-D41. It does not retry, replace, rescore, or relabel any
predecessor, and it does not establish candidate acceptance, installation, or
release readiness.

## Qualification And Consumption

The fresh carrier passed whole-matrix authorization-policy schema and
cardinality preflight, including eight invalid-shape sentinels, before any
model turn. Offline construction, 27-workspace setup, all 77 catalog mappings,
deterministic controller and fixture checks, and exact outer-wrapper success/
failure tests also completed. Its combined 12-check zero-model qualifier
reported `PASS`, but post-consumption native review found that result invalid.

The qualifier's PowerShell subcheck invoked a `pwsh -Command` script that read
its root from `$args[0]`; that value was null. `Get-ChildItem` emitted a non-
terminating binding error, the script still printed its pass sentinel, and the
wrapper accepted exit zero without requiring empty stderr. The target
PowerShell files were therefore not parsed by that pre-consumption check. A
later direct parser run found all six carrier PowerShell files syntactically
valid, but post-hoc success cannot replace the required frozen pre-consumption
qualification.

Three one-shot non-product transport canaries passed for `Sol/high`,
`Sol/xhigh`, and `Terra/high`, with exactly three canary `turn/start` events and
no product or assessor credit. Freeze then bound 117 files with zero product
turns consumed. Those later steps should not have advanced past the invalid
qualification gate.

The product execution consumed six behavior turns. A01-A04 completed, A05
consumed its turn but hard-stopped, and the remaining 22 cells did not start.
The terminal sealed `SEALED_PARTIAL_HARD_STOP`. One independent `Terra/high`
assessor ran and returned `DECISION_REQUIRED`; no second assessor, retry, or
retrospective score was permitted.

## Bounded D42 Observation At A04

A04 loaded the exact candidate `SKILL.md` under controller observation. Its
indirect first response began `Work Charter appears applicable because ...`,
used no selection or activation heading, made no pre-confirmation selected,
loaded, invoked, active, adopted, or in-force claim, and performed no project
or Git read. The same-context confirmation path completed without a cell hard
failure.

This is a bounded post-consumption observation of D42's tightened visible
proposal when the exact body loads under the observed model and Harness. The
invalid qualification, incomplete packet, and missing independent whole-matrix
assessment prevent it from receiving Gate 2 credit or supporting broader
trigger claims.

## A05 Loaded-Copy Hard Stop

A05 returned the required neutral applicability opening, used no forbidden
selection or activation label, and performed no project, Git, non-command-tool,
or mutation action. It nevertheless prescribed Work Charter workflow before
activation confirmation: pause implementation, establish one writer,
revalidate scope/evidence, record durable handoff state, and gate resumption on
those steps. That exceeds the proposal-only surface, which permits explaining
applicability and proposing activation plus the smallest read but not applying
the workflow. This is a pre-activation product-surface mismatch under the
observed model and Harness; it does not isolate Skill text as the sole cause.

Independently, the controller did not observe a read of the candidate
`SKILL.md`. Exact loaded-copy identity remained unproved, and the cell failed
closed on its frozen requirement for controller-observed implicit package
loading. The current product contract says native implicit matching *may* load
`SKILL.md` before confirmation and requires the full body before user-visible
activation; the frozen A05 rubric instead required the body to load during the
proposal turn. Whether that proposal lane should allow metadata-only discovery
while reserving exact body-load proof for confirmed activation remains a
product/evaluation decision. Neither finding may be rescored inside D42.

## Disposition

- Exact candidate: `UNACCEPTED_AT_GATE_2`
- Pre-consumption qualification: `INVALID_AFTER_CONSUMPTION`
- D42 packet: `SEALED_PARTIAL_HARD_STOP`
- Completed cells: 4/27
- Behavior turns consumed: 6
- A04 tightened visible proposal with exact load: bounded observation only;
  no Gate 2 credit
- A05 pre-activation workflow application: observed mismatch; no Gate 2 credit
- A05 exact loaded-copy identity: `UNKNOWN`; frozen cell requirement failed
- Independent assessment: `DECISION_REQUIRED`
- Stable release and installation: unchanged at `v0.1.2`
- Retry, rescore, installation, tag, release, stable update, or cleanup:
  not authorized by this result

## Next Decision Boundary

Any successor must first repair and deterministically guard the PowerShell
qualification invocation. It must require successful exit, admissible stderr,
and positive coverage of the exact expected `.ps1`/`.psm1` set: fixed
cardinality, every expected path recorded as parsed, and no missing, extra, or
zero-file result.

The product owner must also decide the next SOURCE/evaluation correction. A05
shows that proposal-only wording must prevent applying pause/writer/evidence/
handoff workflow before activation. The owner must also choose between keeping
proposal-time exact body loading as a strict implicit-positive requirement, or
splitting metadata-only applicability proposal from confirmed activation and
requiring exact body-load proof only before activation or workflow reliance.
Any successor requires a new authorized plan. D42 itself remains immutable and
receives no replay or rescore.

## Documentation Impact Closure

- `UPDATE`: this report and result index; Work Charter State, Verification, and
  bilingual public evidence entry; root Status, Verification, Roadmap, Index,
  and Handoff.
- `CHECKED_NO_CHANGE`: repository `AGENTS.md`, root README pair,
  `docs/AUTHORITY.md`, `docs/SPEC.md`, `docs/ARCHITECTURE.md`,
  `docs/RUNBOOK.md`, `docs/PROVENANCE.md`, Decisions 0017/0018/0020, Work
  Charter Design, shared evaluation method, and neighboring Skill owners.
- `NOT_APPLICABLE`: Skill SOURCE, behavior cases, fixtures, tracked controller,
  discovery mappings, candidate materialization, installation, release, and
  external effects. The ignored raw carrier remains unpublished evidence.

## Verification Boundary

The unchanged Work Charter package validator passed. The tracked controller
passed 11/11 historical, 32/32 evidence-surface, 33/33 negative, and 4/4
metamorphic checks plus its structural guards. The repository checker passed at
202 text files / 14 cases / 12 fixtures; all 17 fixture checks passed; all eight
PowerShell files/modules parsed; `git diff --check` passed; and Gitleaks found
no secret in the exact 11 changed paths. The bounded temporary scan copy was
removed after verification.

A separate post-consumption parser diagnostic found all six ignored carrier
PowerShell files syntactically valid. It is diagnostic only and is explicitly
not admissible as the missing pre-consumption qualification.

Native Codex review is the final local-commit gate; its completed disposition
is retained in the cumulative attempt record rather than appended after review
to the bytes it reviewed. These checks validate only this sanitized report and
its mapped documentation consumers. They do not convert the incomplete D42
packet into behavior acceptance, reinterpret A05, or permit a fresh model turn.
