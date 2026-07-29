# Report Labels Project State

## Purpose And Scope

Report Labels normalizes ASCII labels for generated report identifiers. It
does not transliterate non-ASCII input.

## Work And Verification

Keep code under `src/` and tests under `tests/`. Run:

```text
python -m unittest discover -s tests -v
```

## Authority And Write Routing

This file owns scope, work rules, current state, evidence, and recovery.
`AGENTS.md` owns only agent routing and structural authorization.

## Current State And Evidence

Slug normalization is planned but not implemented. No verification result is
recorded.

## Next Action And Recovery

Implement slug normalization, then update this current-state and evidence
section. Resume by reading this file and `src/report_labels.py`.
