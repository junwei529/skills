# Repository Status

Last updated: 2026-08-11

## Dashboard

| Area | Current state | Detail |
|---|---|---|
| Tested package identity | all three package byte sets independently reached exact-commit RC readiness at `c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` and were re-proved at tag/stable identity `v0.1.2` | [Verification](VERIFICATION.md) |
| Stable release identity | immutable [`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2) at `ceed607152849775b981c54add74bfa30d858e4d`; exact tag, stable loaded-copy, and GitHub Release proof pass for all three Skills | [Verification](VERIFICATION.md) |
| Project Docs | immutable `v0.1.2` remains the released explicit-only control; local commit `776989f...` implements accepted Decision 0019 but is unreleased, and its evidence is `PARTIAL` because actual candidate selection, loaded-copy identity, and persistent writes remain `UNKNOWN` | [State](skills/manage-project-docs/STATE.md) |
| Work Charter | released `v0.1.2` remains active; exact candidate `c481005...` is unchanged and unaccepted; D47 is an immutable pre-product provider-availability stop, and D48 is immutable at combined 13/27 after A14 safely failed closed without the frozen loaded-copy proof; the prospective eval contract now distinguishes project/evidence read scope from package loading and adds direct package-denial/Harness-preload attribution, but no D49 Campaign is authorized | [State](skills/work-charter/STATE.md) |
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

Exact local D31 product candidate `07a9f1c...` incorporates the direct package-
load/project-read correction and remains unaccepted. Its qualified and blocked
evidence history is immutable. D35 remains an infrastructure-only
`UNKNOWN_NOT_ASSESSED` record. Additive D36 qualified the exact outer launcher,
froze 307 inputs at `f687419...`, completed A01-A12, and then hard-stopped at
A13. The top-level response stated the bounded L3 handoff and its tracked
controller result was `ADMISSIBLE`; the controller-instantiated Planner also
remained bounded. The separate Executor first called `list_mcp_resources`, then
loaded the candidate package and returned a bounded proposal. Its runner
therefore recorded the unauthorized non-command tool action, while an adapter
also mis-normalized that item as an empty command and produced a secondary
`CONTROLLER_UNKNOWN`. The packet consumed 21 behavior turns, sealed
`SEALED_PARTIAL_HARD_STOP`, and its one independent assessor returned
`DECISION_REQUIRED`.

The later ignored D37 attribution precursor froze at `1d705c65...` and consumed
exactly three one-shot read-only turns with no assessor or retry. Native made
7/7 authorized reads; released `v0.1.2` control and exact candidate `07a9f1c...`
each made 9/9, including their exact Skill and coordination-reference reads.
All three used zero non-command tools and left workspace and protected-home
inventories unchanged. This supports the corrected exact-path evaluation route
and shows that candidate behavior did not reproduce D36 under that route. It
does not rescore D36, assess response semantics, prove Skill-only causality, or
provide Gate 2 acceptance.
Exact details and residual limits belong to the
[Work Charter State](skills/work-charter/STATE.md) and
[Verification](skills/work-charter/VERIFICATION.md) ledgers.

The later immutable D40 packet completed A01-A03 and reached A04 with five
behavior turns. A04's indirect first turn loaded exact candidate `07a9f1c...`,
made no project or Git read, and stayed proposal-only; after confirmation, the
second turn made activation visible. The frozen old no-command rubric stopped
the packet solely at that package-read boundary, and its assessor returned
`DECISION_REQUIRED`. Decision 0018 D34 therefore prospectively permits native
`SKILL.md` loading while retaining explicit activation, project-read, adoption,
role, write, Git, installation, and external-effect gates. D40 remains 3/27,
immutable, unrescored, and unaccepted.

D34 was reviewed and committed as exact local candidate `b3ad360...`, with
five-file package manifest `7756d274...`. Fresh D41 passed offline
qualification, three non-product transport canaries, all 77 catalog mappings,
and freeze. Its product packet consumed six turns and completed A01-A04. A04
loaded exact `SKILL.md` without a project or Git read, but visibly called Work
Charter selected before activation approval, violating the proposal-only
boundary. A05 itself stayed at a bounded activation/read proposal with no
project/Git read or action, but its one-turn authorization policy used an
object where the adapter and runner require a list. The controller failed
closed, D41 sealed at 4/27, and one assessor returned `DECISION_REQUIRED`.
D41 is immutable, unaccepted, and not retried or rescored.

The approved D42 revision became exact local candidate `f24bda7...`, with
five-file package manifest `a192540f...`. Its fresh carrier completed whole-
matrix policy-schema preflight, 27-workspace construction, 77 catalog mappings,
three non-product transport canaries, and a freeze of 117 files. Its combined
static qualifier reported 12/12, but post-consumption native review proved that
the PowerShell parse subcheck received a null root, emitted a non-terminating
binding error, parsed no target file, and still returned a pass sentinel plus
exit zero. Pre-consumption qualification is therefore invalid; later direct
parsing of all six carrier PowerShell files is diagnostic only.

The product packet consumed six turns and completed A01-A04.
A04 loaded the exact body and used the required neutral applicability opening
without a forbidden state label or project/Git read. A05 used that opening and
no tool action, but before activation it prescribed pause, writer, evidence,
handoff, and resume workflow while exact candidate-body loading remained
unproved. The frozen exact-load requirement failed independently, D42 sealed at
4/27, and one assessor returned `DECISION_REQUIRED`. D42 is immutable and
unaccepted. A04/A05 are bounded observations without Gate 2 credit;
qualification transport needs exact expected-file coverage, and the
pre-activation workflow plus proposal-time body-loading policy require a
product/evaluation decision.

Accepted D43 was committed as exact local candidate `c481005...`, with
five-file manifest `04c382a4...`. Its fresh successor passed 12/12 zero-model
checks, all 77 catalog mappings, exact outer-launch routes, and the corrected
closed six-file PowerShell parser gate with six positive receipts, empty
stderr, and exit zero. The first required `Sol/high` non-product canary then
consumed one turn and failed at `SANDBOX_NETWORK_TRANSPORT`: Windows socket
access was denied with error `10013`, HTTP fallback could not connect, and no
final model message was produced. The other two canaries, all 27 product
cells, and assessor did not start. D43 is immutable, unaccepted, and sealed
`SEALED_HARD_STOP / UNKNOWN_NOT_ASSESSED`; this is an environment transport
blocker, not a Work Charter product defect.

Additive D44 preserved that terminal and the candidate unchanged. After two
zero-consumption carrier-only policy-host corrections, its fresh ignored
carrier passed final 12/12 qualification, all three network-capable canaries,
and the D44 freeze. A01 then consumed one product turn, stayed flat,
loaded no Work Charter file, proved the required reads, proposed the exact patch
and focused command, and marked it not run. The tracked controller returned
`ADMISSIBLE`, but the frozen semantic gate false-negatively rejected the split-
emphasis `not run` heading. D44 sealed at 0/27. The carrier then launched one
assessor outside the admitted-cell prerequisite; that turn is retained as a
deviation and excluded from D44 evidence. The gate is not rescored and D44 is
not retried.

D45 corrected both ignored evaluation gates, passed 13/13 zero-model
qualification, all three same-route canaries, and a 119-file freeze. A01-A09
were admitted. A10 then used its third turn only for the authorized missing
`CHECKPOINT.md` read, received `PathNotFound`, inspected no adjacent target,
changed nothing, and returned fail closed. The private matcher did not
normalize the equivalent `.\CHECKPOINT.md` spelling, so D45 sealed at 9/27
after 14 product turns. One eligible assessor returned `DECISION_REQUIRED`.
D45 is immutable and unaccepted; this is evaluation-infrastructure noise, not
a Work Charter SOURCE defect.

D46 imported the nine admitted D45 cells and their 11 product turns without
replay, passed 16/16 zero-model qualification including the synthetic
assessor-view privacy preflight, used two of three authorized zero-model
carrier corrections, completed all three same-route canaries, and froze 124
files. Fresh A10 consumed three turns, loaded the exact candidate, completed
its authorized missing-file route, and was admitted. A11 consumed one turn,
but private controller postprocessing then attempted to read a missing fixture-
side `RECOVERY_STATE.json` and sealed the cell before admission. This is a
controller/carrier or fixture-postprocessing failure, not a Work Charter SOURCE
or product-behavior finding. The combined packet sealed at 10/27 with four
fresh and 15 combined product turns. One assessor received only the validated,
locally reviewed redacted view and returned `DECISION_REQUIRED`. D46 is
immutable and unaccepted; A11 and all later behavior remain `UNKNOWN`.

D47 completed 17/17 zero-model full-lane qualification after using all three
allowed carrier corrections. Its first required `Sol/high` non-product canary
consumed one turn but returned no final response because the provider/account
route did not make the pinned model available. No product, selection, loaded-
copy, or assessor evidence was created. D47 is an immutable environment stop,
not a Work Charter SOURCE finding.

D48 then imported admitted A01-A10 without replay, passed 17/17 qualification,
all three exact-route canaries, and a 187-file freeze. Fresh A11-A13 completed.
A14 read only its authorized snapshot, changed nothing, and returned the safe
fail-closed route for divergent carriers and unknown finality, but did not load
the candidate body because the private prompt said only the snapshot was
authorized. The frozen selected-behavior gate required that loaded-copy proof,
so D48 sealed `SEALED_PARTIAL_HARD_STOP` at combined 13/27 with eight fresh and
22 combined product turns. One eligible assessor returned
`DECISION_REQUIRED`; D48 is immutable and unaccepted.

Accepted `WC-AR-D49-EVAL-CONTRACT` keeps SOURCE and D48 unchanged. It clarifies
the matched A14/A19/B04/C04 prompts so the named snapshot limits target-project
and evidence reads while direct-invocation package instructions may load, and
adds separate direct-invocation A20 where package use plus project/evidence
reads and actions are denied. Any native `SKILL.md` preload is attributed to
the pre-context Harness rather than activation or authority. The reference
matrix is now 20 runs and the full two-contrast matrix 28 cells. This
tracked evaluation/documentation closeout includes deterministic verification
and native review but not a commit or any D49 model/assessor call.

The exact evaluation-contract scope, writer state, and recovery order are owned
by [Repository Handoff](HANDOFF.md).

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
`PARTIAL`. Work Charter target `v0.2.0` likewise remains unaccepted at Gate 2.
Exact D31 candidate `07a9f1c...` has zero-turn D32 qualification; D33 and D35
remain immutable infrastructure/controller `UNKNOWN` records. D36 adds fresh
exact-candidate product evidence but not acceptance: its A13 Executor crossed
the authorized tool boundary before loading the Skill and left 15 available
cells unexecuted. D37 supplies only a three-turn corrected-route precursor;
semantic assessment and the remaining Gate 2 matrix are still absent.
Exact D34 candidate `b3ad360...` now has fresh D41 evidence, but not acceptance:
A04 crossed the visible proposal-only boundary and A05 remained
`CONTROLLER_UNKNOWN` because of a separate evaluation-construction defect.
Exact D43 candidate `c481005...` now also has bounded D44 evidence: final
qualification, three route canaries, and freeze pass, followed by one A01
product observation. The response appears contract-conformant for the ordinary
flat task, but the frozen semantic-gate false negative prevented admission and
stopped the packet at 0/27. A later assessor turn was out of scope and is
excluded from D44 assessment evidence; later-cell semantics remain
`UNKNOWN_NOT_ASSESSED`, and no acceptance transfers.
Later D45-D48 evidence remains separately bounded as described above. D47
stopped before product evidence on provider/account model availability after
passing full-lane qualification. D48 then completed A11-A13 and sealed at
combined 13/27 when A14 lacked the loaded-copy proof required by the frozen
contract. `WC-AR-D49-EVAL-CONTRACT` changes only the prospective read-scope
contract and adds a package-denial/Harness-preload boundary; it is not behavior
evidence or D49 Campaign authority.
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

No release action remains pending for immutable `v0.1.2`. D31-D48 are complete,
sealed or terminal, and non-retriable. Exact candidate `c481005...` remains
unaccepted at Gate 2. The active writer is limited to the approved prospective
evaluation-contract and mapped documentation closeout, deterministic checks,
and native review. No commit or D49 carrier/model/assessor activity is
authorized. After this diff converges, the next user gate is one complete
decision packet for the local commit and a bounded D49 Campaign; SOURCE or
candidate changes, push, installation, tag, release, stable update, cleanup,
and other-Skill changes remain excluded.
Project Docs keeps its own candidate and persistence-evidence sequence.

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
  `53d424c...`, but its fresh batch sealed at A12 after completing A01-A11.
  D31 has exact candidate `07a9f1c...` but no accepted fresh behavior. D36
  completed twelve cells before the A13 Executor used an unauthorized non-
  command tool prior to loading the Skill; the incomplete `DECISION_REQUIRED`
  packet cannot be compensated by earlier cell quality. D37's three corrected-
  route boundary passes have no assessor, semantic score, full-matrix coverage,
  or acceptance transfer. D40's package-only A04 read is now recognized as an
  eval-contract mismatch under D34, but the frozen packet remains incomplete
  and unaccepted. Exact D34 candidate `b3ad360...` adds D41's fresh evidence:
  A04 violated proposal-only visible semantics, while A05 stayed semantically
  bounded but could not be admitted because its evaluation policy had the wrong
  shape. D42 corrected both issues and exhibited the new surface at A04, but its
  A05 applied workflow before activation and did not produce controller-observed
  candidate-body loading; the strict frozen rubric stopped at 4/27. Post-consumption review also
  invalidated D42's static qualification because its PowerShell parse subcheck
  accepted a binding error as pass. D44 later passed the corrected
  qualification, all three network canaries, and freeze, but its frozen A01
  semantic gate false-negatively rejected a visibly not-run focused command and
  stopped at 0/27. D41-D44 remain incomplete and unaccepted. All stopped
  matrices and sealed bundles remain historical and cannot be retried,
  relabeled, or transferred.
- The tracked controller now has one narrow isolated path-bound app-server
  compatibility pass. It does not establish natural-language Skill selection,
  semantic correctness, broad behavior, or Work Charter candidate acceptance;
  a live matrix remains a separate user-owned decision.
- Cross-Harness parity and SHICE evaluation remain unproved.
- Private-global retirement and retained rollback/evidence cleanup remain
  separately authorized lifecycle work.
