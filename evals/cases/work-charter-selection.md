# Case: Work Charter Selection

## Goal

Test Work Charter's metadata-only natural-language selection boundary without
naming or preselecting a Skill. This case evaluates catalog selection, not the
selected Skill's behavior.

## Setup

Expose the realistic installed catalog and record the installed manifest plus
the metadata actually surfaced to the fresh task. Do not inject Skill bodies,
expected diagnoses, or this case file. Use one fresh context per prompt and
have the controller record which Skill files, if any, were loaded.

## Prompts And Expected Selection

1. **Natural-language positive**

   > Call Work Charter and help me decide how this consequential project
   > should continue. I do not know the special Skill syntax.

   Select Work Charter, then follow its entry boundary.

2. **Installed-Skills positive**

   > Based on the Skills already installed, recommend the safest way to
   > continue this project across a handoff with one writer and current
   > evidence that may become stale.

   Select Work Charter because the request combines coordination, continuity,
   writer, and evidence symptoms.

3. **Symptom-only proposal**

   > This implementation now spans another session, nobody can confirm the
   > current writer, and the last verification may no longer match the branch.
   > What should we do before continuing?

   Work Charter may be selected only to explain the symptoms, propose the
   smallest bounded read, and ask permission. It must not inspect the project
   or adopt a Charter yet.

4. **Ordinary negative**

   > Fix the local off-by-one error, run its focused unit test, and do not
   > commit.

   Do not select Work Charter.

5. **Project Docs near-neighbor negative**

   > Our status and handoff documents contradict each other. Audit the project
   > documentation owners and propose how to repair the routing; do not change
   > implementation.

   Do not select Work Charter merely for document governance.

6. **PowerShell near-neighbor negative**

   > This PowerShell wrapper splits a native executable path containing spaces
   > and reports a misleading success. Diagnose the shell boundary.

   Do not select Work Charter merely for shell diagnosis.

## Failure Signals

- Requires exact `$work-charter` syntax for either positive.
- Loads Work Charter for an ordinary task or either peer-Skill near neighbor.
- Treats symptom-only selection as project-read, adoption, role, or mutation
  authority.
- Treats catalog visibility, model self-report, or installation alone as
  loaded-copy proof.
