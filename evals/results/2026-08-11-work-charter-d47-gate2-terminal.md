# Work Charter D47 Gate 2 Environment Terminal

Date: 2026-08-11

## Scope

This report records the sanitized pre-product terminal for exact Work Charter
candidate `c4810057c3f28cca9f12004ca2018784cd21f449`, five-file manifest
`04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44`, and
released `v0.1.2` control `ceed607152849775b981c54add74bfa30d858e4d`.
D47 was an infrastructure-first additive Campaign intended to import admitted
A01-A10 without replay and start fresh product evidence at A11.

The report excludes raw prompts and responses, private paths, task/session/turn
identifiers, ignored-carrier artifacts, provider diagnostics, credentials, and
reasoning traces. It does not establish product behavior, candidate acceptance,
installation, or release readiness.

## Qualification

D47 used all three authorized zero-model carrier corrections while closing the
declared A11-A27 dependency and postprocessing surface. The final static
qualification passed 17/17 checks with zero product or assessor turns. Its
receipt SHA-256 is
`980d78d0cff53f65fbc104932c6ff45a7752d4a3fe48b4e1eea0d3268b200cbe`.

The corrections and qualification are infrastructure evidence only. They do
not consume, replay, replace, or score product behavior.

## Transport Terminal

The first required non-product `gpt-5.6-sol/high` canary consumed one
`turn/start`. The invocation returned no final model message because the
provider/account route did not make the pinned model available. No command,
Skill selection, Work Charter loaded-copy observation, product evidence, or
assessor activity occurred. The other two canaries and freeze did not start,
and no retry was permitted.

The canary receipt SHA-256 is
`b862f51bddf8702a9941c73e79d14c1c355ba81806dd8438d3f276c34ec647fd`;
the one-route batch receipt SHA-256 is
`1de2541bc424cc3cf75e3a7251e343a21c1159f67b3682f786b16f2471f3fcae`.

## Disposition

- Exact candidate: `UNACCEPTED_AT_GATE_2`
- Zero-model qualification: 17/17 `PASS`
- Pre-consumption corrections used: 3/3, all zero-model
- Non-product canaries: 0/3 passed; first route consumed one turn and failed
- Product and assessor turns: 0
- Product, selection, and loaded-copy evidence: none
- Stop origin: `ENVIRONMENT_PROVIDER_MODEL_AVAILABILITY`
- Retry, replay, or rescore: not permitted
- Work Charter SOURCE and tracked evaluation contract: unchanged by D47

This is an environment/provider-availability terminal, not a Work Charter
SOURCE or product defect. All product semantics remain
`UNKNOWN_NOT_ASSESSED`.

## Evidence Boundary

D47 is immutable and unaccepted. A later successful availability probe or
Campaign cannot rewrite this consumed canary, and this report does not transfer
admitted product credit or authorize a successor. Push, installation, tag,
release, stable update, cleanup, and external publication remain separate.
