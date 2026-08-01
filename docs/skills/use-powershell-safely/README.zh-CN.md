# PowerShell

[English](README.md)

PowerShell 用于诊断并安全处理 PowerShell、native executable、文本字节、
权限和 WSL 之间的实质 Windows shell 边界。它是聚焦的 boundary workflow，
不是通用 PowerShell 教程或 installer。

## 何时使用

- PowerShell 5.1 与 7 的行为差异是实质因素；
- native argument、quoting、stdout、stderr、`$LASTEXITCODE`、pipeline、
  redirection、stdin 或嵌套 shell string 可能有问题；
- UTF-8、BOM、newline、JSON、schema、hash、legacy code page 或
  non-ASCII 文本有影响；
- 执行或路径跨越 Windows 与 WSL；或
- 需要诊断 sandbox、permission、破坏性文件操作或 process control 边界。

## 何时不使用

- 普通、版本无关的 cmdlet 没有边界症状；或
- 任务完全是 POSIX-only。

## 独立安装

从 live repository refs 和仓库[验证](../../VERIFICATION.md)中选择一个已接受的
不可变 tag，并用它替换 `<version-tag>`：

```text
$skill-installer Install the Skill from https://github.com/junwei529/skills/tree/<version-tag>/skills/use-powershell-safely.
```

当前 stable `v0.1.2` 包包含后续 hardening。Skill 安装、更新、PowerShell
安装和系统变更仍是分别授权的动作。不要把持续移动的 `main` branch 当作
stable identity。

## 调用

实质症状可以隐式选择该 Skill。高风险或需要可复现诊断时适合显式调用：

```text
$use-powershell-safely 在修改应用代码前诊断此 native argument、stream 和 exit-code 边界。
```

## 安全边界

按照 native 工具合同捕获退出状态，以结构化值保留参数，并在相关时把精确文本
字节视为正确性。安装、更新、提权、profile、policy、locale、registry、
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
[状态](STATE.md)。

## 权威合同

本页是面向人的入口。仓库[产品合同](../../SPEC.md)、
[PowerShell 设计](DESIGN.md)、已接受 decisions 和 canonical
[`SKILL.md`](../../../skills/use-powershell-safely/SKILL.md)拥有行为定义；
发生冲突时，以这些英文 canonical 来源为准。
