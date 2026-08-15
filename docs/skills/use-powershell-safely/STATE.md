# PowerShell State

Last updated: 2026-08-15

## Current Implementation

Canonical editable SOURCE is the five-file package under
[`skills/use-powershell-safely`](../../../skills/use-powershell-safely) with
one entry and three conditional references.

User Authority Revision P1 produced reviewed SOURCE commit
`30668743cdc6c8be00100fd48fa89376adf746f8`, now integrated into local `main`.
The unreleased `PRE_ERROR_SELECTION_AND_COMMAND_READINESS` delta adds pre-error
metadata selection for explicit non-trivial PowerShell while preserving
ordinary-cmdlet and POSIX-only negatives, plus deterministic command-readiness
guidance for parameter contracts, cmdlet error semantics, parse-only
validation, and four observed syntax traps. It does not change the three-
reference package shape or the immutable `v0.1.2` release.

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

Immutable tag `v0.1.2` at
`ceed607152849775b981c54add74bfa30d858e4d`, its GitHub Release, and the
verified stable installed copy contain this current five-file revision.

## Current Writer

The P1 SOURCE writer completed reviewed commit `30668743...`, reconciled the
registered worktrees, and relinquished before local-main integration. A
separately authorized evidence-sync writer now owns only the eight existing
documentation consumers named in Repository Handoff, through one reviewed
local commit in the retained task worktree. That commit is the terminal writer
action and relinquishes at its integration gate. The lease does not authorize
SOURCE, case, fixture, controller, installed-copy, formal candidate, RC,
stable, release, push, integration, cleanup, Work Charter, or Project Docs
changes.

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

After the reviewed local evidence-sync commit, the next gate is explicit
integration authorization for that documentation-only commit. A formal
candidate/RC decision remains separate and would need fresh loaded-copy and
selected-behavior evidence; the narrow selection observation does not
authorize it. Stable installation, release, live WSL/Bash, sandbox-denial
injection, shadow use, private-global retirement, retained-evidence cleanup,
and rollback-copy cleanup remain separate decisions. Released `v0.1.2` and its
installed copy are unchanged.

## Recovery Entry

1. Read [`AGENTS.md`](../../../AGENTS.md), the repository
   [Authority Map](../../AUTHORITY.md), and [Decision 0014](../../decisions/0014-powershell-portable-guidance-and-private-host-delta.md).
2. Read [Design](DESIGN.md), this state, and
   [Verification](VERIFICATION.md).
3. Inspect local/public Git identities and current writer/dirty scope against
   [Repository Handoff](../../HANDOFF.md).
4. Recompute the five SOURCE hashes before attributing any behavior.
5. Keep the tested `c42eef3...` candidate, released `v0.1.2` stable copy, and
   earlier `58fc526...` isolated RC distinct even though the current package
   bytes match.
