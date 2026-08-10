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

Project Docs 可以根据直接的文档治理请求，或高置信度的 authority、evidence、
routing、recovery 症状被选择。该隐式路径只允许只读检查和提出方案，不授权采用、
结构、canonical owner 变更或写入；`$manage-project-docs` 仍是手动 override。
具体方案可见后，自然语言确认只授权方案列明的目标项目变更。有效的持久化项目
路由负责普通维护，无需加载 Skill。

Work Charter 也接受“调用 Work Charter，判断项目应该怎样继续”这类自然语言
请求；只有完整正文已经进入当前上下文后才能声称已经激活。泛化的“根据已安装 Skills
判断”请求或具体控制与恢复症状，只需 catalog metadata 就可以提出 proposal；原生选择
可能读取也可能不读取 `SKILL.md`，两种情况都不产生授权。首个回复必须以
`Work Charter appears applicable because ...` 开头，随后解释原因、提出激活与最小
项目读取范围并请求确认；不得使用 selection 或 activation 标题，不得声称已 selected、
loaded、invoked、active 或 adopted，不得检查项目，也不得提前给出 pause、writer、
evidence、handoff、resume、protection level 或角色流程。用户确认后，必须先证明精确
正文可用，才能声明激活或依赖流程；当前分支必需的 package references 可以加载，但
项目检查仍需批准精确范围。正文不可用时
停止激活；已批准的项目读取无法通过批准路径完成时，相关事实保持 `UNKNOWN`，其他
路径必须作为新的 proposal。若 runtime 不暴露精确加载路径或 revision，该身份保留为
`UNKNOWN`，Codex 不声称具体副本。PowerShell 可以在实质 Windows 边界出现时被选择。
激活或读取许可并不授权持久采用、角色交付、写入、Git、安装或外部影响。

## 可选组合

三个 Skill 是平级产品，不是层级结构：

- Project Docs 可以先修复文档路由，随后由 Work Charter 消费。
- Work Charter 可以保留任务 authority，同时由 PowerShell 处理一个实质
  Windows 边界。
- 三者可以在同一项目使用，但不会共享 runtime state 或传播授权。

Recipe 不会自动安装、调用、采用、写入或发布另一个 Skill。

## 发布状态

本仓库对一个受支持的三 Skill 集合使用同一个不可变 repository-level tag。
当前已接受的 stable release 是
[`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2)，对应
`ceed607152849775b981c54add74bfa30d858e4d`。`v0.1.0` 与 `v0.1.1` 仍是
已记录的历史 identity；精确 release 与 installed-copy 证据由 live refs 和
[仓库验证](docs/VERIFICATION.md)拥有。

这个共享 tag 是 release-set identity；它不表示每个 Skill 都在该 release
发生了变化，也不表示它们具有相同成熟度。

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
