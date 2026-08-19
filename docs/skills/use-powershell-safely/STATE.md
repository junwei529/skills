# PowerShell State

Last updated: 2026-08-19

## Current Implementation

Canonical editable SOURCE is the five-file package under
[`skills/use-powershell-safely`](../../../skills/use-powershell-safely) with
one entry and three conditional references.

User Authority Revision P1 produced reviewed SOURCE commit
`30668743cdc6c8be00100fd48fa89376adf746f8` and exact five-file tree
`d8bf6dc74f106c386653cb3b598d50e790c38348`, integrated into immutable
`v0.2.0` release commit `ac790233d5a8ba5afafd6eef95b1d5bc3cbe83a6`
through committed ancestry. The released
`PRE_ERROR_SELECTION_AND_COMMAND_READINESS` delta adds pre-error
metadata selection for explicit non-trivial PowerShell while preserving
ordinary-cmdlet and POSIX-only negatives, plus deterministic command-readiness
guidance for parameter contracts, cmdlet error semantics, parse-only
validation, and four observed syntax traps. It does not change the three-
reference package shape.

Tested public candidate
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29` contains both the reviewed
boundary-hardening revision and the later native-example correction introduced
at `a150a8652111ad7a04b4b8a048e861ee5c91fc93`. The hardening adds
executable-discovery cardinality and identity, one-base path resolution,
cross-shell newline contracts, task-specific sandbox remediation, and a
strictly bounded confirmed-Junction fallback. It keeps frontmatter and the
three-reference structure unchanged.

The committed local correction follows the public exact-commit RC response
that omitted cardinality and stream handling from its user-runnable command.
The entry and native reference now require complete
candidate identity, arguments, actual stream disposition, exit status,
observed runtime/capability evidence, and any material text contract to survive
into the emitted command. The eval case makes those transfer fields explicit.
Frontmatter, metadata, the text and WSL references, and the three-reference
structure remain unchanged.

Immutable tag `v0.2.0` points to coherent release commit `ac790233...`; its
PowerShell subtree is exact reviewed P1 tree `d8bf6dc...`. The current active
stable copy was materialized from that tag through the official installer and
matches all five tag blobs. The retained rollback copy contains exact
`v0.1.2` control bytes.

The current unreleased ES-C1 revision preserves the released five-file shape
and the existing `ApplicationInfo` multi-candidate regression. It separates
executable resolution, exact-path launch, normalized output contract, typed
native exit, and support status for `pwsh`; adds application-only zero/one/many
WSL discovery and immediate typed exit handling; and narrows selection to
material shell boundaries while retaining pre-error selection for genuinely
non-trivial PowerShell. Ordinary cmdlets, simple native near-neighbors, general
Windows work, and POSIX-only work are explicit negatives. The unrelated empty-
byte-array closeout incident did not reproduce in current SOURCE and is
rejected as a product residual.

## Current Writer

The P1 SOURCE and release writers relinquished after their recorded commits
and all-worktree reconciliation. The current bounded repository writer is the
ES-C1 tranche B successor on `codex/es-c1-coordination-contracts`; it owns only
the approved current-SOURCE, deterministic evaluation, mapped documentation,
verification, and one local commit window. No live WSL, installation, push,
tag movement, release asset, integration, cleanup, or host mutation is
authorized.

## Evidence State

The P1 revision has deterministic SOURCE-development evidence plus one bounded
fresh selection tranche. Static contracts, synthetic parameter/error and
parser/runtime pairs, dual-runtime focused checks, package validation, and
repository checks pass. At exact commit `30668743...`, one matched pre-error
positive loaded the P1 Skill before the first risky command while immutable
`v0.1.2` did not; ordinary-cmdlet and POSIX-only negatives did not load it.
This is `PRE_ERROR_SELECTION_OBSERVED / NARROW_PASS`, not broad selection or
selected-behavior efficacy. The target command did not execute, model and
reasoning identities remain `UNKNOWN`, and no assessor ran. The private sample
audit remains intake only and is not product or application-defect evidence.

The current ES-C1 deterministic boundary suite passes 59 assertions under the
exact selected PowerShell 7 and Windows PowerShell 5.1 executables. Synthetic
coverage includes existing ApplicationInfo cardinality, `pwsh` nonzero/empty/
malformed readiness, WSL application candidate cardinality and typed exit, and
destructive-filesystem pre-error selection plus ordinary-cmdlet, simple-native,
general-Windows, and POSIX-only negatives. It
does not use live WSL or prove native catalog selection, loaded-copy behavior,
selected execution, installed state, or efficacy.

The exact `ac790233...` RC later completed one PowerShell positive, the
ordinary-cmdlet negative, the POSIX-only negative, and one independent
assessor. The positive loaded the candidate entry and relevant references
before returning safe guidance; neither negative loaded a target Skill. The
assessor returned `ACCEPTED` with no finding. After stable installation, a
fresh canary physically loaded the active stable entry plus native/process and
text/encoding references and returned a complete non-executing command shape.
These results prove exact loaded-copy routing and bounded selection behavior;
the target command still did not execute and they do not prove broad behavior,
live WSL/Bash, sandbox-denial injection, shadow use, or efficacy.

The released `v0.1.1` revision has exact-source, DEV_DISCOVERY, RC, and stable
loaded-copy evidence. The later public hardening passes fifteen
deterministic assertions under PowerShell 7 and Windows PowerShell 5.1 and all
repository checks recorded at its run. Three fresh SOURCE-assisted behavior
contexts plus one same-context follow-up passed the current hardening matrix,
and an independent fresh assessor returned `ACCEPTED` with all eight Must
surfaces passing.

The public exact commit was then materialized as an isolated five-file
`RC_INSTALL`. Candidate identity, native positive selection, actual loaded
entry plus native/text references, and an ordinary-cmdlet non-trigger pass.
The loaded positive response omitted fail-closed executable cardinality and
separate stream capture, so an independent RC assessor returned
`CORRECTION_REQUIRED`.

The correction introduced at `a150a865...` and now contained in tested
candidate `c42eef3...` passed the Skill validator, repository checker, fifteen
deterministic assertions under both PowerShell 7 and Windows PowerShell 5.1, an
executed separate-stream process smoke, and a final fresh fixture run with an
independent `ACCEPTED` verdict. This is SOURCE-assisted development evidence
later committed and published. A subsequent isolated exact-commit `c42eef3...`
RC proved the corrected five-file loaded copy, two positive relevant-reference
runs, ordinary-cmdlet and POSIX-only non-selection, complete safe command
transfer, an executed controller boundary, dual-runtime deterministic checks,
and an independent `READY_FOR_RELEASE_CANDIDATE` verdict.
The later tag-pinned `v0.1.2` stable copy matched all five package blobs and a
fresh canary actually loaded the entry plus native/process and text/encoding
references. It diagnosed the nested-command argument boundary and emitted a
guarded `ProcessStartInfo.ArgumentList` shape while keeping a policy-blocked
runtime probe explicitly unverified. Live Bash/WSL, actual sandbox-denial
injection, native execution inside that stable canary sandbox, and bounded
shadow-use evidence remain absent. See [Verification](VERIFICATION.md).

## Next Gate

For the current ES-C1 SOURCE revision, complete package validation, dual-
runtime parser/boundary checks, fixture/repository closure, publication/privacy
checks, native review, and only the authorized local tranche B commit. Live
WSL/Bash, installed-copy mapping, selection or behavior models, sandbox-denial
injection, shadow use, broader efficacy, release, integration, and cleanup
remain separate decisions.

## Recovery Entry

1. Read [`AGENTS.md`](../../../AGENTS.md), the repository
   [Authority Map](../../AUTHORITY.md), and [Decision 0014](../../decisions/0014-powershell-portable-guidance-and-private-host-delta.md).
2. Read [Design](DESIGN.md), this state, and
   [Verification](VERIFICATION.md).
3. Inspect local/public Git identities and current writer/dirty scope against
   [Repository Handoff](../../HANDOFF.md).
4. Recompute the five SOURCE hashes before attributing any behavior.
5. Keep reviewed SOURCE `30668743...`, release/tag `ac790233...`, current stable
   `v0.2.0`, retained rollback `v0.1.2`, and earlier candidates distinct even
   when a package byte set matches.
