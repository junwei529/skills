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

用自然语言明确说“使用 Work Charter”就是直接激活意图，不必记住
`$work-charter` 语法。只有该意图与完整正文都存在时，Codex 才能声称已经激活。原生
隐式选择可能在用户确认前读取精确 `SKILL.md`；这个 package read 只表示指令可用，
不是用户可见的激活、采用、项目读取授权或行动授权。泛化的“根据已安装 Skills 判断”
请求或仅由症状触发的匹配，仍只能得到以
`Work Charter appears applicable because ...` 开头的可见 proposal，随后说明原因、
建议的最小项目读取范围，并询问是否激活。回复不得使用 selection 或 activation 标题，
确认前不得声称 Work Charter 已 selected、loaded、invoked、active、adopted 或
in force，即使附带“仅为 Harness 状态”或“未获用户授权”的限定也不行；同时不得检查项目。用户
确认后，已经可用的正文可以满足 package 条件，只加载当前分支必需的 references；
项目仍只能检查另行批准的范围。正文不可用时停止激活；已批准的项目读取无法通过批准
路径完成时，相关事实保持 `UNKNOWN`，其他路径必须作为新的可见 proposal。若 runtime
不暴露精确加载路径或 revision，具体副本身份同样保持 `UNKNOWN`。首次持久采用、第一份
Standard policy、角色交付、写入、Git 和外部影响仍需分别授权。

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
一条 bounded synthetic Standard Phase One。`v0.2.0` 目前没有 accepted
candidate：`206c497...` 因 convergence 停止；successor `92a8c045...` 在 A04
停止，因为它虽然安全地提出了间接入口 proposal，却在没有加载 Skill 时声称已经
selected。精确 `72db7e9...` 实现了两阶段入口，但其固定轮次 Standard probe 已封存
`VIOLATION`，且没有运行 A16。条件式角色读取修订会在完整 Skill 正文不可用时
停止，并把未暴露的精确副本身份保留为 `UNKNOWN`；每个 fresh `L3`/`L4` 角色都
必须加载完整 Skill 和 coordination reference，`L4` 还必须在履行职责前加载
Standard reference。精确 candidate `b965102...` 仍未被接受。十个 Gate 2 行为
execution window 与两条零 turn 资格记录均已封存且不可重试。successor-8 在 A10
硬停止前完成 27 个 cell 中的 9 个：A04 暴露 metadata-only selected-state 声明，
A10 则在 Git 读取失败后扩大了批准读取范围；后者同时暴露 runner ownership 噪声，
不能算作产品 finding。独立 assessor 返回 `DECISION_REQUIRED`。当前 SOURCE 已收紧
metadata 措辞并加入 unavailable-read 停止规则；精确本地 product candidate
`53d424c...` 已记录这些字节。其 fresh Gate 2 batch 完成 A01-A11 后在 A12 封存，
原因是直接调用仍要求另行授权加载 Skill package；独立 assessor 返回
`DECISION_REQUIRED`。精确本地 D31 candidate `07a9f1c...` 明确区分激活所需
package reads 与精确项目读取范围。D32 mapping/freeze qualification 在无模型活动下
通过；D33 在模型输出或 package loading 前封存为基础设施 `UNKNOWN`。之后的
provider-response canary 通过，但 D35 使用的另一层外部 launcher 在一个
本来 controller-clean 的 native-baseline turn 后跳过了必需的 A01 semantic gate。
D35 已封存为 controller-orchestration `UNKNOWN_NOT_ASSESSED`。Additive D36
完成了 exact outer-wrapper qualification 和 A01-A12，但由评测 controller
实例化的 A13 Executor 在加载 candidate 前调用了未授权的
`list_mcp_resources`；top-level response 与 Planner 均保持在边界内。packet 以
12/27 个 cell 完成而封存，独立 assessor 返回 `DECISION_REQUIRED`。之后的三
turn D37 precursor 提供了精确 package 路径和分类型 tool normalization；native、
released control 与 exact candidate 都遵守读取边界，但未评估 response semantics，
也不转移任何 Gate 2 接受。D40 随后以五个行为 turn 到达 A04；其间接首轮加载了精确
candidate，没有读取项目或 Git，回复也保持 proposal-only，但冻结的旧 no-command rubric
仍停止了 packet，assessor 返回 `DECISION_REQUIRED`。Decision 0018 D34 现已通过区分
原生 package loading 与用户可见激活来修正 SOURCE 和评测合同；D40 保持不可变，不被
重评分或追认接受。这些 D34 字节已成为精确 candidate `b3ad360...`。fresh D41 随后
完成 A01-A04；A04 证明原生加载可以不伴随项目读取，但其首轮可见回复在用户批准激活前
就称 Work Charter 已被 selected，违反 proposal-only 边界。A05 只提出有界激活建议，
没有项目/Git 读取或动作，但评测 policy 把单轮合同写成了错误的 object 而不是 list；
controller 因此 fail closed，packet 以 4/27 个 cell 完成而封存。一个 assessor 返回
`DECISION_REQUIRED`。D41 不被重试或追认接受，stable `v0.1.2` 保持不变。
D42 精确 candidate `f24bda7...` 对该间接可见表面作出收紧：首个回复必须以
`Work Charter appears applicable because ...` 开头，且不得使用 selection 或
activation 标题；同时，任何证据 turn 前都必须完成整个矩阵的 authorization-policy
schema 预检。fresh D42 的组合静态 qualifier 曾报告通过，carrier 随后进入三个
transport canary、freeze 和 A01-A05；但消费后 review 发现 PowerShell parse 子检查发生
参数绑定错误，实际没有解析目标文件，资格因此无效。A04 的 exact-load 收紧提案只能
保留为观察。A05 使用了要求的开头且没有项目/tool 动作，但在激活前就规定了 pause、
writer、evidence、handoff 和 resume 步骤，同时 body loading 仍未得到证明；这是独立的
pre-activation workflow mismatch。packet 在 4/27 处封存，一个 assessor 返回
`DECISION_REQUIRED`。D42 仍未获接受；资格 transport、proposal-only SOURCE wording 与
提案阶段 loading policy 都需要新的决策。D31、D34 与 D42 均仍无行为接受、安装或发布
证据。
完整分阶段 selection、entry、等级、
重新接入和可见 Standard 行为，stable 层完整 Standard
delivery、广泛隐式触发 telemetry、独立真实项目效果、确定性角色交付或 writer
锁，以及跨 Harness 等价性仍未得到证明。参见[验证](VERIFICATION.md)和
[状态](STATE.md)。

## 权威合同

本页是面向人的入口。仓库[产品合同](../../SPEC.md)、
[Work Charter 设计](DESIGN.md)、已接受 decisions 和 canonical
[`SKILL.md`](../../../skills/work-charter/SKILL.md)拥有行为定义；发生冲突时，
以这些英文 canonical 来源为准。
