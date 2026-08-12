# Work Charter D52 Gate 2 Terminal Result

Date: 2026-08-12

## Scope

This report records the sanitized D52 result for exact Work Charter candidate
`c4810057c3f28cca9f12004ca2018784cd21f449`, five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`,
released `v0.1.2` control `ceed607152849775b981c54add74bfa30d858e4d`,
and Campaign `WC-AR-D52-TRACKED-OUTER-DISPATCH`.

D52 preserved D51-03 as `CANARY_ROUTE_INVALID / PRODUCT_UNKNOWN`. Its three
inner-only canary turns were not retried, replayed, rescored, or transferred.
The report excludes raw prompts and outputs, private paths, credentials, task
or session identifiers, and reasoning traces. It does not establish candidate
acceptance, installation, or release readiness.

## Tracked Outer Runner

Local commit `410b0bd1f361688e4444ced48e0e9451be1787d6` records the tracked
single-entry runner, deterministic checker, fixture consumer, and mapped
authorization documentation. The tracked runner checker passed 24/24 before
and after that commit, and the fixture consumer passed 18/18. The checker
covers the
outer positive path, typed child nonzero propagation, exactly-once successor
dispatch, committed runner and production-policy binding, exact argv and
byte-snapshot isolation, successful app-server completion correlation, direct-
inner rejection, and absent, stale, wrong-phase, wrong-hash, and reused
receipts. It consumes no model or assessor turn and supplies no Gate 2 product
credit.

## Private Qualification

One fresh ignored carrier was materialized from the D50 certified credential-
free source bundle, not from D51. Its finalized controller-bundle manifest and
bundle SHA-256 values are
`10499be1944f0dc2677d30a876e12d98d535f84da77d74886d4be7b1686da7b6`
and `24338f9dc765cde8e109c042de8c8954e22f52d7cefc9e48c82c39c84f3b2f0d`.
The bundle binding SHA-256 is
`08df913cabac9e8d020ba0a07fcc8288bc906c6e84aa8bfc398f256ff31e0e27`.

Both authorized private corrections were consumed before any scarce evidence.
`D52-P01` removed a generated Python cache created by an offline parse check.
`D52-P02` corrected rooted Windows Git command rendering so the overlay,
allowlist, binding, and executed command shared one path identity. The resulting
five rooted positives passed; five bare-name and five shadow-path variants
failed closed. Neither correction changed tracked code, SOURCE, candidate,
permissions, or the evidence budget.

The official zero-model qualification completed stages 1-6, including fixture
setup, recovery-state materialization, catalog mapping, and the three synthetic
launcher branches. Stage 7's full-lane first phase produced a zero-turn
dependency-closure manifest and synthetic receipt, but its deterministic gate
failed `model_authorization_envelope` with:

```text
frozen run policy does not require the post-freeze authorization gate
```

The full-lane launch result SHA-256 is
`5a44774cbbd4e121cd678bdaf588735a6b3a8df68843f67d79086743d3ff66ff`;
the gate diagnostic SHA-256 is
`247a3c4719ad41d810a7039ff0516ad2af5625c5382c42590aba8140649950bb`.
Private static qualification and the fresh tracked-runner stage did not start
inside the official sequence. The required aggregate D52 48/48 receipt was not
created. D51's immutable 24/24 receipt remains retained by hash but is not a
partial D52 pass or product credit.

## Disposition

- Exact candidate: `UNACCEPTED_AT_GATE_2`
- D52 Campaign: `QUALIFICATION_FAILED`
- Product disposition: `PRODUCT_UNKNOWN`
- Required aggregate qualification: not completed; no 48/48 receipt
- Private corrections: 2/2 consumed; no third correction
- Outer production phase receipts: 0
- Fresh model contexts: 0
- Canary, product, and assessor `turn/start`: 0 / 0 / 0
- Freeze, product cells, and assessor: `UNKNOWN_NOT_STARTED`
- Retry, operator recovery, replay, rescore, or automatic D53: not permitted
- Work Charter SOURCE, candidate, cases, fixtures, matrix, rubric, tracked
  evidence controller, stable release, and installation: unchanged

The terminal receipt SHA-256 is
`7c12bbdb8901b3ec825a8e671b43d21fa6c7b1a78761a7df4b824cb9397abd4d`.
The failure is a private-carrier qualification-contract mismatch. It is not a
Work Charter SOURCE or product-behavior finding, and the successful tracked
runner checks cannot compensate for the failed shared qualification gate.

## Next Decision Boundary

D52 is immutable at this terminal. The evaluation line stops unless the user
later authorizes one new complete successor Campaign. A new label, carrier, or
session cannot reset D51 or D52 history, restore either correction budget, or
transfer unused model turns. No D53, installation, release, cleanup, or other
external effect follows automatically.

## Documentation Impact Closure

- `UPDATE`: this report and result index; `evals/README.md`; Decision 0018;
  Work Charter State and Verification; root Status, Verification, Roadmap,
  Index, and Handoff.
- `CHECKED_NO_CHANGE`: repository `AGENTS.md`, root and Work Charter README
  pairs, Authority, SPEC, Architecture, Runbook, Provenance, Decisions
  0017/0020, Work Charter SOURCE/Design/cases/fixtures/
  matrix/rubric/controller/package references/assets, neighboring Skills, and
  the immutable D31-D51 evidence.
- `NOT_APPLICABLE`: SOURCE or candidate revision, new behavior case or fixture,
  discovery mapping, installation, push, PR, merge, tag, release, stable-copy
  change, cleanup, public publication, or automatic D53.
