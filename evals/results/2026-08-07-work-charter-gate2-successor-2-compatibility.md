# Work Charter Gate 2 Successor-2 Compatibility Result

Date: 2026-08-07
Amended: 2026-08-08

## Scope

This report records a sanitized result for exact Work Charter candidate
`b965102ea58f9cc1ef3c73e8dea515731fec12a6` under tracked controller
`191cd1f841468d6585382a64aef8d81a9aff7550`. It preserves the sealed
execution and evaluates the controller/Harness boundary only. It does not
change Work Charter SOURCE, retry or rescore a consumed turn, or establish
candidate acceptance.

## Terminal result

The successor-2 carrier passed its offline qualification, freeze, and
prestart checks before consuming one authorized `Sol/high` A01 turn. The turn
completed and exposed an ordinary small-task behavior surface:

- Work Charter was neither read nor selected;
- the response stayed flat and identified the intended one-line correction;
- the response explicitly reported the read-only limitation; and
- the workspace, protected paths, and isolated system-Skill inventory remained
  unchanged.

The deterministic controller nevertheless returned `CONTROLLER_UNKNOWN`.
The carrier sealed `SEALED_PARTIAL_HARD_STOP`; no later matrix cell started.
A separately authorized `Terra/high` assessor consumed one turn and returned
`DECISION_REQUIRED` because the packet was incomplete and the controller did
not admit A01. The two turns reported 178,310 aggregate tokens, but this is an
observed usage total only, not cost, efficacy, or token-saving evidence.

This is the sixth sealed execution record for the unchanged logical subject.
It is non-retriable and does not replace the five earlier records.

## Compatibility diagnosis

The completed command records used a path-qualified PowerShell wrapper with
`-Command` but without `-NoProfile`. Their `commandActions` contained the inner
command as `type: unknown`. The controller therefore could not prove the outer
PowerShell startup boundary or reconcile the outer and inner command families.
One later Git read also failed and remained a failed diagnostic rather than a
completed effect.

This is a runner/Harness compatibility result, not a Work Charter SOURCE
defect. Current OpenAI Codex configuration documents
`allow_login_shell = false` as the control that rejects login-shell requests
and makes omitted shell requests non-login. The current official Codex shell
implementation adds `-NoProfile` for non-login PowerShell invocations. A future
isolated Gate 2 runner must therefore set that configuration explicitly and
must stop before scarce evidence consumption unless an isolated wrapper probe
observes the expected `-NoProfile` shape. The source reference was inspected at
OpenAI Codex `HEAD` `964a227d8cda5ea4b8cb091b571a7a15a4e22b2b` on the report
date; the next runner still has to prove its own pinned executable behavior.

The controller remains fail closed:

- N31 now asserts the full observed missing-profile consequence set;
- new N32 proves that a fully parsed failed Git-read shape remains
  `CONTROLLER_UNKNOWN`, while preserving read-only diagnostics and avoiding a
  false write or mutation label; paired N33 supplies a shadow Git identity and
  proves the same fail-closed diagnostic boundary. Failed records stop before
  identity admission, so neither case claims resolved-identity validation; and
- the public offline regression passes 33/33 negatives without changing any
  historical generated contract or sealed result.

## Disposition

- Work Charter candidate: `UNACCEPTED_AT_GATE_2`
- Sixth execution: `SEALED_PARTIAL_HARD_STOP / CONTROLLER_UNKNOWN`
- Independent assessment: `DECISION_REQUIRED`
- Work Charter SOURCE change: `NOT_APPLICABLE`
- Controller relaxation: `REJECTED`
- Runner correction for a future successor: `REQUIRED`
- New successor, model turn, candidate, installation, or release authority:
  `NOT_GRANTED_BY_THIS_RESULT`

## Documentation impact closure

- `UPDATE`: the controller case/checker pair and fixture aggregator;
  `evals/README.md`; this report and the result index; the live-evaluation
  procedure in `docs/RUNBOOK.md`; Work Charter State and Verification; and the
  root Status, Roadmap, Verification, and Handoff consumers.
- `CHECKED_NO_CHANGE`: repository `AGENTS.md`, root README pair,
  `docs/INDEX.md`, `docs/AUTHORITY.md`, `docs/SPEC.md`,
  `docs/ARCHITECTURE.md`, `docs/PROVENANCE.md`, Decision 0017, Decision 0018,
  and Work Charter Design. Their routing, product, authority, provenance, and
  capability-delta contracts do not change.
- `NOT_APPLICABLE`: every Skill SOURCE file, eval behavior case and fixture,
  package README, candidate/install/release evidence, and other per-Skill
  owners. No public product contract or package byte changes.

## Verification

- PowerShell parse check: 8/8 tracked evaluation scripts/modules parsed.
- Controller regression: 11/11 historical, 19/19 evidence-surface, 33/33
  negative, 4/4 metamorphic, 8/8 command-resolution, 6/6 content/proof, 3/3
  external-type, 9/9 Git-safety, and 1/1 no-clobber checks passed; canonical
  repeat matched and no external model or assessor call ran.
- Fixture aggregation: all 17 checks passed after updating its negative-case
  expectation to the current 33-case set.
- Repository check: 199 text files, 14 cases, and 12 fixtures passed.
- Work Charter package validator: passed with no SOURCE change.
- Git whitespace check: passed.
- Publication-safety scan: Gitleaks found no secret in the exact 13 changed
  paths; the task-owned temporary scan copy was removed after the scan.
- CRG structural preflight: degraded and not relied on. The existing index was
  built at `763a15e...`, did not match current `HEAD` `776989f...`, and mapped
  zero changed symbols or flows even though it received all 13 paths. Native
  review and the deterministic checks remain the acceptance evidence.
- Native review: an initial prompt-bearing `--uncommitted` invocation was
  rejected by CLI selector validation before producing a semantic result and
  did not count. Review 1/5 then ran the supported `--uncommitted` selector with
  `gpt-5.6-terra/high`, materially inspected the 12 tracked modifications and
  included untracked report, independently reran the controller, fixture,
  repository, and whitespace checks, and returned no actionable finding. The
  Review 2/5 found two P2 accuracy gaps: N32 did not prove the documented
  identity admission, and the recovery owner called the 12-tracked plus one-
  untracked scope a tracked 13-path diff. The same-scope correction narrows the
  claim, adds shadow-identity N33, and records the exact scope split. One final
  review found that N33 excluded only one possible identity error; the case now
  rejects every resolved-command or resolved-wrapper identity unknown and thus
  directly protects the documented pre-admission boundary. One final review
  over the resulting bytes remains required; its result is retained in the
  session-level cumulative attempt record to avoid a post-review metadata
  mutation.

Official references:

- [Codex configuration reference](https://learn.chatgpt.com/docs/config-file/config-reference)
- [OpenAI Codex PowerShell shell construction](https://github.com/openai/codex/blob/964a227d8cda5ea4b8cb091b571a7a15a4e22b2b/codex-rs/core/src/shell.rs)

## 2026-08-08 Successors 3-7 And D29 Disposition

The later sequence preserved the same logical candidate and never retried or
rescored a consumed event. Successors 3 and 5 stopped during zero-turn
qualification, so they are retained qualification records rather than behavior
executions. Successor-4 became the seventh sealed behavior execution after its
single A01 turn ended without an admissible completed command surface.
Successor-6 became the eighth after one A01 turn retained mixed or missing
auxiliary attribution as `CONTROLLER_UNKNOWN`.

Successor-7 became the ninth sealed behavior execution. Its one A01 turn read
`src/range_utils.py` and `tests/test_range_utils.py`, kept Work Charter
unloaded, proposed `return end - start + 1`, named the focused unittest command
as future work, and performed no write, test, or Git mutation. The controller's
only violation was `auxiliary_read_path_not_authorized`: the runner used
separate nonrecursive inventory observations for the workspace root, `src`,
and `tests`, while the D27 policy admitted only the root. The semantic content
was correct, but the sealed controller result remains a violation and provides
no candidate acceptance.

D29 classifies that mismatch as a prospective evaluation-contract defect. It
permits only the exact root, `src`, and `tests` auxiliary paths for A01, A06,
A17, B02, and C02, with at most one command and unchanged inventory link per
observed path. The observation and inventory link must use the allowlist's
exact ordinal root/path spelling, and every inventory row must remain inside the
linked path; dot segments and redundant separators fail closed before
normalization, and unused allowlist entries remain optional. It changes no Skill SOURCE and
no prior result. Case aliases fail closed conservatively, and an observed path
receives credit only when its components are reparse-free.
After the exact D29 controller commit is
integrated, the separately authorized successor-8 must append all nine behavior
records and both qualification records, consume A01 once, advance through the
remaining matrix only after both A01 gates pass, and finish with one independent
assessor. Every terminal failure still seals without retry.
