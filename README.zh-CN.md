# Agent Workflow Skills

[English](README.md)

让有后果的 Codex 工作保持可恢复，同时不把每项任务都变成工作流。

这个 Markdown-first 仓库包含三个相互独立的 Codex Skills。每个 Skill 都可以单独
安装、调用、使用、停止和评估。

| Skill | 用途 | 指南 |
|---|---|---|
| `manage-project-docs` | 建立并维护可靠的项目文档治理 | [Project Docs](docs/skills/manage-project-docs/README.zh-CN.md) |
| `work-charter` | 按 outcome、authority、evidence、recovery 和比例化协调约束有后果的工作 | [Work Charter](docs/skills/work-charter/README.zh-CN.md) |
| `use-powershell-safely` | 处理实质 PowerShell、native process、文本、权限和 WSL 边界 | [PowerShell](docs/skills/use-powershell-safely/README.zh-CN.md) |

属于同一个仓库不构成触发条件，一个 Skill 也不会授权或激活另一个 Skill。

## 安装

从 live repository refs 和[验证账本](docs/VERIFICATION.md)选择一个已接受的
immutable tag，然后只安装所需 package：

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/work-charter.
```

按需把末尾路径替换为 `skills/manage-project-docs` 或
`skills/use-powershell-safely`。不要把持续移动的 `main` 当作 stable installation
identity。

安装、调用、项目读取、写入、Git 和外部影响是彼此独立的授权面。

## 使用

```text
$manage-project-docs 审计此仓库的项目文档治理。

$work-charter 约束此项有后果的工作、权限、证据和恢复。

$use-powershell-safely 在修改代码前诊断此 Windows shell 边界。
```

Work Charter 也可能识别明显的复杂性、连续性、authority、writer、evidence、
recovery 或协作信号。在显式激活前，它只解释为什么可能适用、提出最小必要读取并
请求确认；不会声称已经激活，也不会预先规定工作流。获得显式权限且精确正文可用
后，它才推荐最小充分保护，同时让普通任务保持 flat。完整边界见
[Work Charter 指南](docs/skills/work-charter/README.zh-CN.md)。

## 发布状态

当前已接受的 stable set 是 immutable
[`v0.2.0`](https://github.com/junwei529/skills/releases/tag/v0.2.0)，对应
`ac790233d5a8ba5afafd6eef95b1d5bc3cbe83a6`。该集合中 Work Charter 和
PowerShell 是 changed packages，Project Docs 与其 `v0.1.2` package
byte-identical。精确 package、installer、loaded-copy、rollback 与 release 证据
记录在[仓库验证](docs/VERIFICATION.md)。

共享 tag 只标识 coherent release set，并不表示每个 Skill 都发生了变化或具有相同
的证据成熟度。工作区 SOURCE 可能领先于 installed release；归因行为前请查看
[仓库状态](docs/STATUS.md)。

## 证据限制

仓库记录结构检查、合成行为、受控 loaded-copy canary、exact-commit candidate 和
stable-install identity。它不宣称广泛触发准确率、确定性强制、因果正确性提升、
token 节省、跨 Harness 等价或真实项目 efficacy。

## 项目文档

- [文档索引](docs/INDEX.md)
- [产品规范](docs/SPEC.md)
- [架构](docs/ARCHITECTURE.md)
- [仓库状态](docs/STATUS.md)
- [验证](docs/VERIFICATION.md)
- [开发与发布 Runbook](docs/RUNBOOK.md)

可安装 packages 位于 `skills/<skill-name>/`；面向人的产品、设计、状态和证据文档
位于 `docs/skills/<skill-name>/`。

## 许可证

采用 [MIT License](LICENSE)。
