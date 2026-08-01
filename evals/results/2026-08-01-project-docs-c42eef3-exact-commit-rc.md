# Project Docs `c42eef3` Exact-Commit RC

Date: 2026-08-01

## Scope And Identity

Public and local `main` resolved to exact commit
`c42eef392a5b9f58bbee64aa73ffb603a6fb6c29`. `$skill-installer` with the
download method materialized `skills/manage-project-docs` into one unique
ignored `RC_INSTALL` root. The candidate was an ordinary directory, did not
resolve to editable SOURCE, and contained exactly six files.

Every file matched the selected Git blob and raw SHA-256, decoded as strict
UTF-8 without BOM, and used LF-only text:

```text
SKILL.md
  cc536a35c7bbba6f293193849b98db85923de8fe0d73c106feed405bfc4b448b
agents/openai.yaml
  50fa3c3799caeca29ec6ba10151bd7c58e3c85d4e86d86b38ae9632306e31b17
references/audit-and-adopt.md
  b4af599f3838868db9479a6321a1f1aa82a8ff29cc492afa15b7e5de26078321
references/maintain-and-recover.md
  5c774b699d832ce0f52f68e6ef0b355d9ca79bc6c3407064276bf3638c5fb9ba
assets/templates/project-doc-starter.md
  d5d70f3c2b3422f51be420658bfe2198992ad95daaeac0aa28e5f1e4fe61ec8a
assets/templates/continuity-anchor.md
  258578585c4a9c69379afdfa9a872b41233885a11c6342a7458c7677aeb68ec5
```

The installed candidate passed the Skill validator.

## Loaded-Copy Isolation

Five fresh synthetic scopes exposed only the candidate-backed Project Docs
entry. The user-level stable entry was disabled only through a process-local
`skills.config` override. No persistent discovery or user configuration was
changed.

Native events proved that every counted explicit run read the candidate entry
and the required current reference. None read editable SOURCE or the stable
copy. The ordinary negative did not read the Project Docs body or references.

## Counted Behavior

| Scenario | Outcome | Observed boundary |
|---|---|---|
| Mature sufficient layout | `NOOP` | loaded candidate entry plus audit reference; no structural delta |
| Recovery coherence | `STOP` | distinguished reader, session, and writer; rechecked writer; retained one recovery target; failed closed when native policy prevented persistence |
| Authority conflict | `PROPOSE` | did not guess a canonical owner or cross the implementation gate; preserved the pre-existing dirty file |
| Safety boundaries | `REPORT` | preserved nearest scope, generated source, external owner, immutable history, active writer, language, and permission limits |
| Ordinary routing negative | no Skill selection | answered without reading Project Docs body or references |

The recovery scenario establishes fail-closed RC behavior, not a persistent
`UPDATE`: the active native policy prevented the write and the Skill stopped
instead of claiming success. An independent assessor returned `ACCEPTED` with
no Must finding under that bounded claim.

## Attempts And Checks

- Counted fresh processes: five, consisting of four explicit behavior canaries
  and one ordinary negative.
- Excluded behavior attempt: one continuity retry could not read the disk RC
  and supports neither loaded-copy nor `UPDATE` claims.
- Excluded controller preflight: one initial `git write-tree` call attempted an
  index lock and was rejected before model execution. Direct hashing of the
  existing index replaced it; no Git change remained.
- Three focused fixture tests exited `0` without creating interpreter caches.
- Five before/after manifests had no unaccounted delta; synthetic HEAD and
  index identities remained unchanged.
- Repository checker, fixture checker, PowerShell parser sweep, Git whitespace
  checks, and the publication-scope secret scan passed at the run boundary.

The directory-wide secret scan's only finding was inside an ignored official
manual cache and was excluded from publication claims after the tracked Git
scan passed.

## State Preservation And Verdict

The existing six-file `v0.1.1` stable installation remained byte-identical to
its immutable tag at
`f7c07b5470f10ce09ecb704bb0fb6d01e1d52b42`. Candidate and task evidence were
retained only under the unique ignored run root. Tracked files, SOURCE, stable,
user configuration, tags, and release state did not change during the run.

Verdict: `READY_FOR_RELEASE_CANDIDATE` for exact-commit Project Docs candidate
identity, loaded-copy attribution, mature `NOOP`, fail-closed recovery,
authority-conflict and safety behavior, and ordinary non-selection.

This does not establish persistent RC `UPDATE`, broad trigger telemetry,
cross-Harness parity, real-project long-term efficacy, stable behavior for the
current revision, a new tag, or a GitHub Release.
