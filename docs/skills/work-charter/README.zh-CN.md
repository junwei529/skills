# Work Charter

[English](README.md)

让有后果的 Codex 工作保持可恢复，同时不把每项任务都变成工作流。

Work Charter 识别复杂性、连续性、authority、writer、evidence、recovery 和协作
信号。遇到间接适用性匹配时，它解释何时可能需要额外保护并在激活前询问用户；
激活后，它推荐最小充分协调。小型普通任务保持 flat。

## 它自动完成什么

这些能力属于 advisory。Work Charter 可以提出建议并停止其自身工作，但不能锁定
writer、重新路由其他 task 或强制执行 permission。

- 识别强适用信号，并用普通语言解释原因；
- 提出选择保护形态所需的最小读取；
- 激活后持续显式呈现 outcome、authority、evidence、recovery 与 coordination
  边界；
- 推荐最小充分保护，并识别实质 re-entry gate；
- 在 identity、state、evidence 或 authority 无法核实时保留 `UNKNOWN`。

## 你决定什么

你显式决定激活、第一次持久采用、项目读取范围、角色交付、写入、Git、安装、
release 和外部影响。outcome、permissions、workspace、writer、evidence 标准、
recovery 路径或 acceptance 边界的任何实质变化也由你决定。

可用不等于激活。直接 `$work-charter` 调用或明确要求使用 Work Charter 的普通语言
请求会直接请求激活，无需第二次确认；但只有完整 Skill 正文加载后才能声称激活。

间接 symptom 或 catalog 匹配仍然只是 proposal，必须等待确认。确认前，Work
Charter 只说明为什么可能适用、提出激活与最小有用读取并询问；不会检查项目、声称
激活或正文/工作流已可用，也不会预先规定 pause、writer、evidence、handoff、
resume、protection 或角色工作流。

## 保护形态

Work Charter 使用内部 `L0`–`L4` shorthand 压缩决策；这些标签不是通用成熟度标准。

| 形态 | 用户如何使用 |
|---|---|
| 普通 flat task（`L0`） | 在没有 active Charter 的情况下完成小型、有界任务。 |
| 当前任务 Charter（`L1`） | 在当前任务内保持 authority、evidence 与 recovery 可见，不创建持久 owner。 |
| 持久单 agent Charter（`L2`） | 当连续性必须跨越当前任务时，使用一个 agent 与 durable anchor。优先复用合适的 authoritative owner；只有获得显式授权后才新建 durable anchor。 |
| Planner/Executor（`L3`） | 继承 L2 的 durable recovery，并为有界的 consequential delivery 增加独立 Planner/assessor 与 sole-writer Executor。 |
| 仓库定义的 Standard（`L4`） | 继承 L3，并增加 Orchestrator responsibility、适用且已批准的 standing policy 和 multi-phase governance。 |

任何 fresh L3 或 L4 role 在履行 Work Charter responsibility 前，都要加载完整 Skill
与 Coordination And Recovery 指引；fresh L4 role 在履行任何 L4 responsibility 前
还要加载 Standard O/P/E。

在仓库定义的 Standard 形态中，Orchestrator 负责跨阶段方向与 Phase Mandate；
Planner 负责 phase definition、边界和独立验收；Executor 负责实现、验证和证据。
这是本仓库的专用术语，不是行业标准。

## 五部分 Charter

1. **Outcome** — 具体结果和 acceptance 边界。
2. **Authority** — 可以读取、改变、执行或影响什么，以及哪些事项仍需用户决定。
3. **Evidence** — 声明所需的证明，以及使证据失效的条件。
4. **Recovery** — authoritative state、停止条件，以及中断或失败后的安全下一步。
5. **Coordination** — 只采用保护结果所需的角色、writer discipline 和 handoff。

## Authoritative Carrier 与 Workstream

持久 Charter 只有一个 authoritative carrier，并对应一个 managed workstream。
branch、task、label 或 replacement carrier 不会抹除既有尝试、已消费证据、批准、
finding 或 stop。保持一条 active execution lane 和一个 repository writer；当仅有一个
workstream 被治理时，不要把整个仓库描述为已经 adopted。

## Re-entry

当 outcome、authority、permission、workspace、writer、evidence subject、recovery
path、delivery route 或 acceptance boundary 发生实质变化时，必须 re-enter。
Re-entry 核对当前 authoritative revision，并请求最小缺失决策；不会从过时聊天静默
恢复，也不会通过重命名旧 attempt 获得新预算。

## Evidence 与 Assessment

Evidence 必须标识实际 subject 和 result surface。一个 revision、copy、route、role
或 workspace 的测试不能证明另一个。无法取得或互相冲突的事实保持 `UNKNOWN`。

Planner acceptance 本身不等于 durable closeout。项目要求记录 assessment 时，必须
由 authoritative owner 完成记录后才能视为关闭。新的实质变化只会使其实际影响的
证据失效。

使用角色时，Result Notice 不会只停留在上游 task：assessor 必须针对该 checkpoint
恰好返回一个 disposition，包括 terminal acceptance 或 decision-required stop。
terminal disposition 不要求 acknowledgement，角色之间也不靠 polling 等待。同一个
实质用户问题只有一个 owner；其他角色只精确 relay 问题或答案，不再重复询问。这是
coordination obligation，不是 Harness 已经成功交付消息的保证。

## 安全边界

- Protection 不会扩大 action authority。
- Proposal 不代表 activation。
- Skill loading 不授予项目读取或写入权限。
- 单次失败、耗时、文件数量或新 task 本身不足以要求 Charter。
- 普通文档治理和 shell 诊断继续使用各自的产品路由。
- 遇到实质 contract、permission、workspace、writer、evidence、delivery 或
  recovery 歧义时停止。

## 安装与调用

从仓库[验证账本](../../VERIFICATION.md)选择一个已接受的 immutable tag：

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/work-charter.

$work-charter 约束此项有后果的工作、权限、证据和恢复。
```

显式提到 Work Charter 的普通语言请求也构成 direct intent。安装、调用、激活、
项目读取、写入、Git 和外部影响仍彼此独立。

## 当前已验证

- Immutable release `v0.2.0` 包含精确五文件 Work Charter tree
  `97f0d9de...` 和 canonical manifest `04c382a4...`。
- [验证账本](VERIFICATION.md)记录了有界 release surface 的精确副本安装与
  loaded-copy 证据。
- 已采纳的 synthetic evidence 支持五项窄行为：proposal 不是 activation、小型
  工作保持 flat、有界 adoption 保持有界、实质 re-entry 会重新询问，以及仓库定义
  的 Standard 形态需要显式 policy。

## 尚未证明

完整比较产品验证、广泛 trigger accuracy、确定性 role/writer enforcement、完整
Standard delivery、真实项目 efficacy、token 节省和跨 Harness 等价仍未证明。
WC-PV1 paired pilot 为 `INCONCLUSIVE / PRODUCT_UNKNOWN`：八个一次性 root 全部在
产生可采纳响应前因 provider-stream transport 失败，不提供 efficacy 声明。详见
[State](STATE.md)、[Verification](VERIFICATION.md)和
[sanitized PV1 result](../../../evals/results/2026-08-17-work-charter-pv1-terminal.md)。

## 设计与证据

- [Design](DESIGN.md)
- [State](STATE.md)
- [Verification](VERIFICATION.md)
- [仓库评估规则](../../../evals/README.md)
