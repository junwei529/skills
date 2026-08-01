# PowerShell `c42eef3` Exact-Commit RC

Date: 2026-08-01

## Scope And Identity

Public and local `main` resolved to exact commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`. `$skill-installer` materialized
`skills/use-powershell-safely` from that exact ref into one unique ignored
`RC_INSTALL` root.

The candidate contained exactly five ordinary, non-reparse files. Each file
matched the selected Git blob and raw SHA-256, decoded as strict UTF-8 without
BOM, used LF-only text, and ended in one LF:

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

The installed candidate passed the Skill validator.

## Loaded-Copy And Behavior Evidence

The older stable entry was disabled only through process-local Skill
configuration. Two fresh positive processes read the candidate entry plus the
native/process and text/encoding references. Neither read the WSL reference,
stable entry, or private fallback. An ordinary-cmdlet negative and a POSIX-only
negative read no PowerShell Skill.

The positive response preserved:

- zero/one/many executable discovery and an explicit selected executable;
- one array item per argument, including a path with spaces;
- separate stdout and stderr plus numeric exit status;
- observed runtime and `ProcessStartInfo.ArgumentList` capability; and
- the actual UTF-8, BOM, newline, and JSON producer/consumer contract.

A controller independently executed the same synthetic boundary under
PowerShell Core 7.6.3. `ProcessStartInfo.ArgumentList` was available. The
direct invocation returned stdout `valid`, empty stderr, and exit `0`; the
broken wrapper emitted its split-argument diagnostic on stderr and exited `1`.
The input was valid UTF-8 without BOM, LF-terminated, and parseable JSON.

Both PowerShell 7 and Windows PowerShell 5.1 passed all fifteen deterministic
boundary assertions. An independent assessor recomputed identity, inspected
the counted event logs and deterministic evidence, and returned
`READY_FOR_RELEASE_CANDIDATE`.

## Attempts And Attribution

- Counted fresh model runs: four — two positives, one ordinary-cmdlet
  negative, and one POSIX-only negative.
- Excluded before-behavior attempts: eight controller, launcher, transport, or
  parser failures. They included a sandboxed network failure followed by a
  successful read-only retry, an inaccessible launcher, a misplaced CLI flag,
  one prompt-name mismatch, and evidence-summary parsing errors.
- One final controller probe used the singular form of the WSL reference
  filename. It changed nothing; the complete five-file recomputation passed.
- Policy-blocked commands in fresh agent processes were retained as Harness
  limits. Controller execution proof was attributed separately rather than
  presented as agent-executed behavior.

## State Preservation And Verdict

Immutable stable `v0.1.1` remained at
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`, with all five installed files
still matching its tag blobs. Counted runs read the stable path zero times.
No persistent discovery, configuration, SOURCE, tag, stable, or release state
changed. The isolated RC evidence directory was retained under the ignored run
root.

Verdict: `READY_FOR_RELEASE_CANDIDATE` for exact-commit PowerShell candidate
identity, relevant-reference loading, complete safe native-command transfer,
controller-executed native and text contracts, and ordinary Windows/POSIX
non-selection.

This does not establish a new stable installation or tag, live WSL/Bash,
actual sandbox-denial behavior, real-project shadow use, broad implicit-trigger
accuracy, causal efficacy, token savings, cross-Harness parity, or a GitHub
Release.
