# 0005: v0.1 Standalone GitHub Distribution

Date: 2026-07-28
Status: accepted; repository-owner locator superseded by Decision 0013

## Context

The repository needs one supported v0.1 path that lets a Codex user install
one Skill without treating a development checkout, copied directory, or moving
branch as a release identity. The three Skills must remain independently
selectable even though v0.1 uses one repository-level version.

Current
[OpenAI Skill guidance](https://learn.chatgpt.com/docs/build-skills)
supports standalone local Skills and using `$skill-installer` to download
Skills from other repositories. It describes that path as local setup and
experimentation, while preferring Plugin packaging for broadly installable
distribution. A Plugin is a larger distribution envelope and is not required
for these instruction-only Skills to work locally.

## Options Considered

1. Publish the repository and tell users to copy directories from the moving
   `main` branch.
2. Publish one standalone GitHub repository, install individual
   `skills/<skill-name>` directories through `$skill-installer`, and pin every
   release install to an immutable repository tag.
3. Package the three Skills as a skill-only Plugin for v0.1.
4. Maintain separate repositories or release lines for each Skill.

## Decision

- Use one standalone public GitHub repository as the v0.1 distribution source.
- Use
  [`matsuri1987/eddie-skills`](https://github.com/matsuri1987/eddie-skills)
  as the exact public repository identity.
- Keep each public installation unit at `skills/<skill-name>`. A user may
  install one Skill or multiple Skills, but every Skill in one supported v0.1
  set must come from the same repository tag.
- Use the public `$skill-installer` workflow as the supported Codex
  installation interface. The install request must name the exact public
  repository URL, immutable version tag, and requested Skill path or paths.
- Use repository-level semantic version tags. The first intended stable tag is
  `v0.1.0`; the tag may be created only after the release candidate is
  accepted.
- Use an exact commit SHA for release-candidate or diagnostic installs and an
  immutable tag for stable installs. Do not present the moving `main` branch as
  a stable installation source.
- Treat GitHub-generated archives as derived transport for the named tag, not
  as separately editable or independently versioned packages.
- Do not make manual directory copying the supported v0.1 installation path.
  It cannot by itself prove the selected revision, installer behavior, or
  actually loaded copy.
- Do not promise one universal destination path. The active Codex surface and
  installer own local placement; release evidence must record the actual
  destination and discovery result.
- Defer Plugin packaging. v0.1 is an early standalone Codex distribution, not a
  Plugin-directory or one-click workspace distribution claim.
- Keep installation, replacement, update, rollback, remote creation, push,
  tag, and release actions behind their existing explicit authorization gates.
- Permit the accepted candidate commit to be visible in the public repository
  before the stable tag so `$skill-installer` can be tested by exact commit
  SHA. This visibility policy does not itself execute or authorize a specific
  remote creation, commit, or push action.

## Consequences

- The repository remains the only source and does not need a duplicated package
  tree or per-Skill repository.
- Users can install only `use-powershell-safely` or another selected Skill
  without installing all three.
- The public README can use the stable `$skill-installer` user interface rather
  than exposing a bundled helper script path as a permanent API.
- The stable installation prompt can name the approved repository and intended
  `v0.1.0` tag, but it must remain marked unavailable until the remote and tag
  actually exist.
- A full pre-tag installer smoke requires the exact candidate commit to be
  reachable from GitHub. The visibility policy is accepted, while the concrete
  commit and push remain separately authorized external actions.
- A supported-path claim still requires an isolated candidate installation,
  loaded-copy proof, and a stable-tag regression smoke; this decision alone is
  not installation evidence.
- v0.1 will not appear in the universal Plugin directory and does not claim the
  broader sharing, workspace, connector, or presentation features of Plugins.

## Re-evaluation Conditions

Reconsider Plugin packaging when users need directory discovery, one-click
installation, workspace distribution, multiple bundled capabilities,
connectors, MCP servers, hooks, or presentation metadata. Also reconsider this
decision if the supported Codex Skill installation interface materially
changes or cannot install an immutable GitHub subdirectory reproducibly.

## Related Documents

- [GitHub public identity update](0013-github-public-identity-update.md)
- [Development, installation, and release runbook](../RUNBOOK.md)
- [Product specification](../SPEC.md)
- [Architecture](../ARCHITECTURE.md)
- [Verification](../VERIFICATION.md)
- [OpenAI Skills and Plugins](https://learn.chatgpt.com/docs/skills-and-plugins)
