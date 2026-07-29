# JSON Verifier Fixture

The JSON verifier succeeds when called directly, but the PowerShell wrapper
reports that the same file is invalid.

Reproduce the wrapper failure from this repository root:

```powershell
pwsh -NoProfile -File .\evals\fixtures\powershell-boundary\tools\run-verifier.ps1
```

The input path intentionally contains a space.

This fixture covers only the direct-versus-nested argument-transport branch. It
does not simulate an absent or unsupported PowerShell 7 installation, a
Windows PowerShell 5.1-only host, WSL, legacy code pages, or authorization for a
system change.
