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
- 用户显式要求使用 Project Docs 进行项目文档审计、修复、暂停、交接或恢复，
  包括通过 `$manage-project-docs` 调用。

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

## 调用与选择

无歧义的手动 token 是 `$manage-project-docs`，UI 名称是 **Project Docs**。
直接的文档治理意图，或高置信度的 authority、evidence、routing、recovery 症状，
也可以选择当前 development SOURCE，但只允许最小范围的只读检查和可见方案。
选择或加载 body 不授权采用、持久化、结构或 canonical owner 变更，也不授权写入。

手动调用：

```text
$manage-project-docs 审计此仓库的项目文档治理。未经单独批准，不要进行结构变更。
```

每次写入都需要用户以自然语言明确授权其具体可见效果。经授权完成采用后，普通
任务无需加载 Project Docs，而是遵循目标项目持久化的路由。路由损坏时可以重新
进入 proposal-only 行为，但路由与 Skill 选择都不授权修复。

对于新项目，Project Docs 从五项最小逻辑职责开始；当一个合并 starter 是最小的
已授权采用方式时，可以使用它。对于已有项目，它映射现存文档；路由充分时保留
原布局。

## 安全边界

除非另行授权更新，否则审计保持只读。每次写入、首次采用、新模块、拆分、合并、
重命名、迁移、权威变更和 canonical owner 变更都需要针对具体效果的显式授权。范围、权限、writer
归属或证据未解决时，Project Docs 会在不安全写入前停止。它不是 daemon，也不会
在后台扫描每个任务。

## 已验证能力与限制

`v0.1.2` 六文件包已有 exact-source 行为证据、受控开发 loaded-copy 证据、
exact-commit candidate identity 与 tag-pinned 成熟布局 `NOOP` canary。immutable
仓库 release [`v0.2.0`](https://github.com/junwei529/skills/releases/tag/v0.2.0)
保留这六个 exact package 文件，将 Project Docs 分类为 `unchanged`，并增加 fresh
active-stable loaded-copy 证明。对一个故意不完整的 synthetic authority map，结果如实
返回 `PROPOSE`；这属于 identity 与 bounded audit behavior，不是新的 Project Docs
package 或更广泛 efficacy claim。当前未发布的六文件 SOURCE 已提升 Decision
0019，并以 deterministic source、fixture 和 current-identity 检查约束；不可变的
explicit-only `v0.1.2`/`v0.2.0` package 仍作为历史 control。该 revision 的 fresh
loaded-copy selection、candidate、installation、release 与写入持久化仍未证明。稳定安装层的
变更行为、广泛触发 telemetry、因果效果、token 节省和跨 Harness 等价性均未
得到证明。参见[验证](VERIFICATION.md)和[状态](STATE.md)。

## 权威合同

本页是面向人的入口，不是第二份运行规范。仓库
[产品合同](../../SPEC.md)、[Project Docs 设计](DESIGN.md)、已接受 decisions
和 canonical [`SKILL.md`](../../../skills/manage-project-docs/SKILL.md)
共同拥有行为定义；如有冲突，以这些英文 canonical 来源为准。
