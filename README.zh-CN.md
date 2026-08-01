# Agent Workflow Skills

[English](README.md)

一个 Markdown-first 的 Codex Skill 集合，包含三个可以独立使用的产品，分别处理
可靠项目事实、有后果的工作和 Windows shell 边界。

## 选择 Skill

| Skill | 用途 | 公开指南 |
|---|---|---|
| `manage-project-docs` | 审计、采用、修复和维护项目文档治理 | [Project Docs](docs/skills/manage-project-docs/README.zh-CN.md) |
| `work-charter` | 用显式 authority、evidence、recovery 和比例化协调约束有后果的工作 | [Work Charter](docs/skills/work-charter/README.zh-CN.md) |
| `use-powershell-safely` | 诊断并安全执行实质 PowerShell、native、文本、权限和 WSL 边界 | [PowerShell](docs/skills/use-powershell-safely/README.zh-CN.md) |

每个 Skill 都可以独立发现、安装、调用、使用、停止和评估。属于同一个仓库并不
构成触发条件。

## 安装

从 live repository refs 和[仓库验证](docs/VERIFICATION.md)中选择一个已接受的
不可变 tag，并用它替换 `<version-tag>`：

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/manage-project-docs.
```

如需另一个 Skill，把末尾路径替换为 `skills/work-charter` 或
`skills/use-powershell-safely`。

从同一个仓库版本安装完整集合：

```text
$skill-installer Install `skills/manage-project-docs`, `skills/work-charter`, and `skills/use-powershell-safely` from https://github.com/junwei529/skills at tag `<version-tag>`.
```

安装、调用/采用、执行/写入和打包/发布是彼此独立的授权面。不要把持续移动的
`main` branch 当作 stable installation identity。

## 调用

```text
$manage-project-docs 审计此仓库的项目文档治理。

$work-charter 约束此项有后果的工作、权限、证据和恢复。

$use-powershell-safely 在修改应用代码前诊断此实质 Windows shell 边界。
```

Project Docs 只允许显式调用。Work Charter 可以根据具体控制或恢复症状隐式
识别，但只能提出可见 proposal。PowerShell 可以在实质 Windows 边界出现时
被选择。各公开指南定义了不触发场景和安全限制。

## 可选组合

三个 Skill 是平级产品，不是层级结构：

- Project Docs 可以先修复文档路由，随后由 Work Charter 消费。
- Work Charter 可以保留任务 authority，同时由 PowerShell 处理一个实质
  Windows 边界。
- 三者可以在同一项目使用，但不会共享 runtime state 或传播授权。

Recipe 不会自动安装、调用、采用、写入或发布另一个 Skill。

## 发布状态

本仓库对一个受支持的三 Skill 集合使用同一个不可变 repository-level tag。
`v0.1.0` 与 `v0.1.1` 仍是已记录的历史 identity；当前已接受的 stable tag、
candidate proof 和任何 GitHub Release object 由 live refs 与
[仓库验证](docs/VERIFICATION.md)拥有，而不是由本 README 快照声明。

工作区 SOURCE 可能包含不属于已安装 release 的后续开发内容。在归因行为前，
请查看[仓库状态](docs/STATUS.md)和各 Skill State 页面。

## 仓库文档

- [文档索引](docs/INDEX.md)
- [权威映射](docs/AUTHORITY.md)
- [产品规范](docs/SPEC.md)
- [架构](docs/ARCHITECTURE.md)
- [仓库状态](docs/STATUS.md)
- [仓库验证](docs/VERIFICATION.md)
- [开发与发布 Runbook](docs/RUNBOOK.md)
- [路线图](docs/ROADMAP.md)

可安装包位于 `skills/<skill-name>/`。面向人的产品、设计、状态和证据文档位于
`docs/skills/<skill-name>/`，不会复制进可安装包。

## 证据限制

仓库记录结构检查、合成行为、受控 loaded-copy canary、exact-commit candidate
和 stable-install identity。它不宣称因果正确性提升、token 节省、广泛触发准确率、
跨 Harness 等价性或 SHICE 验证。

## 许可证

采用 [MIT License](LICENSE)。
