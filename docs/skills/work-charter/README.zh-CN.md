# Work Charter

[English](README.md)

Work Charter 用显式 outcome、authority、evidence、recovery route，以及保护
结果所需的最小 coordination，来约束有后果的 Codex 工作。

## 何时使用

- continuity、authorization、recovery、writer ownership 或 independent
  assessment 使 flat execution 不再可靠；
- 有后果的工作需要当前任务内或持久 Charter；
- Planner/Executor 分离能够实质保护实现；或
- 已批准 standing policy 和 active Charter 支持 Standard
  Orchestrator/Planner/Executor。

## 何时不使用

- 工作是小型、有界、单 session 任务；
- 唯一信号只是新任务、一次失败、耗时或文件数量；
- 任务属于普通文档治理或 shell 诊断；或
- 需要在其他 Harness 上冒充未经验证的 Codex 能力。

## 独立安装

从 live repository refs 和仓库[验证](../../VERIFICATION.md)中选择一个已接受的
不可变 tag，并用它替换 `<version-tag>`：

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/work-charter.
```

Work Charter 不依赖 Project Docs。它可以消费可靠的既有项目路由，而不安装或
调用另一个 Skill。不要把持续移动的 `main` branch 当作 stable identity。

## 调用

```text
$work-charter 约束此项有后果的工作、权限、证据、恢复和最小充分协调。
```

用户不需要记住精确语法，例如：

```text
调用 Work Charter，判断这个项目应该以什么方式继续。
根据已经安装的 Skills，建议这项工作怎样继续最安全。
```

首次选中后，Work Charter 会解释为什么匹配，并提出最小读取范围，例如项目规则、
一个 canonical owner（权威状态载体）、当前 workspace/writer 状态和已命名证据；
取得许可后才检查这些项目详情。仅由症状触发的隐式选择会停在这一可见 proposal。
首次持久采用、第一份 Standard policy、角色交付、写入、Git 和外部影响仍需分别
授权。

它会用通用语言推荐最小充分形式：普通简单任务（`L0`，无 active Charter）、
当前任务 Charter（`L1`）、持久单 Agent Charter（`L2`，有一个便于冷恢复的小型
持久锚点）、Planner/Executor 分离（`L3`），或 Standard O/P/E（`L4`）。这些代码
只是内部简写；Skill 解释保护收益与协调成本后，由用户选择。

## 安全边界

保护形式选择不会扩大 action authority。持久工作只使用一个权威 carrier（状态
载体），并按一个 managed workstream（受 Charter 保护的具体工作线）匹配，而不把
整个仓库都视为已采用。active Charter 保持一条 execution
lane、一个 repository writer，并至多有一个 Planner 和一个 Executor。合同、
权限、workspace、writer、证据、交付或恢复存在实质歧义时停止。

跨 session 继续前，应核验 material decision 的权威 revision，以及任何必要的
持久 assessment 记录。证据必须覆盖实际结果表面；其绑定对象发生实质变化后，
原证据即变为 stale。

## 已验证能力与限制

已记录的 M2R SOURCE、受控开发 P/E 与 Standard 角色交付、exact-commit RC
恢复 canary，以及 `v0.1.1` tag-pinned Flat smoke，均对其历史精确 revision
通过。仓库级
[`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2) stable copy
已有精确 loaded-copy identity、flat non-loading canary，以及一条窄范围的
fail-closed recovery/assessment-order canary；其精确的 release 前 control 还通过
一条 bounded synthetic Standard Phase One。后续 Gate 1 SOURCE 目前只有结构和
fixture 前置条件证据；自然语言选择、首轮读取边界、等级建议、重新接入路由和
可见 Standard 复用尚未运行分阶段模型矩阵。stable 层完整 Standard delivery、
广泛隐式触发 telemetry、独立真实项目效果、确定性角色交付或 writer 锁，以及
跨 Harness 等价性仍未得到证明。参见[验证](VERIFICATION.md)和[状态](STATE.md)。

## 权威合同

本页是面向人的入口。仓库[产品合同](../../SPEC.md)、
[Work Charter 设计](DESIGN.md)、已接受 decisions 和 canonical
[`SKILL.md`](../../../skills/work-charter/SKILL.md)拥有行为定义；发生冲突时，
以这些英文 canonical 来源为准。
