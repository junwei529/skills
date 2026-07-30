# Audit And Adopt

Use this reference to discover an existing documentation contract, repair
authority drift, adopt a project, or propose structural change.

## Build The Responsibility Map

Inventory the nearest applicable project scope before deciding on files.

| Field | Record |
|---|---|
| Logical responsibility | One of the five minimum responsibilities |
| Read locations | Every source a reader is expected to consult |
| Canonical write locus | The single owner for normative durable facts |
| Evidence | Code, tests, runtime output, Git state, or external source |
| Confidence | Verified, partial, unverified, or `UNKNOWN` |
| Conflict | Competing claim, scope, lifecycle, or owner |

Treat a repository with all five responsibilities and usable routing as
sufficient even when filenames, language, or grouping differ from examples.
Return `NOOP` if there is no stale fact or broken route to repair.

## Classify Claims Before Resolving Them

Keep these classes separate:

1. intended contract;
2. actual implementation;
3. current work state;
4. verification evidence;
5. historical decision and rationale.

Prefer direct evidence for current behavior, but do not silently replace an
accepted contract. Record a mismatch and preserve `UNKNOWN` when the available
sources cannot resolve it.

## Audit Or Repair

1. Confirm whether the request is read-only or permits updates to existing
   canonical owners.
2. Read declared precedence and ownership before choosing a winner.
3. Identify stale duplicates, missing routes, and facts without a write locus.
4. Apply the primary outcome rules in `SKILL.md`. A completed read-only audit
   remains `REPORT` when only a later write is blocked; any proposed structure
   or authority change remains `PROPOSE`.

Do not make a structural repair merely because it is obvious or reversible.

## First Adoption

1. Obtain explicit authorization for target-project structural writes.
2. Reuse existing sources for every responsibility they already satisfy.
3. Add only the missing routing or content.
4. Prefer one combined project document when it is clearer than several empty
   owners. Use the [single-file Starter](../assets/templates/project-doc-starter.md)
   only as an adaptable starting point.
5. If persistent continuity is authorized, merge the
   [Continuity Anchor](../assets/templates/continuity-anchor.md) into the
   existing project instruction or governance entry.
6. Verify that a fresh reader can locate all five responsibilities without
   knowing the template names.

## Structural Expansion

Propose expansion only after a concrete event shows that the current routing is
insufficient, such as:

- a new independently governed subproject or monorepo scope;
- incompatible update cadences or owners;
- repeated conflicts caused by one file owning unrelated facts;
- one responsibility dispersed across sources without a clear write locus;
- a rename, migration, generator, or external owner changing edit location;
- a durable interface, security, operational, or evidence domain becoming too
  large for its current owner.

State the user-visible benefit, affected owners, migration path, compatibility
links, verification, and rollback before requesting authorization. Do not
represent this as a maturity-level upgrade.

## Special Sources

- Generated documentation: locate and edit the generator input; report the
  generated file as derived.
- External Wiki or issue tracker: allow it to own a fact; when unavailable,
  retain the mapping and mark the fact unverified.
- Monorepo: use the nearest applicable instruction and responsibility map;
  avoid promoting subproject facts into a root owner.
- Multilingual docs: preserve the established language and canonical owner;
  do not create translation/version publishing machinery.
