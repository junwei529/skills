# PowerShell

[English](README.md)

PowerShell 用于诊断并安全处理 PowerShell、native executable、文本字节、
权限和 WSL 之间的实质 Windows shell 边界。它是聚焦的 boundary workflow，
不是通用 PowerShell 教程或 installer。

## 何时使用

- 在首次相关命令之前，任务明确要求非平凡 `.ps1`、`pwsh` 或
  `powershell.exe` workflow，包括多行逻辑、loop、`try`/`catch`、regex、
  complex pipeline、native execution 或 child-process handling；
- PowerShell 5.1 与 7 的行为差异是实质因素；
- native argument、quoting、stdout、stderr、`$LASTEXITCODE`、pipeline、
  redirection、stdin 或嵌套 shell string 可能有问题；
- UTF-8、BOM、newline、JSON、schema、hash、legacy code page 或
  non-ASCII 文本有影响；
- 执行或路径跨越 Windows 与 WSL；或
- 需要诊断 sandbox、permission、破坏性文件操作或 process control 边界。

## 何时不使用

- 普通、版本无关的 cmdlet 没有边界症状；
- 简单、已有文档的 native command 不涉及实质 parser、version、argument、stream、
  encoding、path、permission、process 或 WSL 边界；
- 只是一般 Windows 工作且没有 shell 边界；或
- 任务完全是 POSIX-only。

## 独立安装

从 live repository refs 和仓库[验证](../../VERIFICATION.md)中选择一个已接受的
不可变 tag，并用它替换 `<version-tag>`：

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/use-powershell-safely.
```

当前 stable `v0.2.0` 包包含后续 hardening 与 reviewed P1 pre-error
selection/readiness revision。Skill 安装、更新、PowerShell
安装和系统变更仍是分别授权的动作。不要把持续移动的 `main` branch 当作
stable identity。

## 调用

明确的非平凡 PowerShell 或实质症状可以在执行前选择该 Skill。需要
pre-execution readiness 或可复现诊断时适合显式调用：

```text
$use-powershell-safely 在运行前验证此非平凡 PowerShell 命令，并保留其 native argument、stream 和 exit-code 边界。
```

## 安全边界

复杂逻辑优先放入 `.ps1`，否则在运行前使用将执行它的同一 PowerShell
executable/version parse exact inline payload。检查 cmdlet 的实际 parameter set，
不要假定都有 `-LiteralPath`；`New-Item` 使用 `-Path`。
关键 cmdlet 使用窄范围 fail-fast 并验证预期 artifact 或 state；
`$LASTEXITCODE` 只属于 native process status。以结构化值保留 native 参数，并在
相关时把精确文本字节视为正确性。安装、更新、提权、profile、policy、locale、registry、
service、firewall、WSL state 或破坏性主机变更都需要显式授权。破坏性目标必须
按 literal path 解析并证明 containment。

## 已验证能力与限制

历史 `v0.1.1` revision 已有 fresh-context、受控 DEV_DISCOVERY、exact-commit RC
和 tag-pinned stable loaded-copy 证据。`c42eef3...` 的 package bytes 加入后续
hardening，并已有 exact-commit corrected-copy identity、native 正负 loaded-copy
canary、双 runtime 确定性检查、实际执行的 native/text controller boundary 和
独立 readiness verdict。仓库级
[`v0.1.2`](https://github.com/junwei529/skills/releases/tag/v0.1.2) stable copy
已有精确 loaded-copy identity 和一条带守卫的 native/text diagnosis canary；
hardening 仍缺少真实 Bash/WSL、stable canary sandbox 内实际执行的 native probe、
实际 sandbox-denial 注入和 shadow-use 证据。参见[验证](VERIFICATION.md)和
[状态](STATE.md)。P1 SOURCE revision 新增双 runtime deterministic
command-readiness checks 和 pre-error selection contract。一轮有界 fresh
证据观察到 exact P1 revision 在首次风险命令前加载，而同一请求没有加载不可变的
`v0.1.2`；ordinary-cmdlet 与 POSIX-only negatives 也保持未加载。目标命令没有
执行。exact candidate `ac790233...` 随后重复 positive 与两个 negatives，并获得一轮
有界独立 `ACCEPTED` assessment。immutable
[`v0.2.0`](https://github.com/junwei529/skills/releases/tag/v0.2.0) 保留 reviewed
五文件 tree `d8bf6dc...`、将 PowerShell 分类为 `changed`，并已有 fresh
active-stable loaded-copy 证明，覆盖 entry、native 与 text references。目标命令仍未
执行；广泛 selection、selected execution behavior、live WSL 与因果 efficacy 仍未
证明。`a7637a6...` evidence sync 不是新的 PowerShell SOURCE revision。

当前未发布 SOURCE 为真正的非平凡 PowerShell 保留 pre-error contract，同时收窄
ordinary 与 simple near-neighbor selection。双 runtime 确定性套件现在会拒绝这样
的 `pwsh`：虽然 executable 已解析，但精确 readiness probe 返回非零、空输出或
malformed version；它还验证 application-only WSL candidate cardinality、立即保存
的 typed native exit，以及破坏性文件操作的 pre-error 正向选择。PowerShell 7 与
Windows PowerShell 5.1 下的 59 项 focused
assertion 全部通过。未运行 live WSL，也未进行安装、提权、profile、policy、locale、
registry 或 host configuration 变更。

## 权威合同

本页是面向人的入口。仓库[产品合同](../../SPEC.md)、
[PowerShell 设计](DESIGN.md)、已接受 decisions 和 canonical
[`SKILL.md`](../../../skills/use-powershell-safely/SKILL.md)拥有行为定义；
发生冲突时，以这些英文 canonical 来源为准。
