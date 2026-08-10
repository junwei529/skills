# Work Charter D43 Transport-Canary Terminal Result

Date: 2026-08-10

## Scope

This report records the sanitized terminal result for exact Work Charter
candidate `c4810057c3f28cca9f12004ca2018784cd21f449`, whose five-file package
manifest is `04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`.
It preserves immutable D31-D42 and tests only whether the fresh D43 carrier can
qualify its exact inputs and reach three non-product transport canaries before
any 27-cell product or assessor turn.

The report does not publish raw prompts or responses, private paths, task or
session identifiers, ignored carrier artifacts, credentials, or reasoning
traces. It does not establish candidate acceptance, installation, or release
readiness.

## Zero-Model Qualification

The fresh ignored carrier bound the exact D43 candidate, released `v0.1.2`
control, current content-only manifest, and immutable D42 predecessor
artifacts. It created 27 isolated workspaces, proved all 77 catalog mappings,
and passed exact outer-launch success, first-failure, and gate-failure routes.

Its combined zero-model qualifier passed 12/12 checks before any model turn.
The corrected PowerShell gate observed exactly the six expected `.ps1` and
`.psm1` paths, emitted one positive parse receipt per path, proved expected,
actual, and unique cardinality six, reported no missing or extra path, captured
empty standard error, and returned exit zero. This is admissible
qualification evidence for the D43 carrier. It is not product-behavior
evidence.

## Transport-Canary Stop

The first required non-product route, `Sol/high`, consumed one `thread/start`
and one `turn/start`. The app-server process started successfully, but the turn
ended with terminal status `failed` and no final model message. The preserved
transport diagnostics show that WebSocket access was denied by the host with
Windows socket error `10013`; the subsequent HTTP fallback also could not
connect. The route returned failure, and the outer launcher stopped the batch.

This is classified as `SANDBOX_NETWORK_TRANSPORT`, not as a Work Charter
product defect or a controller-contract failure. Harness-internal connection
retries occurred inside the consumed turn, but the D43 controller performed no
retry and the Campaign does not permit replay. The `Sol/xhigh` and `Terra/high`
canaries did not start.

No product turn, Skill-selection observation, candidate-body load proof,
27-cell freeze, semantic score, or assessor turn occurred. Candidate and
tracked repository state remained unchanged.

## Disposition

- Exact candidate: `UNACCEPTED_AT_GATE_2`
- Zero-model qualification: `PASS`
- D43 Campaign: `SEALED_HARD_STOP`
- Failure origin: `SANDBOX_NETWORK_TRANSPORT`
- Canary turns consumed: 1
- Required canaries completed: 0/3
- Product cells completed: 0/27
- Product turns consumed: 0
- Product semantics: `UNKNOWN_NOT_ASSESSED`
- Assessor turns consumed: 0
- Retry or rescore: not permitted
- Stable release and installation: unchanged at `v0.1.2`
- Push, installation, tag, release, stable update, retained-evidence cleanup,
  or external publication: not authorized by this result

## Consequence

Because all three transport canaries were prerequisites, the 27-cell packet
and assessor are ineligible to start in D43. The candidate contract therefore
has SOURCE and deterministic qualification evidence but no fresh selected-
behavior evidence. D43 supplies no pass, failure, or causal attribution for the
metadata-sufficient proposal or confirmed exact-body activation behavior.

Any future behavior packet must be a separately authorized additive successor.
It must preserve D43 and its consumed canary turn, revalidate the then-current
model, Harness, executable, permissions, catalog, candidate, and carrier, and
must not call itself a D43 retry or transfer qualification across a materially
changed route.

## Documentation Impact Closure

- `UPDATE`: this report and result index; Work Charter bilingual public entry,
  State, and Verification; root Status, Verification, Roadmap, Index, and
  Handoff.
- `CHECKED_NO_CHANGE`: repository `AGENTS.md`, root README pair,
  `docs/AUTHORITY.md`, `docs/SPEC.md`, `docs/ARCHITECTURE.md`,
  `docs/RUNBOOK.md`, `docs/PROVENANCE.md`, Decisions 0017/0018/0020, Work
  Charter SOURCE, Design, cases, fixtures, shared evaluation method,
  current-SOURCE manifest, tracked controller, and package references/assets.
- `NOT_APPLICABLE`: another product candidate, tracked controller or fixture
  expansion, discovery mappings, candidate materialization, installation, tag,
  release, stable update, cleanup, or external effects. The ignored raw carrier
  remains unpublished evidence.

## Verification Boundary

The unchanged Work Charter package validator passes. The repository checker
passes at 203 text files / 14 cases / 12 fixtures; the tracked controller passes
11/11 historical, 32/32 evidence-surface, 33/33 negative, and 4/4 metamorphic
checks plus its structural guards; all 17 fixture checks pass; all eight tracked
PowerShell files/modules parse; `git diff --check` passes; and Gitleaks finds no
secret in the exact 11 changed paths. The bounded temporary scan copy was
removed after verification.

Native Codex review is the final local-commit gate; its completed disposition
is retained in the cumulative attempt record rather than appended after review
to the bytes it reviewed. These checks validate this sanitized record and its
mapped documentation consumers only. They do not convert the transport blocker
into product evidence or authorize another model turn.
