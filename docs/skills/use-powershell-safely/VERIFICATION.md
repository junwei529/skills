# PowerShell Verification

Last updated: 2026-08-15

## Claim Ledger

| Claim | Status |
|---|---|
| The current package has one entry and exactly three conditional references | verified structurally |
| P1 metadata and case contract cover `.ps1`, `pwsh`, `powershell.exe`, and non-trivial PowerShell before the first related command | verified statically and observed in one bounded fresh selection cell at exact commit `30668743...`; broad Harness selection efficacy remains unproved |
| P1 ordinary version-independent cmdlet and POSIX-only negatives remain explicit | verified statically and observed as two bounded fresh non-selection controls |
| P1 revision-relative pre-error selection | `PRE_ERROR_SELECTION_OBSERVED / NARROW_PASS`: the exact P1 copy loaded before the first risky command in one matched positive, while immutable `v0.1.2` did not load for the same request |
| P1 parameter, cmdlet-error, parser, and automatic-variable readiness | 41 focused assertions pass under PowerShell 7 and Windows PowerShell 5.1 |
| Coherent `v0.2.0` release-set package identity | PowerShell is `changed`; exact reviewed P1 tree `d8bf6dc74f106c386653cb3b598d50e790c38348` is preserved from SOURCE commit `30668743...`, while `a7637a6...` contributes evidence-sync facts but is not a new SOURCE revision |
| Released portable guidance handles the recorded native, text, WSL, version, locale, sandbox, and destructive boundaries | seven fresh development scenarios pass |
| Ordinary cmdlet and POSIX-only work remain outside the Skill | catalog-assisted and controlled native negatives pass |
| Released DEV_DISCOVERY, exact-commit RC, and stable loaded-copy identity | verified |
| Current public hardening preserves cardinality, LF bytes, one-base paths, and confirmed-Junction link-only removal | fifteen assertions pass under PowerShell 7 and Windows PowerShell 5.1; SOURCE-assisted behavior independently accepted |
| Boundary-hardening exact-commit RC identity, native selection, and loaded copy | verified at historical public `58fc52600df0e1dc3abd92ba31f031ee2b07db82` |
| Boundary-hardening RC behavior acceptance | `CORRECTION_REQUIRED`; the loaded response omitted fail-closed executable cardinality and separate stream capture |
| Current public native-example correction behavior | final fresh SOURCE-assisted fixture run independently `ACCEPTED`; introduced at `a150a865...` and contained in tested `c42eef3...` |
| Current corrected exact-commit RC identity and behavior | exact-commit `c42eef3...` loaded-copy positives/negatives, controller boundary, and independent readiness pass |
| Current hardening stable identity and guarded native/text diagnosis | tag-pinned `v0.1.2` five-file identity and fresh loaded-copy canary pass |
| Live Bash/WSL, native execution inside the stable canary sandbox, actual sandbox denial, or shadow use | unverified |
| General efficacy, token savings, broad trigger accuracy, or cross-Harness parity | unverified |

## Unreleased P1 SOURCE Identity

The five SOURCE files on `codex/use-powershell-safely-next` were decoded as
strict UTF-8, normalized to LF with one final newline, and hashed with SHA-256:

```text
SKILL.md
  fdd28fe8e7770ea0d6ef924eddfe66ed5584c75e99c18405bbf7b5ffeed9f21d
agents/openai.yaml
  3b61f94eec7d23407bd114a80281e2ddee7ea463d39cfc50d1ab3d172cf142df
references/native-process-boundaries.md
  73425524b0d42bcab63f12a17510d6efc29d3efc6c2f523e774cd7304c824e10
references/text-encoding-boundaries.md
  ca1fb4c3caea1c045ab06ebd348a9cfd39863e86faf12e4a7a2548f172a69f96
references/windows-wsl-boundaries.md
  5674d97ac52c6c8b05c8f57acae8ba5970afbdab3a1828ba62297038e450ffb7
```

This identity implements the bounded
`PRE_ERROR_SELECTION_AND_COMMAND_READINESS` residual. It was later
materialized as one task-private isolated exact-commit copy for the bounded
selection evidence below. That materialization was not a discovery mapping,
installed copy, formal candidate, RC, stable update, tag, or release.

## Coherent `v0.2.0` Candidate Boundary

The local release-set candidate preserves all five P1 package blobs from
reviewed SOURCE commit `30668743cdc6c8be00100fd48fa89376adf746f8` and required
tree `d8bf6dc74f106c386653cb3b598d50e790c38348`. Descendant `a7637a6...`
contributes only the recorded deterministic and narrow selection evidence
facts; it does not define a new PowerShell SOURCE revision. Phase 1 runs no
model, product, or assessor turn and creates no isolated install, loaded-copy,
RC, stable, tag, or release evidence.

## 2026-08-15 P1 Deterministic Evidence

The focused boundary checker passed 41 assertions under the installed
PowerShell 7 and Windows PowerShell 5.1 hosts. It proves only these synthetic
mechanisms and static contracts:

- pre-error metadata and case markers cover `.ps1`, `pwsh`, `powershell.exe`,
  and non-trivial PowerShell while retaining ordinary-cmdlet and POSIX-only
  negatives;
- parse-only guidance is bound to the same exact PowerShell executable/version
  that will run the target;
- `New-Item -LiteralPath` is rejected and creates no target, while its actual
  `-Path` shape creates and verifies the intended directory;
- a child PowerShell process can return zero after a non-terminating cmdlet
  error with no artifact, while the corrected narrow fail-closed shape rejects
  the missing input and verifies the artifact on success;
- three invalid/valid parse pairs cover variable-colon boundaries, literal
  scope-prefix regex text, and statement-form `foreach` before a pipeline; and
- one syntactically valid runtime pair exposes and corrects the automatic
  `$Matches` collection collision.

The bundled Skill validator and repository checker pass. The aggregate fixture
checker passes all four PowerShell rows, including the new pair manifest, but
its overall command remains nonzero at the excluded Work Charter Gate 2 runner
regression already present in the clean base. No Work Charter file was changed
or reclassified as a PowerShell defect. No model or assessor path ran in this
deterministic tranche.

## 2026-08-15 P1 Minimal Selection Evidence

One separately authorized, task-private DEV selection tranche compared the
exact P1 revision with the immutable `v0.1.2` control without changing any
installed or discovered Skill copy. The P1 materialization matched all five
Git blobs and the normalized SOURCE hashes above. A zero-model catalog probe
surfaced exactly one PowerShell entry for each isolated workspace, resolved
each entry to its intended materialization, and reported no omission or
truncation signal.

The task-private carrier bound the exact Harness executable identity without
publishing its local version, path, or hash. The Harness did not expose the
model or reasoning identities, so both remain `UNKNOWN`. Two pre-evidence
launch attempts were excluded: one failed in the local controller shape before
model work, and one stopped at the restricted network transport. After the
authorized corrected transport canary returned the exact `TRANSPORT_OK`
response with no command or Skill read, the counted cells began.

| Counted cell | Observation |
|---|---|
| Exact P1 positive | The agent loaded exact `SKILL.md`, then the native/process reference, before attempting the named `.ps1` command. The read-only policy declined execution, so selection timing is observed but command behavior is not. |
| Immutable `v0.1.2` matched positive | Under the same request, the agent attempted the command without loading the stable Skill entry or a reference. Execution was likewise declined. |
| Exact P1 ordinary-cmdlet negative | The agent did not load the Skill before attempting the ordinary version-independent cmdlet; execution was declined. |
| Exact P1 POSIX-only negative | The agent did not load the Skill and returned a direct Bash shape without executing a command. |

The bounded conclusion is therefore
`PRE_ERROR_SELECTION_OBSERVED / NARROW_PASS`. It supports a revision-relative
selection signal for this one matched positive plus the two required negative
families. It does not prove selected command-readiness behavior, broad trigger
accuracy, real-project efficacy, token savings, cross-Harness parity, or RC or
stable readiness. The target command never executed, no independent assessor
ran, and raw prompts, logs, task identifiers, and private locators remain
unpublished.

## Released `v0.1.2` SOURCE Identity

The five released SOURCE files were decoded as strict UTF-8, normalized to LF
with one final newline, and hashed with SHA-256:

```text
SKILL.md
  fd487e0a073bfefcd714fc3d4ba97da96029d53f6e85db73a7f12691228f5714
agents/openai.yaml
  87f47ad02d7a15ee309bfad896ea53eabfcff877ce51c7a8be149adc60b7bf68
references/native-process-boundaries.md
  49e0f18988f476702bf49d52433d28bcf3bb397c46d4c4172c209f0c0acd9a8a
references/text-encoding-boundaries.md
  ca1fb4c3caea1c045ab06ebd348a9cfd39863e86faf12e4a7a2548f172a69f96
references/windows-wsl-boundaries.md
  5674d97ac52c6c8b05c8f57acae8ba5970afbdab3a1828ba62297038e450ffb7
```

These hashes identify SOURCE introduced at
`a150a8652111ad7a04b4b8a048e861ee5c91fc93` and contained in tested public
candidate `c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` and immutable stable release
`v0.1.2` at `ceed607152849775b981c54add74bfa30d858e4d`. Loaded-copy evidence is
recorded separately below.

## 2026-07-31 Native-Example Correction

The public hardening's RC loaded the intended copy but omitted its diagnostic
cardinality and stream rules from the final command. The later SOURCE
correction therefore adds one core native-example transfer contract and one
detailed process pattern:

- every discovered executable example normalizes application candidates and
  resolves zero/one/many or states one explicit precedence rule;
- argument arrays, exact executable identity, actual stream disposition, and
  numeric exit status remain visible;
- version-specific commands require observed runtime and capability evidence,
  not only a future guard; and
- JSON, text, encoding, BOM, newline, and byte branches close against the
  actual producer and consumer.

The Skill validator, repository checker, Git whitespace check, and fifteen
PowerShell boundary assertions under PowerShell 7 and Windows PowerShell 5.1
passed after the correction. A separate process smoke obtained distinct
stdout `out`, stderr `err`, and exit `7` through the documented
`ProcessStartInfo.ArgumentList` shape.

Fresh iterations did not receive the prior failure or expected answer. Earlier
assessments returned `CORRECTION_REQUIRED` when responses omitted material
stream capture, text closure, or an actually observed runtime. The final
single-contract fixture run reported the current PowerShell runtime and
capability, exact executable selection under stated bare-name precedence,
spaced-path transport, separate streams, verifier exits `0` and `2`, wrapper
exit `1`, and the verifier's real UTF-8/BOM/JSON contract. A final independent
assessor matched all five current hashes and returned `ACCEPTED`.

The first native review then found two P2 transfer defects in the
`ProcessStartInfo` example: assigning an `ApplicationInfo` directly could
re-resolve a same-named executable, and a successful capability guard did not
emit its observed result. The example now passes the selected `.Path`, emits
runtime plus capability before construction, and was executed against a child
process with separate stdout, stderr, and exit status. A new fresh runner and
independent assessor matched the corrected hashes and returned `ACCEPTED`.

This behavior was produced against then-dirty SOURCE, introduced by commit
`a150a865...`, and is now contained in tested candidate `c42eef3...`. It does
not by itself supersede the earlier exact-commit RC verdict or establish native
selection, a loaded corrected copy, another RC, stable, shadow-use, tag, or release evidence. The
[sanitized result](../../../evals/results/2026-07-31-powershell-native-example-correction.md)
owns the detailed iterations and limits.

## 2026-07-31 Boundary-Hardening Evidence

The authorized SOURCE-only revision generalized:

- zero/one/many executable discovery and scalar-string indexing;
- LF-to-CRLF bridge failures at Unix-style consumers;
- paths resolved or joined against more than one base;
- process-creation, program-exit, and write-denial classification; and
- nonrecursive confirmed-Junction removal that retains the target.

[`evals/check-powershell-boundaries.ps1`](../../../evals/check-powershell-boundaries.ps1)
passed fifteen assertions under both a PowerShell 7 process and Windows
PowerShell 5.1. It verified two synthetic application candidates, scalar
normalization, UTF-8 without BOM plus LF and final `0A`, a CRLF trailing-`0D`
control, one-base path resolution, and link-only Junction removal with a
retained sentinel. Both task-specific temporary roots were removed.

This check did not run a live Bash/WSL consumer, inject an actual sandbox
denial, or establish symbolic-link, mount-point, or unknown reparse behavior.
No fresh agent, discovery, installed copy, candidate, stable install, global
rule, private reference, tag, remote, or release changed. The full
[sanitized result](../../../evals/results/2026-07-31-powershell-boundary-hardening.md)
owns commands, hashes, limits, and the recorded 146-file/11-case/10-fixture
check result.

### Current SOURCE behavior and independent assessment

Three fresh read-only contexts used the five frozen canonical SOURCE hashes
directly and independently recomputed them. A same-context follow-up completed
the native runner's direct zero/one/many and resolve-once observations.

The behavior evidence covered:

- application-only discovery, explicit candidate identity, normalized
  cardinality, scalar-string avoidance, fail-closed ambiguity, a spaced path,
  direct argument arrays, streams, and immediate native exit capture;
- one-base path resolution that left an already rooted path unchanged;
- UTF-8 without BOM, CRLF versus LF, final newline, JSON/text semantics,
  raw-byte hashes, and no unsupported locale or CJK diagnosis;
- synthetic post-start cache write denial with task-specific remediation and
  no broad permission or system change;
- confirmed-Junction identity, containment, retained target/sentinel, explicit
  authorization, bounded nonrecursive fallback, and no actual removal; and
- routine-cmdlet, POSIX-only, and valid-English-byte negative controls.

A separate fresh assessor read the contract, complete SOURCE, raw tasks and
outputs, deterministic evidence, fixtures, and manifests without using a
controller conclusion. It independently matched all hashes, rated all eight
Must surfaces `PASS`, found no SOURCE Must defect, and returned `ACCEPTED`.
The outside-run-root manifest and Git status had zero delta during the runs.

This is SOURCE-assisted development behavior, not native selection,
`DEV_DISCOVERY`, loaded-copy, candidate, stable, live Bash/WSL, actual
sandbox-denial, shadow-use, commit, or release evidence. See the
[sanitized result](../../../evals/results/2026-07-31-powershell-boundary-hardening.md).

### Exact-commit RC and loaded-copy gate

The supported installer materialized the five-file package from public exact
commit `58fc52600df0e1dc3abd92ba31f031ee2b07db82` into one ignored,
repository-scoped `RC_INSTALL`. Every installed file matched its public Git
blob and raw plus normalized SHA-256, decoded as strict UTF-8 without BOM,
used LF with one final newline, and was not a reparse point. The installed
candidate passed the bundled Skill validator, and the existing `v0.1.1`
stable copy remained unchanged.

Fresh processes used a documented process-local per-path disable for the older
stable entry without changing persistent configuration. Exactly one same-named
candidate remained selectable in the test scope. The positive task implicitly
loaded the RC entry and native/text references, but not its WSL reference,
stable entry, or private fallback. The ordinary `Get-Date` negative loaded no
Skill.

The positive diagnosis correctly classified nested command-string argument
transport, spaced-path handling, immediate native exit capture, and
pre-process policy rejection. Its user-visible safe example nevertheless
selected an executable without the required zero/one/many cardinality and
fail-closed rule and did not separate stdout from stderr. A separate fresh
assessor therefore returned `CORRECTION_REQUIRED`.

This proves boundary-hardening exact-commit RC materialization, native
selection, and loaded-copy identity at `58fc526...`, but not accepted RC
behavior or a loaded copy of the later correction. The
[sanitized RC result](../../../evals/results/2026-07-31-powershell-hardening-exact-commit-rc.md)
owns the attempts, verdict, and limitations.

## Released Development Evidence

### 2026-07-30 — Portable-guidance migration

The revision later released as `v0.1.1` had these recorded raw identities:

```text
SKILL.md
  5bbdc428febfebede4144f98d25d7952a4dfe9e6bafc90711b32a22dc17fa70f
agents/openai.yaml
  87f47ad02d7a15ee309bfad896ea53eabfcff877ce51c7a8be149adc60b7bf68
references/native-process-boundaries.md
  476f735f012a12739ebe1193fe331f26f0b6120c8753ec0cb4c8a7327a5d643c
references/text-encoding-boundaries.md
  fef6a7eaab548e90752c3720021ee8c0e5dba532caab44b95ee915ead81a0af8
references/windows-wsl-boundaries.md
  5674d97ac52c6c8b05c8f57acae8ba5970afbdab3a1828ba62297038e450ffb7
```

Seven isolated scenarios passed Windows PowerShell 5.1 argument/UTF-8 and
`NativeCommandError` branches, PowerShell 7.3/7.4 native and redirection
branches, staged WSL identity/path/stream/exit diagnosis, legacy CJK versus
valid English bytes, a useful-but-gated PowerShell 7 recommendation, and
sandbox plus destructive stop boundaries. Two catalog-assisted negatives
declined an ordinary cmdlet and POSIX-only task without loading the body.

A separately authorized DEV_DISCOVERY junction resolved directly to SOURCE.
The positive native canary implicitly selected the Skill, loaded only the entry
and two relevant references, reproduced direct exit `0`, broken-wrapper exit
`1`, and split-argument exit `2`, and classified parser transport rather than
JSON corruption. The ordinary `Get-Date` canary did not load the Skill body.
This was development identity only. The
[portable-guidance result](../../../evals/results/2026-07-30-powershell-portable-guidance-migration.md)
preserves the full scenario and limitation record.

### 2026-07-28 — Earlier revision

Four fresh behavior contexts produced three passes and one partial WSL result;
the partial answer did not preserve the unknown PowerShell minor/native mode or
separately isolate WSL user, cwd, stdout, and stderr. A POSIX-only canary
declined the Skill. This is historical evidence for older SOURCE, not current
acceptance. See the
[historical result](../../../evals/results/2026-07-28-powershell-forward-tests.md).

## Candidate And Stable Evidence

### 2026-08-01 — `v0.1.2` stable installed-copy proof

The immutable repository tag `v0.1.2` resolved publicly to
`ceed607152849775b981c54add74bfa30d858e4d`. `$skill-installer` materialized
all three packages from that exact tag into an isolated staging root before
the approved stable update. The PowerShell candidate contained exactly five
ordinary non-reparse files; every file matched its tag Git blob, decoded as
strict UTF-8 without BOM, and used LF with one final newline. The installed
stable package repeated the same identity and passed the Skill validator.

An isolated repository-scoped `.agents/skills/use-powershell-safely` entry
resolved to the verified stable target. A fresh read-only boundary process
selected that sole same-named entry, and native events recorded reads of the
stable `SKILL.md` plus native/process and text/encoding references. It diagnosed
nested-command argument splitting, kept the spaced path as one
`ProcessStartInfo.ArgumentList` element, preserved stdout/stderr/exit semantics,
and checked the fixture as strict UTF-8 without BOM, LF-only with one final
newline, valid JSON, and representative non-ASCII text. Native runtime probes
denied by the read-only sandbox were explicitly left unverified rather than
inferred. The shared ordinary-task negative exposed all three stable entries
but executed no Skill or reference read. Controller-side discovery-target and
Git-blob checks own revision identity.

The prior `v0.1.1` stable package was preserved as an exact rollback copy.
Persistent Codex configuration, SOURCE, and tracked repository state did not
change during installation or canaries. This proves current stable identity
and one guarded native/text diagnosis, not live Bash/WSL, native execution
inside the stable canary sandbox, actual sandbox-denial injection, broad
trigger accuracy, shadow use, causal efficacy, or cross-Harness parity.
Repository tag, stable-set, and GitHub Release evidence is recorded in
[root Verification](../../VERIFICATION.md).

### 2026-08-01 — Current `c42eef3` corrected exact-commit RC

`$skill-installer` materialized the five-file package from public exact commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` into one unique ignored
`RC_INSTALL`. Every candidate file matched its Git blob and current raw hash,
decoded as strict UTF-8 without BOM with LF-only text and one final LF, and was
an ordinary non-reparse file. The candidate validator passed.

Two fresh positives loaded the candidate entry plus native/process and
text/encoding references, but not the WSL reference, stable entry, or private
fallback. The response preserved executable zero/one/many cardinality, exact
identity and argument boundaries, separate stdout/stderr, numeric exit,
observed runtime/capability, and the UTF-8/BOM/newline/JSON contract. An
ordinary cmdlet and a POSIX-only negative loaded no PowerShell Skill.

A controller executed the synthetic boundary under PowerShell Core 7.6.3:
`ArgumentList` was available, the direct invocation returned stdout `valid`,
empty stderr, and exit `0`, while the broken wrapper emitted the split-argument
error on stderr and exited `1`. PowerShell 7 and Windows PowerShell 5.1 each
passed fifteen deterministic assertions. An independent assessor returned
`READY_FOR_RELEASE_CANDIDATE`.

Eight pre-behavior controller, launcher, transport, or parser failures and one
later filename typo were excluded. Policy-blocked fresh-process commands were
retained as Harness limits; controller execution was attributed separately.
Stable `v0.1.1`, persistent configuration, SOURCE, and tracked repository state
were unchanged during the run.

This establishes corrected exact-commit RC identity, loaded-copy attribution,
the safe native/text transfer, and applicable non-selection. At that checkpoint
it did not prove current stable behavior, live WSL/Bash, actual sandbox denial, real-project
shadow use, broad trigger accuracy, causal efficacy, token savings,
cross-Harness parity, tag, or release. The
[sanitized result](../../../evals/results/2026-08-01-powershell-c42eef3-exact-commit-rc.md)
owns the detailed attempts and limitations.

At public exact commit
`b0099c9d5ad986be5e893ceea13f1fc8b5aea384`, a first test-home attempt was
invalid because a development copy remained discoverable and was actually
loaded. It is excluded from RC evidence.

The corrected repository-scoped `RC_INSTALL` exposed only one ordinary
five-file candidate. All files matched Git blobs and the released hashes,
decoded as strict UTF-8 without BOM, and were not reparse points. The positive
canary implicitly loaded only the entry plus native/process and text/encoding
references and diagnosed the parser/argument boundary; `Get-Date` did not load
the Skill. Controller runs reproduced exits `0`, `1`, and `2` with separated
streams.

The shared candidate
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09` repeated the same identity and
positive/negative behavior with Project Docs and Work Charter in one isolated
scope. Failed preflights involving discovery isolation, prompt transport, or
semantic completion were excluded.

The coherent `v0.1.1` candidate
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42` repeated exact-commit proof.
Immutable tag `v0.1.1` resolved to that commit, and the tag-pinned stable entry
was actually loaded in a fresh read-only process and preserved the requirement
to capture `$LASTEXITCODE` immediately. The boundary hardening has its own
exact-commit RC materialization and loaded-copy evidence, but its independent
RC behavior verdict is `CORRECTION_REQUIRED`. The later correction now in
candidate `c42eef3...` has its own loaded corrected RC proof and is now
contained in the verified `v0.1.2` stable copy recorded above.

Repository-level shared candidate, tag, installation, and release evidence is
owned by [root Verification](../../VERIFICATION.md).

## Required Checks

For any current PowerShell change:

```text
python -B <skill-creator>/scripts/quick_validate.py skills/use-powershell-safely
pwsh -NoProfile -File evals/check-powershell-boundaries.ps1
powershell.exe -NoProfile -File evals/check-powershell-boundaries.ps1
python -B scripts/check_repository.py
pwsh -NoProfile -File evals/check-fixtures.ps1
PowerShell parser check across evals/**/*.ps1
git diff --check
gitleaks dir . --no-banner --redact --no-color --exit-code 1
```

SOURCE, DEV_DISCOVERY, RC_INSTALL, and STABLE_INSTALL identity and behavior
must be attributed separately.
