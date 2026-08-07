# Project Docs

[English](README.md)

Project Docs 帮助 programmer 和技术型独立开发者，让项目事实、权威、
证据和恢复路径能够被人类与 coding agent 可靠地找到和维护。它会保留已经
充分的现有文档体系，并在不强制固定文件套件的前提下修复治理问题。

## 何时使用

- 项目文档缺失、重复、陈旧、冲突、由生成器产生、由外部系统拥有，或难以
  从中恢复工作；
- 项目需要首次采用文档治理；
- 需要评估结构拆分、合并、重命名、迁移或 canonical owner 变更；或
- 用户通过自然语言或 `$manage-project-docs` 请求项目文档审计、修复、暂停、
  交接或恢复。

## 何时不使用

- 普通文档更新已经有有效的项目路由；
- 任务只是文案编辑或生成结果格式调整；
- 成熟布局已经充分且不需要修复；或
- 唯一理由只是项目持续时间较长。

## 独立安装

从 live repository refs 和仓库[验证](../../VERIFICATION.md)中选择一个已接受的
不可变 tag，并用它替换 `<version-tag>`：

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/manage-project-docs.
```

安装不等于调用、目标项目采用、写入或发布授权。不要把持续移动的 `main`
branch 当作 stable identity。

## 调用

Codex 可以根据直接的文档治理请求，或高置信度的 authority、evidence、routing、
recovery 症状选择 Project Docs。隐式选择从只读开始：可以检查并提出方案，但不
授权采用、结构变更、owner 变更或任何写入。

`$manage-project-docs` 仍是手动 override：

```text
$manage-project-docs 审计此仓库的项目文档治理。未经单独批准，不要进行结构变更。
```

具体方案可见后，用户用自然语言作出的无歧义确认只授权方案列明的目标项目变更。
经授权完成采用后，普通任务无需加载 Project Docs，而是遵循目标项目持久化的
路由。损坏的路由可以让 Project Docs 再次变得相关，但路由文字和隐式选择都不
授权修复。

对于新项目，Project Docs 从五项最小逻辑职责开始，只有在 owner 或更新生命周期
确实需要独立时才启用单独的功能模块。对于已有项目，它映射现存文档；路由充分时
保留原布局。

## 安全边界

除非另行授权更新，否则审计保持只读。首次采用、新模块、拆分、合并、重命名、
迁移、权威变更和 canonical owner 变更都需要显式结构授权。范围、权限、writer
归属或证据未解决时，Project Docs 会在不安全写入前停止。它不是 daemon，也不会
在后台扫描每个任务。

## 已验证能力与限制

已发布的 `v0.1.2` 六文件包已有 exact-source 行为证据、受控开发 loaded-copy 证据、
exact-commit candidate identity，以及 `v0.1.2` tag-pinned stable
loaded-copy identity 与成熟布局 `NOOP` canary。当前 working-tree revision 改变了
selection 与 module routing，在达到 candidate readiness 前需要 revision-specific
评估。当前已接受的 release 仍是仓库级
[`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2)。稳定安装层的
变更行为、广泛触发 telemetry、因果效果、token 节省和跨 Harness 等价性均未
得到证明。参见[验证](VERIFICATION.md)和[状态](STATE.md)。

## 权威合同

本页是面向人的入口，不是第二份运行规范。仓库
[产品合同](../../SPEC.md)、[Project Docs 设计](DESIGN.md)、已接受 decisions
和 canonical [`SKILL.md`](../../../skills/manage-project-docs/SKILL.md)
共同拥有行为定义；如有冲突，以这些英文 canonical 来源为准。
