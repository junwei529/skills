# PowerShell Native-Example Correction

Date: 2026-07-31

## Evidence Boundary

This gate corrected current canonical `SOURCE` after the public exact-commit
RC exposed a transfer defect: the Skill contained executable-cardinality and
stream rules, but a fresh loaded response omitted them from its user-runnable
safe example.

The gate edited only the entry, native/process reference, and PowerShell eval
case. It did not stage, commit, install, map discovery, create another RC,
change the stable copy, edit private global guidance, configure the host, or
publish anything. Public and local `main` remained at
`58fc52600df0e1dc3abd92ba31f031ee2b07db82`; the working SOURCE was dirty
development input rather than an exact-commit candidate.

## Current SOURCE Identity

All five files decoded as strict UTF-8 without BOM. After LF normalization
with exactly one final newline, SHA-256 identities were:

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

An independent post-review assessor recomputed and matched every identity.

## Correction

The entry now requires a user-runnable native example to carry the complete
boundary contract:

- application-only discovery normalized with `@(...)`;
- zero/one/many handling or one stated precedence or identity rule;
- an exact executable object or path and one array element per argument;
- truthful inherited, merged, discarded, or separately captured streams;
- immediate numeric native exit capture;
- observed runtime and capability evidence before a version-specific shape;
  and
- closure of every material text, JSON, encoding, newline, or byte hypothesis
  against the actual producer and consumer contract.

The native reference adds the same transfer checklist and a PowerShell 7
`ProcessStartInfo.ArgumentList` pattern that redirects and asynchronously
drains stdout and stderr independently. It keeps Windows PowerShell 5.1's
missing `ArgumentList` capability explicit. The eval case rejects examples
that omit these fields, present a future guard as an observed result, or parse
the wrong output contract.

The frontmatter, metadata, text reference, WSL reference, trigger boundary,
and three-reference progressive-disclosure structure did not change.

## Deterministic Checks

The corrected package passed:

```text
skill-creator quick_validate
  Skill is valid!
python -B scripts/check_repository.py
  pass
pwsh -NoProfile -File evals/check-powershell-boundaries.ps1
  15 checks pass
powershell.exe -NoProfile -File evals/check-powershell-boundaries.ps1
  15 checks pass
git diff --check
  pass
```

A controller smoke also executed the documented
`ProcessStartInfo.ArgumentList` redirection shape against a child native
process and independently obtained stdout `out`, stderr `err`, and exit `7`.

## Fresh SOURCE-Assisted Behavior

Fresh contexts received the current Skill and realistic read-only native
tasks without the prior defect or intended answer.

The first assessment returned `CORRECTION_REQUIRED`: one response preserved
candidate cardinality and honestly described inherited streams but did not
perform material separate capture, close the text branch, or report observed
runtime; another gave the redirected shape but only labeled its runtime.

The second iteration carried runtime and text requirements into both outputs.
Its assessment still exposed the distinction between a future capability guard
and an actually observed host result. A mixed generic-CLI task also had a
different stdout contract from the repository fixture, so it was not used as
the final fixture acceptance surface.

The final fresh run used only the repository's PowerShell-boundary fixture. It
reported the observed PowerShell runtime and `ArgumentList` capability,
selected an exact Python executable under a stated bare-name precedence rule,
preserved the spaced path as one argument, captured stdout and stderr
independently, and distinguished verifier exits `0` and `2` from wrapper exit
`1`. It used the verifier's actual strict UTF-8, BOM, and JSON contract rather
than parsing its plain-text `valid` status as JSON.

A separate fresh assessor read the complete current SOURCE, eval case, fixture,
and raw result and returned:

```text
ACCEPTED
```

The first native review found that the detailed process example assigned the
selected `ApplicationInfo` directly to `FileName` and did not emit a successful
runtime/capability observation. The corrected example uses the selected
`.Path`, emits the runtime and `ArgumentList` availability before construction,
and preserves the same separate-stream shape. A new fresh runner exercised
that exact identity boundary, and a separate assessor matched the corrected
five hashes and returned `ACCEPTED`.

## Claim Limits

This establishes corrected dirty-SOURCE behavior for one synthetic
native/text fixture plus deterministic dual-runtime checks. It is not native
implicit selection, `DEV_DISCOVERY`, loaded-copy, exact-commit RC, stable,
shadow-use, live Bash/WSL, actual sandbox-denial, commit, review, tag, or
release evidence. The older public exact-commit RC verdict remains
`CORRECTION_REQUIRED`; a new commit identity and later RC are separate gates.
