# Repository Status

Last updated: 2026-08-09

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Tested package identity | all three package byte sets independently reached exact-commit RC readiness at `c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` and were re-proved at tag/stable identity `v0.1.2` | [Verification](VERIFICATION.md) |
| Stable release identity | immutable [`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2) at `ceed607152849775b981c54add74bfa30d858e4d`; exact tag, stable loaded-copy, and GitHub Release proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Project Docs | immutable `v0.1.2` remains the released explicit-only control; local commit `776989f...` implements accepted Decision 0019 but is unreleased, and its evidence is `PARTIAL` because actual candidate selection, loaded-copy identity, and persistent writes remain `UNKNOWN` | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | released `v0.1.2` remains active; prior target `b965102...` is unaccepted with ten behavior windows and two zero-turn qualification records sealed; successor-8 stopped after 9/27 cells, and exact local D30 product candidate `53d424c...` now hardens metadata-state and unavailable-read boundaries without fresh behavior evidence | [State](skills/work-charter/STATE.md) |
| PowerShell | released five-file `v0.1.2` stable copy; corrected loaded identity and guarded native/text diagnosis pass; live WSL remains unproved | [State](skills/use-powershell-safely/STATE.md) |
| Release lifecycle | `v0.1.2` tag, stable update, tag-pinned canaries, and Latest GitHub Release complete; `v0.1.1` retained as rollback identity | [Runbook](RUNBOOK.md) |

## Current Repository State

Exact package behavior was tested at public commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`; its sanitized evidence was later
committed and pushed in descendant
`801139eb36c99c393011e2328b839165e8a216a5`. Release-preparation commit
`ceed607152849775b981c54add74bfa30d858e4d` preserved all 6/5/5 package blobs,
passed its own exact public installer and loaded-copy gate, and is now the
immutable `v0.1.2` tag, verified stable installation, and Latest GitHub
Release. Immutable `v0.1.1` remains retained as rollback identity.

Local `main` contains an unreleased Project Docs revision at `776989f...`
implementing [Decision 0019](decisions/0019-project-docs-implicit-discovery-and-demand-driven-modules.md).
Its implicit path is read-only and proposal-only, persistent writes remain
separately authorized, and ordinary maintenance stays with valid project
routing. A static SOURCE/eval-contract assessor found no Must defect, but the
overall evidence is `PARTIAL`: actual candidate selection, physical loaded-copy
identity, and write persistence remain `UNKNOWN`; immutable `v0.1.2` is
unchanged.

Target Work Charter `v0.2.0` remains at Gate 2. Exact candidate `b965102...`
is unaccepted; ten behavior windows are sealed and non-retriable, and two zero-
turn stops remain qualification records. Integrated D29 controller
`8f00a557...` enabled successor-8 to complete A01-A09 before A10 hard-stopped
the 27-cell window. A04 claimed selected state while only metadata was
available. A10 loaded the exact candidate and authorized documents but, after a
Git route failed, inspected adjacent root and hidden metadata outside the
approved scope; its different-OS-owner Git failure is runner qualification
noise, not a product finding. The independent assessor returned
`DECISION_REQUIRED`.

Exact local D30 product candidate `53d424c...` changes only Work Charter
`SKILL.md` inside the five-file package: indirect metadata may say only
"appears applicable" and cannot claim selected, loaded, invoked, or active; an
unavailable approved read preserves `UNKNOWN` and stops without adjacent
inspection. Existing selection/entry cases and the fixture precondition carry
the prospective checks. This candidate is not `b965102...` and has no fresh
model/assessor, installation, or release evidence. Exact history and residual
limits belong to the
[Work Charter State](skills/work-charter/STATE.md) and
[Verification](skills/work-charter/VERIFICATION.md) ledgers.

The exact post-commit documentation scope, writer state, and recovery order are
owned by [Repository Handoff](HANDOFF.md).

## Current Verification Boundary

All three current candidates were installed from exact public `c42eef3...`,
matched their 6/5/5 Git blobs, passed strict UTF-8/no-BOM and non-reparse checks,
and proved the actually loaded candidate copy while keeping stable `v0.1.1`
unchanged. The later exact tag `v0.1.2` repeated 6/5/5 Git-blob and installed
identity, preserved `v0.1.1` as rollback, and ran fresh stable loaded-copy
canaries through isolated repository-scoped discovery plus a shared non-loading
negative.
Project Docs has a bounded fail-closed matrix, PowerShell has corrected
positive/negative boundary evidence, and Work Charter has a complete bounded
synthetic Standard Phase One. Counted and excluded attempts and all residual
limits remain in the per-Skill ledgers and sanitized result files.

The current Project Docs revision has SOURCE-assisted routing, outcome, and
no-write observations only; actual candidate selection, loaded-copy attribution,
and write-capable persistence remain `UNKNOWN`, so its overall evidence is
`PARTIAL`. Work Charter target `v0.2.0` likewise remains unaccepted at
Gate 2; its ten sealed behavior windows, two qualification records, and
controller regressions do not establish product behavior acceptance. The
exact D30 candidate `53d424c...` has offline definition and commit evidence only
until separately authorized materialization and a fresh behavior window exist.
Exact counts, hashes, exclusions, and residual limits remain in the per-Skill
ledgers rather than this dashboard.

Per-Skill evidence and gaps:

- [Project Docs Verification](skills/manage-project-docs/VERIFICATION.md)
- [Work Charter Verification](skills/work-charter/VERIFICATION.md)
- [PowerShell Verification](skills/use-powershell-safely/VERIFICATION.md)

## Historical Controller Pre-Commit Record

The detailed controller review and correction history below predates the
current documentation-integration window. Its canonical evidence is the
[Repository Verification](VERIFICATION.md) ledger; this section is retained
unchanged as historical source pending a separately scoped dashboard cleanup.

Before local commit `119aa27...`, one scoped writer owned the twelve-path
controller-stabilization diff on `codex/work-charter-v0.2`; its tracked status
was `IMPLEMENTED_UNCOMMITTED`. Completed native semantic reviews 1 through 3
produced the earlier cumulative infrastructure findings. Review 4
then found unsafe Boolean coercion and throwing nested-turn count conversions;
both are fixed in the existing controller/checker paths and covered by 2/2
external-input type guards. Review 5 then found blank/malformed candidate
identities and null-filled empty violation output; those are fixed and covered
by 3/3 identity-shape plus 1/1 output-shape guards. The user reset the completed
review budget for this same commit attempt. Reset-cycle review 1 found that
`git status` could refresh the index and pager-capable Git reads could launch an
external pager despite being classified as read-only. Both P1 findings are
fixed by mandatory global safety flags and covered by 3/3 focused guards; the
two affected historical generated contracts and bindings were re-hashed
without changing their verdicts. Reset-cycle review 2 then found malformed
allowed-file and read-proof identities could be admitted or throw; both sides
now receive strict length/SHA-256 validation, with 3/3 focused guards. Reset-
cycle review 3's findings are also fixed: contradictory duplicate policy or
proof keys no longer overwrite each other, and string exit codes cannot prove
success. Three record-cardinality/exit guards pass. Reset-cycle review 4 then
found that `git cat-file --filters` could invoke configured content filters;
the classifier now rejects both filter option forms, formal negative N16 passes,
and the fail-closed aggregate is 16/16. Reset-cycle review 5 then found that an
admitted `git status` could still invoke a configured `core.fsmonitor` hook.
The classifier now requires an exact command-local disable, the two affected
historical generated contracts and bindings are re-hashed again without verdict
changes, and 4/4 Git-read safety guards pass. The reset cycle is exhausted; the
fix changed the reviewed bytes, so any further native review requires another
explicit budget reset. The user approved that second reset. Its review 1/5
found that `git remote -v set-url ...` could be misclassified as a read; exact-
shape remote listing now fails closed on extra subcommands, 5/5 Git-read safety
guards pass. Review 2/5 then found missing manifest-before-reconciliation
ordering and unproved command resolution. N17 now enforces the full construction
order; completed commands require a policy-pinned resolved identity, with 3/3
focused guards. All 11 historical generated contracts/bindings were re-bound
without verdict changes and 17/17 negatives pass. Review 3/5 then found exact-
shape gaps in branch reads and configured signature display, unsafe string
coercion for `assessor_requested`, and incomplete terminal failure diagnostics.
Exact branch shapes, command-local signature-display disablement, strict Boolean
typing, empty-family fail-closed handling, and complete aggregate diagnostics
are now covered by 7/7 Git-read safety, 3/3 external-input type, and 3/3 command-
resolution guards. The canonical hash remains stable; the terminal JSON hash is
`9e94d7b0313be99b275dbefd1c6a4cea43d2314a746daf23b7e0fb34502a69b1`.
Review 4/5 then found unsafe PowerShell wrapper modes and repeat/post-seal
construction events. Wrapper parsing now uses a strict inert-switch plus final
constant-command shape, and construction requires exactly one ordered stage
sequence. N18-N20 raise the passing negative aggregate to 20/20; historical
verdicts and sealed inputs remain unchanged. The current canonical and terminal
hashes are `7a1d2727...590d3` and `7d0c6d76...d8934`. One review remains in
the current cycle. Review 5/5 then found malformed allowed-file row crashes and
matching-invalid inventory admission. Defensive allowed/proof row extraction
and strict inventory path/length/hash validation now pass 6/6 focused guards;
the canonical hash remains `7a1d2727...590d3` and the terminal hash is
`81250a27...844a`. The second reset cycle is exhausted, and the corrected bytes
required another explicit review-budget reset. The user approved a third reset;
its review 1/5 found that unclassified PowerShell/.NET expressions could run
beside an allowed command without entering the effect set. Command and member
expressions/invocations now fail closed, N21 raises the passing negative
aggregate to 21/21, and the canonical/terminal hashes are
`a056c1cd...5536` / `ebfc6acd...d680`. Review 2/5 then found wrapper outer
redirection was discarded during inner-command extraction. Outer redirections
now fail closed, N22 raises the passing negative aggregate to 22/22, and the
canonical/terminal hashes are `8d25dcee...0152` / `af40309f...b1d9`. Review
3/5 then found that diff-capable Git reads could invoke configured textconv and
that canonical key ordering depended on the current culture. `log`, `show`, and
`diff` now require `--no-textconv`; N23 raises the passing negative aggregate
to 23/23, Git-read safety passes 8/8, and a three-culture ordinal-order guard
passes 1/1. The canonical/terminal hashes are `cded4de8...a97b6` /
`89f0d8af...59938`. Review 4/5 then found that a path-qualified executable
named `pwsh.exe` could be unwrapped without proving the outer executable.
Wrapper and inner command identities are now independently policy-pinned; N24
raises the passing negative aggregate to 24/24, and command-resolution guards
pass 5/5. Five affected historical generated contracts and their binding
declarations were re-bound without changing source projections or verdicts.
The canonical/terminal hashes are `105280a1...1a267` /
`19e2d778...54e2e0`. Review 5/5 then found that public evidence repeated a
private ignored-workspace locator and canary artifact identities. Those
locators, hashes, and detailed private state are now omitted from tracked
evidence in favor of a non-identifying `CANARY_PASS` summary. The third reset
cycle was exhausted. The user approved a fourth review-budget reset for the
same commit attempt. A 900-second qualification timeout and one CLI-rejected
selector/prompt combination returned no semantic result and did not count as
completed reviews. Fourth-reset review 1/5 then found that a static outer
side effect could precede an otherwise valid PowerShell wrapper and be lost
during inner-command extraction. Wrapper extraction now requires the wrapper
command to cover the complete outer script; N25 raises the passing negative
aggregate to 25/25. The canonical/terminal hashes are
`a324cb8e...4877f` / `cbd86ca3...523b3`, and four completed review slots
remained at that checkpoint. Review 2/5 then found two publication-safety P1s:
tracked cases exposed private sealed-evidence locators, and the public report
listed private artifact lengths/hashes. Tracked cases now retain only eight
logical source keys; an ignored private manifest supplies physical identities
only for explicitly requested local sealed verification. The public report
retains only the 8/8 disposition. All 11 public binding declarations are
re-bound without changing historical verdicts or sealed bytes. That full
checkpoint produced canonical/terminal hashes `eaa62861...b65ae` /
`f90aeaf4...2037d`. A Gitleaks false positive then caused the public field name
to change from `sealed_input_keys_sha256` to `sealed_input_names_sha256`;
pre-review-4 public mode remained `PASS` at `eaa62861...b65ae` /
`a4067b4e...9665`, while the 8/8 private-manifest result remains the immediately
preceding checkpoint rather than a fresh reread. Fourth-reset review 3/5 then
completed clean on Terra/high, independently reran the controller and fixture
checks successfully, and satisfied the native-review gate with material
coverage. Two slots remained at that checkpoint and were not needed to
establish the gate. Synchronizing that result changed tracked docs; review 4/5
then found two P1 fail-closed exception paths for missing/malformed roots and
malformed required-read, inventory-comparison, or construction-event rows.
One roots normalizer, safe nested-row extraction, N26-N29, and six direct probes
now return `CONTROLLER_UNKNOWN` without exception. Current public mode passes
29/29 negatives and 11/11 historical cases with zero failures at
`ebf302e2...c1464` / `76c84ea6...57622`. The remaining review slot owns final
exact-byte disposition in the cumulative attempt record. Review 5/5 then found
that shadow Git/PowerShell paths could copy trusted tuples and that
`-OutputPath` could overwrite existing sealed evidence. Resolved-path/AST
binding plus N24/N30 now rejects the shadow paths; atomic `CreateNew` plus a
1/1 sentinel guard prevents output clobber. All 11 generated contracts and
bindings were re-hashed without verdict changes. Current public mode passes
30/30 negatives and 11/11 historical cases with zero failures at
`691974ff...42ccd` / `da3de467...b0df3`. The fourth cycle then exhausted. The
user approved a fifth reset; review 1/5 found that bare native names remained
PATH-shadowable despite a copied trusted tuple. Exact rooted invocation
matching, 8/8 command-resolution guards, and re-bound affected historical
contracts now pass at `186391f3...1301c` / `8feac1c9...123be`. The correction
changed reviewed bytes. Review 2/5 then found two unused malformed allowed/proof
rows escaped global validation; eager identity checks now close both within the
existing 6/6 guards. Its action-parser finding is disproved by a direct
`CONTROLLER_UNKNOWN` / `command_kind_unknown` probe. Focused hashes remain
unchanged. Another native review was required at that tracked checkpoint; three
cycle slots remained and commit eligibility was then blocked. The canary had
already passed out of the intended order and remains sealed and non-retriable.
Local commit `119aa27...` now records the controller revision, so current
integration uses a fresh merge-result review rather than that historical
ordinal. Any successor or live-matrix proposal still requires a separate user
decision.

## Next Gate

No release action remains pending for immutable `v0.1.2`. Native review 1/5
found and corrected one P1 frontmatter trigger contradiction; review 3/5 found
and corrected one P2 selection-prompt coverage gap. Reviews 2/5 and 4/5 found no
actionable correctness issue, and review 4 covered the final 20-file diff. Local
commit `53d424c...` now records that exact D30 product candidate. The bounded
post-commit synchronization changes only nine existing documentation consumers
and ends with one local docs-only descendant commit. Its next user-owned gate is
whether to fast-forward push both local commits. No push, candidate
materialization, model or assessor turn, installation, tag, release, stable
update, or cleanup is presently authorized.

Successor-9 remains a separate Gate 2 decision bound to exact candidate and
controller `53d424c...`. Its design preserves all ten sealed behavior windows
and two zero-turn qualification records, qualifies entry workspaces under the
same OS identity as model commands, and tests the existing no-owner entry
context with one exact unavailable-read sentinel. Product gates remain
independent; Project Docs keeps its own candidate and persistence-evidence
sequence.

## Known Repository Gaps

- Project Docs `v0.1.2` stable proof is mature `NOOP`, not persistent `UPDATE`.
  For the current implicit-selection revision, exact loaded-copy attribution,
  write persistence, candidate readiness, broad triggers, and real-project
  behavior remain unproved.
- PowerShell still lacks live Bash/WSL, native execution inside the stable
  canary sandbox, actual sandbox-denial injection, and shadow-use evidence.
- No Skill has a causal correctness or token-saving comparison.
- Work Charter's full Standard evidence remains one historical synthetic
  bounded RC path; its stable proof is narrower and does not prove deterministic
  role delivery or writer locking, broad triggers, real-project efficacy, or
  standalone causality. Decision 0018's entry, level, re-entry, convergence,
  two-stage activation, and conditional role-read behavior remains unaccepted.
  D30 metadata-state and unavailable-read hardening has exact candidate
  `53d424c...` but no fresh behavior evidence. The stopped matrices and sealed
  fixed-turn bundle remain historical and cannot be relabeled for that
  candidate.
- The tracked controller now has one narrow isolated path-bound app-server
  compatibility pass. It does not establish natural-language Skill selection,
  semantic correctness, broad behavior, or Work Charter candidate acceptance;
  a live matrix remains a separate user-owned decision.
- Cross-Harness parity and SHICE evaluation remain unproved.
- Private-global retirement and retained rollback/evidence cleanup remain
  separately authorized lifecycle work.
