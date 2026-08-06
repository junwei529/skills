# Work Charter Codex Evidence Controller Stabilization

Date: 2026-08-05

## Result

`IMPLEMENTED_UNCOMMITTED`

This tranche implements and deterministically checks tracked controller
infrastructure. It does not accept Work Charter Gate 2, retry or rescore any
sealed model evidence, create a new product candidate, or authorize a live
matrix.

## Identity And Scope

- Product candidate: `b965102ea58f9cc1ef3c73e8dea515731fec12a6`.
- Work Charter package tree: `9111aba4cc141f52545f4ddfcf8d03db1e8f3189`.
- Product package: the same five `skills/work-charter` blobs as the candidate;
  no package path changed in this tranche.
- Controller revision: the twelve tracked controller, evaluation, result, and
  mapped documentation paths declared by the repository handoff. It is later
  evaluation infrastructure, not part of the product package identity.
- Entry baseline manifest SHA-256:
  `2d0dcb755a1bf3af69e627e2500d88d82c7e7795a189a460c9aa5433e0cb4762`.

## Controller Contract

One PowerShell module owns preflight, runtime, historical-import, and terminal-
stage normalization through the same core function. It:

- parses PowerShell command structure with the PowerShell AST;
- normalizes completed, declined, and failed actions separately;
- distinguishes reads, writes, read-only Git, Git mutation, and unknowns;
- resolves relative paths from each observed command working directory and
  fails closed on traversal, unauthorized roots, wrong content identity,
  completed writes, and Git mutation;
- keeps declined commands diagnostic-only, while failed execution always
  returns at least `CONTROLLER_UNKNOWN` and exposes attempted write or Git
  mutation effects;
- rejects Git output, unauthorized relocation, configuration/repository
  overrides, signature verification, and external-execution shapes unless the
  narrow exact-root `safe.directory`/`-C` form is structurally proved;
- treats `Get-Content` proof as full-file evidence and rejects `-TotalCount`;
- treats the stable work subject, candidate SHA, package-manifest hash,
  relative package path, and normalized content/output hash as logical
  candidate identity while retaining physical successor roots only as lineage
  locators;
- validates nonempty, structurally relative, and exact hash-shaped expected and
  observed candidate identities before comparing them;
- recomputes each package-manifest hash from the exact revision's five Git
  blobs as canonical path-sorted `path`/`length`/`sha256` rows;
- binds every historical input specification to one public logical source key,
  a hash-only redacted JSON-selector projection, and a canonical hash
  of the complete generated controller input plus expected result contract;
- proves literal containment plus non-reparse ordinary-file shape, captures
  each sealed file once through a read handle that denies write/delete sharing,
  and derives length, SHA-256, strict UTF-8 JSON, and projection from the same
  bytes;
- compares inventories by normalized relative path plus length/hash independent
  of row order;
- preserves historical violation sets as JSON arrays, including `[]`; and
- returns `ADMISSIBLE`, `CONTROLLER_VIOLATION`, or `CONTROLLER_UNKNOWN`.

The checker is qualified only for quiescent offline single-writer execution:
no other task or process may mutate the repository, `.eval-runs`, sealed
inputs, or path topology while it runs. It rejects observable pre-existing or
pre/post topology drift, but it does not implement no-follow protection against
a malicious concurrent swap entirely between validations.

Free-form natural language is not judged by marker matching. Structurally
admissible free text routes to `SEMANTIC_ASSESSMENT_REQUIRED`; only an explicit
exact-response protocol receives deterministic exact-text comparison. The
offline gate calls no semantic assessor.

## Regression Result

| Group | Result | Boundary |
|---|---:|---|
| Historical R01-R11 | 11/11 | source identity, redacted selector projection, complete generated input, and expected result contract are jointly hash-bound before controller invocation |
| Historical binding guards | 4/4 | unknown, unrelated, missing, and changed mappings fail closed |
| Generated-contract drift guards | 3/3 | generated command, effect, or expected-result drift rejects while source identity, projection, and `input_spec` stay unchanged |
| Fail-closed negatives | 30/30 | prior twenty-nine plus a path-qualified shadow Git executable carrying a copied trusted tuple; N24 also covers the equivalent shadow PowerShell wrapper |
| Metamorphic pairs | 4/4 | parameter order, relative/absolute path, split/compound read-only Git, and successor-root relocation |
| Package manifests | 2/2 | exact five Git blobs at `72db7e9...` and `b965102...`; two stale-hash guards reject |
| Sealed locator guards | 4/4 | rooted, traversal, alternate-root, and the platform-selected real directory link reject before read; the current Windows run proves Junction link-only removal retains its target, while non-Windows SymbolicLink execution remains `UNKNOWN` |
| Single-capture guard | 1/1 | accepted hash and parsed projection remain tied to one captured byte buffer even after the scratch pathname changes |
| Scratch topology guards | 2/2 | a pre-existing reparse `.eval-runs` and cleanup-time root/scratch reparse drift both fail closed, retain their targets, and perform no recursive cleanup through a link |
| External-input type guards | 3/3 | string role or assessor authorization and malformed nested-turn count/budget values return `CONTROLLER_UNKNOWN` without coercion or exception |
| Git-read safety guards | 8/8 | every supported read fails closed without global `--no-pager`, bounded forms remain admissible with it, `status` separately fails closed without global `--no-optional-locks` or command-local `-c core.fsmonitor=false`, `log`/`show` require `-c log.showSignature=false`, diff-capable reads require `--no-textconv`, and remote/branch reads admit only exact shapes |
| Canonical ordinal guard | 1/1 | dictionary and object key ordering is byte-stable under process-local `en-US`, `sv-SE`, and `tr-TR` cultures |
| Command-resolution guards | 8/8 | bare `git`, `git.cmd`, and `pwsh`, missing or shadowed inner/outer identity, shadow paths, and a policy-pinned rooted positive fail closed or pass as required |
| Content/proof/inventory identity guards | 6/6 | malformed policy/proof content identities, scalar or missing-field allowed/proof rows, and matching-invalid inventory path/length/SHA-256 identities return `CONTROLLER_UNKNOWN` before comparison |
| Record-cardinality/exit guards | 3/3 | duplicate allowed-file keys, duplicate observed-proof keys, and non-integral or nonzero completed exit codes fail closed; numeric zero remains admissible |
| Logical candidate identity guards | 3/3 | blank, malformed-observed, and malformed-expected identities return `CONTROLLER_UNKNOWN` before comparison |
| Historical output-shape guard | 1/1 | empty actual violation sets serialize as `[]`, not `[null]` |
| Output no-clobber guard | 1/1 | atomic `CreateNew` rejects an existing output and preserves its exact sentinel bytes |
| Local sealed inputs | 8/8 | contained ordinary files match pinned length/SHA-256 and all 11 case projections recompute |
| Four entry modes | pass | all call the same adjudication core |
| Canonical repeat | pass | two complete runs emit identical canonical JSON |

Canonical regression SHA-256:
`eaa62861c22a0bde8efbd6ffe20a024d770859ca2e3621ff8ab48eacfa8b65ae`.
The complete full-checkpoint terminal JSON (without a trailing newline) was
`f90aeaf48c55f2897442cd7550394ddb634669aa3aa363b1b49859d5b042037d`.
Post-review verification found that Gitleaks classified the public
`sealed_input_keys_sha256` field as a `generic-api-key` false positive. The
field was renamed `sealed_input_names_sha256`, advancing the entry-baseline
hash without changing the logical source-name hash. Before review 4, public
mode remained `PASS` at the same canonical regression hash; its no-newline terminal JSON was
`a4067b4eb83530bc0efd03203738966f7cf2600e1ffcf59178a0ef6fccc19665`.
The ignored private manifest was not reread after this schema-label-only
change, so the table's 8/8 sealed-input result remains evidence from the
immediately preceding full checkpoint.

After review 4's malformed-input correction, current public mode preserves
11/11 historical cases and advances the negative aggregate to 29/29 with zero
failures. Canonical repeat SHA-256 is
`ebf302e2627d3b8c06c7fd2359932f9707a1976327ee9c3955856d686e9c1464`;
the current no-newline terminal JSON is
`76c84ea675b601df55eaa513b7d88c07a4bea51c60b2efd6ff004fd8bdb57622`.

Review 5's resolved-invocation and output-no-clobber corrections advance
current public mode to 30/30 negatives, 11/11 historical cases, and 1/1
no-clobber with zero failures. Canonical repeat SHA-256 is
`691974ffcf78dc76026560bbd07763d2b81d296340587ed9485770018df42ccd`;
the current no-newline terminal JSON is
`da3de46776c27c129e7181a0e545b3b2fd00d5c55d225af43efeab3c40ab0df3`.

After the user approved a fifth review-budget reset, review 1/5 found that a
bare native invocation could still claim a trusted resolved identity without
proving which PATH entry executed. Native applications now require an absolute
observed invocation equal to the policy-pinned path. Eight command-resolution
guards cover bare `git`, `git.cmd`, and `pwsh` plus the prior identity, shadow-
path, and trusted-positive cases. Six affected historical generated contracts
and bindings were re-hashed without verdict changes. Current public mode remains
30/30 negatives and 11/11 historical with zero failures. Canonical repeat is
`186391f34dfd50526d38b8bc844ae5f5672500bc70e520bb81f962778561301c`;
the no-newline terminal JSON is
`8feac1c980ef36f7b287c452a8335f5dc14a0b41418b879a64a218ca3ee123be`.

Review 2/5 found that an unused malformed allowed-file row and an extra
malformed proof were not validated unless a normalized read referenced them.
Both maps now validate every supplied content identity while retaining its key
for authorization classification. The existing 6/6 content/proof/inventory
guard groups now include unused-malformed variants. The same review reported
that action-command parse errors were discarded; the completed-action path
already adds those errors to controller unknowns. A direct synthetic safe outer
read whose action appended an unknown command returned `CONTROLLER_UNKNOWN`
with `command_kind_unknown`, so that finding is a false positive and required no
code change. Focused checks preserve the current canonical and terminal hashes.

Canonical five-file manifest SHA-256 values are
`bb9201169e28de9a1ae3071f29cbacde2554d4cc30a27066822ce324a404449f`
for `72db7e9...` and
`98b8f2373398fecf0b8813dd50ed29a34e8f74ed6a8fb7731b113ad4f00fbe8b`
for `b965102...`.

The historical A15 unauthorized Orchestrator delivery and unbudgeted nested
turn remain `CONTROLLER_VIOLATION`. Correcting marker, command, path, inventory,
and locator classification does not erase those findings.

## Same-Scope Correction

An earlier same-scope correction made failed execution non-admissible while
retaining its structured diagnostics, validated Git context and effect-
changing arguments instead of trusting the subcommand alone, and prevented
partial `Get-Content` output from satisfying a full-file proof.

Completed native semantic review 1 of the current five-review cycle then found
four further controller-infrastructure gaps. Its user-authorized correction
rejects Git signature-verification options, derives declared package-manifest
identities from the actual five-file revision bytes, binds R01-R11 to versioned
redacted projections of pinned sealed sources, and contains every sealed
locator before read.

Completed native semantic review 2/5 confirmed the Git-signature and five-blob
manifest corrections, then found three remaining fail-closed gaps: the final
generated historical input and expected result were not themselves bound; hash
and JSON projection came from separate pathname reads; and the reparse guard
did not exercise the real resolver. This user-authorized correction binds the
complete root-normalized generated contract before controller invocation,
captures and parses each sealed source from one held byte stream, and routes a
platform-selected real scratch directory link through the resolver before
confirmed nonrecursive link removal. The implementation selects `Junction` on
Windows and `SymbolicLink` otherwise; this host proves the Windows branch only,
so non-Windows execution remains `UNKNOWN`. Generated command/effect/expected
drift has 3/3 negative coverage.

Completed native semantic review 3/5 raised two filesystem-threat findings.
Its P1 adversarial-concurrency finding is valid under a broader threat model;
the user resolved it by approving quiescent offline single-writer operation,
not by declaring a false positive or claiming implemented no-follow defense.
Hostile rename or reparse swaps entirely between validations therefore remain
unsupported and `UNKNOWN`. Review 3 P2 is fixed: before creating scratch, the
checker proves `.eval-runs` is the exact ordinary non-reparse repository child;
before recursive cleanup it revalidates that root, the contained ordinary
scratch, and reparse-free descendants, then verifies scratch absence and root
shape afterward. Any failed cleanup precondition retains residue for manual
disposition. Two focused scratch-owned guards pass without unsafe recursive
cleanup.

Declined commands and the true A15 violations remain intact, and SOURCE plus
sealed bytes are unchanged.

Completed native semantic review 4/5 found two external-record type defects.
PowerShell converted a string-valued role authorization such as `"false"` to
Boolean true, which could admit an unauthorized delivery; explicit integer
casts for malformed nested-turn count or budget values could also throw before
the controller returned a verdict. The correction accepts only actual Boolean
authorization and nonnegative integral counts. Invalid types, negative values,
or overflow produce explicit controller unknowns. The existing checker adds
2/2 focused external-input type guards without adding a historical case,
fixture, sealed input, or product contract. All prior regression groups remain
unchanged.

Completed native semantic review 5/5 found two more same-contract defects.
Present-but-empty or malformed expected and observed candidate identities could
compare equal and reach `ADMISSIBLE`; an empty historical violation set also
serialized as `[null]`. The correction validates all five logical identity
fields before comparison, returns `CONTROLLER_UNKNOWN` for invalid identity,
and preserves empty arrays as `[]`. Three identity-shape guards and one output-
shape guard pass without adding a case, fixture, sealed input, or product
contract. Historical verdicts remain unchanged; the corrected output shape
changed the intermediate canonical hash to
`fca3e989a61fa97df9ded66203604c071c3d8691eff8170b38cff49c859dfc44`.

After the user reset the completed review budget for this same commit attempt,
reset-cycle review 1 found two P1 Git-read gaps. `git status` could take an
optional lock and refresh the index, and admitted Git reads could launch a
configured external pager. The correction requires global `--no-pager` for
every admitted Git read and additionally requires global
`--no-optional-locks` for `status`. Three focused guards prove missing flags
fail closed and the supported bounded-read matrix stays admissible. R02/R04
generated contracts and bindings are re-hashed for the safer synthetic command
form; historical verdicts, sealed source identities, SOURCE, case inventory,
and fixture inventory remain unchanged. This correction produced the
intermediate canonical hash
`48b58734cb19cb927fba9d2b23a20a3acc9838375c7c31e61793615fb731bdbb`.

Reset-cycle review 2 found one P1 at the content-proof comparison boundary.
Matching malformed policy/proof SHA-256 strings could reach `ADMISSIBLE`, and a
malformed length could throw before adjudication. The correction independently
requires nonnegative integral length and 64-hex SHA-256 for both allowed-file
policy rows and observed file proofs. Three focused guards cover malformed
policy identities, malformed evidence proofs, and matching-malformed inputs.
The historical/canonical regression is unchanged; the added guard record
changed only the then-current terminal JSON hash to
`a9c9fb5dd40b0688d58a17716bb4f41cebd33284c76bf17e3ff2ca8740eeb519`.

Reset-cycle review 3 found two P1 duplicate-key gaps and one P2 completed-exit
typing gap. Contradictory duplicate allowed-file and proof rows were silently
overwritten, while string `"0"` was coerced into success. Map construction now
reports each duplicate family as an explicit unknown without overwriting, and
completed exit codes must be actual integral values equal to zero. Three focused
guards cover duplicate policy/proof records plus string zero, positive/negative
nonzero, and numeric zero. Historical/canonical output stays unchanged; the
additional guard record produced the then-current terminal JSON hash
`38257d531d240abd656c52486664c6579000b1ffbf398b31a1613236fec873bd`.

Reset-cycle review 4 found one P1 external-execution gap. `git cat-file
--filters` and `--filters=...` could invoke configured content filters while
appearing read-shaped. The classifier now rejects both option forms as
`git_external_input_or_execution_not_admissible`. Formal negative N16 raises
the aggregate to 16/16 and produced the then-current canonical
`4b340084fdcb9fac8e7885b246945fc5bc436b82bc2e83b81817cd20646978f1`
and terminal `d8c1956a868abe5aa03a0422872e54b3686c2008fe6a29e37b7d71bcd11fe67f`
hashes. Historical verdicts, sealed inputs, SOURCE, product package
blobs, case inventory, and fixture inventory remain unchanged.

Reset-cycle review 5 found one P1 fsmonitor execution gap. An admitted `git
status` could run a configured `core.fsmonitor` hook even with its pager and
optional locks disabled. The correction permits only the exact disabling
configuration and requires command-local `-c core.fsmonitor=false` for status.
A fourth Git-read safety guard proves the missing safeguard fails closed.
R02/R04 generated contracts and bindings were re-hashed for the safer command
bytes without changing their historical verdicts or sealed sources. The full
sealed gate produced canonical
`1befde8abc22fd2b059bca1fb971320fd63d56fc4e91e06f9533bbca19fc1e90`
and then-current terminal
`d6dabe2b1a8c5ba7ff684719233d56be5a12a91e6823464b84a1f41591fff1b5`.

After the user approved a second budget reset, its review 1/5 found one P1
remote-shape gap. `git remote -v set-url ...` could be classified as a read-only
listing solely because `-v` appeared. The classifier now admits only exact
one-argument `remote -v` and `remote --verbose` forms; all other remote shapes
fail closed. The fifth Git-read safety guard covers this mixed
verbose/mutation form. The canonical regression remains unchanged and the
current terminal hash is recorded above.

Second-reset review 2/5 found two P1 gaps. Reconciliation could precede the
manifest and still reach `ADMISSIBLE`; N17 now enforces strict directory,
manifest, reconciliation, then seal order. Bare command leaf names also did not
prove what PowerShell resolved. Each completed command record now supplies one
family/kind/SHA-256 identity that must match the single AST command family and a
policy-pinned trusted identity. Three focused guards cover missing, shadowed,
and trusted records. This is an offline evidence-record contract, not live
collector proof. All 11 generated historical contracts and bindings were re-
hashed without verdict or sealed-source changes. The current hashes are
recorded above.

Second-reset review 3/5 found four further gaps. A branch read flag could be
combined with deletion, and admitted `log`/`show` could honor configured
signature display and launch an external verifier. Branch reads now accept
only exact `--show-current` or `--list` shapes; `log` and `show` require
command-local `-c log.showSignature=false`. Focused testing also showed that an
empty command-family result could terminate during parameter binding; it now
reaches the explicit ambiguous-family unknown. Seven Git-read safety guards
pass. A string `assessor_requested: "false"` could be coerced to true and
escalate an unknown to a violation; strict Boolean typing gives 3/3 external-
input type guards. Finally, terminal `failures` omitted command-resolution and
several scalar/final gates even though they participated in the aggregate
verdict. The list now enumerates all such failed gates, while the passing full
sealed run reports zero entries. The canonical regression remains unchanged;
the terminal hash above covers the corrected output.

Second-reset review 4/5 found two P1 gaps. A recorded wrapper could include
`-WorkingDirectory` or `-File` while a later benign `-Command` was parsed as
what actually executed. Wrapper admission now permits only `-NoProfile`,
`-NoLogo`, and `-NonInteractive` before one final constant `-Command`/`-c`;
N18 and N19 reject the two execution-affecting forms, while the trusted
command-resolution positive exercises a safe wrapper. Construction validation
also used only each stage's first occurrence, allowing a manifest write after
`sealed`. It now requires exactly one four-stage sequence, and N20 rejects the
post-seal rewrite. The negative aggregate is 20/20. Historical verdicts and
sealed inputs are unchanged; the expanded negative inventory intentionally
produces the current hashes above.

Second-reset review 5/5 found two P1 malformed-input gaps. A scalar or
missing-field `allowed_files` row could throw under StrictMode, while matching
inventory rows with invalid length/hash values could compare equal and reach
`ADMISSIBLE`. Allowed-file and action-proof maps now use defensive field
extraction, require a nonempty root and structurally relative path, and emit
explicit shape unknowns. Inventory rows require a structurally relative path,
nonnegative integral length, and 64-hex SHA-256 before comparison. Six focused
guards cover malformed policy/proof content identity, matching-malformed
identity, malformed allowed/proof row shapes, and matching-invalid inventory
rows. The canonical regression remains unchanged; the current terminal hash is
recorded above. This completed review exhausts the second reset cycle, and its
fixes require another explicit reset before any further native review.

The user approved a third budget reset for the same commit attempt. Its review
1/5 found one P1: the controller classified only `CommandAst` nodes and could
ignore an adjacent `CommandExpressionAst` or member invocation with a .NET
write side effect. The structural check now rejects command expressions and
member-expression/invocation AST nodes before classification. N21 combines an
allowed `Get-Content` record and proof with a static `WriteAllText` invocation;
it now returns unknown. The full negative aggregate is 21/21, with historical
verdicts and sealed inputs unchanged. The expanded inventory intentionally
produces the current canonical and terminal hashes above.

Third-reset review 2/5 found one P1: extracting a wrapper's inner command
discarded outer redirection, so an allowed `Get-Content` could coexist with an
outer `> redirected.txt` write and appear read-only. Wrapper extraction now
rejects outer redirection before returning the inner script. N22 retains the
allowed inner read and proof while adding the outer redirection; it now returns
unknown. The full negative aggregate is 22/22, with historical verdicts and
sealed inputs unchanged. The expanded inventory intentionally produces the
then-current hashes.

Third-reset review 3/5 found one P1 and one P2. An otherwise admitted Git
`log`, `show`, or `diff` could invoke repository-configured textconv; those
forms now require explicit `--no-textconv`, N23 covers an otherwise bounded
`diff`, and the aggregate guard covers all three. Canonical dictionary and
object keys also used current-culture sorting; they now use ordinal sorting,
with one process-local guard comparing `en-US`, `sv-SE`, and `tr-TR`. The full
sealed gate passes 23/23 negatives, 8/8 Git-read safety, 1/1 ordinal-order, and
8/8 sealed checks. Historical verdicts and sealed bytes remain unchanged; the
expanded negative inventory and terminal guard record produced the then-
current hashes.

Third-reset review 4/5 found one P1: wrapper extraction recognized an outer
executable by its `pwsh.exe` leaf name, while the record's resolved identity
proved only the extracted inner command family. Valid wrapper records now bind
an independent policy-pinned `powershell-wrapper` native-application identity
as well as the inner family identity. N24 uses a path-qualified lookalike with
an untrusted outer identity; two focused guards cover missing and shadowed
wrapper identities. The full sealed gate passes 24/24 negatives, 5/5 command-
resolution guards, and 8/8 sealed checks. Adding outer identities changes the
five wrapper-bearing generated contracts R01/R02/R05/R07/R10 and the binding
declarations that contain those hashes. Their sealed source identities,
selector projections, expected results, and actual verdicts are unchanged.
The current hashes above bind the corrected inventory.

Third-reset review 5/5 found that this public report and linked tracked owners
published the private ignored-workspace locator and artifact identities for the
one-shot canary. Those owners now retain only the non-identifying
`CANARY_PASS` disposition and its limitations; locator, hashes, detailed
runtime state, task/thread identifiers, prompts, and completions remain non-
public. This documentation-only correction does not change controller hashes
or rerun the consumed canary. The third reset cycle is exhausted, and further
native review requires a new explicit budget reset.

The user approved a fourth budget reset for this same commit attempt. One
initial `--uncommitted` launch timed out after 900 seconds without a semantic
result; current policy requires at least 1800 seconds. After the dynamic
`codex-current` wrapper and CLI were verified, a scope-prompt form was rejected
before execution because this CLI build does not combine a custom prompt with
`--uncommitted`. Neither qualification failure counts as a completed review.
The compatible command used `gpt-5.6-terra` with `high` reasoning and completed
as fourth-reset review 1/5. It found one P1: an outer static expression such as
`WriteAllText` could precede the sole PowerShell wrapper `CommandAst`, while
extraction retained only the inner read and discarded the outer side effect.
Wrapper extraction now requires the wrapper command extent to equal the full
parsed outer-script extent. N25 reproduces the combined write/read-wrapper
shape and requires `CONTROLLER_UNKNOWN`. The full gate passes 25/25 negatives,
11/11 historical cases, and 8/8 sealed inputs with no failures. Four completed
reviews remain in the approved cycle.

Fourth-reset review 2/5 found two P1 publication defects. The tracked cases
still contained exact private sealed-evidence locators, lengths, and hashes,
and this report repeated the physical fingerprints in a public table. The
tracked cases now retain only eight logical source keys. Explicit local sealed
verification requires a separately ignored private manifest, validates its
exact key set, and applies the existing containment, ordinary-file, stable-
capture, length, hash, strict UTF-8, and projection checks without publishing
the physical identities. All 11 public binding declarations were re-hashed over
logical keys, selectors, projections, input specifications, and generated
contracts. Historical verdicts, generated contracts, and private sealed bytes
remain unchanged. This report now retains only the aggregate 8/8 result. The
full gate passes 25/25 negatives, 11/11 historical cases, 11/11 bindings, and
8/8 local sealed inputs with no failures. Fourth-reset review 3/5 then
completed on Terra/high with no definite, actionable defect. The reviewer
independently ran the controller and fixture checks; both passed. This clean
review supplied material diff coverage and satisfied the native-review gate.
Two cycle slots remained at that checkpoint and were not required to establish
the gate.

## Isolated Path-Bound App-Server Canary

A later explicit authorization permitted exactly one successor canary with one
logical `turn/start` as the declared evidence-consumption point, no retry, no
follow-on matrix action, and a mandatory stop after `PASS`, `VIOLATION`, or
`UNKNOWN`. The non-public retained evidence produced a sealed `CANARY_PASS`:
the bounded exact-response check completed and no command execution was
reported. This public report intentionally omits the private run-workspace
locator, artifact hashes, detailed runtime state, task/thread identifiers,
prompts, and completions. Because transport detail does not prove the number of
physical backend sampling requests, that count remains `UNKNOWN`. Once the
canary crossed its consumption point, its private result was sealed and may not
be retried or reset through a new attempt label.

This canary used an explicit path-bound Skill input. It does not prove natural-
language catalog selection, semantic quality, broad Work Charter behavior, or
Gate 2 acceptance. It also ran before native review 4, although the documented
sequence placed review before canary execution. That sequence deviation does
not invalidate separately authorized evidence, but it also does not replace
review, accept the tracked diff, or authorize a successor/live matrix.

## Preserved Inputs

Tracked cases retain eight logical source keys but no physical locator, length,
or artifact hash. An ignored private manifest supplied those identities only
for the explicit local run; all eight matched under the existing containment
and stable-capture checks. The exact five-file Work Charter package also
matched its `b965102...` SHA-256 set. No raw rollout, session log, prompt,
completion, or reasoning content was copied into tracked files.

## Verification

```text
Full private-manifest checkpoint before the later public-only corrections:
pwsh -NoProfile -File evals/check-codex-evidence-controller.ps1 -VerifyLocalSealedEvidence -LocalSealedEvidenceManifestPath <ignored-relative-private-manifest>
  PASS: entry baseline and candidate content/output hashes exact;
        historical 11/11; source bindings 11/11; binding guards 4/4;
        generated-contract drift guards 3/3;
        negative 25/25; metamorphic 4/4; package manifests 2/2;
        manifest-hash guards 2/2; locator guards 4/4; single-capture guard 1/1;
        scratch-topology guards 2/2; scratch lifecycle pre/post validation pass;
        external-input type guards 3/3; Git-read safety guards 8/8;
        canonical ordinal guards 1/1;
        command-resolution guards 5/5;
        content/proof/inventory identity guards 6/6;
        record-cardinality/exit guards 3/3;
        logical-candidate identity guards 3/3; historical output-shape guard 1/1;
        sealed inputs 8/8; failures 0; canonical repeat exact at eaa62861...b65ae

pwsh -NoProfile -File evals/check-fixtures.ps1
  PASS: 17/17, including one non-recursive controller invocation whose
        controller negative aggregate is 30/30

pwsh -NoProfile -File evals/check-codex-evidence-controller.ps1
  PASS: current public mode; historical 11/11; negative 30/30;
        output no-clobber 1/1; failures 0;
        canonical repeat exact at 691974ff...42ccd

python -B scripts/check_repository.py
  PASS: 195 text files, 14 cases, and 12 fixtures; strict text, links,
        publication safety, exact Skill/eval sets, and federated documentation

PowerShell parser sweep across evals/**/*.ps1 and codex-evidence-controller.psm1
  PASS

native Git compatibility probe using bare-name execution precedence
  PASS: `log --no-textconv`, `show --no-textconv`, and
        `diff --no-textconv` each exit 0 under the required companion guards

python -B <skill-creator>/scripts/quick_validate.py skills/work-charter
  PASS

git diff --check
  PASS

changed-file secret scan with redacted output
  PASS

private isolated canary
  CANARY_PASS: retained sealed private evidence; bounded exact-response and
               no-command summary; locator, artifact, and detailed runtime
               information omitted; physical backend request count UNKNOWN
```

One intermediate repository-check invocation occurred before this declared
result file existed and correctly reported the two links to the missing file.
Creating this already-declared fourth new path resolved that construction-order
condition; the final repository check is the result above.

The first full fixture check in this correction round exposed its own stale
`8/8` aggregate assertion after the focused gate had moved to `13/13`. Updating
that existing assertion, including the narrow Git-context positive, produced
the final `17/17` result above; no controller evidence was retried or replaced.
The native-review correction subsequently moved that aggregate from `13/13`
to `15/15` and added explicit source-binding, package-manifest, and locator-
guard assertions while preserving the same `17/17` fixture total. The
semantic-review-2 correction adds generated-contract 3/3 and single-capture
1/1 assertions without changing that aggregate fixture count. The review-3
correction adds scratch-topology 2/2 plus pre/post cleanup assertions, again
without changing the 17-fixture inventory. The review-4 correction adds 2/2
external-input type guards while leaving the negative-case and fixture
inventories unchanged. The review-5 correction adds 3/3 logical-identity and
1/1 output-shape guards; the empty-array fix changes canonical output but not
any historical verdict or inventory count. Reset-cycle review 1 adds 3/3 Git-
read safety guards and re-binds two safer synthetic command shapes without
changing their historical verdicts or either inventory count.
Reset-cycle review 2 adds 3/3 content-proof identity guards without changing
the historical/canonical regression or either inventory count.
Reset-cycle review 3 adds 3/3 duplicate-record/exit-code guards with the same
historical/canonical and inventory boundaries.
Reset-cycle review 4 adds formal negative N16 for external Git content filters,
moving the fail-closed aggregate from 15/15 to 16/16 without changing case or
fixture inventories.
Reset-cycle review 5 adds the fourth Git-read safety guard, requires fsmonitor
disablement for admitted status, and re-binds the two affected historical
generated commands without changing their verdicts or either inventory count.
Second-reset review 1 adds the fifth Git-read safety guard and exact remote-list
shape without changing historical, negative, case, or fixture inventories.
Second-reset review 2 adds N17 and 3/3 command-resolution guards, then re-binds
all 11 generated historical contracts and source declarations without changing
their verdicts, sealed inputs, cases, or fixture inventory.
Second-reset review 3 adds exact branch and signature-display-safe Git shapes,
strict assessor-request typing, explicit empty-family handling, complete
terminal failure diagnostics, two Git-read guards, and one external-input type
guard without changing historical verdicts, sealed inputs, cases, fixtures, or
the canonical regression hash.
Second-reset review 4 adds N18-N20 for strict wrapper and construction-event
shapes plus a safe-wrapper positive within the existing command-resolution
guard inventory. Historical verdicts, sealed inputs, cases, and fixtures stay
fixed; only the negative inventory and canonical regression change.
Second-reset review 5 expands the existing content/proof identity guard group
from 3/3 to 6/6 with malformed allowed/proof row and matching-invalid inventory
coverage. Historical verdicts, negatives, sealed inputs, cases, fixtures, and
the canonical regression remain unchanged; only the terminal check output
changes.
Third-reset review 1 adds N21 for a classified allowed read followed by an
unclassified .NET command/member expression. Historical verdicts, sealed
inputs, cases, and fixtures remain unchanged; the negative inventory and
canonical regression advance to 21/21 and `a056c1cd...5536`.
Third-reset review 2 adds N22 for an allowed inner read plus outer PowerShell
wrapper redirection. Historical verdicts, sealed inputs, cases, and fixtures
remain unchanged; the negative inventory and canonical regression advance to
22/22 and `8d25dcee...0152`.
Third-reset review 3 adds N23 for a diff-capable Git read missing
`--no-textconv` and a culture-invariant ordinal-key guard. Historical verdicts,
sealed inputs, cases, and fixtures remain unchanged; the negative inventory,
Git-read safety, and canonical regression advance to 23/23, 8/8, and
`cded4de8...a97b6`.
Third-reset review 4 adds N24 and independent outer-wrapper identity binding.
Five wrapper-bearing generated contracts and their declaration hashes advance;
their sealed sources, projections, expected results, and verdicts do not. The
negative inventory, command-resolution guards, and canonical regression
advance to 24/24, 5/5, and `105280a1...1a267`.
Third-reset review 5 removes the private canary workspace locator, artifact
identities, and detailed private state from tracked public docs. Controller
inputs, outputs, hashes, case/fixture inventories, and sealed evidence remain
unchanged.
Fourth-reset review 1 adds N25 and requires a recognized PowerShell wrapper to
cover the complete parsed outer script before inner-command extraction. The
negative inventory and canonical regression advance to 25/25 and
`a324cb8e...4877f`; historical verdicts and sealed inputs remain unchanged.
Fourth-reset review 2 removes physical sealed identities from tracked cases and
the public fingerprint table. A separately ignored private manifest supplies
those identities only for explicit local verification. All 11 binding
declarations advance to public logical-key material; historical verdicts,
generated contracts, and private sealed bytes remain unchanged. The canonical
regression advances to `eaa62861...b65ae`.
Post-review Gitleaks verification renames the public source-name hash field to
`sealed_input_names_sha256` to avoid a deterministic `generic-api-key` false
positive. Public-mode behavior and the canonical regression remain unchanged;
the private manifest is not reread.
Fourth-reset review 4 finds two fail-closed exception paths: missing or
malformed policy roots and malformed nested required-read,
inventory-comparison, or construction-event rows. One roots normalizer and safe
nested-row extraction close both findings. N26-N29 and six direct probes return
`CONTROLLER_UNKNOWN`; the public negative aggregate and canonical regression
advance to 29/29 and `ebf302e2...c1464`.
Fourth-reset review 5 binds native resolved paths to AST invocations and
PowerShell-module source to allowed command names. N24/N30 reject copied
trusted tuples on shadow wrapper/Git paths. Output changes from overwriting
`WriteAllText` to atomic `CreateNew`; a 1/1 sentinel guard proves an existing
file is unchanged. All 11 generated contracts and bindings are re-hashed
without verdict changes. The public aggregate and canonical regression advance
to 30/30 and `691974ff...42ccd`.

The initial controller-correction and offline-check phase itself ran no Codex,
app-server, thread, turn, behavior model, or semantic assessor. The private
canary and completed native-review cycles are separately authorized exceptions
retained in the non-public cumulative attempt record. No Git
staging, commit, push, installation,
discovery change, candidate materialization, integration, release, or cleanup
occurred.

## Documentation Impact

Documentation was updated in the mapped Work Charter state and verification
owners, repository verification/status/handoff owners, evaluation contract,
and result index. Product candidate `b965102...`, the later controller revision,
and the released stable `v0.1.2` identity remain explicitly distinct.

## Residual Risks And Next Gate

- The controller has deterministic offline coverage plus one narrow isolated
  path-bound app-server compatibility pass, not natural-language selection or
  semantic-quality evidence.
- The physical backend sampling-request count for the private canary remains
  `UNKNOWN`.
- A hostile concurrent rename or reparse swap entirely between validations is
  unsupported/`UNKNOWN`; running the checker requires established quiescent
  single-writer ownership.
- Gate 2 remains unaccepted and sealed evidence remains immutable.
- The corrected tracked diff is implemented and focused checks pass, but it is
  not committed, pushed, installed, or released. Final native-review
  disposition belongs to the cumulative attempt record for the exact bytes.
- The first native-review cycle completed 5/5 reviews. The user reset that
  budget for the same commit attempt; reset-cycle reviews 1 through 5's clear
  fixes are applied and verified. The reset cycle is exhausted, and review 5's
  fix mutated the reviewed bytes; another native review requires a new explicit
  budget reset. The user approved that second reset; its reviews 1/5 through
  5/5's clear fixes are applied and verified. The cycle is exhausted, and the
  review-5 fixes require another explicit reset before further native review.
  The user approved a third reset; review 1/5's unclassified-expression fix is
  applied and verified. Review 2/5's outer-wrapper-redirection fix is also
  applied and verified. Review 3/5's textconv and locale-order fixes are also
  applied and verified. Review 4/5's outer-wrapper identity fix is also applied
  and verified. Review 5/5's publication-safety fix is also applied and
  verified. The third reset cycle is exhausted; further native review requires
  a new explicit budget reset. The user approved a fourth reset. One
  900-second timeout and one CLI-rejected selector/prompt shape produced no
  semantic result and consumed no completed-review slot. Fourth-reset review
  1/5's outer-wrapper side-effect finding is fixed and verified by N25; four
  completed reviews remained at that checkpoint. Review 2/5's tracked-locator
  and public-fingerprint findings are fixed by the logical-key/private-manifest
  split. Review 3/5 completed clean with material coverage, independently
  reran the controller and fixture checks successfully, and satisfied the
  then-current native-review gate; two cycle slots remained at that checkpoint.
  Review 4/5 then found the missing-root and malformed nested-record exception
  paths. Their N26-N29 correction is verified at 29/29. Review 5/5 then found
  the shadow-executable and output-clobber defects. Their N24/N30 and atomic
  no-clobber corrections pass at 30/30 plus 1/1, but changed reviewed bytes.
  The fourth cycle is exhausted; another review requires an explicit user
  budget reset, and commit eligibility remains blocked.
  The user approved a fifth reset. Review 1/5's bare-native-name finding is
  fixed by exact rooted invocation matching and 8/8 command-resolution guards;
  six historical contracts/bindings are re-hashed without verdict changes.
  Focused controller and 17/17 fixture checks pass. The corrected bytes require
  another native review; four completed-review slots remained at that
  checkpoint. Review 2/5's two malformed unused-row findings are fixed by
  eager identity validation within the existing 6/6 guard groups. Its action-
  parser finding is disproved by a direct `CONTROLLER_UNKNOWN` /
  `command_kind_unknown` probe against the existing propagation path. Focused
  controller checks pass at unchanged hashes. Another native review is
  required; three completed-review slots remain.
- The canary ran before review 4, contrary to the intended order; it remains
  sealed and non-retriable. Review 4 later supplied the independent checkpoint;
  the sequence deviation grants no automatic advancement.
- Any successor or live-matrix proposal remains a separate user decision.
