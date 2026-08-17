# Work Charter PV1 Paired Product Validation Terminal

Date: 2026-08-17

## Terminal Disposition

Overall result: `INCONCLUSIVE / PRODUCT_UNKNOWN`.

WC-PV1-D01 / WC-PV1-C01 completed exact-candidate and Native-isolation
qualification, then consumed the eight approved pilot roots once. All eight
turns ended in the same provider-stream transport failure before producing a
user-visible response. No product cell is admissible, so the pilot continuation
gate failed and P4/P5/P6/P8, nested roles, and the blinded assessor did not
start.

The thread receipts named the requested model but did not report reasoning
effort. The requested `high` reasoning binding therefore remains `UNKNOWN` and
independently fails the pilot continuation gate; it is not represented as a
verified paired condition.

This result is neither a Work Charter defect nor evidence of benefit. It cannot
support a comparative win, median delta, efficacy statement, resume efficacy
bullet, or product acceptance.

## Frozen Subject And Conditions

- Repository baseline: `22a8e19d2cbec8b13847cf9120c4df2cd31cbf27`.
- Released Work Charter: commit
  `ac790233d5a8ba5afafd6eef95b1d5bc3cbe83a6`.
- Exact package tree: `97f0d9de17abc9c699772e0ebdcbdaa23d890008`.
- Canonical five-file manifest:
  `04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`.
- Frozen contract SHA-256:
  `df373205e1d4be7aa732b3b8f03b5f8cac1d223df812f91f6b49cff3c5c68558`.
- Freeze SHA-256:
  `023512e3efe776fc8479397b46fbdd7ebf6ebf1b228eb3c689ce9671bbc14d10`.
- Harness: Codex CLI `0.147.0-alpha.6.6`, executable SHA-256
  `592958896cbffa154709618476fc9c9bf7fe73957e9a4fc12094c5051b6c69b3`.
- Requested evaluation model: `gpt-5.6-sol` with high reasoning.
- Tools and permissions: identical read-only local conditions, no network tool,
  no MCP servers, approval policy `never`.

Native workspaces exposed no Work Charter path. Assisted workspaces exposed one
exact release package path and the same non-target catalog. Each pair had the
same user prompt, payload inventory, model request, tools, and permissions.
Project instruction discovery was suppressed for both conditions so the Native
baseline did not receive target-derived repository guidance.

## Qualification

The third and final pre-consumption qualification attempt passed with zero
product contexts and zero model starts. Two earlier zero-consumption attempts
are retained in the private carrier:

1. `q01` corrected canonical JSON key ordering for the already accepted
   package-manifest algorithm.
2. `q02` corrected the Windows executable route after direct CreateProcess of
   the WindowsApps alias returned access denied before app-server
   initialization.
3. `q03-final` passed exact candidate identity, Native/Assisted catalog
   separation, prompt/payload equality, workspace materialization, and
   zero-model app-server discovery.

These are carrier and host-route qualifications, not product evidence.

## Pilot Consumption

| Scenario | Native | Assisted | Admissible comparison |
|---|---|---|---|
| P1 small off-by-one | transport failure | transport failure | no |
| P2 implicit applicability proposal | transport failure | transport failure | no |
| P3 current-task handling | transport failure | transport failure | no |
| P7 authority ordering | transport failure | transport failure | no |

Each root created one ephemeral thread and one `turn/start`. The thread-start
receipts identified model `gpt-5.6-sol`; the current app-server response left
`reasoningEffort` unreported (`null`). Every turn then exhausted the Harness's
internal reconnect sequence and completed `failed` with a stream-disconnected
error for the Responses endpoint. Every workspace inventory remained
unchanged.

Counts at terminal:

- root product contexts: 8/16;
- nested role contexts: 0/8;
- assessor contexts: 0/1;
- total contexts: 8/25;
- model-turn starts: 8/32;
- admissible product cells: 0;
- retries, reruns, resumes, replacements, or fallback cells: 0.

The Harness-internal reconnect attempts occurred inside each already consumed
turn; they were not new product contexts or runner-initiated retries.

## Stop And Claim Boundary

The frozen pilot policy required condition isolation, candidate identity,
paired-input equality, and valid private/public evidence routing before the
remaining scenarios. Identity, isolation, equality, and routing qualified, but
the pilot supplied no admissible product response. The remaining-evidence and
assessor prerequisites therefore failed closed.

The eight consumed roots are sealed. They must not be repaired, replayed,
rescored, replaced, or renamed to evade the stop. A successor would require a
new user-owned material decision and a new contract; it could not reuse these
starts as fresh evidence.

## Evidence And Privacy

Raw prompts, event streams, thread identifiers, exact task-local paths, and
workspace inventories remain in one declared task-owned ignored carrier. This
public record retains only sanitized identities,
hashes, counts, outcomes, and limits. No private raw evidence, credentials,
cookies, user configuration, or host containment details are published.

## Portfolio Disposition

No comparative case study, efficacy diagram, demo claim, or resume efficacy
bullet is produced because WC-PV1 has no admissible product cell. The product
overview may describe the approved promise and existing bounded evidence, but
must link this result and preserve the `PRODUCT_UNKNOWN` limit.

## Effects

Work Charter SOURCE, cases, fixtures, controllers, model configuration, user
configuration, installation, stable copies, tags, releases, remotes, and host
configuration were unchanged. No push, merge, integration, publication,
cleanup, or remote effect occurred.
