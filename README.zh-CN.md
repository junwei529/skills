# Agent Workflow Skills

[English](README.md) | **简体中文**

这是一组小而可组合、面向 Codex 的 Skills，用于在多个 Agent Session
之间保持可靠的项目事实、约束大型任务协作，并显式处理
PowerShell、native executable 与 WSL 的边界。

它把大型个人规则集中的经验提炼为三个彼此独立、按需加载的 Skill。
目标项目自己的指令始终具有更高权威；详细指导只在需要时加载；尚未验证
的主张会被明确标出。

> 本文件是 [`README.md`](README.md) 的简体中文镜像。若两者存在语义
> 冲突，以英文 README 为准。

## 你能获得什么

- Project Docs 治理层：先采用已有文档，再修复权威与状态漂移，只增加让
  后续 Agent 能安全继续所需的最小结构。
- 受约束的 Work Charter：当已观察到的连续性或控制风险确有需要时，
  按比例启用受政策约束的 Orchestrator/Planner/Executor 支持。
- Windows shell 诊断与安全执行工作流：区分代码缺陷与 runtime、encoding、
  quoting、native process、WSL、permission 和 environment 问题。

## 状态

Project Docs 的产品合同和 canonical Skill SOURCE 已于 2026-07-28
针对程序员和技术型独立开发者完成精简。其接受的
[渐进式治理决策](docs/decisions/0006-project-docs-progressive-governance.md)
定义了五项逻辑职责、事件驱动扩展、显式结构授权，以及轻量的目标项目
连续性锚点。当前实现使用两个条件性 reference、两个最小 output asset
和五个聚焦场景，而不是强制规定一套文档目录。

三个 Skill 的原始 baseline 已有 synthetic development evidence。
后续 PowerShell portable-guidance revision 增加了受限泛化、
高信号 trigger、native error preference、更加完整的 WSL identity/stream
检查，以及显式的 private-host 排除。七个边界场景和两个
catalog-assisted non-trigger canary 在对应 development SOURCE 上通过。
这些结果是 SOURCE-assisted behavior 和 catalog-level selection evidence。
受控的 native `DEV_DISCOVERY` canary 还证明了 canonical SOURCE 的隐式
选择，以及普通 cmdlet 不会加载该 Skill；这仍不是 candidate、
stable-install 或 release proof。

Project Docs 现已与当前官方 Codex manual 对 explicit-only invocation、
AGENTS loading、continuity routing 和 authorization boundary 的定义对齐。
五个显式 fresh-context 场景、一个只验证 persistence 的 broken-routing
变体，以及受控的 native `DEV_DISCOVERY` 正负 canary 均已通过。它们证明
选中的 development SOURCE 和未显式调用时不加载，而不是 candidate 或
release identity。

Candidate identity 必须是包含这份记录的 clean、reviewed commit；
staged 或 dirty working tree 不是 candidate，后续 commit 也不会把上述
development evidence 追溯固定为 release evidence。

对应 revision 已提交为
[`c5d8e185ea9a9f32a4e98ac8ac364c4ebe915535`](https://github.com/junwei529/skills/commit/c5d8e185ea9a9f32a4e98ac8ac364c4ebe915535)
并公开到
[`junwei529/skills`](https://github.com/junwei529/skills) 的 `main`。
后续 shared exact-commit candidate
`78caaa6ecf6b86c1b7be26d03aa5dfde1ebbdf09`
对三个 Skill 都通过了隔离的 `$skill-installer`、identity、loaded-copy
及代表性的正负 smoke。不可变的 `v0.1.0` tag 指向同一 candidate，
tag-pinned multi-Skill `STABLE_INSTALL` 也通过了 6/5/5 文件 identity、
single-discovery、validator 和 fresh-process loaded-copy smoke。

这些结果关闭了 tag-to-install 的技术 identity，但没有建立自洽的公开
release identity：`v0.1.0` 自身快照里的 README 早于标签发布，仍写着该
标签不存在。该标签仅作为历史 evidence 保留，绝不能移动。目前没有
GitHub Release object，也没有建立 generalized efficacy、portability、
broad trigger telemetry 或 token-saving 主张。

修正后的 patch-release 接口是 `v0.1.1`。该不可变标签必须指向一个经过
审查、包含本双语 README 和已接受 Skill SOURCE 的 revision，并再次通过
exact-tag installation 与 loaded-copy proof。这里的措辞在标签发布前后
都成立，不会把尚未验证的标签写成已经存在。当前 mapping 与 evidence
由 [`docs/VERIFICATION.md`](docs/VERIFICATION.md) 统一维护。

Work Charter M2R 产品合同已由
[Decision 0012](docs/decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)
接受。它使用一个最小充分的逻辑合同、observed-risk activation、已批准
standing policy 的可见复用、紧凑 recovery 与按比例 role separation。
首次 persistent adoption 和第一个 Standard policy 仍由用户决定；后续
复用也不会传播 action authority。Canonical package 是 `work-charter`，
已废弃的 `manage-large-tasks` SOURCE 不保留 alias。

Work Charter 的 SOURCE-assisted matrix 已有五组符合合同的行为和两个
受控 negative variant，并记录 canonical SOURCE identity。
Development、candidate behavior 与 tag-pinned stable loaded-copy identity
均已通过；broad trigger telemetry 和独立真实项目行为仍属于后续 gate。

可查看以下经过脱敏的 evidence：

- [初始 development report](evals/results/2026-07-27-development-forward-tests.md)
- [修订后的 PowerShell report](evals/results/2026-07-28-powershell-forward-tests.md)
- [PowerShell portable-guidance migration check](evals/results/2026-07-30-powershell-portable-guidance-migration.md)
- [Project Docs M1R report](evals/results/2026-07-29-project-docs-m1r-forward-tests.md)
- [Project Docs official-manual alignment report](evals/results/2026-07-30-project-docs-official-manual-alignment.md)
- [Work Charter M2R report](evals/results/2026-07-29-work-charter-m2r-forward-tests.md)

## Skills

| Skill | 用途 |
|---|---|
| [`manage-project-docs`](skills/manage-project-docs/SKILL.md) | 采用并修复项目文档治理，使后续 Agent 能找到权威状态并安全恢复。 |
| [`work-charter`](skills/work-charter/SKILL.md) | 用最小充分合同、按比例协作、evidence-aware recovery 和显式授权约束 consequential work。 |
| [`use-powershell-safely`](skills/use-powershell-safely/SKILL.md) | 诊断 PowerShell/native/WSL 边界、检查 runtime readiness，并在确实降低风险时推荐 PowerShell 7。 |

每个 Skill 都是解决不同问题的独立产品。`manage-project-docs` 负责
document semantics、canonical placement、governance repair，以及目标
项目的轻量 continuity anchor。Work Charter 负责 consequential-work
boundary、按比例 role coordination、recovery 与 assessment。
`use-powershell-safely` 负责 Windows shell boundary diagnosis 和
safe-execution guidance。任何一个 Skill 都不要求先安装或调用另一个。

它们也可以通过可选 recipe 组合。例如，Project Docs 可以先建立可靠的
document routing，再由 Work Charter 使用这些指针；当大型 Windows
任务出现 native/WSL boundary 时，可以单独选择 PowerShell Skill。
Recipe 不会自动安装、调用或转移 Skill 之间的授权。参见
[独立 Skill 决策](docs/decisions/0007-independent-skills-and-optional-recipes.md)。

## 60 秒导览

1. 阅读已接受的
   [Project Docs 合同](docs/decisions/0006-project-docs-progressive-governance.md)
   及其五项逻辑职责。
2. 查看当前
   [`manage-project-docs`](skills/manage-project-docs/SKILL.md) workflow、
   条件性 references 和
   [最小 output assets](skills/manage-project-docs/assets/templates)。
3. 阅读已接受的
   [Work Charter 合同](docs/decisions/0012-work-charter-v0-1-identity-and-minimum-sufficient-design.md)，
   再查看 [`work-charter`](skills/work-charter/SKILL.md)、两个条件性
   reference 和最小 asset。
4. 查看 [evaluation cases](evals/README.md) 和诚实记录 claim 状态的
   [verification ledger](docs/VERIFICATION.md)。

安装后可这样调用：

```text
Use $manage-project-docs to audit this repository's authority, status, and handoff docs.
Use $work-charter to bound this consequential migration and its acceptance loop.
Use $use-powershell-safely to diagnose this PowerShell-to-WSL quoting failure.
```

这些是预期的独立 v0.1 接口。Work Charter 既有 canonical SOURCE，也有
经过验证的 tag-pinned installation。安装不会授权把 Skill 引入目标项目，
也不会授权任何其他 external action。修正后的 patch-release 接口见下节；
当前 availability 与 proof 仍是独立的 lifecycle facts。

## 安装与分发

v0.1 使用一个独立 GitHub repository 和 repository-level immutable
version tags。每个 Skill 仍可从自己的 `skills/<skill-name>` 目录独立
安装。安装必须通过 `$skill-installer` 指定准确的公开 repository URL、
immutable tag 和 Skill path，不能把移动的 `main` 当作 stable source。

对于修正后的 `v0.1.1` patch release，只应在公开标签已经解析到经过审查
的 candidate 后安装。单独安装 PowerShell Skill 的接口是：

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/v0.1.1/skills/use-powershell-safely.
```

如需从同一标签一次安装三个 Skill：

```text
$skill-installer Install `skills/manage-project-docs`, `skills/work-charter`, and `skills/use-powershell-safely` from https://github.com/junwei529/skills at tag `v0.1.1`.
```

标签一旦发布就必须保持不可变。旧的 `v0.1.0` 只保留为 installation
evidence，不得移动；其中的 README 也不是 canonical release
documentation。只有在 `docs/VERIFICATION.md` 记录了公开 tag-to-commit
mapping、精确 installed files、每个 Skill 仅一个 discoverable copy、
validator 和 fresh-process loaded-copy evidence 后，才能提出 `v0.1.1`
release claim。

当前 OpenAI guidance 支持 standalone local Skills，以及通过
`$skill-installer` 从 repository 下载；对于更广泛的可安装分发则更倾向
Plugins。本项目有意把 v0.1 保持为早期 standalone Codex release，并推迟
Plugin packaging。参见
[distribution decision](docs/decisions/0005-v0-1-standalone-github-distribution.md)、
[identity update](docs/decisions/0013-github-public-identity-update.md) 和
[runbook](docs/RUNBOOK.md)。

## 为什么使用 Skills，而不是一个全局文件

- Trigger-specific description 可避免普通任务加载无关指导。
- 简洁的 entry file 只在需要时路由到条件性 reference 和 output template。
- 项目本地规则可以覆盖通用 workflow guidance，无需 fork 一个单体规则文件。
- 文档治理、role control 和 shell diagnosis 可以独立评估。

## 设计原则

- 保持每个 `SKILL.md` 简洁，只在需要时加载详细 reference。
- 每个 Skill 必须独立有用；组合只能作为可选 recipe，不能成为隐式依赖。
- 保留 project-local instructions 和已有文档体系。
- Continuity 必须持久化在目标项目自己的治理入口，而不是 chat、
  private memory 或 Skill installation。
- 普通任务保持 Flat；只有观察到 continuity、control、authorization、
  recovery 或 independent-assessment 风险时才增加 role separation。
- Skill 是 advisory workflow，不是 sandbox、lock 或 permission system。
- 诚实记录 unknown 与未验证 claim。
- 公开 artifact 不得包含 private path、ID、credential、raw conversation
  或 host-specific fingerprint。

## Repository 文档

从 [docs/INDEX.md](docs/INDEX.md) 开始阅读。

Repository 自身的治理文档描述本项目。`skills/*/assets/` 下的模板是供
目标项目使用的输出资源，并不是本 repository 的当前事实。

贡献者应遵循
[development、installation 与 release runbook](docs/RUNBOOK.md)。
`skills/` 下的文件是唯一可编辑 SOURCE；development mapping、
release candidate 和 stable installation 都是派生环境。

Evidence 与 release boundary 记录在
[evaluation plan](evals/README.md)、
[verification ledger](docs/VERIFICATION.md) 和
[provenance record](docs/PROVENANCE.md)。

## 当前非目标

- 通用 Agent Harness runtime。
- 自动 thread 或 session orchestration。
- MCP service、Web UI、database 或 remote registry。
- 组织级 documentation catalog、compliance/policy engine、
  connector synchronization 和 automatic mapping invalidation。
- 原生 cross-Harness Project Docs package 或 umbrella Skill。
- 自动 commit、push、merge、cleanup、software installation/update、
  elevation 或 system configuration mutation。
- 没有 evidence 的 cross-Harness portability 或 causal token-saving claim。

## License

采用 [MIT License](LICENSE)，Copyright 2026 junwei529。
