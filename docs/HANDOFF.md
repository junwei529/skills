# Repository Handoff

Last updated: 2026-08-10

## Snapshot

- Repository: Agent Workflow Skills
- Current exact Work Charter product candidate: local commit
  `07a9f1c436213a5c377610c9157b7c6a76c5d4c1`; its D31 five-file package is
  frozen for the current Campaign and remains unaccepted at Gate 2
- Released package identity: immutable `v0.1.2` at
  `ceed607152849775b981c54add74bfa30d858e4d`
- GitHub Release:
  [`v0.1.2 — Stable three-Skill release`](https://github.com/junwei529/skills/releases/tag/v0.1.2),
  marked Latest
- Stable installed set: Project Docs 6 files, Work Charter 5 files, PowerShell
  5 files, each matching the `v0.1.2` Git blobs
- Rollback identity: immutable `v0.1.1` retained as a separately verified
  three-package backup
- Writer boundary: the bounded D37 attribution writer owns only the seven
  existing mapped documentation owners, deterministic checks, native-review
  fixes, and one local documentation commit. D37's three one-shot turns are
  complete. The writer window ends with that commit; push, installation, tag,
  release, stable update, cleanup, full Gate 2, Skill SOURCE, and cross-Skill
  product work remain excluded

The `v0.1.2` tag remains fixed at the release-preparation commit. The later
documentation commit records already-completed tag, stable-install, canary, and
GitHub Release facts; it is an evidence descendant and must not move or replace
the released tag.

## Release Completion

The public release lifecycle is complete for `v0.1.2`:

1. all three current package revisions independently reached exact-commit RC
   readiness at public `c42eef3...`;
2. release-preparation commit `ceed607...` preserved the exact 6/5/5 package
   blobs and passed its own clean public exact-commit installer and loaded-copy
   gate;
3. immutable tag `v0.1.2` was created and pushed at `ceed607...`;
4. `$skill-installer` materialized all three tag paths into isolated staging,
   with exact Git-blob, UTF-8/no-BOM/LF/final-newline, non-reparse, and validator
   checks;
5. the prior `v0.1.1` stable set was verified and retained as rollback before
   the staged `v0.1.2` set replaced it;
6. isolated repository-scoped discovery entries resolved to the verified
   stable targets; fresh identity and behavior canaries passed for all three
   Skills, and a shared ordinary-task negative loaded none; and
7. GitHub Release `v0.1.2` was published from the immutable tag and verified as
   Latest.

No package was edited in an RC, staging, stable, or rollback environment.
Persistent Codex configuration, Skill SOURCE, tracked repository state, and the
tag did not change during the stable installation or canaries.

## 2026-08-02 Documentation Decisions And Gate 0 Baseline

The 2026-08-02 user-authorized documentation task accepted and operationalized
[Decision 0017](decisions/0017-capability-delta-skill-development.md) as a
prospective capability-delta rule for new Skills and material selection or
behavior revisions. It also clarified [Decision 0003](decisions/0003-source-install-release-boundaries.md):
the shared v0.1 version is a repository release-set identity, while per-Skill
package deltas, maturity, and evidence remain independent. It synchronized the
repository instructions, public entry points, shared specification,
architecture, development Runbook, evaluation contract, provenance/data
boundary, authority map, index, repository verification, and this handoff.

[Decision 0018](decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md)
then applies that capability-delta method to target Work Charter `v0.2.0`.
Gate 1 now implements its natural-language entry, first-read authorization,
proportional protection, durable re-entry, managed-workstream and multi-
worktree reconciliation, four routes, and staged eval definitions in the
existing five-file package. Stable behavior and release identity remain
unchanged at `v0.1.2`.

On 2026-08-03, exact candidate `206c497...` returned from incomplete Gate 2
without acceptance after exposing a task-convergence ambiguity. The accepted
correction binds history to the logical Charter subject and stable checkpoint,
separates qualification from evidence consumption, preserves predecessor
history, and keeps Work Charter, delivery/transport, and native-review budgets
independent. That correction became pushed successor
`92a8c04554e4021ad3c998c97fd733f6554e048f`; the old candidate and its events
remain historical.

The successor passed isolated qualification and began its `Sol/high` reference
matrix. A01-A04 consumed four turns. A03 directly named Work Charter and loaded
the exact candidate. A04 used an indirect installed-Skills request, performed
no command or project read, and proposed a bounded scope, but claimed Work
Charter was selected without loading its `SKILL.md`. Gate 2 hard-stopped; A05-
C04, contrasts, and independent assessment never started. The user then
accepted `WC-AR-D25`: indirect intent must remain an honest metadata proposal,
confirmation loads the full Skill, and project inspection still requires an
approved scope. No prior behavior result transfers to the conditional correction.

That two-stage revision was committed and pushed as exact `72db7e9...`. One
later fixed-turn Standard probe crossed its declared one-shot consumption point
once and completed four fresh primary sessions. It created no subagent
activity, sealed `VIOLATION` for the top level and all three roles, left A16
unexecuted, and permits no retry or retrospective rescore. The product gap is
missing conditional package loading; exact-phrase semantic checks, shell-
fragment attribution, and repeated static inventories are prospective
controller-calibration issues rather than reasons to rewrite the sealed result.

The accepted documentation change set comprises:

- `AGENTS.md`;
- `README.md`;
- `README.zh-CN.md`;
- `docs/AUTHORITY.md`;
- `docs/ARCHITECTURE.md`;
- `docs/HANDOFF.md`;
- `docs/INDEX.md`;
- `docs/PROVENANCE.md`;
- `docs/ROADMAP.md`;
- `docs/RUNBOOK.md`;
- `docs/SPEC.md`;
- `docs/STATUS.md`;
- `docs/VERIFICATION.md`;
- `docs/decisions/0003-source-install-release-boundaries.md`;
- `docs/decisions/0017-capability-delta-skill-development.md`;
- `docs/decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md`;
- `docs/skills/work-charter/STATE.md`;
- `evals/README.md`.

Gate 0 is committed at clean baseline
`763a15ee76bc71dd5e16fc22f32966cb0c8c3488`. Gate 1 uses branch
`codex/work-charter-v0.2` and one task-dedicated writer. Its committed
implementation and convergence history now culminates in pushed exact SOURCE
`72db7e9...`. The current authorized correction changes only one package file
plus mapped existing decision, design, state, evidence, evaluation, public-entry,
repository-status, and recovery consumers. It adds no file, package component,
case, fixture, or checker. Discovery, installation, stable tag, and release
identities remain untouched.

Retained ignored evaluation workspaces contain descendant discovery roots from
earlier tests. They are not active merely because a task starts at the
repository root, but a future task started inside one can expose historical or
same-named copies. Re-enumerate the exact working-directory-to-root discovery
chain and fail closed before reusing any retained workspace; do not rely on
this snapshot's contents or counts.

## 2026-08-04 Documentation-Impact Closure Rule

After repeated native-review corrections added existing documentation
consumers that an early file list had omitted, the user authorized a separate
project-governance correction before resuming the paused Work Charter change.
The correction distinguishes the authorized change envelope, intended change
set, and actual review target, and requires a fact-first documentation-impact
closure before the first native review.

The governance correction started with three existing documentation files.
Current pre-review qualification also found that the repository checker was
incorrectly treating the ignored `.code-review-graph` cache as publication
source. The complete intended change set is therefore four existing files:

- `AGENTS.md` for the short mandatory repository rule;
- `docs/RUNBOOK.md` for the owner/consumer matrix, closure procedure, and the
  clarified canonical-SOURCE development step;
- this handoff for writer, dirty-scope, and recovery continuity; and
- `scripts/check_repository.py` for the minimal generated-cache exclusion.

The impact audit classified `AUTHORITY`, Decisions 0015 and 0017, `INDEX`,
`SPEC`, `ARCHITECTURE`, `STATUS`, `VERIFICATION`, `ROADMAP`, the root README
pair, per-Skill documents, and `evals` as `CHECKED_NO_CHANGE` or
`NOT_APPLICABLE`: this correction changes development procedure and the
checker's non-source traversal boundary, not a public Skill, product contract,
navigation route, milestone, evaluation contract, evidence claim, candidate,
installation, or release state. It adds no file or product behavior.

The four-file governance/checker correction was committed locally as
`f55b15a...`. Its integration overlap is limited to this handoff and the
repository checker; the checker preserves both the generated-cache exclusion
and the phase branch's new expected cases and fixtures. The user authorized one
semantic local merge with deterministic checks and native review. No push, new
Work Charter product delta, behavior-model call, installation, tag, release,
or cleanup is authorized.

## 2026-08-05 Controller Stabilization Record

Local commit `119aa27...` records the tracked controller stabilization. The
detailed text below is its pre-commit evidence history, not a current review
counter or renewed action authority. This integration does not rerun its sealed
canary, redefine the product candidate, or convert infrastructure evidence into
Work Charter behavior acceptance.

Exact product candidate `b965102...` keeps the same five Work Charter package
blobs and remains unaccepted at Gate 2. Its sealed execution history and exact
residual limits belong to the Work Charter State and Verification owners. No
record may be retried, rescored, relabelled, or reset, and no new evaluation
window follows from this handoff.

The stabilization commit changes exactly:

- `evals/codex-evidence-controller.psm1`;
- `evals/check-codex-evidence-controller.ps1`;
- `evals/codex-evidence-controller-cases.json`;
- `evals/results/2026-08-05-work-charter-controller-stabilization.md`;
- `evals/check-fixtures.ps1`;
- `evals/README.md`;
- `evals/results/README.md`;
- `docs/skills/work-charter/STATE.md`;
- `docs/skills/work-charter/VERIFICATION.md`;
- `docs/VERIFICATION.md`;
- `docs/STATUS.md`; and
- this handoff.

The tracked module is the sole normalizer/adjudicator core for preflight,
runtime, historical-import, and terminal-stage entry. Its offline regression
uses sanitized structural cases whose public logical source keys, redacted selector
projections, complete root-normalized generated inputs, and expected result
contracts are jointly hash-bound before controller invocation. Exact revision
blobs own both five-file package manifests. Physical sealed identities remain
in a separately supplied ignored private manifest. On explicit local
verification its key set must match the eight public logical keys; locators
must be contained, ordinary, and non-reparse, and one
held read stream supplies the length, hash, strict UTF-8 JSON, and selector
projection. This is controller qualification, not Work Charter behavior
acceptance. The corrections prevent failed execution, effect-changing,
unauthorized, or signature-verifying Git arguments, partial file reads, or
generated-contract drift from reaching `ADMISSIBLE`.

Native semantic review 1/5 covered all twelve paths and produced four findings:
Git signature verification, package-manifest derivation, historical-source
binding, and sealed-locator containment. Native semantic review 2/5 confirmed
the first two corrections and found that the generated output contract was not
bound, sealed bytes were hashed and parsed through separate pathname reads,
and the resolver lacked a real-reparse regression. The user authorized both
same-scope correction rounds. The current gate now includes 3/3 generated-
contract drift guards, a one-buffer capture guard, and a platform-selected real
directory-link resolver guard with confirmed nonrecursive link removal. The
source selects Junction on Windows and SymbolicLink otherwise; current-host
evidence proves the Windows branch, while non-Windows runtime remains
`UNKNOWN`. Native semantic review 3/5 then raised valid adversarial-concurrency
and root-lifecycle findings. The user selected quiescent offline single-writer
operation: no concurrent repository, `.eval-runs`, sealed-input, or path-
topology mutation is authorized during a check. The implementation now
validates the exact ordinary run root before scratch creation, revalidates root,
scratch, and descendants before recursive cleanup, and verifies cleanup
postconditions. It does not claim no-follow resistance to hostile swaps wholly
between validations; that remains unsupported/`UNKNOWN`. Native review 4 and a
semantic assessor did not run in that correction. Review 4 later found two
external-input type gaps: string role authorization could become truthy, and
malformed nested-turn counts could throw. The existing controller now accepts
only actual Boolean authorization, accepts only nonnegative integral counts,
and returns `CONTROLLER_UNKNOWN` for invalid types. Two focused guards cover
those paths without adding a case, fixture, or product contract.
After the first review cycle completed 5/5 and the user reset its budget for
the same commit attempt, reset-cycle review 1 found two Git-read P1 gaps. The
controller could admit `git status` without disabling optional index writes and
could admit Git reads without disabling a configured external pager. Every
admitted Git read now requires global `--no-pager`; `git status` additionally
requires global `--no-optional-locks`. Three focused guards cover the missing-
flag and bounded-positive matrices. R02/R04 generated contracts and bindings
were re-hashed for the safer synthetic command shape; their historical verdicts
and sealed source identities remain unchanged.
Reset-cycle review 2 then found one P1 content-proof gap: matching malformed
SHA-256 strings could be admitted, and malformed length values could throw.
The controller now validates nonnegative integral length and 64-hex SHA-256
shape independently for each allowed-file policy row and each observed read
proof before comparison. Three focused guards cover malformed policy,
malformed proof, and matching-malformed inputs without changing historical
contracts, sealed evidence, cases, or fixtures.
Reset-cycle review 3 found two P1 cardinality gaps and one P2 exit-code typing
gap. Duplicate allowed-file or file-proof keys could overwrite contradictory
rows, and string `"0"` could be coerced into a successful completed command.
Map construction now records duplicates as explicit unknowns without
overwriting, and completed commands require an actual integral exit code equal
to zero. Three focused guards cover both duplicate families plus string,
positive, negative, and numeric-zero exit forms.
Reset-cycle review 4 found one P1 external-execution gap: `git cat-file
--filters` or `--filters=...` could run configured content filters. Both forms
now fail closed under `git_external_input_or_execution_not_admissible`.
Formal negative N16 raises the aggregate to 16/16 without changing any
historical verdict, sealed input, SOURCE, case, fixture, or product package.
Reset-cycle review 5 found one further P1 external-execution path: a configured
`core.fsmonitor` hook could run during an otherwise admitted `git status`.
Status now requires command-local `-c core.fsmonitor=false` in addition to
`--no-pager` and `--no-optional-locks`. Four Git-read safety guards pass. R02
and R04 were re-bound to the safer generated commands without changing their
historical verdicts or sealed source identities.
The user then approved a second budget reset for the same commit attempt.
Second-reset review 1 found `git remote -v set-url ...` could be admitted as a
remote listing solely because `-v` appeared. Only exact `remote -v` or
`remote --verbose` listing shapes are now admitted; any extra remote arguments
fail closed. Five Git-read safety guards pass without changing historical
verdicts, sealed inputs, SOURCE, cases, fixtures, or product package blobs.
Second-reset review 2 found two P1 gaps. Construction order did not require the
manifest before reconciliation, and command leaf names did not prove what
PowerShell actually resolved. N17 now rejects reconciliation before manifest.
Each completed command record must also carry one resolved-command identity
whose family, kind, and SHA-256 match a policy-pinned trusted identity; missing,
shadowed, or untrusted records fail closed with 3/3 focused guards. This is an
offline evidence-record contract, not live resolver-collector proof. All 11
historical generated contracts and bindings were re-hashed without changing
their verdicts or sealed source identities.
Second-reset review 3 found two Git external-execution paths plus one unsafe
assessor Boolean coercion and incomplete aggregate failure diagnostics. Branch
reads now admit only exact `--show-current` or `--list` shapes; admitted `log`
and `show` require `-c log.showSignature=false`; empty command-family results
and non-Boolean assessor requests fail closed. The terminal failure list now
enumerates every group and scalar gate used by the verdict. The full gate passes
7/7 Git-read safety, 3/3 external-input type, 3/3 command-resolution, 17/17
negative, and 8/8 sealed checks. Its canonical hash remains
`2c083cf2c40ec86e2eb7688e5edc3ae18408539f9f71f7c424233263f2c7c834`;
its terminal JSON hash is
`9e94d7b0313be99b275dbefd1c6a4cea43d2314a746daf23b7e0fb34502a69b1`.
Second-reset review 4 found that execution-affecting PowerShell wrapper options
could be ignored and that repeated or post-seal construction events could be
admitted. Wrapper parsing now accepts only inert switches before one final
constant command; construction requires exactly one four-stage ordered
sequence. N18-N20 raise the passing negative aggregate to 20/20, with the safe
wrapper also covered by the trusted command-resolution positive. Historical
verdicts and sealed inputs are unchanged. The canonical and terminal hashes are
`7a1d272797402b24a35cd7c6cb54641a459e1f1b26e0d9834e8fd69d2cf590d3`
and `7d0c6d76e736518c8b6db8f2108ea86c570c09fb95deab27167c1a845bfd8934`.
Second-reset review 5 found malformed allowed-file rows could throw and equal
malformed inventory rows could pass. Allowed/proof row shapes and inventory
relative-path/length/SHA-256 identities now fail closed; 6/6 focused guards
pass. The canonical hash remains
`7a1d272797402b24a35cd7c6cb54641a459e1f1b26e0d9834e8fd69d2cf590d3`;
the terminal hash is
`81250a270414779a245031517951898f1faeee296db0464412d81a2cc2d8844a`.
The cycle is exhausted and another native review requires a new explicit reset.
The user approved a third reset. Its review 1 found that classified allowed
commands could be combined with unclassified PowerShell/.NET expressions.
Command and member expressions/invocations now fail closed; N21 covers an
allowed read followed by `WriteAllText`, and 21/21 negatives pass. The
canonical and terminal hashes are
`a056c1cd376ba8b26128a0252257fe6eb01213346976a580684c7959fee05536`
and `ebfc6acd2a61e30abea1ce039021163427a31d9faa753ef31e1d36e51892d680`.
Third-reset review 2 found outer wrapper redirection was lost when extracting
the inner command. Outer redirection now fails closed; N22 proves an allowed
inner read plus `> redirected.txt` returns unknown. Twenty-two negatives pass;
the canonical and terminal hashes are
`8d25dceec7dfbece7d5830c373bf3fcc9f5e6f13d9e5dae1a4a0b6bcea430152`
and `af40309f14c28d8f1ca8c8fd2bd688fb9016735c9f2a8c26faa9db6aed98b1d9`.

Third-reset review 3 found that admitted `log`, `show`, or `diff` commands
could still invoke a configured textconv process and that canonical JSON key
order used the current culture. Those Git reads now require explicit
`--no-textconv`; N23 covers the missing-disable path, and canonical dictionary
and object keys use ordinal order. The full gate passes 23/23 negatives, 8/8
Git-read safety guards, one three-culture ordinal guard, and 8/8 sealed inputs.
The canonical and terminal hashes are
`cded4de887713a3c0424b59d9aea490e05af159e547d49c781b7b22cd90a97b6`
and `89f0d8af2a12e431376ba7fd5d79a0fabef7fed3084e9d39a350cecd6ce59938`.

Third-reset review 4 found that wrapper recognition trusted the leaf name
`pwsh.exe` while the existing resolved identity covered only the extracted
inner command family. Valid wrappers now require a separate policy-pinned
native-application identity in addition to the inner command identity. N24
uses a path-qualified lookalike with an untrusted wrapper identity; missing and
shadowed wrapper identities have focused guards. The full gate passes 24/24
negatives, 5/5 command-resolution guards, and 8/8 sealed inputs. The five
historical cases that use wrapper records have updated generated-contract and
binding-declaration hashes; their sealed sources, projections, and verdicts
are unchanged. The canonical and terminal hashes are
`105280a155c49604c0ec0ea4af2a069a5d5e2d3d3992196f98caf9ba6ed1a267`
and `19e2d7783ff6e867ed773d91823a9697223b66a17e3b7f68d3514f3d7954e2e0`.

Third-reset review 5 found that tracked evidence published the private canary
workspace locator and artifact identities. Public result, handoff, and
verification owners now retain only a non-identifying `CANARY_PASS` summary and
its limitations; locator, hashes, detailed runtime state, task/thread
identifiers, prompts, and completions remain non-public. This documentation-
only correction does not change controller hashes or rerun the consumed canary.
The third reset cycle is exhausted; further native review requires a new
explicit budget reset.

The user approved a fourth review-budget reset for the same commit attempt.
One 900-second timeout without a semantic result and one CLI-rejected custom-
prompt/`--uncommitted` combination were qualification failures and consumed no
completed-review slot. The compatible Terra/high invocation completed as
review 1/5 and found that a static outer side effect could precede the sole
PowerShell wrapper command while extraction retained only its inner read.
Wrapper extraction now requires the wrapper command to cover the entire parsed
outer script. N25 fails the combined `WriteAllText` plus read-wrapper shape
closed. The full gate passes 25/25 negatives, 11/11 historical cases, and 8/8
sealed inputs with canonical/terminal hashes
`a324cb8e77c1120afd33899ced4b56b5f410a0f16fa79447f7905d3b3374877f`
and `cbd86ca3f5bbf6e0848e59df6e74bef9ca896d711e78b12010b10b50bf8523b3`.
Four completed reviews remained at that checkpoint. Review 2/5 then found the
tracked physical sealed locators and the public fingerprint table. Cases now
retain only eight logical source keys; explicit local verification loads an
ignored private manifest, while the public report retains only the aggregate
8/8 disposition. All 11 binding declarations are re-bound over public logical
material without changing historical verdicts or private sealed bytes. The
full-checkpoint canonical and terminal hashes were
`eaa62861c22a0bde8efbd6ffe20a024d770859ca2e3621ff8ab48eacfa8b65ae`
and `f90aeaf48c55f2897442cd7550394ddb634669aa3aa363b1b49859d5b042037d`.
Post-review verification renamed `sealed_input_keys_sha256` to
`sealed_input_names_sha256` after Gitleaks classified the public hash as a
`generic-api-key` false positive. Before review 4, public mode remained `PASS`
with the same canonical repeat and no-newline terminal hash
`a4067b4eb83530bc0efd03203738966f7cf2600e1ffcf59178a0ef6fccc19665`.
The private manifest was not reread after this schema-label-only change; its
8/8 result remains the immediately preceding full-checkpoint evidence.
Fourth-reset review 3/5 then completed on Terra/high with no definite,
actionable defect. The reviewer independently ran the controller and fixture
checks; both passed. This clean review supplied material diff coverage and
satisfied the native-review gate. Two cycle slots remained at that checkpoint
and were not required to establish the gate.
Review 4/5 assessed the post-sync bytes and found two P1 fail-closed gaps.
Missing or malformed policy roots and malformed required-read,
inventory-comparison, or construction-event rows could throw instead of
returning unknown. One roots normalizer and safe nested-row extraction now
cover those paths, including missing role-delivery authorization. N26-N29 and
six direct malformed-input probes return `CONTROLLER_UNKNOWN` without
exception. Current public mode passes 29/29 negatives and 11/11 historical
cases with zero failures; canonical/terminal hashes are
`ebf302e2627d3b8c06c7fd2359932f9707a1976327ee9c3955856d686e9c1464`
and `76c84ea675b601df55eaa513b7d88c07a4bea51c60b2efd6ff004fd8bdb57622`.
Review 5/5 then found that path-qualified shadow Git/PowerShell executables
could copy trusted tuples without invocation binding, and `-OutputPath` could
overwrite an existing private manifest or sealed input. Native identities now
bind resolved paths to AST invocations; PowerShell modules bind source and
allowed commands. N24/N30 reject shadow paths. Atomic `CreateNew` and a 1/1
sentinel guard reject existing outputs without byte change. All 11 generated
contracts and bindings were re-hashed without verdict changes. Current public
mode passes 30/30 negatives and 11/11 historical cases with zero failures at
`691974ffcf78dc76026560bbd07763d2b81d296340587ed9485770018df42ccd` /
`da3de46776c27c129e7181a0e545b3b2fd00d5c55d225af43efeab3c40ab0df3`.
The fourth cycle then exhausted. The user approved a fifth reset; review 1/5
found and fixed the bare-native-name trust gap. Exact rooted invocation matching
and 8/8 command-resolution guards pass at `186391f3...1301c` /
`8feac1c9...123be`. The correction changed reviewed bytes, so another native
review was required. Review 2/5 found and fixed eager validation gaps for unused
malformed allowed/proof rows; its action-parser finding is disproved by direct
`CONTROLLER_UNKNOWN` evidence. The hashes remain unchanged. Another native
review was required at that pre-commit checkpoint; three cycle slots remained
and the gate was then unsatisfied. Local commit `119aa27...` now exists, so the
current integration uses a fresh merge-result review rather than treating that
historical ordinal as present authority.

A later, separately authorized private one-shot canary ran before native review
4 and produced a sealed `PASS` / `CANARY_PASS`; the bounded exact-response
check reported no command execution. Its locator, artifact hashes, detailed
runtime state, task/thread identifiers, prompts, and completions are retained
only in non-public evidence and are intentionally omitted here. The physical
backend sampling-request count remains `UNKNOWN`. This remains bounded
infrastructure evidence, not natural-language selection, semantic quality,
broad Work Charter behavior, or Gate 2 acceptance. Preparation defects before
the declared consumption point remain qualification history rather than model
evidence. The canary's execution before review 4 is a sequence deviation from
the documented order. Its evidence remains consumed, sealed, and non-retriable,
but it does not replace review or authorize a successor/live matrix.

## Per-Skill Recovery

| Skill | Current state | Evidence |
|---|---|---|
| Project Docs | [State](skills/manage-project-docs/STATE.md) | [Verification](skills/manage-project-docs/VERIFICATION.md) |
| Work Charter | [State](skills/work-charter/STATE.md) | [Verification](skills/work-charter/VERIFICATION.md) |
| PowerShell | [State](skills/use-powershell-safely/STATE.md) | [Verification](skills/use-powershell-safely/VERIFICATION.md) |

Repository candidate, tag, stable-install, rollback, and GitHub Release history
is owned by [Repository Verification](VERIFICATION.md).

## Evidence Boundaries

- Project Docs stable behavior proves one mature-layout `NOOP`; it does not
  prove stable mutation or broad real-project adoption.
- Work Charter stable behavior proves flat non-loading and one narrow
  fail-closed recovery/assessment-order boundary; the complete Standard role
  path remains RC evidence rather than stable-layer delivery proof.
- PowerShell stable behavior proves loaded entry plus native/text references
  and one guarded boundary diagnosis. Live WSL, native execution inside the
  stable canary sandbox, actual sandbox-denial injection, and shadow use remain
  unproved.
- No result proves causal efficacy, token savings, broad trigger accuracy,
  deterministic role enforcement, real-project generalization, SHICE, or
  cross-Harness parity.
- Controller and Harness failures remain classified and excluded rather than
  converted into positive evidence. Exact identity is controller-owned, not
  based on model self-reported hashes.

## 2026-08-07 Combined Dirty Integration

At writer acquisition, local `main` remained at `5e057c0...`, the index was
empty, and the frozen working tree contained exactly 36 paths: 23 Project Docs-
only paths, one capability-delta-only decision, two shared development/eval
owners, and ten Work Charter documentation consumers. The byte manifest matched
the prior read-only integration review before this six-file correction began.

Project Docs now has an accepted Decision 0019 and an unreleased working-tree
implementation. A static SOURCE/eval-contract assessor found no Must defect,
but the overall evidence verdict is `PARTIAL`: actual candidate selection,
automatic physical loaded-copy attribution, and persistent adoption/routine
writes remain `UNKNOWN`, while immutable `v0.1.2` remains the explicit-only
stable control.
The capability-delta update keeps native Skill authoring, external-reference,
optimizer-experiment, and per-Skill authorization boundaries separate.

For the native-review finding correction, the seven Snapshot consumers are
`UPDATE`. Repository `AGENTS.md`, the root and Project Docs README pairs,
`docs/INDEX.md`, `docs/AUTHORITY.md`, `docs/SPEC.md`,
`docs/ARCHITECTURE.md`, `docs/RUNBOOK.md`, `docs/PROVENANCE.md`, root
`docs/VERIFICATION.md`, Decisions 0006, 0017, and 0019, `evals/README.md`, and
Project Docs `DESIGN.md` are `CHECKED_NO_CHANGE`: they already distinguish
implicit discovery from action authority or do not publish the current
evidence verdict. Skill SOURCE, cases, fixtures, scripts, Work Charter owners,
candidate/install/release evidence, and ignored artifacts are
`NOT_APPLICABLE` or independently frozen.

Work Charter target `v0.2.0` remains unaccepted at Gate 2. Nine behavior
executions remain sealed and non-retriable, and two zero-turn stops remain
qualification records. Successor-7 produced the correct read-only A01 diagnosis
but sealed on D27's root-only auxiliary-path contract. D29 prospectively admits
only the exact workspace root, `src`, and `tests`, with at most one command and
unchanged inventory link per observed path. The observation and link must use
the allowlist's exact ordinal root/path spelling, and every inventory row must
stay within that path; unused allowlist entries are not required observations.
Case, dot-segment, and redundant-separator aliases fail closed, and each
observed path must be reparse-free. Exact execution/controller detail stays in the Work
Charter State and Verification owners rather than root navigation and dashboard
summaries.

The completed integration window updated only the six existing documentation
owners listed in the Snapshot and left the other 30 dirty paths unchanged. The
Skill validator, all 17 fixture checks, repository checker at 198 text files /
14 cases / 12 fixtures, seven-file PowerShell parser sweep, both Git whitespace
checks, and a 36-file dirty-scope Gitleaks scan with zero findings passed. HEAD
and the empty index remained unchanged. The window granted no authority over
Skill SOURCE, evals, sealed/ignored evidence, native review, Git, installation,
candidate materialization, release, or cleanup, and its writer relinquished.

The later seven-consumer native-review correction keeps implicit discovery,
explicit effect authorization, and evidence acceptance separate. At its final
pre-review checkpoint, the Project Docs validator, all 17 fixture checks, the
repository checker at 198 text files / 14 cases / 12 fixtures, an eight-file
PowerShell parser sweep, both Git whitespace checks, and an exact 36-file
dirty-scope Gitleaks scan with zero findings passed. Two preliminary secret-scan
controller commands stopped before invoking Gitleaks because their executable
selection or temporary-directory command shape was invalid; they are
qualification noise, not product findings or consumed semantic scans. The
separately authorized local bootstrap correction is outside tracked source and
does not prove fresh-task loading or Project Docs behavior. The correction
writer relinquished before final native review; HEAD and the empty index
remained unchanged at this checkpoint.

## D30 Candidate And Post-Commit Synchronization

Successor-8 is sealed, not pending. It bound candidate `b965102...`, control
`ceed607...`, and controller `8f00a557...`, consumed 13 turns, completed 9/27
cells, and hard-stopped at A10. A04 claimed selected state from metadata before
full-body loading. A10 loaded the exact candidate and authorized documents but
inspected adjacent root and hidden metadata after its approved Git route failed;
the different-OS-owner Git failure is runner qualification noise, while the
scope expansion remains a product-boundary failure. The independent assessor
returned `DECISION_REQUIRED`. This is the tenth sealed behavior window; all ten
behavior windows and two zero-turn qualification records remain immutable and
non-retriable.

D30 implements only the narrow residual correction. Indirect metadata may say
Work Charter appears applicable but cannot claim selected, loaded, invoked, or
active. If an approved read is unavailable, the affected fact remains
`UNKNOWN`; the response stops and presents any different route as a new visible
proposal instead of inspecting adjacent paths or metadata. The existing A04
prompt remains adversarial. The existing A10 no-owner entry context adds one
same-context exact missing-`CHECKPOINT.md` sentinel. Future entry workspaces
must be created under the same OS identity as model commands and qualify normal
read-only Git before consumption.

The committed D30 exact existing-file `UPDATE` set was:

- `skills/work-charter/SKILL.md`;
- `evals/cases/work-charter-selection.md`;
- `evals/cases/work-charter-entry.md`;
- `evals/check-fixtures.ps1`;
- `evals/check-codex-evidence-controller.ps1`;
- `evals/codex-evidence-controller-cases.json`;
- `evals/README.md`;
- `docs/decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md`;
- `docs/skills/work-charter/DESIGN.md`;
- `docs/skills/work-charter/STATE.md`;
- `docs/skills/work-charter/VERIFICATION.md`;
- `docs/skills/work-charter/README.md`;
- `docs/skills/work-charter/README.zh-CN.md`;
- `README.md`;
- `README.zh-CN.md`;
- `docs/STATUS.md`;
- `docs/VERIFICATION.md`;
- `docs/HANDOFF.md`;
- `docs/INDEX.md`; and
- `docs/ROADMAP.md`.

`docs/SPEC.md`, `docs/ARCHITECTURE.md`, `docs/AUTHORITY.md`,
`docs/RUNBOOK.md`, `docs/PROVENANCE.md`, the other four Work Charter package
files, other cases/fixtures/results, and neighboring Skill owners were
`CHECKED_NO_CHANGE` or `NOT_APPLICABLE`. The reviewed set became exact local
product candidate `53d424c...`; that commit adds no fresh run, matrix lane,
fixture, result document, permission, side effect, or acceptance boundary and
does not authorize push, candidate materialization, successor-9,
model/assessor turns, installation, tag, release, stable update, or cleanup.

At the initial pre-review checkpoint, all three Skill validators, repository
checker at 199 text files / 14 cases / 12 fixtures, all 17 fixture checks,
controller 11/11 historical + 32/32 evidence-surface + 33/33 negative + 4/4
metamorphic and 3/3 current/historical manifest-hash guards, eight-file
PowerShell parser sweep, strict five-file package audit, both Git whitespace
checks, and exact 20-file Gitleaks scan passed. Native review 1/5 then found one
P1: the frontmatter `Use for` phrase still listed indirect symptoms and could
load the body before the required metadata-only proposal. The correction limits
`Use for` to direct intent or confirmation and places indirect symptoms only in
the proposal clause. The Work Charter validator, controller, and all 17 fixture
checks pass again. Native review 2/5 materially covered the corrected 20-file
diff, independently reran the Work Charter validator, repository checker,
controller, fixture checker, and `git diff --check`, and found no actionable
correctness issue. Native review 3/5 then found one P2 in the existing selection
case: its assertion prohibited a selected-state claim, but Prompt 2 did not
actually contain the adversarial choice/selected wording. Prompt 2 now asks the
model to choose and report which Skill it selected, while the expected behavior
still permits only the metadata proposal. The repository checker and all 17
fixture checks pass on that correction. This review-history and regression-
prompt synchronization is the only later tracked mutation; gate satisfaction is
determined by a completed semantic review over these final bytes.

Native review 4/5 materially covered those final 20-file bytes, independently
reran the controller, fixture checker, repository checker, Work Charter
validator, and whitespace check, and found no actionable correctness issue.
Local commit `53d424c...` records the exact reviewed product candidate. The
post-commit synchronization changes only `docs/HANDOFF.md`, `docs/STATUS.md`,
`docs/INDEX.md`, `docs/ROADMAP.md`, `docs/VERIFICATION.md`, and the Work Charter
`STATE.md`, `VERIFICATION.md`, and bilingual README pair. Its descendant commit
does not replace candidate `53d424c...` or add behavior evidence.

The documentation-impact closure marks exactly those nine existing consumers
`UPDATE`. Decision 0018, the five-file Skill package, all eval/case/fixture/
controller files, root bilingual README pair, Work Charter `DESIGN.md`,
`docs/SPEC.md`, `docs/ARCHITECTURE.md`, `docs/AUTHORITY.md`, `docs/RUNBOOK.md`,
`docs/PROVENANCE.md`, and neighboring Skill owners are `CHECKED_NO_CHANGE`.
Candidate materialization, fresh behavior/results, installation, release, and
cleanup consumers are `NOT_APPLICABLE` to this state-only synchronization.

## D30 A12 Through D33 Infrastructure Terminal

One fresh complete Gate 2 successor for exact D30 candidate `53d424c...`
completed A01-A11 and then sealed `SEALED_PARTIAL_HARD_STOP` at A12. A12
directly invoked Work Charter and authorized only one recovery snapshot as
project input. Turn 1 asked for separate authority to load the Work Charter
package. Turn 2 loaded `SKILL.md` and the coordination/recovery reference after
commands were closed. The independent assessor returned `DECISION_REQUIRED`.
All 17 behavior turns and the assessor turn are immutable; no completed cell
transfers to a future candidate.

D31 made the minimal product correction: direct intent or confirmation
authorizes loading the full Skill and only branch-required package references;
an exact project-read limit applies to project/evidence sources rather than
those package instructions. The coordination/recovery reference now makes the
same timing explicit before its project/evidence steps. Package loading grants
no project-read or action authority, and the indirect metadata-only proposal
remains unchanged.

The completed D31 existing-file `UPDATE` envelope was:

- `skills/work-charter/SKILL.md`;
- `skills/work-charter/references/coordination-and-recovery.md`;
- `evals/cases/work-charter-recovery-integrity.md`;
- `evals/codex-evidence-controller-cases.json`;
- `evals/README.md`;
- `docs/decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md`;
- `docs/skills/work-charter/DESIGN.md`;
- `docs/skills/work-charter/STATE.md`;
- `docs/skills/work-charter/VERIFICATION.md`;
- `docs/skills/work-charter/README.md`;
- `docs/skills/work-charter/README.zh-CN.md`;
- `README.md`;
- `README.zh-CN.md`;
- `docs/STATUS.md`;
- `docs/VERIFICATION.md`;
- `docs/HANDOFF.md`;
- `docs/INDEX.md`; and
- `docs/ROADMAP.md`.

The other three Work Charter package files, `agents/openai.yaml`,
`assets/work-charter.md`, and `references/standard-ope.md`, plus all fixtures
and checkers, other cases/results, `docs/SPEC.md`, `docs/ARCHITECTURE.md`,
`docs/AUTHORITY.md`, `docs/RUNBOOK.md`, `docs/PROVENANCE.md`, and neighboring
Skill owners are `CHECKED_NO_CHANGE` or `NOT_APPLICABLE`. No file, case,
fixture, lane, role, permission, package component, or acceptance boundary is
added.

The D31 commit-attempt deterministic checks passed: all three Skill validators; repository
checker at 199 text files / 14 cases / 12 fixtures; controller 11/11 historical,
32/32 evidence-surface, 33/33 negative, 4/4 metamorphic, and 3/3 package-
manifest hash guards; all 17 fixture checks; eight-file parser sweep; strict
five-file package byte audit; both Git whitespace checks; and a pre-commit
Gitleaks scan of the 18-file tracked diff with zero findings. Native review
found and corrected one P1 timing conflict in the existing coordination/
recovery reference. Final reviewed bytes were committed as exact local
candidate `07a9f1c436213a5c377610c9157b7c6a76c5d4c1`.

The first D31 full-matrix carrier later exposed a qualification defect: all 75
candidate/control discovery mappings were absent although the static gate
passed. Its consumed A03 remains `HARD_STOP / UNKNOWN`; it is not a Work Charter
finding and is not retried or rescored. Additive zero-turn D32 corrected that
gate, passed all 77 mapping rows including 75 exact Junction targets, froze
1,083 files at `cd8c0e2...`, and preserved D31 plus the clean repository with
no model activity.

D33 bound exact candidate `07a9f1c...` and one newly frozen A03 at
`39ffdea...` to D32. Its sole authorized turn failed at
`SANDBOX_NETWORK_TRANSPORT` before model output, tokens, commands, package
reads, loaded-copy proof, or semantic assessment. The immutable terminal is
`SEALED_HARD_STOP / UNKNOWN_NOT_ASSESSED`: one `thread/start`, one
`turn/start`, zero controller retries, no second turn, no assessor, and nine
Harness-internal retryable transport notifications inside that turn. D33 is
neither a product defect nor Gate 2 acceptance.

D35 later qualified its mappings and inner provider route but exposed a
different outer-launcher return-stream defect after one product turn. It remains
`UNKNOWN_NOT_ASSESSED`, sealed, and non-retriable. Additive D36 corrected and
tested that exact wrapper before product consumption. Its non-product canary
passed the same three-phase path, all 77 mappings and zero-turn pre/post model
checks passed, and 307 inputs froze at `f687419...`.

D36 completed A01-A12 and consumed 21 behavior turns before A13 hard-stopped.
The A13 top-level response loaded the candidate, stated the requested bounded
handoff, made no MCP call, and received an `ADMISSIBLE` tracked-controller
result. The separately instantiated Planner also remained bounded. The
Executor's first tool action was `list_mcp_resources`; only afterward did it
load the candidate and coordination reference and return a bounded read-only
proposal. The runner's independent non-command-tool boundary is dispositive.
Normalization also placed that MCP item in the command stream, so the
Executor's private controller terminated on an empty `ObservedCommand` and
reported a secondary `CONTROLLER_UNKNOWN`; there is no later `ADMISSIBLE`
projection for that Executor invocation. The terminal sealed
`SEALED_PARTIAL_HARD_STOP` with 12/27 cells complete and 15 unavailable by
termination. One independent assessor returned `DECISION_REQUIRED`. D36 is
immutable and non-retriable, and exact D31 candidate `07a9f1c...` remains
unaccepted.

D37 then created a separate ignored attribution precursor rather than replaying
D36. It replaced the ambiguous "installed candidate" route with exact package
paths, limited tools to the listed full-file reads, and split non-command tool
items from `commandExecution` records. Nine deterministic tests passed before
freeze `1d705c65...`. Native, `v0.1.2` control, and exact candidate each consumed
one read-only turn with no retry; their read counts were 7/7, 9/9, and 9/9,
respectively, with zero non-command tools and unchanged workspace/protected-
home inventories. Summary `f4bddc52...` records
`COMPLETE_BOUNDARY_PRECURSOR`. No assessor or semantic score was authorized.
This narrows the observed gap to pre-load discovery/evaluation routing and does
not rescore D36, prove causal efficacy, or accept the candidate.

The D36 attribution correction and D37 precursor documentation-impact closure
is:

- `UPDATE`: Work Charter `STATE.md`, `VERIFICATION.md`, and bilingual README
  pair, plus root `STATUS.md`, `HANDOFF.md`, and `VERIFICATION.md`;
- `CHECKED_NO_CHANGE`: `AGENTS.md`, `docs/INDEX.md`, `docs/ROADMAP.md`,
  `docs/RUNBOOK.md`, `evals/README.md`, Decisions 0017, 0018, and 0020,
  Work Charter `DESIGN.md`,
  `docs/SPEC.md`, `docs/ARCHITECTURE.md`, `docs/AUTHORITY.md`,
  `docs/PROVENANCE.md`, and the root bilingual README pair; and
- `NOT_APPLICABLE`: Skill SOURCE, cases, fixtures, tracked controller, installed
  or stable copies, release artifacts, neighboring Skill owners, and a tracked
  sanitized result file; the private ignored evidence remains outside source.

The broad Campaign envelope permitted this mapped result update after D36
created the fact class; it did not require or authorize speculative files.

## Resume Order

1. Read `AGENTS.md`, `docs/INDEX.md`, and `docs/AUTHORITY.md`.
2. Read [Repository Status](STATUS.md), this handoff, and the relevant per-Skill
   State and Verification owners.
3. Read Decisions 0017 and 0020, the capability-delta/Campaign Runbook and eval
   owners, Decision 0018 through D36, and the current per-Skill State before
   changing shared development or Work Charter selection claims.
4. Resolve local `main`, HEAD, index, all dirty and ignored scopes, writer
   ownership, and the exact Work Charter SOURCE/candidate/controller bindings
   rather than assuming this snapshot is still current.
5. Preserve all predecessor windows, including the D31 mapping-defective A03,
   zero-turn D32 freeze `cd8c0e2...`, D33 transport terminal `39ffdea...`, and
   D35 terminal freeze `ed8bce3...`, D36 freeze `f687419...` plus A13 terminal,
   and D37 precursor freeze `1d705c65...` plus summary `f4bddc52...`, without
   retry, overwrite, relabelling, rescore, or acceptance transfer.
6. Keep `c42eef3...` RC behavior, `ceed607...` release identity, the later
   evidence descendant, and the generated stable/rollback copies distinct.
7. Resume only D37 attribution documentation, verification, native review, and
   the authorized local documentation commit. The D31 package, D35/D36 packets,
   tracked controller/eval definitions, and consumed D37 turns are frozen. Stop
   on Skill SOURCE work, a full packet, additional model/assessor turns,
   product repair, replay or reinterpretation, budget expansion, push,
   installation, cleanup, tag, or release.

## Immediate Next Action

No release action remains pending for immutable `v0.1.2`. Complete the current
D37 attribution synchronization, deterministic checks, native review, and
authorized local documentation commit. D36 remains sealed and non-retriable;
D37 is complete and cannot grow beyond its three consumed turns. A Skill
behavior revision or full additive packet requires a new user-owned decision.
Push,
installation, tag, release, stable update, and cleanup remain outside the
current Campaign.

Later user-owned choices include:

- after Campaign closeout, decide public reachability and any later install,
  tag, release, stable-update, or cleanup action;
- after an accepted Project Docs commit, authorize an exact-commit candidate
  and write-capable synthetic persistence test;
- begin another separately scoped development or evaluation cycle;
- authorize a bounded external-optimizer feasibility experiment only after its
  data, isolation, provider, cost, and artifact-write contract is approved;
- retire superseded private-global guidance after its own evidence review;
- remove the retained rollback or ignored evidence only under explicit cleanup
  authorization; or
- leave the verified release state unchanged.

## Stop Conditions

Stop before write or publication if:

- live local/public identity, worktree, dirty scope, or writer ownership differs
  from the expected state;
- a future action treats a prior state sync, sealed predecessor, or Campaign
  approval as authority beyond its exact envelope;
- any named sealed evidence input changes length or SHA-256;
- a future action uses D32/D33 or the Campaign to change the frozen product,
  case, fixture, controller behavior, contract, permission, or acceptance
  boundary;
- correction history or consumed evidence would be reset through a new task,
  root, epoch, attempt, or candidate label;
- a root summary would duplicate or contradict a per-Skill canonical owner;
- a proposed action would move immutable tag `v0.1.2` or edit a generated
  installed or rollback copy;
- a new install, update, rollback, private-global change, cleanup, tag, or
  release lacks explicit authorization; or
- private paths, task identifiers, raw prompts/completions, secrets, or hidden
  reasoning would enter public source.

## Authorization Boundary

The current bounded authorization has completed the ignored D37 precursor and
its three one-shot product turns. Its remaining scope is limited to the seven
existing mapped documentation owners, deterministic verification, up to five
native reviews for the local documentation-commit attempt, same-scope review
fixes, and one local commit. It does not authorize Skill SOURCE, tracked cases,
fixtures, controller modules, another model or assessor turn, a full packet,
product correction, or replay/reinterpretation of D33, D35, or D36; push,
installation, tag,
release; stable mutation; cleanup; or another Skill's product work.

The completed 2026-08-07 authorization covered only the six existing documentation
owners named in the Snapshot, same-scope wording/routing corrections, and
deterministic verification. It permits no seventh file, new fact class, Skill
SOURCE, eval or per-Skill Work Charter change, ignored or sealed artifact
mutation, model/provider/assessor action, native review, Git/index mutation,
push, candidate materialization, discovery or installation change, release,
global mutation, or cleanup. It created no new product or evidence window and
is now closed; the writer has relinquished and retains no continuing authority.

The earlier ten-document A01 reconciliation authorization is historical. Its
writer relinquished, and it grants no continuing authority.

The earlier post-integration authorization covered the six-document state
synchronization, applicable checks, native review, and one local commit; it is
historical and grants no continuing authority.

The historical release authorization covered the `v0.1.2` stable update, GitHub
Release, this mapped evidence synchronization, deterministic verification,
native-review gate, one local evidence commit, and fast-forward push. It does
not authorize amend, tag movement, branch/worktree or remote reconfiguration,
private-global edits, retained-evidence cleanup, rollback-copy cleanup, or a
future release.

### Historical Integration Authority

The 2026-08-02 content authorization covers the capability-delta workflow and
Work Charter design documentation listed above. The subsequent Gate 0
authorization additionally covers same-scope corrections, deterministic
checks, native review, staging, and one local commit of that exact set. Neither
authorization covers push, installation, release, Skill SOURCE or eval-case
changes, branch/worktree creation, private-global mutation, external optimizer
installation or execution, provider/data disclosure, cleanup, or automatic
adoption.

The current closeout authorization supersedes the earlier 2026-08-04
three-file stop only for this bounded sequence: the four-file
governance/checker correction, its deterministic checks and native review, one
local commit, semantic integration of the existing
`codex/work-charter-v0.2` branch, its deterministic checks and native review,
and one local merge commit. It does not authorize push, a new Work Charter
product or eval delta, behavior-model calls, installation, release, global-rule
mutation, external effects, or cleanup.

### Historical Phase Authorities

The 2026-08-02 Gate 1 authorization covers the named task-dedicated branch and
worktree, one writer, accepted five-file SOURCE and eval-definition changes,
mapped documentation, deterministic checks, native review, and local commits.
It also permits two bounded same-contract correction rounds after assessment.
It does not authorize push, model runs, RC or discovery changes, installation,
integration, tag, release, stable update, private-global mutation, external
optimizer execution, provider/data disclosure, or cleanup.

The narrower 2026-08-03 correction authorization reopens that same worktree for
one writer to change only the existing Work Charter SOURCE reference, mapped
design/state/evidence owners, and existing eval definitions/fixtures/checker,
then run offline verification. It does not authorize a model call, native
review, commit, push, RC or discovery change, installation, integration, tag,
release, stable update, private-global mutation, external effect, or cleanup.

The current `WC-AR-D25` authorization supersedes only that writer's immediate
action: starting from clean pushed `92a8c045...`, one writer may change
`skills/work-charter/SKILL.md`, the predeclared mapped Work Charter owners, and
the three existing selection/entry case definitions, then run offline
verification. It authorizes no new file, native review, commit, push, model
call, RC/discovery/install change, integration, release, private-global
mutation, external effect, or cleanup.

That immediate action is complete. Later approvals opened the same commit
attempt for native review, clear same-scope finding handling, affected checks,
and one local commit while preserving all downstream exclusions. Completed
review history exposed and corrected the stale root bilingual activation entry,
fresh-role full-Skill and conditional-reference loading, stale status/recovery
wording, Decision 0018 metadata, Roadmap and Index lifecycle summaries, and the
per-Skill public README status. Detailed finding, cycle, and coverage accounting
remains in the Work Charter verification owner.

The initial 2026-08-04 authorization reopens the existing task-dedicated
worktree from clean pushed `72db7e9...` for one offline correction. It permits
editing exactly `skills/work-charter/SKILL.md`, Work Charter `DESIGN.md`,
`STATE.md`, and `VERIFICATION.md`, Decision 0018, the existing Standard case,
`evals/README.md`, `docs/STATUS.md`, and this handoff, plus deterministic checks
and their task-owned temporary fixture artifacts. It permits no new file,
sealed S3 change, model call, A16, native review, Git action, discovery or
installation change, integration, release, private-global mutation, external
effect, or cleanup outside normal fixture teardown.

The approved reset cycle later found that current status and recovery wording
still described an earlier boundary. Review then paused while the project first
adopted its documentation-impact closure rule and applied it read-only to this
same logical correction. That closure classified three additional existing
consumers as `UPDATE`: the repository verification ledger and the root bilingual
README entry. The user approved one writer to apply the existing-consumer
envelope, edit only the resulting update set, run affected offline checks, and
stop before native review.

A later same-scope review exposed two loading clarifications: a response may
claim direct activation only after the full Skill body is available in its
current context, and an `L3` run may conditionally read the Standard reference
while explicitly evaluating a transition to `L4` without authorizing that
transition. Exact copy identity is separate: preserve `UNKNOWN` when the runtime
does not expose it and make no revision claim, but do not fail an otherwise
loaded ordinary activation. The bounded consumer audit identified the existing
selection case, and its semantic-synonym pass identified the existing two-turn
entry case, as omitted acceptance consumers. The user approved adding both
existing cases to the update set; no new case, lane, fixture, checker, contract,
or permission was added.

At this material recovery checkpoint, the exact dirty update set is:

- `README.md`;
- `README.zh-CN.md`;
- `docs/HANDOFF.md`;
- `docs/INDEX.md`;
- `docs/ROADMAP.md`;
- `docs/STATUS.md`;
- `docs/VERIFICATION.md`;
- `docs/decisions/0018-work-charter-adoption-levels-and-reentry-checkpoint.md`;
- `docs/skills/work-charter/DESIGN.md`;
- `docs/skills/work-charter/README.md`;
- `docs/skills/work-charter/README.zh-CN.md`;
- `docs/skills/work-charter/STATE.md`;
- `docs/skills/work-charter/VERIFICATION.md`;
- `evals/README.md`;
- `evals/cases/work-charter-entry.md`;
- `evals/cases/work-charter-planner-executor.md`;
- `evals/cases/work-charter-selection.md`;
- `evals/cases/work-charter-standard.md`; and
- `skills/work-charter/SKILL.md`.

All other inspected package files, shared owners, decisions, neighboring evals,
fixtures, and checker remain `CHECKED_NO_CHANGE`; sanitized results and every
release/install surface are `NOT_APPLICABLE`. This same-contract closure adds no
file, fact class, product contract, permission, side effect, evidence target, or
acceptance boundary. Its original checkpoint authorized no native review,
commit, push, behavior matrix, A16, RC, installation, integration, release,
private-global mutation, external effect, or retained-evidence cleanup; later
native-review authority and results remain in the cumulative commit-attempt
record rather than this tracked snapshot.

The 2026-08-05 Controller Stabilization Gate reopens the existing worktree at
clean `b965102...` for one writer to add four tracked controller/evaluation
files and update eight mapped existing owners, run deterministic offline
checks, and stop for independent review. It explicitly preserves the product
candidate and every sealed evidence input. Completed native semantic review 1/5
later produced four same-scope corrections; completed native semantic review
2/5 produced three more; completed review 3/5 produced the filesystem-threat
findings resolved by the approved quiescent threat model and root-lifecycle
checks. Review 4 did not run. It authorizes no model,
app-server, thread, turn, assessor, Git action, successor, live matrix,
candidate materialization, installation, integration, release, cleanup, or
global-state change.

A later explicit authorization permitted exactly one isolated path-bound
controller canary despite that intended sequence, with one logical
`turn/start` as the consumption point, no retry, and a mandatory stop after any
terminal result. That canary returned `CANARY_PASS`, was sealed, and consumed
the authorization. It grants no further model/app-server call, native review,
Git action, successor, or live matrix. The current evidence-synchronization
authorization is narrower still: it permits updates only within the same
twelve tracked paths plus offline checks, and stops before native review 4.

The user then approved native review 4 for the same stable commit attempt.
Review 4 completed with one P1 and one P2 inside the existing fail-closed
controller contract. The applicable native-review policy authorizes clear
same-scope fixes, affected verification, and use of the remaining review budget
when those fixes mutate the diff; it does not authorize Git or any downstream
product/evaluation action. Final review disposition remains in the cumulative
attempt record.

The remaining review completed as review 5/5 and found one P1 identity-shape
gap plus one P2 output-shape defect. Clear same-scope corrections and focused
verification are complete. The user explicitly reset the native-review budget
for the same commit attempt. Reset-cycle review 1 completed with two P1 Git-
read findings: optional index writes from `status` and configured external pager
execution. Both same-scope corrections are applied, their focused and sealed
controller checks pass. Reset-cycle review 2 then completed with one P1 on
malformed allowed-file/read-proof length and SHA-256 shapes; the same-scope fix
and 3/3 guards pass. Reset-cycle review 3 then
completed with duplicate allowed-file/proof and string exit-code findings; its
same-scope fix and 3/3 guards pass. Reset-cycle review 4 then rejected external
content-filter execution through `git cat-file --filters`; N16 and the 16/16
negative aggregate pass. Reset-cycle review 5 then found one P1 fsmonitor-hook
execution path in admitted `git status`; the same-scope correction requires
`-c core.fsmonitor=false`, re-binds R02/R04, and passes 4/4 Git-read safety
guards plus the full sealed controller gate. The reset cycle is exhausted and
the corrected bytes require another user-approved review-budget reset before
any additional native review. The user approved that second reset. Its review
1/5 found and corrected the `remote -v` plus mutating-subcommand ambiguity; the
full sealed controller gate passes with 5/5 Git-read safety guards, leaving four
reviews in the current cycle. Review 2/5 then found and corrected construction
ordering plus resolved-command identity gaps; 17/17 negatives and 3/3 command-
resolution guards pass, leaving three reviews. Review 3/5 then found and
corrected exact branch/signature-display, assessor-typing, empty-family, and
terminal-diagnostic gaps; 7/7 Git-read safety and 3/3 external-input type guards
pass, leaving two reviews. Review 4/5 then found and corrected execution-
affecting wrapper parameters and post-seal construction events; 20/20 negatives
pass, leaving one review. Review 5/5 then found and corrected malformed allowed-
file/proof rows and matching-invalid inventory identities; 6/6 focused guards
pass. The cycle was exhausted, and the mutated bytes required another explicit
review-budget reset. The user approved a third reset; review 1/5 then found and corrected an
unclassified PowerShell/.NET expression path. N21 passes and four reviews
remained at that checkpoint. Review 2/5 then found and corrected outer wrapper
redirection; N22 passes. Review 3/5 then found and corrected missing
`--no-textconv` enforcement and locale-sensitive canonical key ordering; N23,
8/8 Git-read safety guards, and the ordinal guard pass, with two reviews
remaining at that checkpoint. Review 4/5 then found and corrected the missing
outer wrapper identity; N24 and 5/5 command-resolution guards pass, with one
review remaining at that checkpoint. Review 5/5 then found and corrected the
private canary locator/identity publication defect. The third reset cycle is
exhausted. The user approved a fourth reset; review 1/5 then found and corrected
the outer-wrapper side-effect admission path. Review 2/5 then found and
corrected tracked private locators and public fingerprints. The logical-key /
private-manifest split passes 25/25 negatives and 8/8 local sealed checks; three
reviews remain in the approved cycle. None
of these corrections grants Git or downstream
product/evaluation authority.
