# Work Charter Controller Evidence Boundary

Date: 2026-08-06

## Result

`IMPLEMENTED_UNCOMMITTED`

This offline correction separates strict file-read evidence from bounded
auxiliary observation and clarifies matrix-wide versus cell-local stops. It
does not edit the Work Charter package, retry or rescore sealed evidence, call
a Gate 2 behavior model or assessor, accept Gate 2, or authorize Gate 3. A
separately authorized native code review used a review model only to inspect
this repository diff; it is not product-behavior evidence.

## Identity And Preservation

- Starting repository revision: `79806bf47b3d152e19c5e7b5d5ef5a011b4ad37b`.
- Working branch: `codex/work-charter-controller-evidence-boundary`.
- Product candidate: unchanged `b965102ea58f9cc1ef3c73e8dea515731fec12a6`.
- Public Work Charter package: all five `skills/work-charter` files unchanged.
- Historical inputs: 11 tracked sanitized cases unchanged.
- Sealed executions: all three retained terminal records remain immutable and
  were not read, retried, rescored, relabelled, or replaced.
- Earlier controller stabilization: retained as prior infrastructure history;
  this result reports only the later delta.

## Controller Delta

Strict required-read credit now has two supported proof routes:

1. the existing structured full-file proof; or
2. for exactly one successful action classified `unknown`, an exact single
   `Get-Content -Raw` whose string `aggregatedOutput`/`aggregated_output`
   matches the authorized file's UTF-8 length and SHA-256. The comparison may
   remove at most one final LF or CRLF introduced by transport.

Compound, partial, unmatched, missing-output, or non-string-output reads do not
receive required-read credit and remain `CONTROLLER_UNKNOWN`.

Bounded `Get-ChildItem`, `Get-Item`, `Test-Path`, and `Resolve-Path` operations
are recorded separately as auxiliary observations. Admission requires an
explicit policy root and one command-linked unchanged inventory for that same
root. Auxiliary observations may support reconciliation but never satisfy a
required file read or loaded-copy claim. Unauthorized roots and observed drift
fail closed; missing or ambiguous linkage remains unknown.

The evaluation contract now stops the full matrix only for shared
contamination, such as candidate/controller/installed-copy identity drift,
authorization or safety failure, or shared workspace/input/provenance mutation.
A transport or visibility gap confined to an independently planned cell after
its declared consumption point seals that cell `UNKNOWN` without resetting it
or automatically invalidating independent cells. A missing required reference
cell still blocks candidate acceptance, and pre-approval project access remains
a hard failure.

## Regression Result

| Group | Result | Boundary |
|---|---:|---|
| Evidence surface | 19/19 | exact aggregated-output proof, output mismatch, compound read, auxiliary unchanged inventory, required-read separation, unauthorized auxiliary root, unauthorized auxiliary subpath, globally unique and ordinal case-sensitive inventory linkage, variable-bearing transform rejection, inventory drift, pre-approval read, partial read, conflicting command aliases, conflicting inventory-link aliases, outer/action command disagreement, matching duplicate aliases, recursive-listing rejection, and explicit empty-inventory equality |
| Historical | 11/11 | unchanged generated contracts and expected verdicts |
| Fail-closed negatives | 31/31 | unchanged prior negative inventory |
| Metamorphic | 4/4 | unchanged equivalence inventory |
| Repository fixtures | 17/17 | includes the new 19/19 evidence-surface aggregate |
| Canonical repeat | pass | two complete public-mode runs are identical at `a4b1de1b5430e7d239c057175ada81db8f32336bbddfd63d30a14ff0fd8aa75d` |

The focused and repository fixture checks called no Codex behavior model,
app-server turn, or semantic assessor. Local sealed-evidence verification was
not requested and no private manifest was read.

## Native Review

Native review cycle 1 review 1/5 ran with `gpt-5.6-terra`, `high` reasoning,
and the `--uncommitted` selector. An earlier invocation combined that selector
with an unsupported custom-prompt form and was rejected by CLI argument parsing
before a review began; it is qualification work and does not count as a
completed semantic review.

The completed review found two P1 fail-closed gaps:

1. simultaneous snake_case and camelCase aliases could disagree while the
   controller silently selected the first value; and
2. the aggregated-output fallback checked the action command for exact
   `Get-Content -Raw` shape but did not independently check the executed outer
   command.

The correction now accepts duplicate aliases only when their canonical values
agree, otherwise records an explicit conflict and withholds the affected proof.
It also requires both outer and action command representations to be exact
single raw reads. Cases E10-E13 lock conflicting command aliases, conflicting
inventory linkage, outer/action disagreement, and matching duplicate aliases.
At that checkpoint, focused verification passed 13/13. Review 2/5 used the same
Terra/high selector over the corrected uncommitted diff. One sandboxed launch
could not reach the review service and ended without a semantic result; it is a
transport qualification failure, not a completed review. The authorized
network-enabled launch then completed and found two more P1 gaps:

1. recursive auxiliary `Get-ChildItem` could traverse a junction or symlink
   inside an authorized root; and
2. explicit empty before/after inventories caused mandatory-array parameter
   binding failure instead of a controller verdict.

The controller now rejects recursive auxiliary listing and explicitly allows
empty inventory arrays. Cases E14 and E15 lock both behaviors. At that
checkpoint, focused verification passed 15/15. Review 3/5 then found one P1:
directly targeting a subordinate path could still traverse a contained reparse
point. Auxiliary path operations are now restricted to the exact policy-listed
root; E16 proves a subordinate path is a violation and produces no completed
auxiliary effect. At that checkpoint, focused verification passed 16/16.
Because the review-3 fix changed the reviewed diff, a later completed review in
the same authorized cycle must inspect the corrected bytes before its gate can
close.

Review 4/5 materially covered staged, unstaged, and untracked changes and
returned no actionable correctness finding. It independently reran the
controller regression and repository fixture suite successfully. This review-
history synchronization is the only later tracked mutation; the next completed
review outcome over these bytes controls final gate satisfaction. A clean
outcome leaves only the separate commit decision, without another source edit.

Review 5/5 found one P1: an auxiliary command could share its ID with a
non-auxiliary command while inventory attribution still selected the auxiliary
record. The controller now counts IDs across the complete command set and
withholds auxiliary credit unless the linked ID names exactly one record. E17
locks that collision boundary, and focused verification passes 17/17 at the
canonical hash above. The five-review cycle is exhausted, and these fixes changed
the reviewed bytes; another native review requires an explicit user-approved
cycle reset.

The user approved one reset for the same commit attempt. Reset-cycle review
1/5 found two P1 gaps: `Write-Output $env:...` could be admitted as an
auxiliary transform, and a case-insensitive inventory map could let command IDs
that differ only by case reuse one inventory proof. Variable-bearing script
shapes now remain unknown, the inventory map uses ordinal comparison, and
E18-E19 lock both corrections. Focused verification passes 19/19 at the
canonical hash above. These fixes changed the reviewed bytes, so a later
completed review in the authorized reset cycle had to inspect the corrected
diff. Reset-cycle review 2/5 materially covered staged, unstaged, and untracked
changes, independently reran the controller and repository fixture suites, and
returned no actionable correctness issue. This review-history synchronization
is the only later tracked mutation; native-review gate satisfaction is
determined by a completed semantic review over these final bytes.

## Documentation Impact

Updated fact owners and bounded consumers are Decision 0018, the evaluation
contract and result index, Work Charter state/verification, and repository
status/verification/handoff/roadmap. Existing Work Charter behavior case files,
DESIGN, SPEC, ARCHITECTURE, AUTHORITY, RUNBOOK, PROVENANCE, INDEX, and public
README pairs were checked and require no change because neither the product
contract nor navigation, release, installation, or publication procedure
changed. No new case file, fixture, public Skill file, or user-facing product
term was added.

## Next Gate

The initial cycle exhausted 5/5 reviews, the user approved one reset, and
reset-cycle review 1/5 produced the two same-scope corrections above. A later
completed review in the authorized reset cycle had to inspect the corrected
diff. Reset-cycle review 2/5 returned clean; this review-history synchronization
is the only later mutation, and native-review gate satisfaction is determined
by a completed semantic review over the final bytes. Staging, commit, push,
Gate 2 model evidence, assessor use, RC or stable installation, integration,
release, and cleanup remain unauthorized.
