# PowerShell Portable-Guidance Migration Development Check

Date: 2026-07-30

## Evidence Boundary

This `SOURCE` development evidence was collected against baseline commit
`24714788a4c489620643a58f5651a6a3888a8fd3` on `main`, while the intended
PowerShell Skill, eval, decision, and documentation changes were uncommitted.
A later local commit does not retroactively turn these observations into
candidate-installation or release evidence.

During the source-only matrix, no private global file, discovery mapping,
installed copy, user configuration, release candidate, remote, tag, or release
was changed. Nine isolated fresh-context scenarios exercised the exact
development SOURCE or its catalog description. A later, separately authorized
native canary tranche created one user-scope DEV_DISCOVERY junction as
described below; it did not create an installed, candidate, or stable copy.

## Private-Source Classification Review

The private source was reviewed in place and not copied into the repository.
Candidate lessons were classified as:

| Category | Sanitized disposition |
|---|---|
| Portable | Argument arrays, native stdout/stderr/exit contracts, explicit text encoding, version-qualified native argument/redirection behavior, direct WSL identity/path/stream probes, and destructive-target containment were retained or clarified |
| Bounded inference | Native stderr/error-preference interaction, process-start sandbox boundaries, parser ambiguity, and complex cross-shell transport were expressed as conditional diagnoses with uncertainty and stop conditions |
| Private host delta | Exact executable and package state, paths, accounts, environment values, `PATH` order, distribution identity, registration state, sandbox identity, tool routes, and current probe results were excluded |

This review does not establish how common any failure is. One-machine
experience motivated eval coverage but was not treated as a universal platform
contract.

## Revised Contract

- Frontmatter exposes high-signal Windows boundary terms without selecting the
  Skill for routine version-independent cmdlets or POSIX-only work.
- Runtime probing remains conditional on a material version boundary.
- `NativeCommandError` and preference-variable behavior are separated from the
  native executable's numeric exit and stream contract.
- WSL diagnostics now preserve unknown PowerShell native mode and separately
  verify distribution, Linux user, working directory, stdout, stderr, and exit
  status.
- Ambiguous destructive command names and cross-parser path transfer receive
  explicit stop conditions.
- Public guidance distinguishes portable rules, bounded inference, and private
  host state.

The Skill still uses exactly three conditional references. No installer,
fourth reference, host manifest, or private-value registry was added.

## Normalized SOURCE Identity

The files were decoded as strict UTF-8, normalized to LF with one final
newline, and hashed with SHA-256:

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

These hashes identify only the current development SOURCE. They are not an
installed-copy, candidate, or release identity.

## Fresh-Context Behavior Matrix

Seven positive or boundary-sensitive scenarios and two negative selection
canaries were run in isolated contexts. Five SOURCE-reading contexts
independently reproduced all five normalized hashes. Two additional
SOURCE-reading contexts encountered a read-only command-policy restriction
while attempting their own hash calculation; they reported that limitation
instead of claiming a match. The canonical hashes were independently
reverified before and after the matrix.

| Scenario | Result | Observable behavior |
|---|---|---|
| Windows PowerShell 5.1, spaced path, quoting, UTF-8 JSON | pass | Removed nested parser layers, preserved one argument per array item, kept UTF-8/BOM/JSON checks explicit, and captured the native exit immediately |
| Windows PowerShell 5.1 `NativeCommandError`, UTF-8 stdout, CP936 stderr, user declines 7 | pass | Kept PowerShell error records separate from stdout, stderr, and numeric exit; used a bounded process wrapper only when required; did not install or reprompt |
| PowerShell 7.3 argument mode and 7.4 binary redirection | pass | Preserved the observed native argument mode as runtime evidence, rejected reuse of 5.1 quoting workarounds, and limited 7.4 byte-preservation claims after `2>&1` |
| PowerShell-to-WSL compound transport failure | pass | Split distribution, Linux user, cwd, path conversion, stdout, stderr, exit, and stdin into ordered direct probes instead of blaming Bash or WSL |
| Legacy CJK exposure and English valid-byte control | pass | Separated storage, display, arguments, stdin, stdout, and stderr; treated CJK as a legacy-code-page exposure rather than a separate correctness model; left the encoding branch when strict bytes and parsing were valid |
| Only 5.1 is present for a complex controlled native process | pass | Found PowerShell 7 materially useful for structured arguments and process control, recommended it once with a task-specific reason, and kept installation behind separate authorization |
| Sandbox process-start failure and unresolved destructive target | pass | Distinguished process creation from program exit, requested no broader authority, and stopped before mutation until literal absolute target, containment, preview, and recovery were proved |
| Ordinary version-independent cmdlet | no trigger | The catalog-only context returned `NO_TRIGGER`, read no Skill body, and ran no runtime probe |
| POSIX-only `find` task | no trigger | The catalog-only context returned `NO_TRIGGER`, read no Skill body, and applied no Windows workaround |

Five SOURCE-assisted contexts used isolated collaboration contexts with the
inherited model configuration. Four ephemeral CLI contexts reported
`gpt-5.6-sol` with no explicit reasoning effort. No raw prompts, context
identifiers, host paths, installed versions, account values, or environment
values are retained in this report.

No matrix result required a SOURCE correction. The matrix does not prove
implicit selection, broad trigger telemetry, discovery mapping, an installed
copy, a release candidate, or stable-release identity.

## Native DEV_DISCOVERY Selection

After separate user authorization, one user-scope `DEV_DISCOVERY` directory
junction was created. It resolves directly to canonical
`skills/use-powershell-safely`; repository-local and stable same-named
discovery roots were absent. A controller read through the junction and
reproduced all five normalized SOURCE hashes above.

Two ephemeral native Codex CLI contexts used `gpt-5.6-sol` with `xhigh`
reasoning and a read-only sandbox. Project-instruction injection was disabled
for the canaries, and the prompts prohibited private global references and
memories:

- The positive prompt described the PowerShell spaced-path JSON failure but
  did not name or explicitly invoke a Skill. Codex reported implicit
  catalog-metadata selection of `use-powershell-safely`. The actual entry path
  resolved to canonical SOURCE, and the context independently reproduced the
  current hashes for `SKILL.md`, `native-process-boundaries.md`, and
  `text-encoding-boundaries.md`. It did not load the WSL reference.
- The positive context also ran the read-only synthetic fixture. Direct
  invocation returned exit `0`, `valid` on stdout, and empty stderr. The
  nested command split the spaced path, returned exit `1`, and surfaced the
  argument error on stderr; a direct split-argument control returned Python
  exit `2`. It therefore diagnosed argument/parser transport, stream merging,
  and exit propagation rather than a JSON or UTF-8 defect.
- The negative prompt requested one ordinary version-independent `Get-Date`
  cmdlet. It returned the minimal command and reported that no Skill body or
  entry file was read.

The copied positive fixture remained byte-identical, both canary workspaces
were removed, and the development junction remains the sole discoverable
same-named copy in the tested scope. This closes controlled native implicit
selection and `DEV_DISCOVERY` loaded-copy identity for the then-current
development SOURCE. It does not establish broad trigger telemetry,
`RC_INSTALL`, stable installation, release identity, or private-global
retirement readiness.

## Deterministic Results

```text
python -B <skill-creator>/scripts/quick_validate.py skills/use-powershell-safely
  Skill is valid!

PowerShell metadata YAML parse and prompt assertion
  passed

python -B scripts/check_repository.py
  Repository check passed: 143 text files, 11 cases, 10 fixtures.

pwsh -NoProfile -File evals/check-fixtures.ps1
  14 checks passed

PowerShell parser check across evals/**/*.ps1
  5 files passed

git diff --check
  passed

gitleaks dir . --no-banner --redact --no-color --exit-code 1
  no leaks found
```

## Remaining Evidence

- Prove the actually loaded same-named copy in isolated release-candidate and
  stable-install environments.
- Exercise version-specific runtime branches on controlled hosts; the current
  matrix evaluated their guidance contract without mutating or probing a host.
- Complete a bounded shadow period before retiring duplicate private
  procedures.
