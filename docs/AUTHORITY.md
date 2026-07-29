# Documentation Authority

Last updated: 2026-07-28

## Instruction Precedence

System and user instructions take precedence. Within this repository, the
nearest `AGENTS.md` controls agent behavior.

## Current Fact Ownership

Use the following order when repository documents disagree:

1. Root `LICENSE` for public license terms and copyright attribution.
2. `docs/SPEC.md` for the accepted product contract.
3. Files under `skills/` for currently implemented skill behavior.
4. `docs/ARCHITECTURE.md` for module and ownership boundaries.
5. `docs/RUNBOOK.md` for current development, discovery, installation,
   candidate, update, rollback, and release procedures.
6. `docs/VERIFICATION.md` for verified evidence and claim status.
7. `docs/STATUS.md` for current progress, subject to verification evidence.
8. `docs/ROADMAP.md` for future milestones.
9. `docs/HANDOFF.md` for recovery context.
10. `docs/PROVENANCE.md` for source and publication claims.
11. `docs/decisions/` for historical reasons.
12. `evals/` for test definitions, not product truth.

If implementation and `docs/SPEC.md` disagree, record the mismatch in
`docs/STATUS.md` and do not silently redefine either side.

## Templates Are Not Repository Facts

Files under `skills/*/assets/` are reusable output templates for other
projects. They do not describe the current state of this repository.

## Plans And Claims

- Draft or planned work does not imply implementation.
- A passing structural validator does not prove behavioral efficacy.
- Chat messages and session summaries are not durable project facts.
- Unknown or unmeasured claims remain explicitly unverified.
