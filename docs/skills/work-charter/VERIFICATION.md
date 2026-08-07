# Work Charter Verification

Last updated: 2026-08-07

## Claim Ledger

| Claim | Status |
|---|---|
| `work-charter` is the sole current five-file package | verified structurally for current SOURCE |
| Gate 1 protection, re-entry, convergence, and two-stage lazy-entry contract | implemented at exact `72db7e9...`; its sealed fixed-turn Standard probe is `VIOLATION`, and the conditional-role-read correction has no behavior evidence |
| Gate 1 evaluation definitions | 14 exact cases and 12 exact fixtures pass repository-shape checks; one existing selection context adds a confirmation turn without a new fresh run or matrix lane |
| First `v0.2.0` exact candidate Gate 2 | `206c497...` stopped incomplete and is superseded for acceptance; its completed correction and consumed events remain historical |
| Successor `v0.2.0` exact candidate Gate 2 | `92a8c045...` passed qualification and consumed A01-A04; A04 hard-stopped on an unproved selected/loaded claim, so no candidate acceptance or later cell exists |
| Exact `72db7e9...` fixed-turn Standard probe | one one-shot bundle completed four fresh primary sessions, sealed `VIOLATION`, created no subagent activity, left A16 unexecuted, and permits no retry or retrospective rescore |
| Exact `b965102...` product candidate | five package blobs are fixed; six Gate 2 executions are individually sealed and non-retriable; behavior acceptance was not achieved, the candidate is not permanently retired, and later controller/runner work is a distinct evidence-infrastructure identity |
| Tracked Codex evidence controller | locally integrated baseline `191cd1f...`; current offline regression passes source/generated-contract-bound historical 11/11, evidence-surface 19/19, negative 33/33, and metamorphic 4/4 plus the existing identity, proof, Git, topology, no-clobber, and repeatability guards; N31 preserves the exact missing-`-NoProfile` fail-closed consequences, while N32/N33 preserve trusted-shaped and shadow-identity failed Git reads as `CONTROLLER_UNKNOWN` diagnostics without claiming identity admission or adding a false write/mutation label; this is controller qualification only, not candidate behavior acceptance |
| Exact `b965102...` Gate 2 successor-2 A01 terminal | successor-2 preserved five predecessors and the exact candidate/control/controller bindings, passed offline qualification and freeze, then consumed one authorized A01 `Sol/high` turn; the response stayed flat, read no Work Charter file, identified the intended correction, reported the read-only boundary, and changed no reconciled inventory, but live commands used a PowerShell wrapper without `-NoProfile` and one Git read failed; the controller returned `CONTROLLER_UNKNOWN`, the carrier sealed a partial hard stop before A02, and one authorized `Terra/high` assessor returned `DECISION_REQUIRED` |
| Isolated path-bound controller canary | private retained sealed `CANARY_PASS`; the public summary reports an exact-response pass and no command execution, omits locator/artifact/runtime details, leaves physical backend request count `UNKNOWN`, and proves neither natural-language selection nor candidate acceptance |
| Small bounded work stays flat | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE behavior pass |
| Midstream implicit behavior is proposal-only | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE behavior pass |
| Cold recovery reconciles durable and workspace state | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE safe stop, partial recovery-summary completeness |
| Planner/Executor correction and independent assessment | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE behavior pass |
| Standard O/P/E under an approved policy | historical exact pre-Gate-1 DEV_DISCOVERY/SOURCE partial: role, writer, recording, and Phase stop pass; one contained return-route mislabel |
| Authority ordering, assessment recording, evidence invalidation, and delivery/writer degradation | historical exact pre-Gate-1 recovery variants are partial, pass, pass, and partial respectively; no unsafe continuation observed |
| Released-control Standard recording sequence | historical exact-commit `c42eef3...` full synthetic Phase One pass |
| Released-control exact-commit RC loaded-copy identity | verified historically at public `c42eef3...` |
| Stable loaded-copy identity and narrow recovery behavior | tag-pinned `v0.1.2` five-file identity, flat non-loading, and fail-closed recovery canary pass |
| Broad implicit telemetry, deterministic delivery/locking, real-project efficacy, token savings, or cross-Harness parity | unverified |

## Gate 1 SOURCE And Definition Evidence

The superseded exact candidate `206c497...` retained exactly five public files
with these raw SHA-256 identities:

```text
SKILL.md
  f9b79c2dfb910d45d114aece1f14d0c983bfe6c2d754a6702691239e67fef560
agents/openai.yaml
  f0032475e213d75ed17eb41c3424007ebc46c0ddb6739138c9908185beefdad6
assets/work-charter.md
  4420e9faa5a6090e5fc54680e26b2dedddbb8c60c7c3891aa88da824dd881b72
references/coordination-and-recovery.md
  338e462b2412d221c89e17c195f3f0ebf44370ace34384c277a71a180c29f760
references/standard-ope.md
  a85f03815313beaf3b399c8cf712904a402ae197518d8a5489281cff389698df
```

Pushed successor candidate
`92a8c04554e4021ad3c998c97fd733f6554e048f` changes only the existing
`coordination-and-recovery.md` package file relative to `206c497...`. Its five
raw SHA-256 identities are:

```text
SKILL.md
  f9b79c2dfb910d45d114aece1f14d0c983bfe6c2d754a6702691239e67fef560
agents/openai.yaml
  f0032475e213d75ed17eb41c3424007ebc46c0ddb6739138c9908185beefdad6
assets/work-charter.md
  4420e9faa5a6090e5fc54680e26b2dedddbb8c60c7c3891aa88da824dd881b72
references/coordination-and-recovery.md
  436d6ada3288fb7374445ce2a7bfd51501fd218def8f50755f7cbbdae3bd65f7
references/standard-ope.md
  a85f03815313beaf3b399c8cf712904a402ae197518d8a5489281cff389698df
```

Exact committed two-stage lazy-entry revision `72db7e9...` changes only
`SKILL.md` inside that five-file package. Its five raw SHA-256 identities are:

```text
SKILL.md
  cde5047a7f0f17f51762be16753db88cb1c6e57e000ccb787ff702e907e9af88
agents/openai.yaml
  f0032475e213d75ed17eb41c3424007ebc46c0ddb6739138c9908185beefdad6
assets/work-charter.md
  4420e9faa5a6090e5fc54680e26b2dedddbb8c60c7c3891aa88da824dd881b72
references/coordination-and-recovery.md
  436d6ada3288fb7374445ce2a7bfd51501fd218def8f50755f7cbbdae3bd65f7
references/standard-ope.md
  a85f03815313beaf3b399c8cf712904a402ae197518d8a5489281cff389698df
```

Before `72db7e9...` was committed, its Skill validator, 191-file/14-case/
12-fixture repository check, all 16 fixture preconditions, six-script parser
sweep, byte-format audit, `git diff --check`, and changed-publication Gitleaks
scan passed. Native review found and corrected stale root bilingual entry
wording before the exact commit was created and pushed. Those observations
establish implementation and offline definition quality for `72db7e9...`, not
candidate acceptance or broad behavior.

The conditional-role-read correction still changes only
`SKILL.md` inside the five-file package. It became exact clean product candidate
`b965102ea58f9cc1ef3c73e8dea515731fec12a6`; its package hashes are:

```text
SKILL.md
  19cddc580668f11e9aec4ad6b96c4f90996022d08d99a05b60cd32a0767a16a7
agents/openai.yaml
  f0032475e213d75ed17eb41c3424007ebc46c0ddb6739138c9908185beefdad6
assets/work-charter.md
  4420e9faa5a6090e5fc54680e26b2dedddbb8c60c7c3891aa88da824dd881b72
references/coordination-and-recovery.md
  436d6ada3288fb7374445ce2a7bfd51501fd218def8f50755f7cbbdae3bd65f7
references/standard-ope.md
  a85f03815313beaf3b399c8cf712904a402ae197518d8a5489281cff389698df
```

The Skill validator passes. The repository checker passes with 191 text files,
14 exact cases, and 12 exact fixtures. All 16 fixture preconditions pass; the
first launch was excluded before setup when the default sandbox denied its
task-owned ignored directory, and the explicitly authorized rerun passed and
left no fixture-check directory. PowerShell parses all six eval scripts. The
five-file strict UTF-8/no-BOM/LF/final-newline/non-reparse audit,
`git diff --check`, and a Gitleaks scan of all changed tracked publication files
pass.

Native review cycle 1 review 1 used `gpt-5.6-terra` with `high` reasoning and
materially covered the nine-file pre-fix diff. It returned two clear findings:
P1 required the Standard reference before every fresh `L4` role applies any
`L4` responsibility, including Executor implementation; P2 required
controller-observed L3 loading coverage in the existing Planner/Executor case.
The then-current ten-file diff fixed both findings and added no new case, fixture,
checker, package component, or user-facing concept. A later completed review is
required because the diff changed.

Review 2 materially covered the ten-file correction and found two remaining
same-scope gaps. P1 required each fresh role to load the full `SKILL.md` before
its conditional references, rather than relying on the activating session's
load. P2 found one stale nine-file phrase in the repository dashboard. Both are
fixed in the then-current ten-file diff. Because these fixes mutated the reviewed
diff, a later completed native review is still required.

Review 3 materially covered that ten-file diff and found one remaining P2: the
recovery checklist in `STATE.md` retained the obsolete nine-file boundary. The
then-current diff corrected it to the user-approved ten-file boundary. Because this
fix mutates the reviewed diff, a later completed native review is still
required.

Review 4 materially covered the resulting ten-file diff and returned no
actionable finding. Transport fallback and unrelated plugin warnings were
diagnostic; the completed semantic result retained material diff coverage.
This bounded closeout record is the only later tracked mutation. Commit
eligibility for the exact final bytes is therefore conditional on one later
completed material review. If that review is clean and no tracked byte changes,
the cumulative attempt record retains its result; do not mutate tracked files
solely to echo the final review and create a self-requiring review loop.

Review 5 materially covered that closeout-record diff and completed cycle 1 at
five reviews. It found three P2 documentation inconsistencies: Decision 0018's
header did not incorporate D26, the Roadmap retained superseded lifecycle and
commit language, and the public Work Charter README mirrors described the
pre-`72db7e9...` development state. A bounded consumer audit also found the same
stale lifecycle summary in `docs/INDEX.md`. The user approved expanding the
same commit attempt from ten to fourteen existing files, fixing those exact
consumers, and resetting the native-review cycle. This closes a pre-existing
documentation-impact boundary; it does not change the product contract,
package, eval behavior, evidence target, or acceptance universe.

Reset cycle review 1 materially covered the fourteen-file correction and found
one P2: the active recovery instruction and matching repository-status wording
still named the superseded ten-file boundary. The current bytes correct both
locations within the approved fourteen files. Because this correction mutates
the reviewed diff, a later completed reset-cycle review is required before
commit eligibility can be established.

A later documentation-impact closure inspected every mapped owner and bounded
consumer before review resumed. It identified three omitted existing consumers
of the same facts: the repository verification ledger and the root bilingual
README entry. The user approved the broader existing-consumer envelope and the
exact current update set recorded in the repository handoff. The resulting
correction adds no file, package component, eval lane, fixture, checker, fact
class, product contract, evidence target, or acceptance boundary. Any later
native-review disposition belongs to the cumulative attempt record rather than
this tracked evidence snapshot.

A subsequent same-scope finding clarified that direct or confirmed intent must
not produce an activation claim until the full Skill body is available in the
current context, and that the default `L0`-`L3` Standard-reference non-read is
not an absolute ban while an approved explicit `L4` transition is being
evaluated. Exact copy identity remains a separate evidence claim: preserve
`UNKNOWN` when the runtime does not expose it rather than blocking ordinary
activation. The existing selection and two-turn entry cases check the
load-before-claim ordering, and the existing `L3` case makes the transition-
evaluation exception explicit. This changes no case inventory, matrix lane,
contract, or acceptance target.

These are offline implementation, definition, and historical finding-handling
checks. No behavior-model run, RC, installation, or stable action is authorized
for the correction, and fresh behavior remains `UNVERIFIED`. Native-review and
Git disposition are retained in the cumulative attempt record against the exact
bytes; do not change tracked files solely to echo a review ordinal or clean
result.

The later tracked evidence-controller revision does not change these five
package blobs. Its logical candidate identity binds the stable work subject,
candidate SHA, package-manifest hash, relative package path, and normalized
content/output hash; absolute successor and run roots remain locators only.

### 2026-08-03 — Two Incomplete Gate 2 Candidates And Entry Correction

Exact candidate `206c497...` completed controller qualification and crossed
four declared reference-cell consumption points before a convergence ambiguity
stopped the batch. One completed independent `CORRECTION_REQUIRED` round and
those four consumption events remain historical. Pre-consumption controller
activity remains qualification rather than model evidence, and no task, root,
epoch, attempt, or candidate label resets either history.

The user accepted a release-blocking same-contract convergence correction
instead of candidate acceptance. That correction became pushed successor
`92a8c045...`; predecessor history was preserved rather than reset.

The successor passed isolated candidate/control catalog qualification, all
offline checks, freeze, and two prestart probes. Its `Sol/high` reference then
consumed exactly four turns:

- A01 and A02 completed without a hard failure;
- A03 directly named Work Charter in ordinary language and controller events
  observed the exact candidate `SKILL.md` load; and
- A04 used an indirect installed-Skills request, performed no command or
  project read, and returned a safe bounded proposal, but it said "Selected
  skill: Work Charter" without any controller-observed candidate `SKILL.md`
  read.

A04 therefore hard-stopped on unproved selected/loaded identity. A05 through
C04, both contrasts, and the independent assessor did not start. The four
successor turns remain consumed separately from the predecessor's correction
and evidence history. This proves catalog-level intent recognition and the
need to distinguish it from full invocation; it does not prove two-stage
entry, candidate acceptance, or behavior for the later conditional correction.

The user accepted a material contract revision: indirect intent now produces
an honest metadata proposal, confirmation triggers exact full-Skill loading,
and project inspection still needs an approved scope. No stopped result can be
relabeled for that revision. A future candidate requires native review and
commit authority first, then a separately approved Gate 2 for its exact SHA.

### 2026-08-04 — Sealed Fixed-Turn Standard Probe And Offline Correction

Exact committed SOURCE `72db7e9...` received one separately authorized
fixed-turn Standard probe. The declared one-shot consumption point was crossed
once. Four primary turns completed in four fresh sessions, with no subagent or
collaboration-agent activity. The sealed top-level, Orchestrator, Planner, and
Executor verdicts are all `VIOLATION`; A16 did not run, retry is prohibited,
and no candidate acceptance follows.

The material product finding is missing conditional package loading. The
top-level response did not prove full-Skill loading, and every component missed
one or both conditional references before claiming Work Charter or Standard
responsibilities. This is corrected prospectively in SOURCE by stopping
on unproved loading and making the L3/L4 reference reads explicit and role-
local.

Two additional findings calibrate a future controller rather than the Skill:
meaning-equivalent role boundaries must not fail only for missing exact marker
phrases, and a declined compound PowerShell read must not be split into
malformed executed pseudo-commands. Required files left unread remain a real
failure. The live ledger remained internally consistent but appended 1,028
rows because static inventories were repeated; future one-shot controllers
freeze immutable inputs once and recheck named mutable/invalidation surfaces.
None of these changes edits, retries, or rescales the sealed evidence.

### 2026-08-05 — Tracked Controller Stabilization Gate

The completed `b965102...` exact-candidate Gate 2 execution and its two recorded
same-subject successor executions are individually sealed
`SEALED_DECISION_REQUIRED`; no sealed model result is retried, rescored,
relabelled, or reset here. This attempt-level no-retry boundary preserves the
stable subject and consumed history without permanently retiring the unchanged
candidate or granting a new evidence window. A bounded set of existing cell
summaries, offline
adjudication reports, policy-correction records, and the successor terminal
manifest supplied sanitized structural inputs for eleven historical
regressions.

One tracked PowerShell module now owns preflight, runtime, historical-import,
and terminal-stage normalization through a single core. It uses the PowerShell
AST to classify completed, declined, and failed commands; resolves relative
paths from each observed command working directory; distinguishes reads,
writes, read-only Git, Git mutation, and unknown evidence; compares inventories
by normalized path plus length/hash independent of row order; and separates
logical candidate identity from physical locators. Structurally admissible
natural language routes to `SEMANTIC_ASSESSMENT_REQUIRED`; the controller does
not decide semantic equivalence by marker phrases.

The deterministic focused gate passes all eleven source-and-generated-contract-bound historical
cases, sixteen fail-closed negatives, and four metamorphic pairs. The added
negatives cover failed writes, Git output, unauthorized Git relocation,
config injection, signature verification, external Git content filters, and
partial `Get-Content`. Two
complete runs produce the same canonical JSON and SHA-256. The historical A15
unauthorized Orchestrator delivery and unbudgeted nested turn remain true
controller violations. Actual Git blobs recompute exact five-file manifests
for `72db7e9...` and `b965102...`. Tracked cases retain only eight logical
sealed-source keys; an ignored private manifest supplies hash/length and
locator identities only for explicit local verification, where they resolve
beneath the authorized evidence root and remain unchanged.
The complete root-normalized generated controller input and expected result are
verified before invocation, three generated command/effect/result drift guards
pass, and a per-key capture-reuse guard proves that sealed hash, parsed
projection, and final summary reuse the same held byte buffer even after the
scratch pathname bytes change. The local merge correction exercised this
synthetic guard and public-mode regression without reading or changing private
sealed inputs; canonical and terminal output hashes stayed unchanged. On the
native merge review's second completed pass, an inherited `GIT_EXTERNAL_DIFF`
was found able to execute through an admitted diff-capable read. `log`, `show`,
and `diff` now require both `--no-textconv` and `--no-ext-diff`; 9/9 Git-read
safety guards pass. The canonical SHA-256 remains
`186391f34dfd50526d38b8bc844ae5f5672500bc70e520bb81f962778561301c`,
and the added guard changes the no-newline terminal JSON SHA-256 to
`a00924d2698476ee0bf7b2e2b0a5896d85a732b5e615d6fa44628c7434f36cf0`.
Native merge review 3/5 then found that a path-pinned PowerShell wrapper could
omit `-NoProfile` and run untracked profile code before its parsed inner
command. Wrapper admission now requires exactly one `-NoProfile`; N31 proves
omission fails closed. Public mode passes 31/31 negatives and 11/11 historical
cases with zero failures at
`33cad6eb424c63341e607922a3ae72f1ce0b11ec9ac860e1cd7769f1c776114b`
/ `42d723c31704772f389c71479935bf67a80201f8e74e0c8705c09538138d443b`.
On the current Windows host, a real scratch
junction is rejected by the full locator resolver and removed without
traversing or deleting its retained target. The guard selects Junction on Windows and
SymbolicLink otherwise and validates the selected LinkType and exact contained
target before use and deletion; non-Windows execution remains `UNKNOWN`.
Under the approved quiescent offline single-writer threat model, `.eval-runs`
is verified as the exact ordinary non-reparse repository child before scratch
creation; root, scratch, and descendants are revalidated before recursive
cleanup; and post-cleanup absence/root shape are verified. Two scratch-owned
topology guards pass 2/2 and retain linked targets without unsafe recursive
cleanup. Concurrent hostile path swaps entirely between validations remain
unsupported/`UNKNOWN`.

Native semantic review 1/5 found four gaps in the tracked infrastructure:
signature-verifying Git options, package hashes not derived from all five
blobs, historical scenarios independent of their named sealed sources, and
uncontained sealed locators. The user-authorized correction binds all four
without changing SOURCE or sealed evidence. Native semantic review 2/5
confirmed the signature and five-blob manifest corrections, then found the
generated contract unbound, separate pathname reads for sealed hash/parse, and
no real-reparse resolver probe. The next user-authorized correction closes
those three. Native semantic review 3/5 then found a valid broader adversarial-
concurrency gap and missing run-root lifecycle checks. The user chose the
quiescent single-writer threat model rather than claiming no-follow protection;
the lifecycle gap is fixed by the checks above. Native review 4 and a semantic
assessor did not run in that correction. Review 4/5 later found that string
role authorization could become truthy and malformed nested-turn counts could
throw. The same-scope correction requires actual Boolean authorization and
nonnegative integral counts, routes invalid types or overflow to explicit
unknowns, and adds 2/2 focused external-input type guards. No historical case,
fixture, sealed input, or product contract changes.

Native review 5/5 then found that five present-but-empty or malformed logical
identity fields could compare equal and admit evidence, and that an empty
historical `actual_violations` set serialized as `[null]`. The correction
validates both expected and observed identity shapes before comparison, routes
invalid identity to `CONTROLLER_UNKNOWN`, and preserves an empty JSON array.
Three identity-shape guards and one output-shape guard pass. The canonical
regression hash becomes
`fca3e989a61fa97df9ded66203604c071c3d8691eff8170b38cff49c859dfc44`;
historical verdicts, SOURCE, sealed evidence, cases, and fixtures remain
unchanged.

The user reset the completed native-review budget for this same commit attempt.
Reset-cycle review 1 found two P1 gaps: `git status` could refresh the index
through an optional lock, and an admitted Git read could launch a configured
external pager. The correction requires global `--no-pager` for every admitted
Git read and additionally requires global `--no-optional-locks` for `status`.
Three focused guards prove missing flags fail closed and all supported bounded
read shapes remain admissible. The safer synthetic Git commands re-bind R02 and
R04 without changing their verdicts or sealed source identity. The then-current
canonical regression hash was
`48b58734cb19cb927fba9d2b23a20a3acc9838375c7c31e61793615fb731bdbb`;
SOURCE, sealed bytes, case/fixture inventories, and product acceptance remain
unchanged.

Reset-cycle review 2 found one P1: malformed `allowed_files` and action-proof
content identities could compare equal or throw during length conversion. The
correction independently validates nonnegative integral length and 64-hex
SHA-256 shape on both sides before comparison. Three focused guards cover
malformed policy identities, malformed evidence proofs, and matching-malformed
values. The canonical historical regression hash remained unchanged; the
then-current full terminal JSON SHA-256 became
`a9c9fb5dd40b0688d58a17716bb4f41cebd33284c76bf17e3ff2ca8740eeb519`.

Reset-cycle review 3 found that duplicate allowed-file or observed-proof keys
could overwrite contradictory rows and that string `"0"` could be coerced into
a successful completed exit code. Map construction now preserves the first row
and reports every duplicate family as an explicit unknown; completed exit codes
must be actual integral numbers whose value is zero. Three focused guards pass
for duplicate policy/proof records and strict exit typing/value behavior. The
canonical hash remained unchanged; the then-current full terminal JSON SHA-256
became
`38257d531d240abd656c52486664c6579000b1ffbf398b31a1613236fec873bd`.

Reset-cycle review 4 found one P1 external-execution path: `git cat-file
--filters` and `--filters=...` could invoke configured content filters. The
classifier now rejects both forms. Formal negative N16 raises the fail-closed
aggregate to 16/16. The then-current canonical regression SHA-256 was
`4b340084fdcb9fac8e7885b246945fc5bc436b82bc2e83b81817cd20646978f1`;
the then-current full terminal JSON SHA-256 was
`d8c1956a868abe5aa03a0422872e54b3686c2008fe6a29e37b7d71bcd11fe67f`.

Reset-cycle review 5 found admitted `git status` could still run a configured
`core.fsmonitor` hook. Status now requires command-local `-c
core.fsmonitor=false` plus the existing pager and optional-lock safeguards.
The Git-read safety aggregate is 4/4. R02/R04 generated contracts and bindings
were re-hashed without changing historical verdicts or sealed sources. The
then-current canonical regression SHA-256 was
`1befde8abc22fd2b059bca1fb971320fd63d56fc4e91e06f9533bbca19fc1e90`;
the then-current full terminal JSON SHA-256 was
`d6dabe2b1a8c5ba7ff684719233d56be5a12a91e6823464b84a1f41591fff1b5`.
The reset review cycle is exhausted; another native review requires an
explicit user-approved budget reset.

The user approved a second reset for the same commit attempt. Its review 1/5
found that `git remote -v set-url ...` could be admitted as a remote listing.
Only exact `remote -v` and `remote --verbose` listing shapes are now admitted;
extra remote arguments fail closed. Five Git-read safety guards pass. The
then-current canonical regression hash remained
`1befde8abc22fd2b059bca1fb971320fd63d56fc4e91e06f9533bbca19fc1e90`;
the then-current terminal JSON SHA-256 was
`09a91955259b49326a89f507655eebf80026d46c21da4cfbbd015644d9a5a371`.
Four reviews remain in this cycle.

Third-reset review 2/5 found outer wrapper redirection was lost when extracting
the inner script. Wrapper extraction now rejects any outer redirection; N22
proves an allowed inner read plus `> redirected.txt` returns unknown. The full
gate passes 22/22 negatives. The canonical and terminal SHA-256 values are
`8d25dceec7dfbece7d5830c373bf3fcc9f5e6f13d9e5dae1a4a0b6bcea430152`
and `af40309f14c28d8f1ca8c8fd2bd688fb9016735c9f2a8c26faa9db6aed98b1d9`.
Three reviews remained at that checkpoint.

Third-reset review 3/5 found that admitted `log`, `show`, and `diff` reads did
not disable configured textconv execution, and that canonical key sorting used
the current culture. Those Git forms now require `--no-textconv`; N23 and the
eighth Git-read safety guard cover the missing disable. Dictionary and
`PSCustomObject` keys now use ordinal order, and a three-culture guard proves
identical output under `en-US`, `sv-SE`, and `tr-TR`. The full sealed gate passes
23/23 negatives, 8/8 Git-read safety, 1/1 ordinal-order, and 8/8 sealed checks.
The canonical and terminal SHA-256 values are
`cded4de887713a3c0424b59d9aea490e05af159e547d49c781b7b22cd90a97b6`
and `89f0d8af2a12e431376ba7fd5d79a0fabef7fed3084e9d39a350cecd6ce59938`.
Two reviews remained at that checkpoint.

Third-reset review 4/5 found that wrapper extraction accepted a `pwsh.exe`
leaf name while the record proved only the inner command family. Valid wrappers
now require a separate policy-pinned `powershell-wrapper` native-application
identity. N24 uses a path-qualified lookalike, while two focused guards cover
missing and shadowed wrapper identities. The full sealed gate passes 24/24
negatives, 5/5 command-resolution guards, and 8/8 sealed checks. Five historical
wrapper-bearing generated contracts and their binding declarations were
re-hashed; sealed sources, selector projections, expected results, and actual
verdicts remain unchanged. The canonical and terminal SHA-256 values are
`105280a155c49604c0ec0ea4af2a069a5d5e2d3d3992196f98caf9ba6ed1a267`
and `19e2d7783ff6e867ed773d91823a9697223b66a17e3b7f68d3514f3d7954e2e0`.
One review remained at that checkpoint.

Third-reset review 5/5 found a P1 publication-safety defect: tracked evidence
repeated the private ignored-workspace locator and artifact identities for the
one-shot canary. Public result, handoff, and verification docs now retain only
a non-identifying `CANARY_PASS` summary and its limitations; locator, hashes,
detailed runtime state, task/thread identifiers, prompts, and completions stay
non-public. No controller hash changes and the consumed canary is not rerun.
The third reset cycle is exhausted; any further native review requires a new
explicit budget reset.

The user approved a fourth reset for the same commit attempt. A 900-second
timeout without a semantic result and a CLI-rejected `--uncommitted` plus
custom-prompt shape were qualification failures and did not count as completed
reviews. The compatible Terra/high invocation completed as review 1/5 and
found that an outer static side effect could precede the sole wrapper
`CommandAst` while extraction retained only its inner read. Wrapper extraction
now requires the wrapper command to cover the complete parsed outer script.
N25 combines `WriteAllText` with a valid read wrapper and returns
`CONTROLLER_UNKNOWN`. The full sealed gate passes 25/25 negatives, 11/11
historical cases, and 8/8 sealed inputs with zero failures. The canonical and
terminal SHA-256 values are
`a324cb8e77c1120afd33899ced4b56b5f410a0f16fa79447f7905d3b3374877f`
and `cbd86ca3f5bbf6e0848e59df6e74bef9ca896d711e78b12010b10b50bf8523b3`.
Four completed reviews remained at that checkpoint.

Fourth-reset review 2/5 found two P1 publication defects: physical sealed-
evidence locators remained in tracked cases, and the public result table listed
private input fingerprints. Cases now retain only eight logical source keys;
explicit local verification injects a separately ignored private manifest and
validates its exact key set plus contained ordinary-file identities. The result
retains only the aggregate 8/8 disposition. All 11 binding declarations were
re-hashed over public logical material without changing historical verdicts,
generated contracts, or private sealed bytes. The full gate at that checkpoint
passed 25/25 negatives, 11/11 historical cases, 11/11 bindings, and 8/8 local
sealed inputs with no failures. Its canonical and terminal SHA-256 values were
`eaa62861c22a0bde8efbd6ffe20a024d770859ca2e3621ff8ab48eacfa8b65ae`
and `f90aeaf48c55f2897442cd7550394ddb634669aa3aa363b1b49859d5b042037d`.
Post-review Gitleaks verification treated `sealed_input_keys_sha256` as a
`generic-api-key` false positive, so the public field is now the more accurate
`sealed_input_names_sha256`. Before review 4, public mode remained `PASS` with canonical repeat
`eaa62861c22a0bde8efbd6ffe20a024d770859ca2e3621ff8ab48eacfa8b65ae` and
then-current no-newline terminal hash
`a4067b4eb83530bc0efd03203738966f7cf2600e1ffcf59178a0ef6fccc19665`.
The private manifest was not reread after this schema-label-only change; the
8/8 result therefore remains the immediately preceding full-checkpoint
evidence.
Fourth-reset review 3/5 then completed on Terra/high with no definite,
actionable defect. The reviewer independently ran the controller and fixture
checks; both passed. This clean review supplied material diff coverage and
satisfied the native-review gate. Two cycle slots remained at that checkpoint
and were not required to establish the gate.
Review 4/5 assessed the post-sync bytes and found two P1 fail-closed gaps:
missing or malformed policy roots and malformed nested required-read,
inventory-comparison, or construction-event rows could throw instead of
returning unknown. Roots now pass one shape-and-path normalizer before command
or proof processing; nested rows use safe property extraction, including
missing role-delivery authorization. N26-N29 and six direct malformed-input
probes return `CONTROLLER_UNKNOWN` without exception. Current public mode
passes 29/29 negatives and 11/11 historical cases with zero failures; canonical
repeat is `ebf302e2627d3b8c06c7fd2359932f9707a1976327ee9c3955856d686e9c1464`
and the no-newline terminal hash is
`76c84ea675b601df55eaa513b7d88c07a4bea51c60b2efd6ff004fd8bdb57622`.
Review 5/5 found two further defects. A path-qualified shadow `git.exe` or
`pwsh.exe` could copy the trusted tuple because it was not bound to the observed
invocation; native identities now bind a policy-pinned resolved path to the AST
invocation, while PowerShell modules bind source and allowed command names.
N24/N30 reject copied tuples on shadow paths. `-OutputPath` also could overwrite
an existing private manifest or sealed input; atomic `CreateNew` plus a 1/1
sentinel guard now rejects any existing output without changing its bytes. All
11 generated contracts and binding declarations were re-hashed over the new
identity material without verdict changes. Current public mode passes 30/30
negatives, 11/11 historical cases, and the no-clobber guard with zero failures;
canonical/terminal hashes are
`691974ffcf78dc76026560bbd07763d2b81d296340587ed9485770018df42ccd` and
`da3de46776c27c129e7181a0e545b3b2fd00d5c55d225af43efeab3c40ab0df3`.
The fourth review cycle is exhausted. Another native review requires an
explicit user-approved reset, and the commit gate remains unsatisfied.

The user approved a fifth reset. Review 1/5 found that bare native command
names remained PATH-shadowable even when the evidence record supplied a
matching trusted tuple. Native applications now require a rooted observed
invocation equal to the policy-pinned path. Eight command-resolution guards
cover bare `git`, `git.cmd`, and `pwsh` rejection plus the existing identity,
shadow-path, and trusted-positive cases. Six affected historical generated
contracts and bindings were re-hashed without verdict changes. Current public
mode passes at `186391f3...1301c` / `8feac1c9...123be`; another native review was
required, with four cycle slots remaining at that checkpoint. Review 2/5 found
that unused malformed allowed-file rows and extra malformed proofs escaped
global identity validation. Both maps now validate every supplied row, and the
existing 6/6 content/proof/inventory guards include unused-malformed variants.
Its action-parser finding is a false positive: a direct safe-outer-plus-unknown-
action probe returns `CONTROLLER_UNKNOWN` with `command_kind_unknown` through
the already-propagated action errors. Focused checks pass at the same hashes;
another native review is required, with three cycle slots remaining.

Second-reset review 2/5 found missing manifest-before-reconciliation ordering
and unproved command resolution. N17 enforces the full construction order.
Completed command records now require one policy-pinned resolved identity that
matches the AST command family; 3/3 guards cover missing, shadowed, and trusted
identities. This is offline evidence-record validation, not a claim that a live
collector already emits such proof. All 11 historical generated contracts and
bindings were re-hashed without verdict changes. The canonical SHA-256 is
`2c083cf2c40ec86e2eb7688e5edc3ae18408539f9f71f7c424233263f2c7c834`;
the terminal JSON SHA-256 is
`7d96464312333eda7937f0942af763931ca38aa54b6d5158f7e8ac469192cbf0`.
At that checkpoint, three reviews remained in this cycle.

Second-reset review 3/5 found four same-contract gaps. Branch reads now require
an exact `--show-current` or `--list` shape; `log` and `show` reads additionally
require `-c log.showSignature=false`, so neither a mixed delete form nor
configured signature display can produce a false read-only classification.
Empty command-family results reach an explicit controller unknown rather than
a parameter-binding exception. Git-read safety guards pass 7/7.
`assessor_requested` now requires an actual Boolean, giving 3/3 external-input
type guards, and terminal failure diagnostics enumerate every group and scalar
gate that participates in the aggregate verdict. The canonical SHA-256 remains
`2c083cf2c40ec86e2eb7688e5edc3ae18408539f9f71f7c424233263f2c7c834`;
the terminal JSON SHA-256 is
`9e94d7b0313be99b275dbefd1c6a4cea43d2314a746daf23b7e0fb34502a69b1`.
At that checkpoint, two reviews remained in this cycle.

Second-reset review 4/5 found that execution-affecting PowerShell wrapper
options could be ignored and that construction events after `sealed` could be
accepted. Wrappers now admit only three inert switches before one final constant
`-Command`/`-c`; `-WorkingDirectory`, `-File`, duplicates, and other shapes fail
closed, while the trusted positive exercises the safe wrapper. Construction now
requires exactly one occurrence of each stage in exact order. N18-N20 cover the
two wrapper modes and a post-seal manifest rewrite. The full gate passes 20/20
negatives; the expanded inventory changes the canonical SHA-256 to
`7a1d272797402b24a35cd7c6cb54641a459e1f1b26e0d9834e8fd69d2cf590d3`;
the terminal JSON SHA-256 is
`7d0c6d76e736518c8b6db8f2108ea86c570c09fb95deab27167c1a845bfd8934`.
At that checkpoint, one review remained in this cycle.

Second-reset review 5/5 found malformed allowed-file rows could throw and equal
malformed inventory identities could be admitted. Allowed-file and file-proof
rows now require a nonempty root plus structurally relative path; inventory rows
also require a nonnegative integral length and 64-hex SHA-256. Six focused
content/proof/inventory guards pass. The canonical SHA-256 remains
`7a1d272797402b24a35cd7c6cb54641a459e1f1b26e0d9834e8fd69d2cf590d3`;
the terminal JSON SHA-256 is
`81250a270414779a245031517951898f1faeee296db0464412d81a2cc2d8844a`.
The cycle is exhausted and the corrected bytes require another explicit native-
review budget reset.

The user approved a third reset. Review 1/5 found that an allowed command could
be combined with an unclassified PowerShell/.NET command or member expression.
Those AST nodes now fail closed before effect classification, and N21 proves an
allowed read plus `WriteAllText` returns unknown. The full gate passes 21/21
negatives. The canonical and terminal SHA-256 values are
`a056c1cd376ba8b26128a0252257fe6eb01213346976a580684c7959fee05536`
and `ebfc6acd2a61e30abea1ce039021163427a31d9faa753ef31e1d36e51892d680`.
Four reviews remain in this cycle.

A later separately authorized private one-shot canary used the exact candidate
as a path-bound input and returned a sealed `PASS` / `CANARY_PASS`; the bounded
exact-response check reported no command execution. This tracked document
intentionally omits its private locator, artifact hashes, detailed runtime
state, task/thread identifiers, prompts, and completions. The physical backend
sampling-request count remains `UNKNOWN`. Pre-consumption corrections remain
qualification history, not model evidence. This explicit path-bound canary
does not prove natural-language Skill selection, semantic quality, broad Work
Charter behavior, or Gate 2 acceptance.

The documented sequence placed native review 4 before this canary, but the
canary received its own explicit authorization and ran first. Record that as a
sequence deviation: the result remains valid, consumed, sealed, and non-
retriable. Review 4 subsequently supplied the required independent checkpoint,
but no successor or live matrix is authorized automatically. Final native-
review disposition remains in the cumulative attempt record. This establishes
controller infrastructure only;
Gate 2 remains unaccepted.

Local commit `119aa27fdc7867eb1b19afedc8e71ce3bc87af9b` records this exact
twelve-path controller-stabilization revision. The commit does not alter the
five package blobs, rescore sealed evidence, or accept product candidate
`b965102...`. The local merge gate independently verifies the combined
repository result over governance baseline `f55b15a...`.

### Gate 2 Recovery Boundary

All six sealed execution records and their consumed events remain immutable.
Each successor for exact candidate `b965102...` was a separately authorized
Gate 2 evidence window, not a retry or relabelling of a prior execution. Before
its first model `turn/start`, each bound its exact candidate/controller inputs,
approved model/reasoning envelope, consumption point, and terminal stop
behavior.

The pre-consumption reconciliation must enumerate the required matrix evidence
and prove which retained observations, if any, still have exact source,
loaded-copy, workspace, and controller admissibility. It may preserve and
reference those observations without changing their original terminal records.
Anything missing, invalidated, or not comparable remains `UNKNOWN` and requires
separately authorized evidence collection. Controller qualification failure
before consumption is not product evidence; after consumption, every event is
retained and the window seals on its declared stop condition. The successor
completed that pre-consumption qualification and freeze with zero model turns.
A later explicit authorization permitted exactly one A01 `turn/start` in the
fifth window. Transport failed before a response and that window sealed
`HARD_STOP / UNKNOWN`. Successor-2 then received its own explicit envelope,
consumed A01 plus one assessor turn, and exposed a bounded ordinary-task
surface. Because its command wrapper and failed Git diagnostic were not
controller-admissible, it sealed `SEALED_PARTIAL_HARD_STOP /
CONTROLLER_UNKNOWN`; the assessor returned `DECISION_REQUIRED`. Neither result
may be retried or rescored. Gate 3 remains unavailable until one complete exact-
candidate batch receives independent `ACCEPTED`.

## v0.1.2 Stable And Control SOURCE Identity

The five files exercised by the 2026-08-01 fresh-context batch had these raw
SHA-256 identities:

```text
SKILL.md
  d0c86e80d6f8eec0d91c25f4f0c687d60b1e0821ac823e28cf62777bb1badda2
agents/openai.yaml
  fbc47a69d6eab89492c40d2a9e37718f5c31a5d84f0bb207cdf606279d1efb89
references/coordination-and-recovery.md
  8c944b3434e14e70dea705a8b877b70b497c6f512db8681ff0000f418a270483
references/standard-ope.md
  5a813ce43f334c7e06db69f4c1cdd676bbb8708850a052dbc46887ed0298e0cc
assets/work-charter.md
  1b61f20852a545fb1660a999622e9d85bfbb0521f91945867fd65a98021e5c95
```

During the local commit gate, native semantic review found that the Standard
operating path placed Orchestrator assessment before durable Planner-verdict
recording. The corrected current `references/standard-ope.md` raw SHA-256 is:

```text
09882cbc00de9ace0691471f426eae6abb08e01238cfd36a356ce8d30d837597
```

The other four v0.1.2 control hashes remain as listed above. The ordering correction
was not rerun through the complete fresh-context development matrix, so the
batch below remains exact evidence for the pre-review hash. The later
`d781240...` RC section separately provides exact identity for that revision plus narrow
recording-order and flat non-loading canaries; it does not replace that full
matrix.

## Development Behavior History

### 2026-08-01 — Authority, assessment, and evidence matrix

One repository-scoped development entry exposed the tested five-file SOURCE
as the only discoverable same-named Skill. A fresh identity probe and a later
independent assessor each matched the presented entry and raw `SKILL.md` hash
to the identities above. Preflights with a second same-named copy were excluded
before behavior scoring.

The six behavior groups produced three full passes and three partial results.
Small work stayed Flat, midstream symptoms produced only a proposal, and the
Planner/Executor loop passed. Cold recovery stopped safely but returned an
incomplete recovery summary. Standard O/P/E preserved the three roles, sole
writer, two acceptance layers, and the Phase Two stop, but one Planner
mislabeled its return route; the controller revalidated and contained the
error. The four recovery variants scored authority ordering partial,
assessment recording pass, source/evidence drift pass, and uncertain
delivery/writer recovery partial. No variant continued unsafely.

A fresh read-only assessor independently rechecked the bounded artifacts and
returned `ACCEPTED` for recording the tested batch without a SOURCE correction
at that hash. The
[sanitized result](../../../evals/results/2026-08-01-work-charter-authority-assessment-evidence-forward-tests.md)
preserves every partial grade and the attribution limits.

After the batch, the temporary development entry was removed, the pre-test
stable installation was restored byte-for-byte, and a fresh probe observed
only that ordinary stable entry with all five historical stable hashes. This
is restoration evidence, not current-SOURCE stable behavior.

This establishes tested `SOURCE` plus controlled `DEV_DISCOVERY` behavior
evidence only. Repository/global rules and the Harness supplied task routing,
permission, lifecycle, and controller enforcement, so the run is not
standalone causal proof. It is not current `RC_INSTALL`, stable-install,
real-project, cross-Harness, token, deterministic-lock, or release evidence.

### 2026-07-31 — Authority, assessment, and evidence hardening

[Decision 0016](../../decisions/0016-work-charter-authority-assessment-and-evidence-integrity.md)
accepts portable rules for comparable authority revisions, uncertain
non-idempotent delivery, assessment recording, actual-result-surface evidence,
source-bound invalidation, and advisory writer-conflict recovery. Current
SOURCE implements those rules without adding a package file, trigger, role,
verdict, lock, or lifecycle identity.

The new
[recovery-integrity case](../../../evals/cases/work-charter-recovery-integrity.md)
contains four independent read-only variants. Its deterministic precondition
proves the intended stale/new authority pair, pending durable assessment,
revision-bound one-shot evidence, an ignored result omitted from ordinary Git
status but visible to controller inspection, uncertain delivery, and unknown
writer delta. Existing Planner/Executor and Standard cases now require the
assessment recording boundary.

The current Skill validator, repository checker, and all fifteen fixture
checks pass. This is implementation, structural, and fixture-precondition
evidence only. No fresh-context agent has yet exercised the new behavior, so
the earlier behavior, DEV, RC, and stable results remain historical evidence
for their exact recorded revisions rather than proof for current SOURCE.

### 2026-07-29 — M2R SOURCE-assisted matrix and acceptance

Five groups plus two controlled negative variants ran in fresh contexts:

- small work stayed flat and passed two focused tests;
- midstream adoption remained a non-mutating proposal using an existing
  durable owner;
- cold recovery classified branch, commit, index, evidence, and writer drift
  and stopped before write;
- separate Planner/Executor completed one bounded correction, five tests, and
  independent `ACCEPTED`;
- Standard O/P/E completed one bounded correction, four tests, independent
  Planner `ACCEPTED`, dormant Orchestrator behavior, and a stop before
  unapproved Phase Two; and
- stricter-policy and unavailable-delivery variants degraded visibly without
  silently activating Standard.

Controller manifests found only intended fixture deltas and removed the unique
ignored run root. An independent Planner recomputed all five normalized hashes,
reran the deterministic checks, and returned `ACCEPTED`. This proves
SOURCE-assisted behavior only, not native selection or loaded-copy identity.
The [M2R result](../../../evals/results/2026-07-29-work-charter-m2r-forward-tests.md)
owns the exact prompts' sanitized boundaries, manifests, tests, and
limitations.

### 2026-07-30 — Native DEV_DISCOVERY P/E and Standard

Two explicit canaries used the sole repository-scoped development entry
resolving to canonical SOURCE. Every role selection record identified the same
five files, and a controller independently resolved and rehashed the target.

The P/E run used one read-only Planner and one sole-writer Executor, changed
exactly four allowed fixture files, passed five tests at Executor, Planner, and
controller layers, and ended `ACCEPTED` without correction. The Standard run
used one Orchestrator, Planner, and Executor, changed exactly four allowed
files, passed four tests at all three layers, kept the Orchestrator dormant
during implementation, and stopped before Phase Two.

Task-specific discovery and fixture copies were removed; SOURCE and repository
Git state remained unchanged. This establishes controlled explicit
DEV_DISCOVERY selection and role delivery, not implicit telemetry, installed
identity, deterministic permissions, or general Harness routing.

## Candidate And Stable Evidence

### 2026-08-01 — `v0.1.2` stable installed-copy proof

The immutable repository tag `v0.1.2` resolved publicly to
`ceed607152849775b981c54add74bfa30d858e4d`. `$skill-installer` materialized
all three packages from that exact tag into an isolated staging root before
the approved stable update. The Work Charter candidate contained exactly five
ordinary non-reparse files; every file matched its tag Git blob, decoded as
strict UTF-8 without BOM, and used LF with one final newline. The installed
stable package repeated the same identity and passed the Skill validator.

An isolated repository-scoped `.agents/skills/work-charter` entry resolved to
the verified stable target. A fresh read-only recovery process selected that
sole same-named entry, and native events recorded reads of the stable
`SKILL.md`, `references/coordination-and-recovery.md`, and
`references/standard-ope.md`. It allowed only durable Planner-verdict recording
and verification, kept Orchestrator reliance blocked, and stopped before Phase
Two. The shared flat negative exposed all three stable entries but executed no
Skill or reference read. Controller-side discovery-target and Git-blob checks,
rather than model-reported hashes, own revision identity.

The prior `v0.1.1` stable package was preserved as an exact rollback copy.
Persistent Codex configuration, SOURCE, and tracked repository state did not
change during installation or canaries. This proves current stable identity,
flat non-loading, and one narrow fail-closed recovery boundary; it does not
rerun complete Standard role delivery at the stable layer or prove broad
implicit telemetry, deterministic delivery or locking, real-project efficacy,
or cross-Harness parity. Repository tag, stable-set, and GitHub Release
evidence is recorded in [root Verification](../../VERIFICATION.md).

### 2026-08-01 — Current `c42eef3` full Standard RC

`$skill-installer` materialized the five-file package from public exact commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`. Every candidate file matched its
Git blob and current raw hash, decoded as strict UTF-8 without BOM, and was an
ordinary non-reparse file. The candidate validator passed, and the only
same-named entry in the counted native scope resolved to that RC.

One flat negative did not load Work Charter. The positive path used one
Orchestrator, one Planner, and one sole-writer Executor. The Executor changed
exactly four authorized fixture files and passed seven focused tests. The
Planner independently returned `ACCEPTED`; the Executor durably recorded and
verified that verdict before the Orchestrator relied on it. The Orchestrator
then returned `ACCEPTED`, and the Executor durably recorded and verified that
assessment. Phase One closed and Phase Two did not start. The controller passed
seven final assertions with no extra writer, role, file, Git, installation, or
external action.

Read-only capability stops, controller calibration probes, and several
pre-behavior helper or transport errors were excluded. Temporary process trust
blocks and the sole discovery Junction were removed under explicit cleanup
authority, only the task-owned ignored root was removed, and sibling ignored
roots remained unchanged. Stable `v0.1.1`, SOURCE, tracked repository state,
and release refs did not change during the run.

Verdict: `READY_FOR_RELEASE_CANDIDATE` for exact commit `c42eef3...`, bounded
flat non-loading, and one complete synthetic Standard Phase One with ordered
durable Planner and Orchestrator assessment recording. Earlier partial grades
remain valid. This does not prove deterministic delivery or writer locks,
and at that checkpoint did not prove current stable behavior, broad triggers,
real-project efficacy, cost or token
improvement, cross-Harness parity, tag, or release. The
[sanitized result](../../../evals/results/2026-08-01-work-charter-c42eef3-full-standard-rc.md)
owns the detailed attempts and limits.

### 2026-08-01 — Current `d781240` exact-commit RC

Public commit `d7812408fc55a3fad79ae02a8d31665a2255b99c` was cleanly
materialized through `$skill-installer` into a new ignored Work Charter-only
`RC_INSTALL`. Controller checks proved the exact five-file package, Git-blob
equality, the current raw hashes above, strict UTF-8 without BOM, zero internal
reparse points, and a passing candidate validator.

A clean nested synthetic scope exposed one candidate-backed repository entry.
The known user-level stable copy was disabled only for each ephemeral process
through an exact-path override; no persistent configuration changed. Native
events directly observed the positive canary reading the candidate entry and
current Standard reference.

The explicit read-only canary correctly stopped both Orchestrator reliance and
Phase Two while durable Planner-verdict recording was pending, and limited the
next action to the authorized governance recording plus verification. A flat
negative canary returned `703` without a command execution or Skill load. Both
counted processes exited `0`; the synthetic workspace stayed clean.

One TOML-quoting transport attempt failed before Codex execution and is
excluded. Candidate files, editable SOURCE, repository Git state, and the
complete earlier `v0.1.1` stable manifest remained unchanged. The
[sanitized result](../../../evals/results/2026-08-01-work-charter-d781240-exact-commit-rc.md)
owns the exact identity, behavior, exclusion, and limitation record.

This verifies the then-current exact-commit RC identity and a narrow Standard
behavior boundary. It does not prove implicit Standard selection, full role
delivery, stable behavior for this revision, broad telemetry, deterministic
locking, real-project efficacy, cross-Harness behavior, tag readiness, or
release readiness.

At public commit
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`, `$skill-installer`
materialized an ordinary five-file `RC_INSTALL` that matched Git blobs and the
recorded hashes and was the only same-named Skill in scope.

An uncontaminated positive canary did not name Work Charter or an expected
profile. Continuity and recovery symptoms implicitly selected the RC entry and
only the recovery reference, proposed P/E cold recovery, and stopped before
roles or writes. A flat arithmetic canary returned `703` without loading the
Skill.

Two attempts were excluded: a network-blocked launch produced no semantic
result; a name-contaminated, agent-side-hash attempt loaded the candidate but
could not support implicit-trigger or cost claims. Controller-side identity,
not role names or self-hashing, owns the counted revision proof.

The coherent `v0.1.1` candidate
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42` repeated exact-commit identity.
Immutable tag `v0.1.1` resolved to that commit, and the tag-pinned stable entry
was explicitly loaded in a fresh read-only process and chose Flat for a small
task. Standard behavior was not rerun at RC or stable layers.

Repository-level shared candidate, tag, installation, and release evidence is
owned by [root Verification](../../VERIFICATION.md).

### 2026-08-06 — Strict Read And Auxiliary Observation Regression

Local commit `191cd1f841468d6585382a64aef8d81a9aff7550`, now fast-forward
integrated into local `main`, adds a strict fallback for
the live record shape where one completed action is `unknown`: only an exact
single `Get-Content -Raw` can use aggregated output as evidence, and only when
its UTF-8 length/SHA-256 matches the authorized file after removal of at most
one transport-added final newline. Compound, partial, missing-output, and
content-mismatched reads receive no required-read credit.

Read-only path listing/existence operations are a separate auxiliary class.
They require a policy-listed root and command-linked unchanged inventory, never
populate the required-read set, and fail closed on unauthorized scope or
observed drift. Auxiliary path operations target only the exact policy-listed
root, recursive listing is rejected, and explicit empty before/after inventories
compare equal. Inventory-linked command IDs must name exactly one record across
the complete command set and use ordinal, case-sensitive linkage throughout.
Variable-bearing display transforms remain unknown. The 19/19 evidence-surface
suite covers both paths, conflicting and matching duplicate aliases,
inventory-link ambiguity,
outer/action command disagreement, root/recursion/empty-inventory handling,
plus a pre-approval read
violation. Existing historical 11/11, negative 31/31, and
metamorphic 4/4 suites remain unchanged and pass; the repository fixture gate
passes 17/17, and two public-mode runs have canonical SHA-256
`a4b1de1b5430e7d239c057175ada81db8f32336bbddfd63d30a14ff0fd8aa75d`.

Native review cycle 1 review 1/5 used `gpt-5.6-terra` at `high` reasoning over
the uncommitted diff. An earlier unsupported CLI argument combination was
rejected before semantic review and is not counted. The completed review found
two P1 gaps: contradictory snake/camel aliases could be silently selected, and
the exact-raw-read fallback checked only the action command rather than the
executed outer command as well. The controller now accepts duplicate aliases
only when their canonical values agree and requires both command forms to prove
the same exact raw read. E10-E13 lock the corrections. Review 2/5 found two more
P1 gaps: recursive auxiliary listing could cross a contained reparse point, and
empty inventory arrays aborted parameter binding. The controller now rejects
recursion and accepts explicit empty/empty inventories; E14-E15 lock both. A
sandboxed launch before review 2 failed on blocked network and is excluded as
transport qualification. Review 3/5 found one further P1: a direct subordinate
path could traverse a contained reparse point. The controller now authorizes
only the exact root path; E16 proves a subordinate path is rejected as a
violation. Since this fix changed the reviewed bytes, the current authorized
cycle must inspect the corrected diff before the native-review gate can close.

Review 4/5 materially covered staged, unstaged, and untracked changes and
returned no actionable correctness issue. It reran the controller regression
and fixture suite successfully. This review-history synchronization was the only
later tracked mutation. Review 5/5 found one P1: an inventory-linked auxiliary
command ID could collide with a non-auxiliary record. Global command-ID
cardinality and E17 now reject that ambiguity. The user approved one reset for
the same commit attempt. Reset-cycle review 1/5 found two P1 gaps: a transform
could expose an environment variable, and case-distinct command IDs could share
one case-insensitive inventory entry. Variable-bearing script shapes now remain
unknown, ordinal inventory linkage plus E18-E19 lock both corrections, and
focused verification passes 19/19. The fixes changed reviewed bytes, so a later
completed review in the authorized reset cycle had to inspect the corrected
diff. Reset-cycle review 2/5 materially covered staged, unstaged, and untracked
changes, independently reran the controller and fixture suites, and returned no
actionable correctness issue. This review-history synchronization is the only
later tracked mutation; native-review gate satisfaction is determined by a
completed semantic review over these final bytes.

The evaluation contract also distinguishes matrix-wide shared contamination
from a cell-local transport/visibility gap. The latter seals only that
independently planned cell `UNKNOWN` after consumption, without retry or
relabel; required reference-cell absence still blocks acceptance. The delta
called no Gate 2 behavior model or assessor, read no private manifest, and
changed no Work Charter package blob or sealed execution. Native review remains
code-review evidence only.

The commit contains the reviewed 14-path controller/evaluation and mapped-
documentation correction from baseline `79806bf...`. Git ancestry and a clean
working tree were verified after fast-forward integration. This local Git
state does not create an `RC_INSTALL`, behavior-model result, assessor verdict,
candidate acceptance, push, installation, release, or Gate 3 authority.

### 2026-08-07 — Fourth Sealed Execution, Successor Qualification, And A01 Hard Stop

Recovery reconciliation found a fourth exact-`b965102...` execution after the
three carriers previously summarized here. It consumed one A01 `Sol/high`
turn, then sealed a partial hard stop because its private normalization omitted
the command item's existing `aggregatedOutput`. The deterministic controller
therefore retained `CONTROLLER_UNKNOWN` for the raw read, and the fresh
Terra/high assessor returned `DECISION_REQUIRED`. That execution is not retried,
rescored, or relabelled; all four terminal records and prior correction history
remain unchanged.

The separately authorized ignored successor preserves those four predecessor
hash bindings and the same logical subject/material contract. It binds exact
candidate `b965102...`, control `ceed607...`, controller `191cd1f...`, the
pinned Codex executable, isolated candidate/control catalogs and `CODEX_HOME`,
27 cells, a maximum 33 fresh contexts and 39 `turn/start` events with no retry,
and one fresh Terra/high read-only assessor. The only execution-adapter delta
preserves the app-server command item's `aggregatedOutput` in normalized
evidence; exact matching output becomes admissible through `191cd1f...`, while
missing or mismatched output remains `CONTROLLER_UNKNOWN`.

The exact public controller regression passes, including 19/19 evidence-surface
cases. Focused adapter fallback checks cover matching, missing, and mismatched
output; the core suite passes 15/15. The isolated runtime capability probes use
`thread/start` only and record zero model turns. Full offline acceptance,
prefreeze reconciliation, freeze, and four post-freeze prestart probes pass
without a behavior-model or assessor `turn/start`. Two earlier focused outputs
are retained as test-contract mismatches: one synthetic input accidentally used
a proof-sufficient `-LiteralPath` shape, and one test retained an obsolete
upstream query after the successor moved to local `main`. Neither is product
evidence or another adapter behavior change.
The first full-suite output is also retained: an empty `runs/` placeholder made
the pre-consumption absence assertion fail; after removing that empty
placeholder, full run 2 passed 22/22 with zero model turns.

At that checkpoint this established only a qualified, frozen pre-consumption
carrier. It created no fifth behavior execution, candidate acceptance, Gate 3
authority, Git authority, installation, release, or cleanup authority, and its
first fresh A01 `turn/start` still required an explicit user decision.

The user later authorized exactly one A01 `turn/start`, with no retry and a
mandatory stop on every terminal outcome. The Harness accepted one such event,
but the model transport failed before any model response or token usage was
observed. No command, Skill read, Work Charter behavior, A02, later cell, or
independent assessor followed. The successor sealed `HARD_STOP / UNKNOWN` and
stopped. This is the fifth consumed execution record for the unchanged logical
subject, but not candidate behavior evidence, a product defect, candidate
acceptance, or Gate 3 authority. The event and terminal disposition are sealed
and cannot be retried, relabelled, or reset through another carrier.

### 2026-08-07 — Successor-2 A01 Compatibility Hard Stop

A new successor-2 preserved the five earlier sealed records and repeated the
same exact candidate, control, and tracked-controller identities. It passed its
own materialization, isolated-catalog, no-turn capability, focused/full
offline, freeze, and prestart gates before entering the separately authorized
model envelope.

One `Sol/high` A01 turn completed. It did not read or select Work Charter, kept
the task flat, identified the intended one-line correction, reported that the
read-only policy prevented applying and verifying it, and changed none of the
three reconciled inventories. Its command records used a path-qualified
PowerShell `-Command` wrapper without `-NoProfile`; the action records exposed
only inner commands as `type: unknown`, and one Git read failed. The tracked
controller therefore returned `CONTROLLER_UNKNOWN` rather than treating those
records as admitted effects. The matrix sealed before A02. One authorized
`Terra/high` assessor then returned `DECISION_REQUIRED` because 0/27 cells were
controller-complete. Combined reported usage was 178,310 tokens; no cost,
efficacy, or token-saving claim follows.

The compatibility disposition is runner-first and fail closed. A future
isolated app-server runner must set `allow_login_shell=false` and prove that its
pinned executable emits the required `-NoProfile` wrapper before consuming a
Gate 2 turn. N31 now asserts the observed missing-profile consequences. N32
adds the separate failed-read boundary for a parsed Git-read shape with
matching outer/action semantics; N33 pairs it with a shadow Git identity. Both
remain `CONTROLLER_UNKNOWN` after a nonzero exit and are not mislabeled as an
attempted write or mutation. Failed records stop before resolved-identity
admission, so neither case proves or claims identity validation. Public offline
mode passes 33/33 negatives. No controller relaxation, Work Charter SOURCE
change, successor authorization, or retrospective rescore follows.

## Required Checks

```text
python -B <skill-creator>/scripts/quick_validate.py skills/work-charter
pwsh -NoProfile -File evals/check-codex-evidence-controller.ps1
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
PowerShell parser check across evals/**/*.ps1 plus the controller module
git diff --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

Role separation is not loaded-copy identity. SOURCE-assisted,
DEV_DISCOVERY, RC_INSTALL, and STABLE_INSTALL evidence must remain distinct.
