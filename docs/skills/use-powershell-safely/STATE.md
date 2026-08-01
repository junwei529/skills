# PowerShell State

Last updated: 2026-08-01

## Current Implementation

Canonical editable SOURCE is the five-file package under
[`skills/use-powershell-safely`](../../../skills/use-powershell-safely) with
one entry and three conditional references.

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

The installed `v0.1.1` package predates this revision and must not be
described as containing it.

## Current Writer

No PowerShell writer is active. The native-example correction was committed and
published on `main`, and its controller relinquished. A new corrected-copy RC,
stable update, private-global changes, tag, and release all require later
separate authority.

## Evidence State

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
Stable installation, live Bash/WSL, actual sandbox-denial, and bounded
shadow-use evidence remain absent. See [Verification](VERIFICATION.md).

## Next Gate

PowerShell is `READY_FOR_RELEASE_CANDIDATE` at exact commit `c42eef3...`.
After the repository evidence-only commit and push gate, the next lifecycle
decision is whether to map a new immutable repository tag to that tested
commit and repeat tag-pinned stable installed-copy proof. Stable update,
private-global retirement, retained-evidence cleanup, tag, and GitHub Release
remain separate decisions.

## Recovery Entry

1. Read [`AGENTS.md`](../../../AGENTS.md), the repository
   [Authority Map](../../AUTHORITY.md), and [Decision 0014](../../decisions/0014-powershell-portable-guidance-and-private-host-delta.md).
2. Read [Design](DESIGN.md), this state, and
   [Verification](VERIFICATION.md).
3. Inspect local/public Git identities and current writer/dirty scope against
   [Repository Handoff](../../HANDOFF.md).
4. Recompute the five SOURCE hashes before attributing any behavior.
5. Do not confuse the tested `c42eef3...` candidate with the installed
   `v0.1.1` copy or the earlier `58fc526...` isolated RC.
