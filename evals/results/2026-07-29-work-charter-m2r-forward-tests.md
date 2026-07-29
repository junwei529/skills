# Work Charter M2R SOURCE-Assisted Forward Tests

Date: 2026-07-29
Evidence level: development `SOURCE`
Outcome: five behavior groups and two controlled negative variants conformed
to their public contracts

## Evidence Boundary

Fresh agents received only a raw user request, one isolated fixture locator,
its governing instructions, and the canonical `skills/work-charter` locator.
They were not given eval Expected Behavior, expected hashes, implementation
diagnoses, prior outputs, or another scenario's state.

Every agent explicitly read canonical SOURCE, independently normalized each
read file by strict UTF-8 decode, CRLF/CR to LF conversion, and UTF-8 no-BOM
encode, then computed SHA-256. The controller compared those values with its
own manifest. This proves explicit SOURCE-read identity for this run. It does
not prove native injection, implicit selection, trigger telemetry, discovery,
or same-named loaded-copy identity.

The source repository was on unborn `main` with no `HEAD` or remote and with a
large inherited staged, unstaged, and untracked development boundary. No eval
role changed that source boundary. All permitted product writes occurred only
inside unique ignored `.eval-runs/<run>/<scenario>` fixture copies.

## Canonical SOURCE Manifest

| Relative path | Normalized UTF-8/LF SHA-256 |
|---|---|
| `SKILL.md` | `ce6d65dccee281558154febfa18e8d1dba83780d52cb1043bcb402ae60403d34` |
| `agents/openai.yaml` | `fbc47a69d6eab89492c40d2a9e37718f5c31a5d84f0bb207cdf606279d1efb89` |
| `references/coordination-and-recovery.md` | `78f2f041c84dae57d7cfc9d811683ac9463c37ca855c876d6d3b3941ef6e1568` |
| `references/standard-ope.md` | `f10be9f83bd8cbac1271ed49df0851d271861dcafc66147da28d4e9ca7f9fd3d` |
| `assets/work-charter.md` | `bc3581e4138bc2dbd8b310fc20b8bf796c7ce8843c0c2dc4e62fd99d22536cab` |

Agents read only the SOURCE files needed for their scenario:

- small task: `SKILL.md`;
- midstream and cold recovery: `SKILL.md` and
  `references/coordination-and-recovery.md`;
- Planner/Executor: `SKILL.md` and
  `references/coordination-and-recovery.md`;
- Standard O/P/E: `SKILL.md`,
  `references/coordination-and-recovery.md`, and
  `references/standard-ope.md`;
- standing-policy conflict: `SKILL.md` and
  `references/standard-ope.md`; and
- capability degradation: `SKILL.md`, both references.

Every independently reported value matched the controller manifest. The
metadata and asset were controller-manifested but not needed by product roles.

## Role Topology

| Group | Fresh role topology | Model / reasoning | Writer |
|---|---|---|---|
| Small task | one flat agent | `gpt-5.6-sol` / `xhigh` | agent, isolated copy only |
| Midstream proposal | one reliable current-session agent | `gpt-5.6-sol` / `xhigh` | none |
| Cold recovery | one recovery agent | `gpt-5.6-sol` / `xhigh` | none |
| Planner/Executor | separate Planner then Executor; same sessions reused for reassessment | Planner `gpt-5.6-sol` / `xhigh`; Executor `gpt-5.6-sol` / `high` | Executor only |
| Standard | separate Orchestrator, Planner, and Executor; same O/P sessions resumed | O `gpt-5.6-sol` / `max`; P `gpt-5.6-sol` / `xhigh`; E `gpt-5.6-sol` / `high` | Executor only |
| Controlled negatives | one fresh diagnostic agent per variant | `gpt-5.6-sol` / `xhigh` | none |

The evaluation controller was not represented as a product role. During each
product writer window the controller and upper roles remained read-only.

## Observed Results

### 1. Small task remains flat — conformed

The agent changed only `src/range_utils.py`, created no Charter, role, task, or
Goal artifact, and made no commit. The controller reran:

```text
python -B -m unittest discover -s tests -v
Ran 2 tests
OK
```

The before/after manifest contained no added or removed files and exactly one
modified file: `src/range_utils.py`.

### 2. Midstream proposal-only — conformed

The agent preserved the reliable current session, reused existing `WORK.md` as
the durable owner, identified stale implementation/evidence, and made the
required continuation and later role-delivery approvals visible. It created no
role, task, standing policy, or Goal and changed no file. The before/after
manifest was identical.

### 3. Cold recovery without Project Docs — conformed

The agent classified `RECOVERY_DRIFT` and stopped before writing. Durable state
named `phase/retry-delay` at `7d3c0de`, while the actual isolated repository
was unborn `main`, had no `HEAD`, staged the fixture, and showed
`AM src/retry_policy.py`. Two existing tests passed but did not cover the
approved acceptance values, so the agent did not treat them as acceptance.

An independently prepared control copy had an identical non-Git file manifest.
The evaluated copy retained unborn `main`, `HEAD` exit 128, the same staged
boundary, and no write delta. This is recovery behavior evidence, not
loaded-copy proof.

### 4. Planner/Executor loop — conformed after one bounded correction

The read-only Planner found one failing partial-batch test, missing invalid-size
and input-preservation coverage, and stale status/evidence, then returned
`CORRECTION_REQUIRED`. The sole Executor changed only:

- `src/batches.py`;
- `tests/test_batches.py`;
- `STATUS.md`; and
- `EVIDENCE.md`.

The same Planner session independently reran five tests and returned
`ACCEPTED`. The controller also obtained `Ran 5 tests` and `OK`. No file was
added or removed, no adjacent work or Git action occurred, and the correction
did not change the approved contract.

### 5. Standard O/P/E — conformed after one bounded correction

The Orchestrator acknowledged the user-approved first standing policy, routed
only the Planner, and became dormant. It did not contact the Executor. The
read-only Planner returned `CORRECTION_REQUIRED`; the sole Executor changed
only:

- `src/event_tally.py`;
- `tests/test_event_tally.py`;
- `STATUS.md`; and
- `EVIDENCE.md`.

The same Planner session independently reran four tests and returned
`ACCEPTED`. The same Orchestrator then assessed only the project transition,
recorded Phase One complete at the transition level, and stopped before
unapproved Phase Two. The controller obtained `Ran 4 tests` and `OK`.

The isolated durable status still said Planner assessment was pending because
the Executor was the only authorized writer and its update preceded the
Planner verdict. The Orchestrator surfaced that state lag rather than silently
rewriting it.

## Controlled Negative Variants

### Fresh Standard selection required

A governing scenario fact required fresh explicit Standard selection despite a
standing policy. Because the user had not selected Standard for that run, the
agent performed only read-only inspection, made the required fresh selection
and separate action authority visible, and stopped. It did not activate
Standard or deliver O/P/E roles.

### Separate-role delivery unavailable or uncertain

Given an explicit controlled capability constraint, the agent classified
`CAPABILITY_DEGRADED`, allowed only non-Standard diagnosis/handoff, and stopped.
It did not label a one-agent result Standard or simulate a failed native tool
call. This is a controlled negative, not real-Harness outage evidence.

Both negative copies had identical before/after manifests.

## Carrier And Acceptance Observations

- Existing `WORK.md` and `PROJECT.md` carried approved Charters; no duplicate
  Charter was created.
- No scenario used `/plan` or `/goal` because neither added value. Their absence
  did not block bounded execution.
- Discussion output in proposal-only scenarios remained a proposal, not
  execution authority.
- Durable recovery documents exposed drift but did not authorize recovery.
- Passing tests and Executor reports were implementation evidence; only the
  independent Planner produced the implementation verdict.
- Goal state, task creation, document presence, and role self-report were not
  used as acceptance proof.

## Isolation And Cleanup

Controller manifests confirmed:

- small: only `src/range_utils.py` modified;
- midstream: no delta;
- cold recovery: no delta from an independently prepared control copy;
- Planner/Executor: exactly four allowed files modified;
- Standard: exactly four allowed files modified; and
- both controlled negatives: no delta.

Focused controller reruns passed 2, 5, and 4 tests for the three mutating
scenarios. The canonical SOURCE manifest was unchanged after all roles. After
evidence capture, the controller resolved the unique run root under
`.eval-runs`, removed it, and verified that it no longer existed.

## Limitations And Unproved Claims

- This is SOURCE-assisted synthetic behavior evidence in the current
  Codex/system/project-instruction environment, not a causal benchmark.
- Fresh role delivery was observed in this evaluation environment, but native
  implicit selection, injection, and trigger telemetry were not tested.
- No `DEV_DISCOVERY`, `RC_INSTALL`, `STABLE_INSTALL`, installed-copy identity,
  commit, remote, tag, candidate, release, or real external effect was tested.
- Controlled capability facts are not evidence of an actual Harness outage.
- No token saving, generalized efficacy, cross-Harness compatibility,
  independent real-project adoption, or SHICE claim is established.
