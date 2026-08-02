# Documentation Authority

Last updated: 2026-08-02

## Instruction Precedence

System and user instructions take precedence. Within this repository, the
nearest `AGENTS.md` controls agent behavior.

## Current Fact Ownership

Use one canonical owner for each fact class:

| Fact class | Canonical owner |
|---|---|
| Public license and attribution | root `LICENSE` |
| Shared product, independent-Skill, version, and release requirements | `docs/SPEC.md` |
| Cross-Skill architecture, composition, and lifecycle topology | `docs/ARCHITECTURE.md` |
| Per-Skill purpose, trigger, behavior contract, and internal package boundary | `docs/skills/<skill-name>/DESIGN.md` |
| Currently implemented executable behavior | `skills/<skill-name>/` |
| Per-Skill implementation state, writer, next gate, and recovery | `docs/skills/<skill-name>/STATE.md` |
| Per-Skill SOURCE, forward-test, DEV, RC, stable evidence and limits | `docs/skills/<skill-name>/VERIFICATION.md` |
| Repository integration and release dashboard | `docs/STATUS.md` |
| Repository checks, coherent candidate, tag, stable-install, and release evidence | `docs/VERIFICATION.md` |
| Development intake, external optimizer experiment, discovery, installation, candidate, update, rollback, and release procedure | `docs/RUNBOOK.md` |
| Repository writer custody, dirty scope, next integration action, and recovery order | `docs/HANDOFF.md` |
| Future milestone direction | `docs/ROADMAP.md` |
| Source transformation, external reference and data handling, and publication claims | `docs/PROVENANCE.md` |
| Accepted rationale, including capability-delta and external framework or optimizer disposition | `docs/decisions/`; specifically `docs/decisions/0017-capability-delta-skill-development.md` for that disposition |
| Native/control/candidate and optimizer evaluation definitions plus sanitized detailed results | `evals/` |

Root and per-Skill README files are human navigation and distribution entries,
not second runtime specifications. English is canonical; Simplified Chinese
README files mirror the same public surface.

When a shared contract, per-Skill design, implementation, state, and evidence
disagree, do not choose one by file order alone. Preserve the classes, record
the mismatch in the owning per-Skill `STATE.md`, and stop before silently
redefining contract or implementation.

## Templates Are Not Repository Facts

Files under `skills/*/assets/` are reusable output templates for other
projects. They do not describe the current state of this repository.

## Plans And Claims

- Draft or planned work does not imply implementation.
- A passing structural validator does not prove behavioral efficacy.
- Chat messages and session summaries are not durable project facts.
- Unknown or unmeasured claims remain explicitly unverified.
- Root dashboards must link to per-Skill owners rather than copy their detailed
  current state or evidence histories.
