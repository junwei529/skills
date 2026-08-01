# Work Charter

[English](README.md)

Work Charter 用显式 outcome、authority、evidence、recovery route，以及保护
结果所需的最小 coordination，来约束有后果的 Codex 工作。

## 何时使用

- continuity、authorization、recovery、writer ownership 或 independent
  assessment 使 flat execution 不再可靠；
- 有后果的工作需要持久 Charter；
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

可观察的控制或恢复症状可以允许隐式识别和可见 proposal。首次持久采用、第一份
Standard policy、角色交付、写入、Git 和外部影响仍需分别授权。

## 安全边界

Profile 选择不会扩大 action authority。active Charter 保持一条 execution
lane、一个 repository writer，并至多有一个 Planner 和一个 Executor。合同、
权限、workspace、writer、证据、交付或恢复存在实质歧义时停止。

跨 session 继续前，应核验 material decision 的权威 revision，以及任何必要的
持久 assessment 记录。证据必须覆盖实际结果表面；其绑定对象发生实质变化后，
原证据即变为 stale。

## 已验证能力与限制

已记录的 hardening 前 M2R SOURCE、受控开发 P/E 与 Standard 角色交付、
exact-commit RC 恢复 canary，以及历史 `v0.1.1` tag-pinned 显式 Flat smoke，
均对其精确 revision 通过。review 前的 authority、assessment 和 evidence
revision 已有结构、fixture 前置条件、sole-`DEV_DISCOVERY` fresh-context 证据，
以及独立的 bounded `ACCEPTED`；partial 等级仍如实保留。当前 package bytes
已在 `c42eef3...` 获得 exact-commit loaded-copy 证据，在 flat task 中保持未加载，
并通过一条 bounded synthetic Standard Phase One：先持久记录 Planner verdict，
再允许 Orchestrator 依赖，随后也持久记录 Orchestrator assessment。当前已接受的
stable identity 由 live repository release ledger 拥有。当前 stable 行为、
广泛隐式触发 telemetry、独立真实项目效果、确定性角色交付或 writer 锁，以及
跨 Harness 等价性均未得到证明。参见[验证](VERIFICATION.md)和
[状态](STATE.md)。

## 权威合同

本页是面向人的入口。仓库[产品合同](../../SPEC.md)、
[Work Charter 设计](DESIGN.md)、已接受 decisions 和 canonical
[`SKILL.md`](../../../skills/work-charter/SKILL.md)拥有行为定义；发生冲突时，
以这些英文 canonical 来源为准。
