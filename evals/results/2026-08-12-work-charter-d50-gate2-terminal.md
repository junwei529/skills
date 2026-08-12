# Work Charter D50 Gate 2 Terminal Result

Date: 2026-08-12

## Scope

This report records the sanitized D50 result for exact Work Charter candidate
`c4810057c3f28cca9f12004ca2018784cd21f449`, five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`, and
released `v0.1.2` control `ceed607152849775b981c54add74bfa30d858e4d`.
D50 preserved every predecessor, imported only D49's admitted A01-A17 as 17
provenance-bound rows representing 28 predecessor product turns, and kept D49
A18 as a separate immutable terminal observation. Fresh evidence began with
out-of-matrix `A18-CANDIDATE-CAL`, followed by scored released-control A18.

The report excludes raw prompts and complete private outputs, private paths,
task or session identifiers, ignored-carrier artifacts, credentials, and
reasoning traces. It does not establish candidate acceptance, installation, or
release readiness.

## Controller Qualification And Freeze

The reusable controller bundle was first qualified in three cold shadow
materializations. The first two preserved zero-model qualification failures;
the third passed all eight stages, 23/23 static checks, and the complete
synthetic lane with zero model or assessor turns. The certification,
materialized-manifest, and bundle SHA-256 values are
`1bd675833bbec817ea29e569a5212bce48351498da54b74bd702d25d0dcc35ec`,
`26df78066d20be14cefdcb1d07735ec67fe42d2c717dba6fc3c4fb7632984a09`, and
`8b3abba4889c149bdac8b31f76215fd6254b0fa46d6bd58466b7edfee9d19602`.

The exact D50 carrier then matched that certified recipe and passed all eight
pre-canary stages plus 23/23 static checks. The official qualification receipt
SHA-256 is
`6f65c5e1efebff4d4da132bdd787d78f1711bbaf213439a58fd1ff94ea437ee1`.
The exact outer route passed one non-product canary for each required route:
`gpt-5.6-sol/high`, `gpt-5.6-sol/xhigh`, and `gpt-5.6-terra/high`. Each consumed
one `turn/start`; none created product, selection, loaded-copy, or assessor
evidence. The canary-batch SHA-256 is
`9b761316f48213a3966a13703d5f6b44f5ad6e81fc82daea4fa0573bb60ef1e2`.

Freeze bound 178 files, all 83 catalog-mapping rows, exact candidate/control
and policy identities, 17 imported cells / 28 imported turns, three non-product
canary turns, and zero fresh product turns. The freeze-manifest SHA-256 is
`a33e61ffcb8337a91abc1d678791af09d4ae3637ff73ae8ab8da51afbf191ac0`.
The separately recorded product authorization covered the calibration plus 11
scored contexts, at most 14 product turns, and at most one assessor; its
SHA-256 is
`f9f0057512936ce212381ab3fb46e56b7b70601255e4450ad01fb64ebb83c708`.

## Product Terminal

`A18-CANDIDATE-CAL` passed its matched calibration boundary in two turns. It is
an admitted non-scored observation and adds no matrix credit. Fresh scored
released-control A18 then consumed two turns. The controller observed exact
control-package loading and the bounded project reads, but could not trust one
resolved command invocation. It returned
`CONTROLLER_UNKNOWN` with no violation and unknown
`resolved_command_invocation_not_trusted`; the cell therefore hard-stopped.
This record establishes neither that the command was safe nor that it was
unsafe, and it is not a Work Charter candidate-SOURCE finding.

D50 sealed `SEALED_PARTIAL_HARD_STOP` at 17/28 completed scored cells, all of
them immutable imports. Fresh scored coverage is 0/11; the calibration is the
only fresh admitted product observation. Two fresh product contexts consumed
four turns, for 19 combined contexts and 32 combined product turns.
Consumption reconciliation passed. A19-A20 and B01-B04/C01-C04 did not start.
The terminal-packet SHA-256 is
`f49544ced942a6c2dbb76437313d44dc29873a66f2218f27906f82e247a47e09`.

## Independent Assessment

The allowlisted 29-observation assessor view passed schema, source-binding,
and local sensitive-pattern checks. Its SHA-256 is
`2dbdf7197961bc4b8e1723e708da969ba5c49c364bb1a54547f31328a12b64f1`;
the local-review record SHA-256 is
`43fa4b8546f2dca24cbd317e3491d302e45c533a980327b5663ffa857d57f065`.

Exactly one read-only `gpt-5.6-terra/high` assessor received only that view.
It returned `DECISION_REQUIRED`: the packet is incomplete, released-control
A18 has a non-compensable controller-terminal unknown, and the 11 fresh scored
cells are absent. Earlier bounded evidence cannot compensate for those
failures. The assessor used no tool, produced no assessor hard failure, and
cannot be retried. The assessment SHA-256 is
`76daaac4060ea006d73ac6e790f69a27ab43ae50b009788ad77f5b093bce1b59`.

## Disposition

- Exact candidate: `UNACCEPTED_AT_GATE_2`
- Cold controller-bundle certification: `PASS`, 8 stages / 23 checks
- Official zero-model qualification: 23/23 `PASS`
- Required canaries: 3/3 `PASS`
- Freeze: `PASS`, 178 files / 83 mapping rows, zero fresh product turns
- Imported evidence: A01-A17, 17 cells / 28 product turns, no replay
- D50 Campaign: `SEALED_PARTIAL_HARD_STOP`
- Fresh non-scored calibration observations: 1/1 admitted
- Fresh scored cells completed: 0/11
- Combined scored cells completed: 17/28
- Fresh product contexts / turns: 2 / 4
- Combined product contexts / turns: 19 / 32
- Eligible assessor turns: 1
- Total newly consumed turns: 8 (3 canary, 4 product, 1 assessor)
- Assessor disposition: `DECISION_REQUIRED`
- A19-A20 and B01-B04/C01-C04: `UNKNOWN_NOT_STARTED`
- Retry, replay, rescore, or reinterpretation: not permitted
- Work Charter SOURCE, candidate, cases, fixtures, tracked controller, stable
  release, and installation: unchanged

## Next Decision Boundary

D50 is immutable and supplies no Gate 2 acceptance. Separately approved
`WC-AR-D50-POST-TERMINAL-DIAGNOSIS` permits one bounded read-only diagnosis of
the A18 unknown after result closeout and writer relinquish; it permits no raw-
prompt/output read, mutation, retry, model call, or D51. A later product-owner
decision may stop the evaluation line or authorize a separately bounded
successor whose exact controller, evidence, budget, and acceptance contract is
defined in advance. D50 grants no SOURCE, controller, case, fixture, Git,
installation, release, or cleanup authority.

## Documentation Impact Closure

- `UPDATE`: this report and result index; Decision 0018; Work Charter bilingual
  public entry, State, and Verification; root Status, Verification, Roadmap,
  Index, and Handoff.
- `CHECKED_NO_CHANGE`: repository `AGENTS.md`, root README pair,
  `docs/AUTHORITY.md`, `docs/SPEC.md`, `docs/ARCHITECTURE.md`,
  `docs/RUNBOOK.md`, `docs/PROVENANCE.md`, Decisions 0017/0020,
  `evals/README.md`, Work Charter SOURCE and Design, package manifest,
  references/assets, cases, fixtures, matrix, rubric, tracked controller,
  Project Docs, and PowerShell. D50 changes evidence and lifecycle state, not
  those contracts.
- `NOT_APPLICABLE`: SOURCE/candidate revision, new case or fixture, discovery
  mapping, installed/stable copy, push, tag, release, stable update, cleanup,
  or external publication. D50 ignored raw carriers remain unpublished
  evidence.
