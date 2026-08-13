[CmdletBinding()]
param(
    [switch]$KeepScratch
)

$ErrorActionPreference = 'Stop'
$runnerPath = Join-Path $PSScriptRoot 'invoke-work-charter-gate2.ps1'
$runnerItem = Get-Item -LiteralPath $runnerPath -Force -ErrorAction Stop
$strictUtf8 = [System.Text.UTF8Encoding]::new($false, $true)
$pwshName = if ($IsWindows) { 'pwsh.exe' } else { 'pwsh' }
$pwshPath = Join-Path $PSHOME $pwshName
$scratchBase = Join-Path ([System.IO.Path]::GetTempPath()) 'eddie-skills-d54-runner-check'
$scratchRoot = Join-Path $scratchBase ([guid]::NewGuid().ToString('N'))
$checks = [System.Collections.Generic.List[object]]::new()
$authorizationLifecycleCache = @{}
$lifecycleRootContracts = @{}
$protocolAdapterCommand = '$line=$null; while($null -ne ($line=[Console]::In.ReadLine())){$r=$line|ConvertFrom-Json; if($r.method -ceq ''initialize''){$o=[ordered]@{id=$r.id;result=[ordered]@{userAgent=''d52-sim''}}}elseif($r.method -ceq ''initialized''){continue}elseif($r.method -ceq ''thread/start''){$o=[ordered]@{id=$r.id;result=[ordered]@{thread=[ordered]@{id=''d52-sim-thread''}}}}elseif($r.method -ceq ''turn/start''){$turnId=''d52-sim-turn-''+[string]$r.id;$o=[ordered]@{id=$r.id;result=[ordered]@{turn=[ordered]@{id=$turnId;status=''inProgress''}}};[Console]::Out.WriteLine(($o|ConvertTo-Json -Depth 10 -Compress));$o=[ordered]@{method=''turn/completed'';params=[ordered]@{threadId=''d52-sim-thread'';turn=[ordered]@{id=$turnId;status=''completed'';items=@()}}}}else{exit 92};[Console]::Out.WriteLine(($o|ConvertTo-Json -Depth 10 -Compress))};exit 0'
$failedProtocolAdapterCommand = $protocolAdapterCommand.Replace(
    "status='completed'",
    "status='failed'"
)
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$userProfileRoot = $env:USERPROFILE
$d50SourceRoot = Join-Path $repositoryRoot `
    '.eval-runs\work-charter-v0.2-c481005-gate2-d50-bundle-dev-01\bundle'
$d50SourceManifestPath = Join-Path $repositoryRoot `
    '.eval-runs\work-charter-v0.2-c481005-gate2-d50-bundle-dev-01\controller-bundle-manifest.json'
$d54SourceRoot = Join-Path $scratchRoot 'authenticated-source-bundle'
$d54SourceManifestPath = Join-Path $d54SourceRoot '.contract\controller-bundle-manifest.json'
$d53PredecessorRoot = Join-Path $repositoryRoot `
    '.eval-runs\work-charter-v0.2-c481005-gate2-d53-layered-authorization'
$d49PredecessorRoot = Join-Path $repositoryRoot `
    '.eval-runs\work-charter-v0.2-c481005-gate2-d49-08'
$campaignContractPath = Join-Path $repositoryRoot `
    'docs\decisions\0018-work-charter-adoption-levels-and-reentry-checkpoint.md'
$rulesetSources = @(
    [pscustomobject]@{ Locator = '~/.codex/AGENTS.md'; Path = Join-Path $userProfileRoot '.codex\AGENTS.md'; Sha256 = 'fefaad2225dfefc0a4e8048c1fe9ba744035ab101c11851954bcf432b1691be1' },
    [pscustomobject]@{ Locator = 'AGENTS.md'; Path = Join-Path $repositoryRoot 'AGENTS.md'; Sha256 = '49e622e564ba22fb30e4601d1609c4be25a8285f8a9076629de75c7007f2b1db' },
    [pscustomobject]@{ Locator = '~/.codex/skills/work-charter/SKILL.md'; Path = Join-Path $userProfileRoot '.codex\skills\work-charter\SKILL.md'; Sha256 = 'd0c86e80d6f8eec0d91c25f4f0c687d60b1e0821ac823e28cf62777bb1badda2' },
    [pscustomobject]@{ Locator = '~/.codex/skills/work-charter/references/coordination-and-recovery.md'; Path = Join-Path $userProfileRoot '.codex\skills\work-charter\references\coordination-and-recovery.md'; Sha256 = '8c944b3434e14e70dea705a8b877b70b497c6f512db8681ff0000f418a270483' },
    [pscustomobject]@{ Locator = '~/.codex/reference/codex-usage-guidance.md'; Path = Join-Path $userProfileRoot '.codex\reference\codex-usage-guidance.md'; Sha256 = '8139fa6765e0fe7a2972b84a8cb370df386e28736d16228a07780625f7888383' },
    [pscustomobject]@{ Locator = 'docs/RUNBOOK.md'; Path = Join-Path $repositoryRoot 'docs\RUNBOOK.md'; Sha256 = 'f4f42193d45fd279a50f8737ca2e7fe739dbebf703e9cda50118bc66d145ff13' },
    [pscustomobject]@{ Locator = 'evals/README.md'; Path = Join-Path $repositoryRoot 'evals\README.md'; Sha256 = '50001f3dcecf43e7d4bf6ab022eca768cc6fde9f8bacd3321021945bacd81860' }
)

function Write-Json {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][AllowEmptyCollection()][object]$Value
    )

    $json = ConvertTo-Json -InputObject $Value -Depth 100 -Compress
    [System.IO.File]::WriteAllText($Path, $json + "`n", $strictUtf8)
}

function Get-Sha256 {
    param([Parameter(Mandatory)][string]$Path)

    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Get-TextSha256 {
    param([Parameter(Mandatory)][string]$Text)

    return [System.Convert]::ToHexString(
        [System.Security.Cryptography.SHA256]::HashData(
            $strictUtf8.GetBytes($Text)
        )
    ).ToLowerInvariant()
}

function Get-NormalizedTextSha256 {
    param([Parameter(Mandatory)][string]$Path)

    $bytes = [IO.File]::ReadAllBytes($Path)
    $offset = if ($bytes.Length -ge 3 -and
        $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) { 3 } else { 0 }
    $text = $strictUtf8.GetString($bytes, $offset, $bytes.Length - $offset)
    return Get-TextSha256 -Text $text.Replace("`r`n", "`n").Replace("`r", "`n")
}

function New-D54RootContract {
    param(
        [Parameter(Mandatory)][string]$CaseRoot,
        [Parameter(Mandatory)][string]$CampaignRoot,
        [Parameter(Mandatory)][string]$CarrierRoot,
        [Parameter(Mandatory)][string]$EvidenceRoot,
        [string]$SourceRoot = $d54SourceRoot,
        [string]$SourceManifestPath = $d54SourceManifestPath,
        [string]$D53Root = $d53PredecessorRoot,
        [string]$D49Root = $d49PredecessorRoot,
        [string]$ExpectedHead = '',
        [string]$D53ArtifactRelativePath = 'execution/evidence/d53-terminal.json',
        [string]$SchemaVersion = 'work-charter-d54-explicit-root-contract/v1',
        [string]$SourceManifestSha256 = '26df78066d20be14cefdcb1d07735ec67fe42d2c717dba6fc3c4fb7632984a09',
        [string]$D53TerminalSha256 = 'e8e9fb645b83beaa9c64cd5ccf3d8fc3e283d21cdbb964cde8c72adb8849882b',
        [string]$D49TerminalSha256 = '0d17dfba319d84455df9be6738e7be1268c212ec582830021debc7e200f362ec',
        [string]$D49ViewSha256 = 'fa44e6576bf628bf1dd84c7f09e2c60d896439093e5fbd79e41975281c425bd0'
    )

    foreach ($directory in @($CaseRoot, $CampaignRoot, $CarrierRoot, $EvidenceRoot)) {
        [void](New-Item -ItemType Directory -Path $directory -Force)
    }
    if ([string]::IsNullOrWhiteSpace($ExpectedHead)) {
        $ExpectedHead = (& git -C $repositoryRoot rev-parse HEAD).Trim()
    }
    $contractPath = Join-Path $CaseRoot 'd54-explicit-root-contract.json'
    $contract = [ordered]@{
        schema_version = $SchemaVersion
        campaign_id = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
        stable_subject = 'Work Charter v0.2.0 exact candidate'
        candidate_commit = 'c4810057c3f28cca9f12004ca2018784cd21f449'
        candidate_manifest_sha256 = '04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44'
        control_commit = 'ceed607152849775b981c54add74bfa30d858e4d'
        predecessor_terminal_receipt_sha256 = $D53TerminalSha256
        campaign_contract = [ordered]@{
            path = [IO.Path]::GetFullPath($campaignContractPath)
            sha256 = Get-Sha256 -Path $campaignContractPath
        }
        ruleset_sources = @($rulesetSources | ForEach-Object {
            [ordered]@{
                locator = [string]$_.Locator
                path = [IO.Path]::GetFullPath([string]$_.Path)
                normalized_text_sha256 = [string]$_.Sha256
            }
        })
        roots = [ordered]@{
            repository = [ordered]@{
                path = [IO.Path]::GetFullPath($repositoryRoot)
                expected_head = $ExpectedHead
                runner_relative_path = 'evals/invoke-work-charter-gate2.ps1'
                runner_sha256 = Get-Sha256 -Path $runnerPath
            }
            campaign = [ordered]@{ path = [IO.Path]::GetFullPath($CampaignRoot) }
            carrier = [ordered]@{ path = [IO.Path]::GetFullPath($CarrierRoot) }
            source_bundle = [ordered]@{
                path = [IO.Path]::GetFullPath($SourceRoot)
                manifest_path = [IO.Path]::GetFullPath($SourceManifestPath)
                manifest_sha256 = $SourceManifestSha256
                manifest_schema_version = 1
                execution_identity = 'gate2-c481005-d50-02-certified-final-a18'
                bundle_sha256 = '8b3abba4889c149bdac8b31f76215fd6254b0fa46d6bd58466b7edfee9d19602'
                file_count = 148
            }
            evidence = [ordered]@{
                path = [IO.Path]::GetFullPath($EvidenceRoot)
                schema_version = 'work-charter-d54-evidence-root/v1'
            }
            predecessors = @(
                [ordered]@{
                    id = 'd53-terminal'
                    path = [IO.Path]::GetFullPath($D53Root)
                    artifact_relative_path = $D53ArtifactRelativePath
                    artifact_sha256 = $D53TerminalSha256
                    artifact_schema_version = 'work-charter-d53-terminal/v1'
                },
                [ordered]@{
                    id = 'd49-admitted-evidence'
                    path = [IO.Path]::GetFullPath($D49Root)
                    terminal_relative_path = 'execution/terminal/terminal-packet.json'
                    terminal_sha256 = $D49TerminalSha256
                    view_relative_path = 'execution/terminal/assessor-view.json'
                    view_sha256 = $D49ViewSha256
                }
            )
        }
    }
    Write-Json -Path $contractPath -Value $contract
    return [pscustomobject]@{
        Path = $contractPath
        Sha256 = Get-Sha256 -Path $contractPath
        CampaignRoot = [IO.Path]::GetFullPath($CampaignRoot)
        CarrierRoot = [IO.Path]::GetFullPath($CarrierRoot)
        SourceRoot = [IO.Path]::GetFullPath($SourceRoot)
        EvidenceRoot = [IO.Path]::GetFullPath($EvidenceRoot)
        PredecessorRoots = @(
            [IO.Path]::GetFullPath($D53Root),
            [IO.Path]::GetFullPath($D49Root)
        )
    }
}

function Initialize-D54ContainedSourceBundle {
    $manifest = Get-Content -LiteralPath $d50SourceManifestPath -Raw -Encoding UTF8 |
        ConvertFrom-Json -Depth 100
    [void](New-Item -ItemType Directory -Path $d54SourceRoot)
    foreach ($row in @($manifest.files)) {
        $relative = [string]$row.path
        $parts = @($relative -split '/')
        if ([IO.Path]::IsPathFullyQualified($relative) -or
            @($parts | Where-Object { $_ -in @('', '.', '..') }).Count -ne 0) {
            throw "D54 checker source-bundle row is not contained: $relative"
        }
        $source = Join-Path $d50SourceRoot ($relative.Replace('/', '\'))
        $target = Join-Path $d54SourceRoot ($relative.Replace('/', '\'))
        $sourceItem = Get-Item -LiteralPath $source -Force -ErrorAction Stop
        if ($sourceItem.PSIsContainer -or
            ($sourceItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            throw "D54 checker source-bundle input is not ordinary: $relative"
        }
        [void](New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force)
        [IO.File]::Copy($sourceItem.FullName, $target, $false)
    }
    [void](New-Item -ItemType Directory -Path (Split-Path -Parent $d54SourceManifestPath))
    [IO.File]::Copy($d50SourceManifestPath, $d54SourceManifestPath, $false)
}

function Get-D54RootArguments {
    param([Parameter(Mandatory)][object]$Contract)

    return @(
        '-RootContractPath', [string]$Contract.Path,
        '-RootContractSha256', [string]$Contract.Sha256,
        '-RepositoryRoot', [IO.Path]::GetFullPath($repositoryRoot),
        '-CampaignRoot', [string]$Contract.CampaignRoot,
        '-CarrierRoot', [string]$Contract.CarrierRoot,
        '-SourceBundleRoot', [string]$Contract.SourceRoot,
        '-EvidenceRoot', [string]$Contract.EvidenceRoot,
        '-D53PredecessorRoot', [string]$Contract.PredecessorRoots[0],
        '-D49PredecessorRoot', [string]$Contract.PredecessorRoots[1]
    )
}

function Invoke-D54RootDescribe {
    param([Parameter(Mandatory)][object]$Contract)

    $arguments = [System.Collections.Generic.List[string]]::new()
    foreach ($argument in @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-File', $runnerPath,
        '-Mode', 'DescribeLifecycle'
    ) + (Get-D54RootArguments -Contract $Contract)) {
        $arguments.Add([string]$argument)
    }
    return Invoke-Captured -Arguments $arguments.ToArray()
}

function Test-D54ExplicitRootContract {
    $caseRoot = New-Case -Name 'd54-explicit-root-contract'
    $campaignRoot = Join-Path $caseRoot 'campaign-root'
    $nestedCarrier = Join-Path $campaignRoot 'nested\one\two\carrier'
    $nestedEvidence = Join-Path $nestedCarrier 'execution\evidence'
    $decoy = Join-Path $campaignRoot 'work-charter-v0.2-c481005-gate2-d49-08'
    [void](New-Item -ItemType Directory -Path $decoy -Force)
    Write-Json -Path (Join-Path $decoy 'terminal-packet.json') -Value ([ordered]@{
        schema_version = 'decoy/v1'
    })
    $positiveContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'positive-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence
    $positive = Invoke-D54RootDescribe -Contract $positiveContract

    $duplicateRulesetContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'duplicate-ruleset-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence
    $duplicateRulesetValue = Get-Content -LiteralPath $duplicateRulesetContract.Path `
        -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 100
    $duplicateRulesetValue.ruleset_sources[6] = $duplicateRulesetValue.ruleset_sources[1]
    Write-Json -Path $duplicateRulesetContract.Path -Value $duplicateRulesetValue
    $duplicateRulesetContract.Sha256 = Get-Sha256 -Path $duplicateRulesetContract.Path
    $duplicateRuleset = Invoke-D54RootDescribe -Contract $duplicateRulesetContract

    $wrongHeadContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'wrong-head-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence `
        -ExpectedHead ('0' * 40)
    $wrongHead = Invoke-D54RootDescribe -Contract $wrongHeadContract

    $wrongBundleRoot = Join-Path $caseRoot 'wrong-bundle-root'
    [void](New-Item -ItemType Directory -Path $wrongBundleRoot -Force)
    $wrongBundleContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'wrong-bundle-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence `
        -SourceRoot $wrongBundleRoot
    $wrongBundle = Invoke-D54RootDescribe -Contract $wrongBundleContract

    $outsideManifestContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'outside-manifest-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence `
        -SourceManifestPath $d50SourceManifestPath
    $outsideManifest = Invoke-D54RootDescribe -Contract $outsideManifestContract

    $outsidePredecessorTarget = Join-Path $repositoryRoot `
        '.eval-runs\work-charter-v0.2-c481005-gate2-d54-explicit-root\outside-predecessor-target.json'
    $escapeRelative = [IO.Path]::GetRelativePath($d53PredecessorRoot, $outsidePredecessorTarget)
    $escapeContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'predecessor-escape-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence `
        -D53ArtifactRelativePath $escapeRelative
    $predecessorEscape = Invoke-D54RootDescribe -Contract $escapeContract

    $wrongRootContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'wrong-root-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence `
        -D49Root $decoy
    $wrongRoot = Invoke-D54RootDescribe -Contract $wrongRootContract

    $outsideCarrier = Join-Path $caseRoot 'outside-carrier'
    $outsideContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'outside-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $outsideCarrier `
        -EvidenceRoot $outsideCarrier
    $outside = Invoke-D54RootDescribe -Contract $outsideContract

    $reparseTarget = Join-Path $caseRoot 'reparse-target'
    [void](New-Item -ItemType Directory -Path $reparseTarget -Force)
    $reparseCarrier = Join-Path $campaignRoot 'reparse-carrier'
    [void](New-Item -ItemType Junction -Path $reparseCarrier -Target $reparseTarget)
    try {
        $reparseContract = New-D54RootContract `
            -CaseRoot (Join-Path $caseRoot 'reparse-contract') `
            -CampaignRoot $campaignRoot `
            -CarrierRoot $reparseCarrier `
            -EvidenceRoot $reparseCarrier
        $reparse = Invoke-D54RootDescribe -Contract $reparseContract
    }
    finally {
        $reparseItem = Get-Item -LiteralPath $reparseCarrier -Force -ErrorAction SilentlyContinue
        if ($null -ne $reparseItem) {
            if (($reparseItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0) {
                throw 'D54 reparse negative did not create a reparse point.'
            }
            [IO.Directory]::Delete($reparseCarrier, $false)
        }
    }

    $missingSource = Join-Path $caseRoot 'missing-source'
    $missingContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'missing-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence `
        -SourceRoot $missingSource
    $missing = Invoke-D54RootDescribe -Contract $missingContract

    $hashContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'hash-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence `
        -SourceManifestSha256 ('0' * 64)
    $hashMismatch = Invoke-D54RootDescribe -Contract $hashContract

    $schemaContract = New-D54RootContract `
        -CaseRoot (Join-Path $caseRoot 'schema-contract') `
        -CampaignRoot $campaignRoot `
        -CarrierRoot $nestedCarrier `
        -EvidenceRoot $nestedEvidence `
        -SchemaVersion 'work-charter-d54-explicit-root-contract/v0'
    $schemaMismatch = Invoke-D54RootDescribe -Contract $schemaContract

    return [pscustomobject]@{
        Passed = (
            $positive.ExitCode -eq 0 -and
            [string]::IsNullOrEmpty($positive.Stderr) -and
            $duplicateRuleset.ExitCode -eq 86 -and
            $wrongHead.ExitCode -eq 86 -and
            $wrongBundle.ExitCode -eq 86 -and
            $outsideManifest.ExitCode -eq 86 -and
            $predecessorEscape.ExitCode -eq 86 -and
            $wrongRoot.ExitCode -eq 86 -and
            $outside.ExitCode -eq 86 -and
            $reparse.ExitCode -eq 86 -and
            $missing.ExitCode -eq 86 -and
            $hashMismatch.ExitCode -eq 86 -and
            $schemaMismatch.ExitCode -eq 86 -and
            $duplicateRuleset.Stderr -match 'ruleset|locator|unique' -and
            $wrongHead.Stderr -match 'HEAD|repository' -and
            $wrongBundle.Stderr -match 'source-bundle|bundle|file identity' -and
            $outsideManifest.Stderr -match 'source-bundle manifest containment|outside' -and
            $predecessorEscape.Stderr -match 'contain|outside' -and
            $wrongRoot.Stderr -match 'predecessor|root|ordinary|hash|schema' -and
            $outside.Stderr -match 'contain' -and
            $reparse.Stderr -match 'reparse|ordinary' -and
            $missing.Stderr -match 'missing|ordinary' -and
            $hashMismatch.Stderr -match 'hash|manifest' -and
            $schemaMismatch.Stderr -match 'schema'
        )
        Positive = $positive
        DuplicateRuleset = $duplicateRuleset
        WrongHead = $wrongHead
        WrongBundle = $wrongBundle
        PredecessorEscape = $predecessorEscape
        WrongRoot = $wrongRoot
        Outside = $outside
        Reparse = $reparse
        Missing = $missing
        HashMismatch = $hashMismatch
        SchemaMismatch = $schemaMismatch
    }
}

function Test-InitialSegmentCompletionUsesStaticPass {
    $tokens = $null
    $parseErrors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile(
        $runnerPath,
        [ref]$tokens,
        [ref]$parseErrors
    )
    if ($parseErrors.Count -ne 0) {
        return $false
    }
    $functions = @($ast.FindAll({
        param($node)
        $node -is [System.Management.Automation.Language.FunctionDefinitionAst] -and
            $node.Name -ceq 'Complete-LiveCampaignSegment'
    }, $true))
    if ($functions.Count -ne 1) {
        return $false
    }
    $commands = @($functions[0].Body.FindAll({
        param($node)
        $node -is [System.Management.Automation.Language.CommandAst] -and
            $node.GetCommandName() -ceq 'Assert-CompletedModelOuterDispatch'
    }, $true))
    if ($commands.Count -ne 1) {
        return $false
    }
    $switches = @($commands[0].CommandElements | Where-Object {
        $_ -is [System.Management.Automation.Language.CommandParameterAst] -and
            $_.ParameterName -ceq 'RequireLiveCampaignEvidence'
    })
    return $switches.Count -eq 1 -and
        $null -ne $switches[0].Argument -and
        $switches[0].Argument.Extent.Text -ceq '$false'
}

function Test-FailedSegmentAwaitsTerminal {
    $tokens = $null
    $parseErrors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile(
        $runnerPath,
        [ref]$tokens,
        [ref]$parseErrors
    )
    if ($parseErrors.Count -ne 0) {
        return $false
    }
    $functions = @($ast.FindAll({
        param($node)
        $node -is [System.Management.Automation.Language.FunctionDefinitionAst] -and
            $node.Name -ceq 'Invoke-CampaignController'
    }, $true))
    if ($functions.Count -ne 1) {
        return $false
    }
    $text = $functions[0].Extent.Text
    return $text.Contains("`$controller.NextSegment = 'terminal'") -and
        $text.Contains("-Event 'segment_failed'") -and
        $text.Contains('continue') -and
        $text.Contains('return $terminalExitCode') -and
        -not $text.Contains('return [int]$exitCode')
}

function Test-TerminalRequiresReachedControllerState {
    $tokens = $null
    $parseErrors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile(
        $runnerPath,
        [ref]$tokens,
        [ref]$parseErrors
    )
    if ($parseErrors.Count -ne 0) {
        return $false
    }
    $functions = @($ast.FindAll({
        param($node)
        $node -is [System.Management.Automation.Language.FunctionDefinitionAst] -and
            $node.Name -ceq 'Invoke-CampaignController'
    }, $true))
    if ($functions.Count -ne 1) {
        return $false
    }
    $text = $functions[0].Extent.Text
    return $text.Contains("if ([string]`$controller.NextSegment -cne 'terminal')") -and
        $text.Contains('terminal validation requires a recorded segment failure or all segments completed')
}

function Get-RulesetSha256 {
    return Get-TextSha256 -Text (
        @($rulesetSources | ForEach-Object { "$($_.Locator)|$($_.Sha256)" }) -join "`n"
    )
}

function Get-ProductionPolicy {
    $definitions = @(
        @('canary', 'canary-sol-high', 'gpt-5.6-sol', 'high', 1),
        @('canary', 'canary-sol-xhigh', 'gpt-5.6-sol', 'xhigh', 1),
        @('canary', 'canary-terra-high', 'gpt-5.6-terra', 'high', 1),
        @('product', 'candidate-calibration', 'gpt-5.6-sol', 'high', 2),
        @('product', 'released-control-a18', 'gpt-5.6-sol', 'high', 2),
        @('product', 'candidate-a19', 'gpt-5.6-sol', 'high', 1),
        @('product', 'candidate-a20', 'gpt-5.6-sol', 'high', 1),
        @('product', 'candidate-b01', 'gpt-5.6-sol', 'xhigh', 1),
        @('product', 'candidate-b02', 'gpt-5.6-sol', 'xhigh', 1),
        @('product', 'candidate-b03', 'gpt-5.6-sol', 'xhigh', 1),
        @('product', 'candidate-b04', 'gpt-5.6-sol', 'xhigh', 1),
        @('product', 'candidate-c01', 'gpt-5.6-terra', 'high', 1),
        @('product', 'candidate-c02', 'gpt-5.6-terra', 'high', 1),
        @('product', 'candidate-c03', 'gpt-5.6-terra', 'high', 1),
        @('product', 'candidate-c04', 'gpt-5.6-terra', 'high', 1),
        @('assessor', 'assessor-terra-high', 'gpt-5.6-terra', 'high', 1)
    )
    $remainingContexts = 16
    $remainingTurns = 18
    $segmentOrdinals = @{}
    $result = [System.Collections.Generic.List[object]]::new()
    for ($index = 0; $index -lt $definitions.Count; $index++) {
        $definition = $definitions[$index]
        $segment = [string]$definition[0]
        $phase = [string]$definition[1]
        $segmentOrdinals[$segment] = 1 + [int]$segmentOrdinals[$segment]
        $nextPhase = if ($index + 1 -lt $definitions.Count -and
            [string]$definitions[$index + 1][0] -ceq $segment) {
            [string]$definitions[$index + 1][1]
        }
        else { '' }
        $result.Add([pscustomobject]@{
            Ordinal = $index + 1; Segment = $segment
            SegmentOrdinal = [int]$segmentOrdinals[$segment]
            Phase = $phase; Model = [string]$definition[2]
            Effort = [string]$definition[3]; TurnStarts = [int]$definition[4]
            RemainingContexts = $remainingContexts; RemainingTurns = $remainingTurns
            NextPhase = $nextPhase; DirectoryName = ('{0:d2}-{1}' -f ($index + 1), $phase)
        })
        $remainingContexts--
        $remainingTurns -= [int]$definition[4]
    }
    return $result.ToArray()
}

function Get-ProductionPolicySha256 {
    $rows = @(Get-ProductionPolicy | ForEach-Object {
        @(
            $_.Ordinal, $_.Segment, $_.SegmentOrdinal, $_.Phase,
            $_.Model, $_.Effort, $_.TurnStarts,
            $_.RemainingContexts, $_.RemainingTurns, $_.NextPhase,
            $_.DirectoryName, 'd52-codex-app-server',
            'd52-codex-app-server-0.147.0-alpha.6.6', 'app-server', '--stdio'
        ) -join '|'
    })
    return Get-TextSha256 -Text ($rows -join "`n")
}

function Get-PhaseMetadata {
    param([Parameter(Mandatory)][string]$Phase)

    $match = @(Get-ProductionPolicy | Where-Object { $_.Phase -ceq $Phase })
    if ($match.Count -eq 1) { return $match[0] }
    $qualification = @(Get-ProtocolQualificationPolicy | Where-Object {
        $_.Phase -ceq $Phase
    })
    if ($qualification.Count -eq 1) { return $qualification[0] }
    return [pscustomobject]@{
        Ordinal = 0; Phase = $Phase; Model = ''; Effort = ''; TurnStarts = 0
        RemainingContexts = 0; RemainingTurns = 0; NextPhase = ''; DirectoryName = ''
    }
}

function Get-ProtocolQualificationPolicy {
    $definitions = @(
        @('qualification-segment-01', 'gpt-5.6-sol', 'high', 'qualification-segment-02'),
        @('qualification-segment-02', 'gpt-5.6-sol', 'xhigh', 'qualification-segment-03'),
        @('qualification-segment-03', 'gpt-5.6-terra', 'high', '')
    )
    $result = [System.Collections.Generic.List[object]]::new()
    for ($index = 0; $index -lt $definitions.Count; $index++) {
        $definition = $definitions[$index]
        $result.Add([pscustomobject]@{
            Ordinal = $index + 1
            Segment = 'qualification'
            SegmentOrdinal = $index + 1
            Phase = [string]$definition[0]
            Model = [string]$definition[1]
            Effort = [string]$definition[2]
            TurnStarts = 1
            RemainingContexts = $definitions.Count - $index
            RemainingTurns = $definitions.Count - $index
            NextPhase = [string]$definition[3]
            DirectoryName = ('qualification-{0:d2}' -f ($index + 1))
        })
    }
    return $result.ToArray()
}

function New-AuthorityArtifacts {
    param(
        [Parameter(Mandatory)][string]$CaseRoot,
        [Parameter(Mandatory)][string]$Phase
    )

    $phaseMetadata = Get-PhaseMetadata -Phase $Phase
    foreach ($source in $rulesetSources) {
        if ((Get-NormalizedTextSha256 -Path $source.Path) -cne $source.Sha256) {
            throw "Ruleset source drifted before runner qualification: $($source.Path)"
        }
    }
    $authorityPath = Join-Path $CaseRoot 'authority-snapshot.json'
    $carrierPath = Join-Path $CaseRoot 'carrier-manifest.json'
    $frozenPath = Join-Path $CaseRoot 'frozen-inputs.json'
    Write-Json -Path $authorityPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-authority-snapshot/v1'
        campaign_id = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
        stable_subject = 'Work Charter v0.2.0 exact candidate'
        candidate_commit = 'c4810057c3f28cca9f12004ca2018784cd21f449'
        candidate_manifest_sha256 = '04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44'
        campaign_contract_path = $campaignContractPath
        campaign_contract_sha256 = Get-Sha256 -Path $campaignContractPath
        authorization_lifecycle = Get-AuthorizationLifecycleForPhase -Phase $Phase
        ruleset_sources = @(
            $rulesetSources | ForEach-Object {
                [ordered]@{
                    logical_locator = $_.Locator
                    path = $_.Path
                    normalized_sha256 = $_.Sha256
                }
            }
        )
    })
    $authoritySha256 = Get-Sha256 -Path $authorityPath
    Write-Json -Path $frozenPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-frozen-inputs/v1'
        campaign_id = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
        candidate_commit = 'c4810057c3f28cca9f12004ca2018784cd21f449'
        candidate_manifest_sha256 = '04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44'
        authority_snapshot_sha256 = $authoritySha256
        authorization_lifecycle = Get-AuthorizationLifecycleForPhase -Phase $Phase
        phase = $Phase
        authorization_policy_sha256 = Get-ProductionPolicySha256
        phase_ordinal = [long]$phaseMetadata.Ordinal
        model = $phaseMetadata.Model
        reasoning_effort = $phaseMetadata.Effort
        phase_turn_starts = [long]$phaseMetadata.TurnStarts
        successor_phase = $phaseMetadata.NextPhase
    })
    Write-Json -Path $carrierPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-carrier-manifest/v1'
        campaign_id = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
        candidate_commit = 'c4810057c3f28cca9f12004ca2018784cd21f449'
        candidate_manifest_sha256 = '04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44'
        launcher_sha256 = Get-Sha256 -Path $runnerPath
        launcher_commit = 'cf11dcf374ef2f2a09c9a0bc22c42267d667cf3e'
        launcher_blob_oid = '0000000000000000000000000000000000000000'
        authority_snapshot_sha256 = $authoritySha256
        frozen_inputs_sha256 = Get-Sha256 -Path $frozenPath
        campaign_contract_sha256 = Get-Sha256 -Path $campaignContractPath
        ruleset_sha256 = Get-RulesetSha256
        authorization_lifecycle = Get-AuthorizationLifecycleForPhase -Phase $Phase
        phase = $Phase
        authorization_policy_sha256 = Get-ProductionPolicySha256
        phase_ordinal = [long]$phaseMetadata.Ordinal
        model = $phaseMetadata.Model
        reasoning_effort = $phaseMetadata.Effort
        phase_turn_starts = [long]$phaseMetadata.TurnStarts
        successor_phase = $phaseMetadata.NextPhase
    })
    return [pscustomobject]@{
        AuthorityPath = $authorityPath
        CarrierPath = $carrierPath
        FrozenPath = $frozenPath
    }
}

function Get-D54CodexAnchorPath {
    $expectedSha256 = '592958896cbffa154709618476fc9c9bf7fe73957e9a4fc12094c5051b6c69b3'
    $root = Join-Path $env:LOCALAPPDATA 'OpenAI\Codex\bin'
    $codexCandidates = @(
        Get-ChildItem -LiteralPath $root -Directory -Force -ErrorAction Stop |
            ForEach-Object { Join-Path $_.FullName 'codex.exe' } |
            Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } |
            Where-Object {
                (Get-Sha256 -Path $_) -ceq $expectedSha256 -and
                [string](Get-AuthenticodeSignature -LiteralPath $_).Status -ceq 'Valid' -and
                [string](Get-AuthenticodeSignature -LiteralPath $_).SignerCertificate.Subject -cmatch
                    'O="OpenAI OpCo, LLC"'
            }
    )
    if ($codexCandidates.Count -ne 1) {
        throw 'The D54 Codex trust anchor must resolve to exactly one authenticated file.'
    }
    return [string]$codexCandidates[0]
}

function New-Case {
    param([Parameter(Mandatory)][string]$Name)

    $path = Join-Path $scratchRoot $Name
    [void](New-Item -ItemType Directory -Path $path)
    return $path
}

function New-Binding {
    param(
        [Parameter(Mandatory)][string]$CaseRoot,
        [Parameter(Mandatory)][string]$ChildArgumentsPath,
        [string]$Phase = 'transport-canary',
        [string]$NextDispatchPath,
        [string]$ChildExecutablePath = $pwshPath,
        [Parameter(Mandatory)][string]$ChildOperationId,
        [string]$ChildExecutableAnchorId = 'd52-powershell-current',
        [string]$ChildWorkingDirectory = $PSScriptRoot,
        [long]$ModelContexts = 3,
        [long]$TurnStarts = 3
    )

    $phaseMetadata = Get-PhaseMetadata -Phase $Phase
    $artifacts = New-AuthorityArtifacts -CaseRoot $CaseRoot -Phase $Phase
    $path = Join-Path $CaseRoot 'binding.json'
    Write-Json -Path $path -Value ([ordered]@{
        schema_version = 'work-charter-d54-launch-binding/v1'
        campaign_id = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
        stable_subject = 'Work Charter v0.2.0 exact candidate'
        candidate_commit = 'c4810057c3f28cca9f12004ca2018784cd21f449'
        candidate_manifest_sha256 = '04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44'
        authority_snapshot_sha256 = Get-Sha256 -Path $artifacts.AuthorityPath
        authority_snapshot_path_sha256 = Get-TextSha256 -Text $artifacts.AuthorityPath
        carrier_manifest_sha256 = Get-Sha256 -Path $artifacts.CarrierPath
        carrier_manifest_path_sha256 = Get-TextSha256 -Text $artifacts.CarrierPath
        launcher_sha256 = Get-Sha256 -Path $runnerPath
        launcher_commit = 'cf11dcf374ef2f2a09c9a0bc22c42267d667cf3e'
        launcher_blob_oid = '0000000000000000000000000000000000000000'
        authorization_lifecycle = Get-AuthorizationLifecycleForPhase -Phase $Phase
        authorization_policy_sha256 = Get-ProductionPolicySha256
        phase_ordinal = [long]$phaseMetadata.Ordinal
        model = $phaseMetadata.Model
        reasoning_effort = $phaseMetadata.Effort
        phase_turn_starts = [long]$phaseMetadata.TurnStarts
        successor_phase = $phaseMetadata.NextPhase
        campaign_contract_sha256 = Get-Sha256 -Path $campaignContractPath
        ruleset_sha256 = Get-RulesetSha256
        frozen_inputs_sha256 = Get-Sha256 -Path $artifacts.FrozenPath
        frozen_inputs_path_sha256 = Get-TextSha256 -Text $artifacts.FrozenPath
        child_operation_id = $ChildOperationId
        child_executable_sha256 = Get-Sha256 -Path $ChildExecutablePath
        child_executable_anchor_id = $ChildExecutableAnchorId
        child_arguments_sha256 = Get-Sha256 -Path $ChildArgumentsPath
        child_working_directory_sha256 = Get-TextSha256 -Text $ChildWorkingDirectory
        next_dispatch_sha256 = if ([string]::IsNullOrWhiteSpace($NextDispatchPath)) {
            '0' * 64
        }
        else {
            Get-Sha256 -Path $NextDispatchPath
        }
        receipt_max_age_seconds = [long]300
        phase = $Phase
        remaining_budget = [ordered]@{
            model_contexts = $ModelContexts
            turn_starts = $TurnStarts
        }
    })
    return $path
}

function New-Argv {
    param(
        [Parameter(Mandatory)][string]$CaseRoot,
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$Arguments
    )

    $path = Join-Path $CaseRoot "$Name.json"
    Write-Json -Path $path -Value @($Arguments)
    return $path
}

function Invoke-Captured {
    param(
        [Parameter(Mandatory)][string[]]$Arguments,
        [hashtable]$Environment = @{},
        [AllowEmptyCollection()][string[]]$InputLines,
        [switch]$WaitForFirstResponseBeforeClose,
        [object]$RootContract
    )

    $effectiveArguments = [System.Collections.Generic.List[string]]::new()
    foreach ($argument in $Arguments) {
        $effectiveArguments.Add([string]$argument)
    }
    $fileIndex = [Array]::IndexOf($Arguments, '-File')
    $targetsTrackedRunner = $false
    if ($fileIndex -ge 0 -and ($fileIndex + 1) -lt $Arguments.Count) {
        $targetsTrackedRunner = [string]::Equals(
            [IO.Path]::GetFullPath([string]$Arguments[$fileIndex + 1]),
            [IO.Path]::GetFullPath($runnerPath),
            [StringComparison]::OrdinalIgnoreCase
        )
    }
    if ($targetsTrackedRunner -and
        $Arguments -notcontains '-RootContractPath') {
        $bindingIndex = [Array]::IndexOf($Arguments, '-BindingPath')
        $lifecycleIndex = [Array]::IndexOf($Arguments, '-LifecycleEvidenceRoot')
        if ($lifecycleIndex -ge 0) {
            $invocationEvidenceRoot = [IO.Path]::GetFullPath($Arguments[$lifecycleIndex + 1])
            if ($null -eq $RootContract) {
                throw 'D54 lifecycle checker requires an explicit root contract.'
            }
            $invocationContract = $RootContract
        }
        elseif ($bindingIndex -ge 0) {
            $bindingRoot = Split-Path -Parent ([IO.Path]::GetFullPath($Arguments[$bindingIndex + 1]))
            $phaseMarker = "{0}phases{0}" -f [IO.Path]::DirectorySeparatorChar
            $phaseIndex = $bindingRoot.IndexOf($phaseMarker, [StringComparison]::OrdinalIgnoreCase)
            $invocationCarrierRoot = if ($phaseIndex -ge 0) {
                $bindingRoot.Substring(0, $phaseIndex)
            }
            else { $bindingRoot }
            $invocationEvidenceRoot = Join-Path $invocationCarrierRoot 'execution\evidence'
        }
        else {
            $invocationCarrierRoot = Join-Path $scratchRoot 'runner-control-carrier'
            $invocationEvidenceRoot = Join-Path $invocationCarrierRoot 'execution\evidence'
        }
        if ($null -eq $invocationContract) {
            $invocationContract = New-D54RootContract `
                -CaseRoot (Join-Path $invocationCarrierRoot 'd54-control') `
                -CampaignRoot $scratchRoot `
                -CarrierRoot $invocationCarrierRoot `
                -EvidenceRoot $invocationEvidenceRoot
        }
        foreach ($argument in (Get-D54RootArguments -Contract $invocationContract)) {
            $effectiveArguments.Add([string]$argument)
        }
    }
    if ($targetsTrackedRunner -and
        $Arguments -notcontains '-RootContractPath' -and
        $effectiveArguments -notcontains '-RootContractPath') {
        throw 'D54 checker failed to inject the tracked runner root contract.'
    }
    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $pwshPath
    $startInfo.WorkingDirectory = $PSScriptRoot
    $startInfo.UseShellExecute = $false
    $startInfo.CreateNoWindow = $true
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.RedirectStandardInput = $null -ne $InputLines
    foreach ($argument in $effectiveArguments) {
        [void]$startInfo.ArgumentList.Add($argument)
    }
    foreach ($name in $Environment.Keys) {
        $startInfo.Environment[[string]$name] = [string]$Environment[$name]
    }
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    try {
        if (-not $process.Start()) {
            throw 'Runner process did not start.'
        }
        $stderrTask = $process.StandardError.ReadToEndAsync()
        $firstResponse = $null
        if ($null -ne $InputLines) {
            foreach ($line in $InputLines) {
                $process.StandardInput.WriteLine($line)
                $process.StandardInput.Flush()
            }
            if ($WaitForFirstResponseBeforeClose) {
                if ($InputLines.Count -ne 1) {
                    throw 'The response-before-close probe requires exactly one input line.'
                }
                $responseTask = $process.StandardOutput.ReadLineAsync()
                if (-not $responseTask.Wait(30000)) {
                    $process.Kill($true)
                    throw 'Timed out waiting for the first runner response.'
                }
                $firstResponse = [string]$responseTask.Result
            }
            $process.StandardInput.Close()
        }
        $stdoutTask = $process.StandardOutput.ReadToEndAsync()
        $process.WaitForExit()
        $remainingStdout = [string]$stdoutTask.GetAwaiter().GetResult()
        return [pscustomobject]@{
            Stdout = if ($null -ne $firstResponse) {
                $firstResponse + "`n" + $remainingStdout
            }
            else { $remainingStdout }
            Stderr = [string]$stderrTask.GetAwaiter().GetResult()
            ExitCode = [int]$process.ExitCode
        }
    }
    finally {
        $process.Dispose()
    }
}

function Get-AuthorizationLifecycleForPhase {
    param([AllowEmptyString()][string]$Phase)

    $key = [string]$Phase
    if (-not $authorizationLifecycleCache.ContainsKey($key)) {
        $arguments = [System.Collections.Generic.List[string]]::new()
        foreach ($argument in @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-File', $runnerPath,
            '-Mode', 'DescribeLifecycle'
        )) {
            $arguments.Add([string]$argument)
        }
        if (-not [string]::IsNullOrEmpty($Phase)) {
            $arguments.Add('-ExpectedPhase')
            $arguments.Add($Phase)
        }
        $result = Invoke-Captured -Arguments $arguments.ToArray()
        if ($result.ExitCode -ne 0 -or -not [string]::IsNullOrEmpty($result.Stderr)) {
            throw "Tracked D54 lifecycle description failed: $($result.Stderr)"
        }
        try {
            $authorizationLifecycleCache[$key] = $result.Stdout |
                ConvertFrom-Json -Depth 100 -ErrorAction Stop
        }
        catch {
            throw 'Tracked D54 lifecycle description is not valid JSON.'
        }
    }
    return (
        $authorizationLifecycleCache[$key] |
            ConvertTo-Json -Depth 100 -Compress |
            ConvertFrom-Json -Depth 100
    )
}

function Start-ArgumentMutationWatcher {
    param(
        [Parameter(Mandatory)][string]$ReceiptPath,
        [Parameter(Mandatory)][string]$ArgumentsPath,
        [Parameter(Mandatory)][string[]]$MutatedArguments,
        [Parameter(Mandatory)][string]$MutationMarkerPath
    )

    $consumptionPath = $ReceiptPath + '.consumed'
    $mutationJson = ConvertTo-Json -InputObject @($MutatedArguments) -Compress
    $mutationBase64 = [Convert]::ToBase64String($strictUtf8.GetBytes($mutationJson + "`n"))
    $quotedConsumption = $consumptionPath.Replace("'", "''")
    $quotedArguments = $ArgumentsPath.Replace("'", "''")
    $quotedMarker = $MutationMarkerPath.Replace("'", "''")
    $watchCommand = @"
`$deadline = [datetimeoffset]::UtcNow.AddSeconds(15)
while ([datetimeoffset]::UtcNow -lt `$deadline) {
    if (Test-Path -LiteralPath '$quotedConsumption' -PathType Leaf) {
        `$bytes = [Convert]::FromBase64String('$mutationBase64')
        [IO.File]::WriteAllBytes('$quotedArguments', `$bytes)
        [IO.File]::WriteAllText('$quotedMarker', 'mutated', [Text.UTF8Encoding]::new(`$false))
        exit 0
    }
    Start-Sleep -Milliseconds 1
}
[Console]::Error.Write('Timed out waiting for the receipt-consumption claim.')
exit 91
"@
    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $pwshPath
    $startInfo.WorkingDirectory = $PSScriptRoot
    $startInfo.UseShellExecute = $false
    $startInfo.CreateNoWindow = $true
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    foreach ($argument in @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command', $watchCommand
    )) {
        [void]$startInfo.ArgumentList.Add([string]$argument)
    }
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    if (-not $process.Start()) {
        $process.Dispose()
        throw 'Argument-mutation watcher did not start.'
    }
    return [pscustomobject]@{
        Process = $process
        StdoutTask = $process.StandardOutput.ReadToEndAsync()
        StderrTask = $process.StandardError.ReadToEndAsync()
    }
}

function Complete-ArgumentMutationWatcher {
    param([Parameter(Mandatory)][object]$Watcher)

    try {
        if (-not $Watcher.Process.WaitForExit(20000)) {
            $Watcher.Process.Kill($true)
            throw 'Argument-mutation watcher did not finish in its bounded window.'
        }
        return [pscustomobject]@{
            Stdout = [string]$Watcher.StdoutTask.GetAwaiter().GetResult()
            Stderr = [string]$Watcher.StderrTask.GetAwaiter().GetResult()
            ExitCode = [int]$Watcher.Process.ExitCode
        }
    }
    finally {
        $Watcher.Process.Dispose()
    }
}

function Sync-EvidenceBindingHashes {
    param(
        [Parameter(Mandatory)][string]$CaseRoot,
        [Parameter(Mandatory)][string]$BindingPath
    )

    $authorityPath = Join-Path $CaseRoot 'authority-snapshot.json'
    $carrierPath = Join-Path $CaseRoot 'carrier-manifest.json'
    $frozenPath = Join-Path $CaseRoot 'frozen-inputs.json'
    $authority = Get-Content -Raw -Encoding UTF8 $authorityPath | ConvertFrom-Json
    $frozen = Get-Content -Raw -Encoding UTF8 $frozenPath | ConvertFrom-Json
    $carrier = Get-Content -Raw -Encoding UTF8 $carrierPath | ConvertFrom-Json
    $binding = Get-Content -Raw -Encoding UTF8 $BindingPath | ConvertFrom-Json
    $authoritySha256 = Get-Sha256 -Path $authorityPath
    $frozen.authority_snapshot_sha256 = $authoritySha256
    Write-Json -Path $frozenPath -Value $frozen
    $carrier.authority_snapshot_sha256 = $authoritySha256
    $carrier.frozen_inputs_sha256 = Get-Sha256 -Path $frozenPath
    $carrier.campaign_contract_sha256 = [string]$authority.campaign_contract_sha256
    $carrier.ruleset_sha256 = [string]$binding.ruleset_sha256
    Write-Json -Path $carrierPath -Value $carrier
    $binding.authority_snapshot_sha256 = $authoritySha256
    $binding.frozen_inputs_sha256 = Get-Sha256 -Path $frozenPath
    $binding.carrier_manifest_sha256 = Get-Sha256 -Path $carrierPath
    $binding.campaign_contract_sha256 = [string]$authority.campaign_contract_sha256
    Write-Json -Path $BindingPath -Value $binding
}

function Get-RunnerArguments {
    param(
        [Parameter(Mandatory)][string]$Mode,
        [Parameter(Mandatory)][string]$BindingPath,
        [Parameter(Mandatory)][string]$ReceiptPath,
        [Parameter(Mandatory)][string]$StatePath,
        [Parameter(Mandatory)][string]$ChildArgumentsPath,
        [string]$ExpectedPhase = 'transport-canary',
        [string]$NextDispatchPath,
        [string]$ChildExecutablePath = $pwshPath,
        [Parameter(Mandatory)][string]$ChildOperationId,
        [string]$ChildExecutableAnchorId = 'd52-powershell-current',
        [string]$ChildWorkingDirectory = $PSScriptRoot
    )

    $bindingRoot = Split-Path -Parent $BindingPath
    $arguments = [System.Collections.Generic.List[string]]::new()
    foreach ($argument in @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-File', $runnerPath,
        '-Mode', $Mode, '-BindingPath', $BindingPath,
        '-AuthoritySnapshotPath', (Join-Path $bindingRoot 'authority-snapshot.json'),
        '-CarrierManifestPath', (Join-Path $bindingRoot 'carrier-manifest.json'),
        '-FrozenInputsPath', (Join-Path $bindingRoot 'frozen-inputs.json'),
        '-ReceiptPath', $ReceiptPath, '-DispatchStatePath', $StatePath,
        '-ExpectedPhase', $ExpectedPhase,
        '-ChildExecutablePath', $ChildExecutablePath,
        '-ChildOperationId', $ChildOperationId,
        '-ChildExecutableAnchorId', $ChildExecutableAnchorId,
        '-ChildArgumentsPath', $ChildArgumentsPath,
        '-ChildWorkingDirectory', $ChildWorkingDirectory
    )) {
        $arguments.Add([string]$argument)
    }
    if (-not [string]::IsNullOrWhiteSpace($NextDispatchPath)) {
        $arguments.Add('-NextDispatchPath')
        $arguments.Add($NextDispatchPath)
    }
    return $arguments.ToArray()
}

function Add-Check {
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][bool]$Passed,
        [Parameter(Mandatory)][string]$Expectation,
        [Parameter(Mandatory)][object]$Observation
    )

    $checks.Add([pscustomobject]@{
        name = $Name
        passed = $Passed
        expectation = $Expectation
        exit_code = [int]$Observation.ExitCode
        rejection = if ($Passed) { $null } else { [string]$Observation.Stderr }
    })
}

function New-ManualInnerCase {
    param(
        [Parameter(Mandatory)][string]$Name,
        [string]$Phase = 'transport-canary'
    )

    $caseRoot = New-Case -Name $Name
    $childMarker = Join-Path $caseRoot 'child-started.txt'
    $childArgvPath = New-Argv -CaseRoot $caseRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
    )
    $bindingPath = New-Binding `
        -CaseRoot $caseRoot `
        -ChildArgumentsPath $childArgvPath `
        -ChildOperationId 'd52-test-powershell-unexpected' `
        -Phase $Phase
    $statePath = Join-Path $caseRoot 'state.json'
    $receiptPath = Join-Path $caseRoot 'receipt.json'
    $forgedCapabilityId = 'manual-inner-forged-capability'
    $dispatchId = [guid]::NewGuid().ToString('D')
    Write-Json -Path $statePath -Value ([ordered]@{
        schema_version = 'work-charter-d54-dispatch-state/v1'
        dispatch_id = $dispatchId
        campaign_id = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
        phase = $Phase
        status = 'receipt_issued'
        receipt_consumed = $false
        child_exit_code = $null
        next_dispatch_count = 0
        next_exit_code = $null
    })
    Write-Json -Path $receiptPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-launch-receipt/v1'
        dispatch_id = $dispatchId
        campaign_id = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
        phase = $Phase
        binding_sha256 = Get-Sha256 $bindingPath
        outer_capability_id_sha256 = Get-TextSha256 -Text $forgedCapabilityId
        issued_at_utc = [datetimeoffset]::UtcNow.ToString('O')
        status = 'issued'
        consumed_at_utc = $null
    })
    return [pscustomobject]@{
        BindingPath = $bindingPath
        ReceiptPath = $receiptPath
        StatePath = $statePath
        ChildArgumentsPath = $childArgvPath
        ChildMarker = $childMarker
        Phase = $Phase
        ChildOperationId = 'd52-test-powershell-unexpected'
    }
}

function Invoke-InnerCase {
    param(
        [Parameter(Mandatory)][object]$Case,
        [string]$ExpectedPhase = $Case.Phase
    )

    $arguments = Get-RunnerArguments `
        -Mode Inner `
        -BindingPath $Case.BindingPath `
        -ReceiptPath $Case.ReceiptPath `
        -StatePath $Case.StatePath `
        -ChildArgumentsPath $Case.ChildArgumentsPath `
        -ChildOperationId $Case.ChildOperationId `
        -ExpectedPhase $ExpectedPhase
    return Invoke-Captured -Arguments $arguments
}

function Invoke-OuterReceiptNegative {
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][string]$OperationId
    )

    $caseRoot = New-Case -Name $Name
    $childArgvPath = New-Argv -CaseRoot $caseRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
    )
    $bindingPath = New-Binding `
        -CaseRoot $caseRoot `
        -ChildArgumentsPath $childArgvPath `
        -ChildOperationId $OperationId
    $receiptPath = Join-Path $caseRoot 'receipt.json'
    $statePath = Join-Path $caseRoot 'state.json'
    $arguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $bindingPath `
        -ReceiptPath $receiptPath `
        -StatePath $statePath `
        -ChildArgumentsPath $childArgvPath `
        -ChildOperationId $OperationId
    return [pscustomobject]@{
        Result = Invoke-Captured -Arguments $arguments
        ReceiptPath = $receiptPath
        StatePath = $statePath
    }
}

function New-LifecycleEvidenceChain {
    param(
        [Parameter(Mandatory)][string]$CaseRoot,
        [long]$ReceiptMaxAgeSeconds = 300
    )

    $evidenceRoot = Join-Path $CaseRoot 'declared\nested\evidence-root'
    [void](New-Item -ItemType Directory -Path $evidenceRoot -Force)
    $rootContract = New-D54RootContract `
        -CaseRoot (Join-Path $CaseRoot 'd54-control') `
        -CampaignRoot $scratchRoot `
        -CarrierRoot $CaseRoot `
        -EvidenceRoot $evidenceRoot
    $lifecycleRootContracts[[IO.Path]::GetFullPath($evidenceRoot)] = $rootContract
    $lifecycle = Get-AuthorizationLifecycleForPhase -Phase ''
    $common = [ordered]@{
        campaign_id = 'WC-AR-D54-EXPLICIT-ROOT-CONTRACT'
        candidate_commit = 'c4810057c3f28cca9f12004ca2018784cd21f449'
        candidate_manifest_sha256 = '04c382a48e43897a8806aa5ffd996984cb015d3d8cdc6e675e9181a6d94e6f44'
        authorization_lifecycle_policy_sha256 = [string]$lifecycle.policy_sha256
    }
    $qualificationPath = Join-Path $evidenceRoot 'formal-qualification.json'
    Write-Json -Path $qualificationPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-formal-qualification/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        previous_state = 'ZERO_MODEL_QUALIFICATION_PENDING'
        state = 'CANARY_AUTHORIZED_AFTER_QUALIFICATION'
        qualification = [ordered]@{
            passed = 56; total = 56
            private_passed = 24; private_total = 24
            tracked_passed = 32; tracked_total = 32
        }
        tracked_runner_sha256 = Get-Sha256 -Path $runnerPath
    })
    $canaryRoutes = [System.Collections.Generic.List[object]]::new()
    foreach ($policy in @(Get-ProductionPolicy | Where-Object { $_.Segment -ceq 'canary' })) {
        $phaseRoot = Join-Path (Join-Path $CaseRoot 'phases') $policy.DirectoryName
        [void](New-Item -ItemType Directory -Path $phaseRoot -Force)
        $receiptPath = Join-Path $phaseRoot 'receipt.json'
        Write-Json -Path $receiptPath -Value ([ordered]@{
            schema_version = 'work-charter-d54-launch-receipt/v1'
            dispatch_id = [guid]::NewGuid().ToString('D')
            campaign_id = $common.campaign_id
            phase = $policy.Phase
            status = 'consumed'
        })
        $consumptionPath = $receiptPath + '.consumed'
        $receipt = Get-Content -LiteralPath $receiptPath -Raw -Encoding UTF8 |
            ConvertFrom-Json -Depth 20
        Write-Json -Path $consumptionPath -Value ([ordered]@{
            schema_version = 'work-charter-d54-receipt-consumption/v1'
            dispatch_id = [string]$receipt.dispatch_id
            phase = $policy.Phase
            consumed_at_utc = [datetimeoffset]::UtcNow.ToString('O')
        })
        $statePath = Join-Path $phaseRoot 'dispatch-state.json'
        Write-Json -Path $statePath -Value ([ordered]@{
            schema_version = 'work-charter-d54-dispatch-state/v1'
            campaign_id = $common.campaign_id
            phase = $policy.Phase
            status = 'completed'
            child_exit_code = 0
            next_dispatch_count = if ([string]::IsNullOrEmpty($policy.NextPhase)) { 0 } else { 1 }
        })
        $canaryRoutes.Add([ordered]@{
            phase = $policy.Phase
            model = $policy.Model
            reasoning_effort = $policy.Effort
            turn_starts = 1
            verdict = 'PASS'
            outer_receipt_sha256 = Get-Sha256 -Path $receiptPath
            dispatch_state_sha256 = Get-Sha256 -Path $statePath
            inner_consumption_sha256 = Get-Sha256 -Path $consumptionPath
        })
    }
    $canaryPath = Join-Path $evidenceRoot 'transport-canary-batch-result.json'
    Write-Json -Path $canaryPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-canary-gate/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        previous_state = 'CANARY_AUTHORIZED_AFTER_QUALIFICATION'
        state = 'FREEZE_PENDING_AFTER_CANARIES'
        formal_qualification_sha256 = Get-Sha256 -Path $qualificationPath
        model_contexts = 3
        turn_starts = 3
        receipt_max_age_seconds = $ReceiptMaxAgeSeconds
        routes = $canaryRoutes.ToArray()
    })
    $freezePath = Join-Path $evidenceRoot 'freeze-manifest.json'
    Write-Json -Path $freezePath -Value ([ordered]@{
        schema_version = 'work-charter-d54-freeze/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        previous_state = 'FREEZE_PENDING_AFTER_CANARIES'
        state = 'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION'
        canary_gate_sha256 = Get-Sha256 -Path $canaryPath
        model_activity_authorized = $false
    })
    $activationPath = Join-Path $evidenceRoot 'model-activity-authorization.json'
    Write-Json -Path $activationPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-product-activation/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        previous_state = 'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION'
        state = 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
        authorized = $true
        freeze_manifest_sha256 = Get-Sha256 -Path $freezePath
        campaign_contract_sha256 = Get-Sha256 -Path $campaignContractPath
    })
    $terminalRoot = Join-Path $CaseRoot 'execution\terminal'
    [void](New-Item -ItemType Directory -Path $terminalRoot -Force)
    $packetPath = Join-Path $terminalRoot 'terminal-packet.json'
    $productRoutes = @(
        Get-ProductionPolicy | Where-Object { $_.Segment -ceq 'product' } |
            ForEach-Object {
                [ordered]@{
                    phase = $_.Phase
                    model = $_.Model
                    reasoning_effort = $_.Effort
                    model_contexts = [long]1
                    turn_starts = [long]$_.TurnStarts
                    verdict = 'PASS'
                    outer_receipt_sha256 = Get-TextSha256 -Text "diagnostic|receipt|$($_.Phase)"
                    dispatch_state_sha256 = Get-TextSha256 -Text "diagnostic|state|$($_.Phase)"
                    inner_consumption_sha256 = Get-TextSha256 -Text "diagnostic|consumption|$($_.Phase)"
                }
            }
    )
    Write-Json -Path $packetPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-admitted-product-packet/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        state = 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
        score = [ordered]@{ passed = 28; total = 28 }
        candidate_calibration = [ordered]@{
            verdict = 'PASS'; model_contexts = 1; turn_starts = 2
        }
        imported_scored_cells = 17
        fresh_scored_cells = 11
        product_model_contexts = 12
        product_turn_starts = 14
        controller_disposition = 'ADMISSIBLE'
        routes = $productRoutes
    })
    $viewPath = Join-Path $terminalRoot 'assessor-view.json'
    Write-Json -Path $viewPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-assessor-view/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        state = 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
        source_packet_sha256 = Get-Sha256 -Path $packetPath
    })
    $reviewPath = Join-Path $terminalRoot 'assessor-view-local-review.json'
    Write-Json -Path $reviewPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-assessor-view-review/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        state = 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
        verdict = 'PASS'
        disclosure_safe = $true
        assessor_view_sha256 = Get-Sha256 -Path $viewPath
    })
    $eligibilityPath = Join-Path $evidenceRoot 'assessor-eligibility.json'
    Write-Json -Path $eligibilityPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-assessor-eligibility/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        state = 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
        eligible = $true
        admitted_product_packet_sha256 = Get-Sha256 -Path $packetPath
        assessor_view_sha256 = Get-Sha256 -Path $viewPath
        local_review_sha256 = Get-Sha256 -Path $reviewPath
    })
    $terminalPath = Join-Path $evidenceRoot 'd54-terminal.json'
    Write-Json -Path $terminalPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-terminal/v1'
        campaign_id = $common.campaign_id
        candidate_commit = $common.candidate_commit
        candidate_manifest_sha256 = $common.candidate_manifest_sha256
        authorization_lifecycle_policy_sha256 = $common.authorization_lifecycle_policy_sha256
        previous_state = 'ZERO_MODEL_QUALIFICATION_PENDING'
        state = 'TERMINAL'
        terminal_disposition = 'QUALIFICATION_FAILED / PRODUCT_UNKNOWN'
        candidate_accepted = $false
        model_contexts = [long]0
        turn_starts = [long]0
        rehearsal_corrections_used = [long]0
        formal_corrections_used = [long]0
    })
    return [pscustomobject]@{
        Root = $evidenceRoot
        Qualification = $qualificationPath
        Canary = $canaryPath
        Freeze = $freezePath
        Activation = $activationPath
        Packet = $packetPath
        Eligibility = $eligibilityPath
        Terminal = $terminalPath
        RootContract = $rootContract
    }
}

function Invoke-LifecycleValidation {
    param(
        [Parameter(Mandatory)][string]$EvidenceRoot,
        [Parameter(Mandatory)][string]$State,
        [AllowEmptyString()][string]$ExpectedPhase = 'assessor-terra-high',
        [long]$ReceiptMaxAgeSeconds = 300,
        [switch]$RequireActionProvenance,
        [object]$RootContract
    )

    $arguments = [System.Collections.Generic.List[string]]::new()
    foreach ($argument in @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-File', $runnerPath,
        '-Mode', 'ValidateLifecycle',
        '-LifecycleEvidenceRoot', $EvidenceRoot,
        '-ExpectedLifecycleState', $State,
        '-ReceiptMaxAgeSeconds', [string]$ReceiptMaxAgeSeconds
    )) {
        $arguments.Add([string]$argument)
    }
    if (-not [string]::IsNullOrEmpty($ExpectedPhase)) {
        $arguments.Add('-ExpectedPhase')
        $arguments.Add($ExpectedPhase)
    }
    if ($RequireActionProvenance) {
        $arguments.Add('-RequireActionProvenance')
    }
    if ($null -eq $RootContract) {
        $contractKey = [IO.Path]::GetFullPath($EvidenceRoot)
        if (-not $lifecycleRootContracts.ContainsKey($contractKey)) {
            throw 'Lifecycle validation requires an explicit root contract.'
        }
        $RootContract = $lifecycleRootContracts[$contractKey]
    }
    return Invoke-Captured `
        -Arguments $arguments.ToArray() `
        -RootContract $RootContract
}

function Invoke-LifecycleNegative {
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][string]$Target,
        [Parameter(Mandatory)][scriptblock]$Mutation
    )

    $caseRoot = New-Case -Name $Name
    $chain = New-LifecycleEvidenceChain -CaseRoot $caseRoot
    $path = [string]$chain.$Target
    $record = Get-Content -LiteralPath $path -Raw -Encoding UTF8 |
        ConvertFrom-Json -Depth 100
    & $Mutation $record
    Write-Json -Path $path -Value $record
    return [pscustomobject]@{
        Result = Invoke-LifecycleValidation `
            -EvidenceRoot $chain.Root `
            -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
        ReceiptPath = Join-Path $caseRoot 'receipt.json'
        StatePath = Join-Path $caseRoot 'state.json'
    }
}

[void](New-Item -ItemType Directory -Path $scratchRoot -Force)
Initialize-D54ContainedSourceBundle
try {
    $explicitRootContract = Test-D54ExplicitRootContract
    $lifecycle = Get-AuthorizationLifecycleForPhase -Phase ''
    $expectedLifecycleStates = @(
        'ZERO_MODEL_QUALIFICATION_PENDING',
        'CANARY_AUTHORIZED_AFTER_QUALIFICATION',
        'FREEZE_PENDING_AFTER_CANARIES',
        'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION',
        'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN',
        'TERMINAL'
    )
    $expectedLifecycleNext = @(
        'CANARY_AUTHORIZED_AFTER_QUALIFICATION',
        'FREEZE_PENDING_AFTER_CANARIES',
        'PRE_PRODUCT_FROZEN_AWAITING_CAMPAIGN_ACTIVATION',
        'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN',
        'TERMINAL',
        ''
    )
    $lifecycleStates = @($lifecycle.states)
    $lifecyclePositive = (
        $explicitRootContract.Passed -and
        [string]$lifecycle.schema_version -ceq
            'work-charter-d54-authorization-lifecycle/v1' -and
        [string]$lifecycle.campaign_id -ceq
            'WC-AR-D54-EXPLICIT-ROOT-CONTRACT' -and
        [string]$lifecycle.predecessor_terminal_receipt_sha256 -ceq
            'e8e9fb645b83beaa9c64cd5ccf3d8fc3e283d21cdbb964cde8c72adb8849882b' -and
        [string]$lifecycle.policy_sha256 -cmatch '^[0-9a-f]{64}$' -and
        [long]$lifecycle.qualification.required_passed -eq 56 -and
        [long]$lifecycle.qualification.required_total -eq 56 -and
        $lifecycleStates.Count -eq 6
    )
    for ($index = 0; $index -lt $lifecycleStates.Count; $index++) {
        $lifecyclePositive = $lifecyclePositive -and
            [long]$lifecycleStates[$index].ordinal -eq ($index + 1) -and
            [string]$lifecycleStates[$index].state -ceq $expectedLifecycleStates[$index] -and
            [string]$lifecycleStates[$index].next_state -ceq $expectedLifecycleNext[$index]
    }
    $lifecyclePositiveRoot = New-Case -Name 'authorization-lifecycle-positive'
    $lifecyclePositiveChain = New-LifecycleEvidenceChain -CaseRoot $lifecyclePositiveRoot
    $lifecycleObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $lifecyclePositiveChain.Root `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
    $terminalObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $lifecyclePositiveChain.Root `
        -State 'TERMINAL' `
        -ExpectedPhase ''
    $mismatchedEvidenceRoot = Join-Path $lifecyclePositiveRoot 'declared\other-evidence-root'
    [void](New-Item -ItemType Directory -Path $mismatchedEvidenceRoot -Force)
    $mismatchedEvidenceObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $mismatchedEvidenceRoot `
        -State 'CANARY_AUTHORIZED_AFTER_QUALIFICATION' `
        -ExpectedPhase '' `
        -RootContract $lifecyclePositiveChain.RootContract
    $nonDefaultAgeRoot = New-Case -Name 'authorization-lifecycle-nondefault-age'
    $nonDefaultAgeChain = New-LifecycleEvidenceChain `
        -CaseRoot $nonDefaultAgeRoot `
        -ReceiptMaxAgeSeconds 600
    $nonDefaultAgeObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $nonDefaultAgeChain.Root `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' `
        -ReceiptMaxAgeSeconds 600
    $acceptedWithoutActionRoot = New-Case -Name 'accepted-terminal-without-action-provenance'
    $acceptedWithoutActionChain = New-LifecycleEvidenceChain `
        -CaseRoot $acceptedWithoutActionRoot
    $acceptedWithoutActionTerminal = Get-Content `
        -LiteralPath $acceptedWithoutActionChain.Terminal `
        -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 100
    $acceptedWithoutActionTerminal.previous_state = 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
    $acceptedWithoutActionTerminal.terminal_disposition = 'ACCEPTED'
    $acceptedWithoutActionTerminal.candidate_accepted = $true
    $acceptedWithoutActionTerminal.model_contexts = [long]16
    $acceptedWithoutActionTerminal.turn_starts = [long]18
    Write-Json `
        -Path $acceptedWithoutActionChain.Terminal `
        -Value $acceptedWithoutActionTerminal
    $acceptedWithoutActionObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $acceptedWithoutActionChain.Root `
        -State 'TERMINAL' `
        -ExpectedPhase ''
    $inconsistentTerminalRoot = New-Case -Name 'inconsistent-terminal-disposition'
    $inconsistentTerminalChain = New-LifecycleEvidenceChain `
        -CaseRoot $inconsistentTerminalRoot
    $inconsistentTerminal = Get-Content `
        -LiteralPath $inconsistentTerminalChain.Terminal `
        -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 100
    $inconsistentTerminal.terminal_disposition = 'PRODUCT_FAILED / NOT_ACCEPTED'
    Write-Json `
        -Path $inconsistentTerminalChain.Terminal `
        -Value $inconsistentTerminal
    $inconsistentTerminalObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $inconsistentTerminalChain.Root `
        -State 'TERMINAL' `
        -ExpectedPhase ''
    $canaryFailureTerminalRoot = New-Case -Name 'canary-failure-terminal'
    $canaryFailureTerminalChain = New-LifecycleEvidenceChain `
        -CaseRoot $canaryFailureTerminalRoot
    $canaryFailureTerminal = Get-Content `
        -LiteralPath $canaryFailureTerminalChain.Terminal `
        -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 100
    $canaryFailureTerminal.previous_state = 'CANARY_AUTHORIZED_AFTER_QUALIFICATION'
    $canaryFailureTerminal.terminal_disposition = 'CANARY_FAILED / PRODUCT_UNKNOWN'
    Write-Json `
        -Path $canaryFailureTerminalChain.Terminal `
        -Value $canaryFailureTerminal
    $canaryFailureTerminalObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $canaryFailureTerminalChain.Root `
        -State 'TERMINAL' `
        -ExpectedPhase ''
    $forgedFailureTerminalRoot = New-Case -Name 'forged-failure-terminal'
    $forgedFailureTerminalChain = New-LifecycleEvidenceChain `
        -CaseRoot $forgedFailureTerminalRoot
    $forgedFailureTerminal = Get-Content `
        -LiteralPath $forgedFailureTerminalChain.Terminal `
        -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 100
    $forgedFailureTerminal.previous_state = 'CANARY_AUTHORIZED_AFTER_QUALIFICATION'
    $forgedFailureTerminal.terminal_disposition = 'CANARY_FAILED / PRODUCT_UNKNOWN'
    Write-Json `
        -Path $forgedFailureTerminalChain.Terminal `
        -Value $forgedFailureTerminal
    Remove-Item -LiteralPath $forgedFailureTerminalChain.Qualification -Force
    $forgedFailureTerminalObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $forgedFailureTerminalChain.Root `
        -State 'TERMINAL' `
        -ExpectedPhase ''
    $terminalValidation = $null
    try {
        $terminalValidation = $terminalObservation.Stdout |
            ConvertFrom-Json -Depth 20 -ErrorAction Stop
    }
    catch {
        $terminalValidation = $null
    }
    $lifecycleValidation = $null
    try {
        $lifecycleValidation = $lifecycleObservation.Stdout |
            ConvertFrom-Json -Depth 20 -ErrorAction Stop
    }
    catch {
        $lifecycleValidation = $null
    }
    $assessorIneligibleRoot = New-Case -Name 'assessor-ineligible'
    $assessorIneligibleChain = New-LifecycleEvidenceChain -CaseRoot $assessorIneligibleRoot
    $assessorEligibility = Get-Content `
        -LiteralPath $assessorIneligibleChain.Eligibility `
        -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 100
    $assessorEligibility.eligible = $false
    Write-Json -Path $assessorIneligibleChain.Eligibility -Value $assessorEligibility
    $assessorIneligibleObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $assessorIneligibleChain.Root `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
    $missingProductRouteRoot = New-Case -Name 'assessor-missing-product-route'
    $missingProductRouteChain = New-LifecycleEvidenceChain `
        -CaseRoot $missingProductRouteRoot
    $missingProductRoutePacket = Get-Content `
        -LiteralPath $missingProductRouteChain.Packet `
        -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 100
    $missingProductRoutePacket.routes = @($missingProductRoutePacket.routes)[0..10]
    Write-Json `
        -Path $missingProductRouteChain.Packet `
        -Value $missingProductRoutePacket
    $missingProductRouteObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $missingProductRouteChain.Root `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN'
    $forgedActionObservation = Invoke-LifecycleValidation `
        -EvidenceRoot $lifecyclePositiveChain.Root `
        -State 'PRODUCT_AUTHORIZED_BY_APPROVED_CAMPAIGN' `
        -RequireActionProvenance
    $productFirstCommand = [ordered]@{
        schema_version = 'work-charter-d54-campaign-command/v1'
        command = 'dispatch_segment'
        segment = 'product'
    } | ConvertTo-Json -Compress
    $productFirstObservation = Invoke-Captured `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-File', $runnerPath,
            '-Mode', 'Campaign'
        ) `
        -InputLines @($productFirstCommand)
    $earlyTerminalCommand = [ordered]@{
        schema_version = 'work-charter-d54-campaign-command/v1'
        command = 'validate_terminal'
    } | ConvertTo-Json -Compress
    $earlyTerminalObservation = Invoke-Captured `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-File', $runnerPath,
            '-Mode', 'Campaign'
        ) `
        -InputLines @($earlyTerminalCommand)
    $initialCompletionUsesStaticPass = Test-InitialSegmentCompletionUsesStaticPass
    $failedSegmentAwaitsTerminal = Test-FailedSegmentAwaitsTerminal
    $terminalRequiresReachedControllerState = Test-TerminalRequiresReachedControllerState
    $canaryPolicy = @(Get-ProductionPolicy | Where-Object { $_.Segment -ceq 'canary' })
    $productPolicy = @(Get-ProductionPolicy | Where-Object { $_.Segment -ceq 'product' })
    $assessorPolicy = @(Get-ProductionPolicy | Where-Object { $_.Segment -ceq 'assessor' })
    $lifecyclePositive = $lifecyclePositive -and
        $lifecycleObservation.ExitCode -eq 0 -and
        [string]::IsNullOrEmpty($lifecycleObservation.Stderr) -and
        $null -ne $lifecycleValidation -and
        [string]$lifecycleValidation.verdict -ceq 'PASS' -and
        $lifecycleValidation.action_authority -is [bool] -and
        -not [bool]$lifecycleValidation.action_authority -and
        $terminalObservation.ExitCode -eq 0 -and
        [string]::IsNullOrEmpty($terminalObservation.Stderr) -and
        $mismatchedEvidenceObservation.ExitCode -eq 86 -and
        $mismatchedEvidenceObservation.Stderr -match 'lifecycle evidence root.*does not match' -and
        $null -ne $terminalValidation -and
        [string]$terminalValidation.state -ceq 'TERMINAL' -and
        -not [bool]$terminalValidation.action_authority -and
        $nonDefaultAgeObservation.ExitCode -eq 0 -and
        [string]::IsNullOrEmpty($nonDefaultAgeObservation.Stderr) -and
        $acceptedWithoutActionObservation.ExitCode -eq 86 -and
        $acceptedWithoutActionObservation.Stderr -match 'requires action provenance' -and
        $inconsistentTerminalObservation.ExitCode -eq 86 -and
        $inconsistentTerminalObservation.Stderr -match 'does not match its predecessor state' -and
        $canaryFailureTerminalObservation.ExitCode -eq 0 -and
        [string]::IsNullOrEmpty($canaryFailureTerminalObservation.Stderr) -and
        $forgedFailureTerminalObservation.ExitCode -eq 86 -and
        $forgedFailureTerminalObservation.Stderr -match 'formal qualification receipt' -and
        $assessorIneligibleObservation.ExitCode -eq 86 -and
        $assessorIneligibleObservation.Stderr -match 'Assessor eligibility' -and
        $missingProductRouteObservation.ExitCode -eq 86 -and
        $missingProductRouteObservation.Stderr -match 'all twelve product routes' -and
        $forgedActionObservation.ExitCode -eq 86 -and
        $forgedActionObservation.Stderr -match 'live D54 Campaign controller capability' -and
        $productFirstObservation.ExitCode -eq 86 -and
        $productFirstObservation.Stderr -match 'segment order requires canary, not product' -and
        $earlyTerminalObservation.ExitCode -eq 86 -and
        $earlyTerminalObservation.Stderr -match 'terminal validation requires a recorded segment failure or all segments completed' -and
        $initialCompletionUsesStaticPass -and
        $failedSegmentAwaitsTerminal -and
        $terminalRequiresReachedControllerState -and
        $canaryPolicy.Count -eq 3 -and
        [string]$canaryPolicy[-1].NextPhase -ceq '' -and
        $productPolicy.Count -eq 12 -and
        [long]$productPolicy[0].SegmentOrdinal -eq 1 -and
        [string]$productPolicy[-1].NextPhase -ceq '' -and
        $assessorPolicy.Count -eq 1 -and
        [long]$assessorPolicy[0].SegmentOrdinal -eq 1
    Add-Check -Name 'authorization-lifecycle-positive' -Passed $lifecyclePositive `
        -Expectation 'the tracked runner exposes one hash-bound six-state D54 lifecycle, uses the explicitly contract-bound nested evidence root independently from the carrier root, keeps action authority in one live Campaign controller across segments and through failed-segment terminal closeout, uses static validation before recording each initial phase fingerprint and live validation afterward, permits terminal validation only after a recorded segment failure or all three segment completions, validates every terminal predecessor chain plus the exact 56/56 through post-freeze Campaign activation and assessor-eligibility evidence chain, preserves a non-default receipt-age contract, rejects a mismatched evidence root, an early terminal command, a forged failure terminal, self-consistent diagnostic JSON and product-first dispatch without live canary completion, accepted terminal evidence without action provenance, a disposition inconsistent with its predecessor state, an incomplete twelve-route product ledger, and an ineligible assessor, and separates canary, product, and assessor dispatch segments' `
        -Observation $lifecycleObservation

    foreach ($negative in @(
        [pscustomobject]@{
            Name = 'wrong-qualification-state'
            Target = 'Qualification'
            Mutation = { param($record) $record.state = 'FREEZE_PENDING_AFTER_CANARIES' }
        },
        [pscustomobject]@{
            Name = 'wrong-canary-transition'
            Target = 'Canary'
            Mutation = { param($record) $record.previous_state = 'ZERO_MODEL_QUALIFICATION_PENDING' }
        },
        [pscustomobject]@{
            Name = 'wrong-freeze-state'
            Target = 'Freeze'
            Mutation = { param($record) $record.state = 'FREEZE_PENDING_AFTER_CANARIES' }
        },
        [pscustomobject]@{
            Name = 'wrong-activation-state'
            Target = 'Activation'
            Mutation = { param($record) $record.previous_state = 'FREEZE_PENDING_AFTER_CANARIES' }
        },
        [pscustomobject]@{
            Name = 'stale-qualification-threshold'
            Target = 'Qualification'
            Mutation = {
                param($record)
                $record.qualification.passed = 23
                $record.qualification.total = 23
            }
        },
        [pscustomobject]@{
            Name = 'predecessor-state-leakage'
            Target = 'Activation'
            Mutation = {
                param($record)
                $record | Add-Member -NotePropertyName legacy_state `
                    -NotePropertyValue 'PENDING_D52_TRACKED_OUTER_QUALIFICATION'
            }
        },
        [pscustomobject]@{
            Name = 'lifecycle-policy-hash-mismatch'
            Target = 'Qualification'
            Mutation = { param($record) $record.authorization_lifecycle_policy_sha256 = '0' * 64 }
        }
    )) {
        $negativeCase = Invoke-LifecycleNegative `
            -Name $negative.Name `
            -Target $negative.Target `
            -Mutation $negative.Mutation
        $negativeResult = $negativeCase.Result
        Add-Check -Name $negative.Name -Passed (
            $negativeResult.ExitCode -eq 86 -and
            $negativeResult.Stderr -match 'lifecycle|qualification|Canary|Freeze|activation|predecessor-only' -and
            $negativeResult.Stdout -cnotmatch 'UNEXPECTED_CHILD_START' -and
            -not (Test-Path -LiteralPath $negativeCase.ReceiptPath) -and
            -not (Test-Path -LiteralPath $negativeCase.StatePath)
        ) -Expectation 'a malformed, stale, predecessor-only, or hash-mismatched lifecycle fails before receipt issuance and child start' `
            -Observation $negativeResult
    }

    $positiveRoot = New-Case -Name 'outer-positive'
    $positiveReceipt = Join-Path $positiveRoot 'receipt.json'
    $positiveState = Join-Path $positiveRoot 'state.json'
    $nextRoot = Join-Path $positiveRoot 'next-phase'
    [void](New-Item -ItemType Directory -Path $nextRoot)
    $nextReceipt = Join-Path $nextRoot 'receipt.json'
    $nextState = Join-Path $nextRoot 'state.json'
    $childArgv = New-Argv -CaseRoot $positiveRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "[Console]::Out.Write('CHILD_OUT'); [Console]::Error.Write('CHILD_ERR'); exit 0"
    )
    $nextArgv = New-Argv -CaseRoot $nextRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "[Console]::Out.Write('NEXT_OUT'); exit 0"
    )
    $nextBinding = New-Binding `
        -CaseRoot $nextRoot `
        -ChildArgumentsPath $nextArgv `
        -ChildOperationId 'd52-test-powershell-next-positive' `
        -Phase 'qualification-next'
    $nextDispatchPath = Join-Path $positiveRoot 'next-dispatch.json'
    Write-Json -Path $nextDispatchPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-next-dispatch/v1'
        binding_path = $nextBinding
        authority_snapshot_path = Join-Path $nextRoot 'authority-snapshot.json'
        carrier_manifest_path = Join-Path $nextRoot 'carrier-manifest.json'
        frozen_inputs_path = Join-Path $nextRoot 'frozen-inputs.json'
        receipt_path = $nextReceipt
        dispatch_state_path = $nextState
        expected_phase = 'qualification-next'
        child_executable_path = $pwshPath
        child_operation_id = 'd52-test-powershell-next-positive'
        child_executable_anchor_id = 'd52-powershell-current'
        child_arguments_path = $nextArgv
        child_working_directory = $PSScriptRoot
        next_dispatch_path = $null
    })
    $positiveBinding = New-Binding `
        -CaseRoot $positiveRoot `
        -ChildArgumentsPath $childArgv `
        -ChildOperationId 'd52-test-powershell-outer-positive' `
        -NextDispatchPath $nextDispatchPath
    $positiveArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $positiveBinding `
        -ReceiptPath $positiveReceipt `
        -StatePath $positiveState `
        -ChildArgumentsPath $childArgv `
        -ChildOperationId 'd52-test-powershell-outer-positive' `
        -NextDispatchPath $nextDispatchPath
    $positive = Invoke-Captured -Arguments $positiveArguments
    $positiveRecord = Get-Content -Raw -Encoding UTF8 $positiveState | ConvertFrom-Json
    $nextRecord = if (Test-Path -LiteralPath $nextState -PathType Leaf) {
        Get-Content -Raw -Encoding UTF8 $nextState | ConvertFrom-Json
    }
    else { $null }
    Add-Check -Name 'outer-positive' -Passed (
        $positive.ExitCode -eq 0 -and
        $positive.Stdout -ceq 'CHILD_OUTNEXT_OUT' -and
        $positive.Stderr -ceq 'CHILD_ERR' -and
        [int]$positiveRecord.child_exit_code -eq 0 -and
        [int]$positiveRecord.next_dispatch_count -eq 1 -and
        [int]$positiveRecord.next_exit_code -eq 0 -and
        [string]$positiveRecord.status -ceq 'completed' -and
        [bool]$nextRecord.receipt_consumed -eq $true -and
        [int]$nextRecord.child_exit_code -eq 0 -and
        [string]$nextRecord.status -ceq 'completed'
    ) -Expectation 'outer path preserves separate streams, consumes one typed zero exit, and dispatches next exactly once' -Observation $positive

    $snapshotRoot = New-Case -Name 'argv-snapshot'
    $snapshotReceipt = Join-Path $snapshotRoot 'receipt.json'
    $snapshotState = Join-Path $snapshotRoot 'state.json'
    $snapshotMarker = Join-Path $snapshotRoot 'mutation-complete.txt'
    $snapshotArgv = New-Argv -CaseRoot $snapshotRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "Start-Sleep -Milliseconds 150; [Console]::Out.Write('BOUND_ARG'); exit 0"
    )
    $snapshotOriginalHash = Get-Sha256 -Path $snapshotArgv
    $snapshotBinding = New-Binding `
        -CaseRoot $snapshotRoot `
        -ChildArgumentsPath $snapshotArgv `
        -ChildOperationId 'd52-test-powershell-snapshot'
    $snapshotArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $snapshotBinding `
        -ReceiptPath $snapshotReceipt `
        -StatePath $snapshotState `
        -ChildArgumentsPath $snapshotArgv `
        -ChildOperationId 'd52-test-powershell-snapshot'
    $snapshotWatcher = Start-ArgumentMutationWatcher `
        -ReceiptPath $snapshotReceipt `
        -ArgumentsPath $snapshotArgv `
        -MutationMarkerPath $snapshotMarker `
        -MutatedArguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            "[Console]::Out.Write('MUTATED_ARG'); exit 0"
        )
    $snapshot = Invoke-Captured -Arguments $snapshotArguments
    $snapshotWatcherResult = Complete-ArgumentMutationWatcher -Watcher $snapshotWatcher
    $snapshotRecord = Get-Content -Raw -Encoding UTF8 $snapshotState | ConvertFrom-Json
    Add-Check -Name 'argv-snapshot' -Passed (
        $snapshot.ExitCode -eq 0 -and
        $snapshot.Stdout -ceq 'BOUND_ARG' -and
        $snapshot.Stdout -cnotmatch 'MUTATED_ARG' -and
        $snapshotWatcherResult.ExitCode -eq 0 -and
        $snapshotWatcherResult.Stderr -ceq '' -and
        (Get-Sha256 -Path $snapshotArgv) -cne $snapshotOriginalHash -and
        [int]$snapshotRecord.child_exit_code -eq 0 -and
        [string]$snapshotRecord.status -ceq 'completed'
    ) -Expectation 'argv is one bound byte snapshot before receipt consumption and later path mutation cannot alter the launched child' -Observation $snapshot

    $nonzeroRoot = New-Case -Name 'child-nonzero'
    $nonzeroReceipt = Join-Path $nonzeroRoot 'receipt.json'
    $nonzeroState = Join-Path $nonzeroRoot 'state.json'
    $nonzeroNextRoot = Join-Path $nonzeroRoot 'next-phase'
    [void](New-Item -ItemType Directory -Path $nonzeroNextRoot)
    $nonzeroNextReceipt = Join-Path $nonzeroNextRoot 'receipt.json'
    $nonzeroNextState = Join-Path $nonzeroNextRoot 'state.json'
    $nonzeroArgv = New-Argv -CaseRoot $nonzeroRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "[Console]::Out.Write('NONZERO_OUT'); [Console]::Error.Write('NONZERO_ERR'); exit 37"
    )
    $nonzeroNextArgv = New-Argv -CaseRoot $nonzeroNextRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
    )
    $nonzeroNextBinding = New-Binding `
        -CaseRoot $nonzeroNextRoot `
        -ChildArgumentsPath $nonzeroNextArgv `
        -ChildOperationId 'd52-test-powershell-unexpected' `
        -Phase 'qualification-next'
    $nonzeroNextDispatchPath = Join-Path $nonzeroRoot 'next-dispatch.json'
    Write-Json -Path $nonzeroNextDispatchPath -Value ([ordered]@{
        schema_version = 'work-charter-d54-next-dispatch/v1'
        binding_path = $nonzeroNextBinding
        authority_snapshot_path = Join-Path $nonzeroNextRoot 'authority-snapshot.json'
        carrier_manifest_path = Join-Path $nonzeroNextRoot 'carrier-manifest.json'
        frozen_inputs_path = Join-Path $nonzeroNextRoot 'frozen-inputs.json'
        receipt_path = $nonzeroNextReceipt
        dispatch_state_path = $nonzeroNextState
        expected_phase = 'qualification-next'
        child_executable_path = $pwshPath
        child_operation_id = 'd52-test-powershell-unexpected'
        child_executable_anchor_id = 'd52-powershell-current'
        child_arguments_path = $nonzeroNextArgv
        child_working_directory = $PSScriptRoot
        next_dispatch_path = $null
    })
    $nonzeroBinding = New-Binding `
        -CaseRoot $nonzeroRoot `
        -ChildArgumentsPath $nonzeroArgv `
        -ChildOperationId 'd52-test-powershell-nonzero' `
        -NextDispatchPath $nonzeroNextDispatchPath
    $nonzeroArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $nonzeroBinding `
        -ReceiptPath $nonzeroReceipt `
        -StatePath $nonzeroState `
        -ChildArgumentsPath $nonzeroArgv `
        -ChildOperationId 'd52-test-powershell-nonzero' `
        -NextDispatchPath $nonzeroNextDispatchPath
    $nonzero = Invoke-Captured -Arguments $nonzeroArguments
    $nonzeroRecord = Get-Content -Raw -Encoding UTF8 $nonzeroState | ConvertFrom-Json
    Add-Check -Name 'child-nonzero' -Passed (
        $nonzero.ExitCode -eq 37 -and
        $nonzero.Stdout -ceq 'NONZERO_OUT' -and
        $nonzero.Stderr -ceq 'NONZERO_ERR' -and
        [int]$nonzeroRecord.child_exit_code -eq 37 -and
        [int]$nonzeroRecord.next_dispatch_count -eq 0 -and
        [string]$nonzeroRecord.status -ceq 'child_failed' -and
        -not (Test-Path -LiteralPath $nonzeroNextState)
    ) -Expectation 'child nonzero propagates exactly and suppresses next dispatch' -Observation $nonzero

    $emptyRoot = New-Case -Name 'empty-argv'
    $emptyExecutable = if ($IsWindows) {
        Join-Path $env:SystemRoot 'System32\whoami.exe'
    }
    else {
        '/usr/bin/true'
    }
    $emptyWorking = Split-Path -Parent $emptyExecutable
    $emptyArgv = New-Argv -CaseRoot $emptyRoot -Name 'child-argv' -Arguments @()
    $emptyBinding = New-Binding `
        -CaseRoot $emptyRoot `
        -ChildArgumentsPath $emptyArgv `
        -ChildOperationId 'd52-windows-whoami' `
        -ChildExecutablePath $emptyExecutable `
        -ChildExecutableAnchorId 'd52-windows-whoami' `
        -ChildWorkingDirectory $emptyWorking
    $emptyReceipt = Join-Path $emptyRoot 'receipt.json'
    $emptyState = Join-Path $emptyRoot 'state.json'
    $emptyArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $emptyBinding `
        -ReceiptPath $emptyReceipt `
        -StatePath $emptyState `
        -ChildArgumentsPath $emptyArgv `
        -ChildOperationId 'd52-windows-whoami' `
        -ChildExecutablePath $emptyExecutable `
        -ChildExecutableAnchorId 'd52-windows-whoami' `
        -ChildWorkingDirectory $emptyWorking
    $empty = Invoke-Captured -Arguments $emptyArguments
    $emptyRecord = Get-Content -Raw -Encoding UTF8 $emptyState | ConvertFrom-Json
    Add-Check -Name 'empty-argv' -Passed (
        $empty.ExitCode -eq 0 -and
        [int]$emptyRecord.child_exit_code -eq 0 -and
        [string]$emptyRecord.status -ceq 'completed'
    ) -Expectation 'an empty JSON argv remains an empty vector and starts the bound executable' -Observation $empty

    $singletonRoot = New-Case -Name 'singleton-argv'
    $singletonArgv = New-Argv -CaseRoot $singletonRoot -Name 'child-argv' -Arguments @(
        '-Version'
    )
    $singletonBinding = New-Binding `
        -CaseRoot $singletonRoot `
        -ChildArgumentsPath $singletonArgv `
        -ChildOperationId 'd52-powershell-version'
    $singletonReceipt = Join-Path $singletonRoot 'receipt.json'
    $singletonState = Join-Path $singletonRoot 'state.json'
    $singletonArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $singletonBinding `
        -ReceiptPath $singletonReceipt `
        -StatePath $singletonState `
        -ChildArgumentsPath $singletonArgv `
        -ChildOperationId 'd52-powershell-version'
    $singleton = Invoke-Captured -Arguments $singletonArguments
    $singletonRecord = Get-Content -Raw -Encoding UTF8 $singletonState | ConvertFrom-Json
    Add-Check -Name 'singleton-argv' -Passed (
        $singleton.ExitCode -eq 0 -and
        [int]$singletonRecord.child_exit_code -eq 0 -and
        [string]$singletonRecord.status -ceq 'completed' -and
        $singleton.Stdout -match '^PowerShell 7\.'
    ) -Expectation 'a singleton JSON argv remains one exact argument and starts the bound executable' -Observation $singleton

    $codexRoot = New-Case -Name 'codex-trust-anchor'
    $codexExecutable = Get-D54CodexAnchorPath
    $codexWorking = Split-Path -Parent $codexExecutable
    $codexArgv = New-Argv -CaseRoot $codexRoot -Name 'child-argv' -Arguments @(
        '--version'
    )
    $codexBinding = New-Binding `
        -CaseRoot $codexRoot `
        -ChildArgumentsPath $codexArgv `
        -ChildOperationId 'd52-codex-version' `
        -ChildExecutablePath $codexExecutable `
        -ChildExecutableAnchorId 'd52-codex-app-server-0.147.0-alpha.6.6' `
        -ChildWorkingDirectory $codexWorking
    $codexReceipt = Join-Path $codexRoot 'receipt.json'
    $codexState = Join-Path $codexRoot 'state.json'
    $codexArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $codexBinding `
        -ReceiptPath $codexReceipt `
        -StatePath $codexState `
        -ChildArgumentsPath $codexArgv `
        -ChildOperationId 'd52-codex-version' `
        -ChildExecutablePath $codexExecutable `
        -ChildExecutableAnchorId 'd52-codex-app-server-0.147.0-alpha.6.6' `
        -ChildWorkingDirectory $codexWorking
    $codex = Invoke-Captured -Arguments $codexArguments
    $codexRecord = Get-Content -Raw -Encoding UTF8 $codexState | ConvertFrom-Json
    Add-Check -Name 'codex-trust-anchor' -Passed (
        $codex.ExitCode -eq 0 -and
        $codex.Stdout.Trim() -ceq 'codex-cli 0.147.0-alpha.6.6' -and
        [int]$codexRecord.child_exit_code -eq 0 -and
        [string]$codexRecord.status -ceq 'completed'
    ) -Expectation 'the exact signed and hash-pinned D54 Codex executable round-trips through the tracked runner without a model call' -Observation $codex

    $appServerRoot = New-Case -Name 'app-server-zero-model-qualification'
    $appServerArgv = New-Argv -CaseRoot $appServerRoot -Name 'child-argv' -Arguments @(
        'app-server', '--stdio'
    )
    $appServerBinding = New-Binding `
        -CaseRoot $appServerRoot `
        -ChildArgumentsPath $appServerArgv `
        -ChildOperationId 'd52-codex-app-server' `
        -ChildExecutablePath $codexExecutable `
        -ChildExecutableAnchorId 'd52-codex-app-server-0.147.0-alpha.6.6' `
        -ChildWorkingDirectory $codexWorking `
        -Phase 'runner-zero-model-qualification' `
        -ModelContexts 0 `
        -TurnStarts 0
    $appServerReceipt = Join-Path $appServerRoot 'receipt.json'
    $appServerState = Join-Path $appServerRoot 'state.json'
    $appServerArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $appServerBinding `
        -ReceiptPath $appServerReceipt `
        -StatePath $appServerState `
        -ChildArgumentsPath $appServerArgv `
        -ChildOperationId 'd52-codex-app-server' `
        -ChildExecutablePath $codexExecutable `
        -ChildExecutableAnchorId 'd52-codex-app-server-0.147.0-alpha.6.6' `
        -ChildWorkingDirectory $codexWorking `
        -ExpectedPhase 'runner-zero-model-qualification'
    $initializeRequest = [ordered]@{
        id = 0
        method = 'initialize'
        params = [ordered]@{
            clientInfo = [ordered]@{
                name = 'work-charter-d52-zero-model-qualification'
                title = 'Work Charter D52 zero-model qualification'
                version = '1.0.0'
            }
        }
    } | ConvertTo-Json -Depth 10 -Compress
    $appServer = Invoke-Captured `
        -Arguments $appServerArguments `
        -InputLines @($initializeRequest) `
        -WaitForFirstResponseBeforeClose
    $appServerRecord = Get-Content -Raw -Encoding UTF8 $appServerState | ConvertFrom-Json
    $appServerResponseLines = @(
        $appServer.Stdout -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    )
    $appServerMessages = @(
        $appServerResponseLines | ForEach-Object { $_ | ConvertFrom-Json -Depth 20 }
    )
    $appServerResponses = @(
        $appServerMessages | Where-Object {
            $null -ne $_.PSObject.Properties['id'] -and [long]$_.id -eq 0
        }
    )
    $appServerUnsafeMessages = @(
        $appServerMessages | Where-Object {
            [string]$_.method -match '^(?:thread|turn)/'
        }
    )
    $appServerResponse = if ($appServerResponses.Count -eq 1) {
        $appServerResponses[0]
    }
    else { $null }
    $appServerPassed = (
        $appServer.ExitCode -eq 0 -and
        $appServer.Stderr -cnotmatch 'D54_RUNNER_REJECTED|"level":"ERROR"' -and
        $appServerResponses.Count -eq 1 -and
        $appServerUnsafeMessages.Count -eq 0 -and
        [long]$appServerResponse.id -eq 0 -and
        $null -eq $appServerResponse.error -and
        -not [string]::IsNullOrWhiteSpace([string]$appServerResponse.result.userAgent) -and
        [int]$appServerRecord.child_exit_code -eq 0 -and
        [string]$appServerRecord.status -ceq 'completed'
    )
    $appServerObservation = [pscustomobject]@{
        ExitCode = $appServer.ExitCode
        Stderr = if ($appServerPassed) { '' } else {
            "stderr=$($appServer.Stderr); stdout=$($appServer.Stdout); response_count=$($appServerResponses.Count); unsafe_count=$($appServerUnsafeMessages.Count); response_id=$([string]$appServerResponse.id); state=$($appServerRecord | ConvertTo-Json -Compress -Depth 20)"
        }
    }
    Add-Check -Name 'app-server-zero-model-qualification' -Passed $appServerPassed -Expectation 'the exact app-server operation carries one tracked initialize request and its response bidirectionally through outer and inner without thread/start or a model call' -Observation $appServerObservation

    $committedRunnerRoot = New-Case -Name 'committed-runner-binding'
    $committedRunnerArgv = New-Argv `
        -CaseRoot $committedRunnerRoot `
        -Name 'child-argv' `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
        )
    $committedRunnerBinding = New-Binding `
        -CaseRoot $committedRunnerRoot `
        -ChildArgumentsPath $committedRunnerArgv `
        -ChildOperationId 'd52-test-production-runner-binding'
    $committedRunnerReceipt = Join-Path $committedRunnerRoot 'receipt.json'
    $committedRunnerState = Join-Path $committedRunnerRoot 'state.json'
    $committedRunnerArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $committedRunnerBinding `
        -ReceiptPath $committedRunnerReceipt `
        -StatePath $committedRunnerState `
        -ChildArgumentsPath $committedRunnerArgv `
        -ChildOperationId 'd52-test-production-runner-binding'
    $committedRunner = Invoke-Captured -Arguments $committedRunnerArguments
    Add-Check -Name 'committed-runner-binding' -Passed (
        $committedRunner.ExitCode -eq 86 -and
        $committedRunner.Stderr -match 'committed identity|committed runner commit and blob|working bytes' -and
        $committedRunner.Stdout -cnotmatch 'UNEXPECTED_CHILD_START' -and
        -not (Test-Path -LiteralPath $committedRunnerReceipt) -and
        -not (Test-Path -LiteralPath $committedRunnerState)
    ) -Expectation 'a self-hashed working runner cannot issue a production receipt unless HEAD, the committed blob, the binding, and the carrier all identify the same bytes' -Observation $committedRunner

    $forgedAuthorizationRoot = New-Case -Name 'forged-production-authorization'
    $forgedAuthorizationArgv = New-Argv `
        -CaseRoot $forgedAuthorizationRoot `
        -Name 'child-argv' `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
        )
    $forgedAuthorizationBinding = New-Binding `
        -CaseRoot $forgedAuthorizationRoot `
        -ChildArgumentsPath $forgedAuthorizationArgv `
        -ChildOperationId 'd52-test-powershell-unexpected' `
        -Phase 'canary-sol-high'
    $forgedAuthorizationReceipt = Join-Path $forgedAuthorizationRoot 'receipt.json'
    $forgedAuthorizationState = Join-Path $forgedAuthorizationRoot 'state.json'
    $forgedAuthorizationArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $forgedAuthorizationBinding `
        -ReceiptPath $forgedAuthorizationReceipt `
        -StatePath $forgedAuthorizationState `
        -ChildArgumentsPath $forgedAuthorizationArgv `
        -ChildOperationId 'd52-test-powershell-unexpected' `
        -ExpectedPhase 'canary-sol-high'
    $forgedAuthorization = Invoke-Captured -Arguments $forgedAuthorizationArguments
    $forgedAdapterRoot = New-Case -Name 'forged-production-test-adapter'
    $forgedAdapterArgv = New-Argv `
        -CaseRoot $forgedAdapterRoot `
        -Name 'child-argv' `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            $protocolAdapterCommand
        )
    $forgedAdapterBinding = New-Binding `
        -CaseRoot $forgedAdapterRoot `
        -ChildArgumentsPath $forgedAdapterArgv `
        -ChildOperationId 'd52-test-protocol-adapter' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $PSScriptRoot `
        -Phase 'canary-sol-high'
    $forgedAdapterReceipt = Join-Path $forgedAdapterRoot 'receipt.json'
    $forgedAdapterState = Join-Path $forgedAdapterRoot 'state.json'
    $forgedAdapterArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $forgedAdapterBinding `
        -ReceiptPath $forgedAdapterReceipt `
        -StatePath $forgedAdapterState `
        -ChildArgumentsPath $forgedAdapterArgv `
        -ChildOperationId 'd52-test-protocol-adapter' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $PSScriptRoot `
        -ExpectedPhase 'canary-sol-high'
    $forgedAdapter = Invoke-Captured -Arguments $forgedAdapterArguments
    Add-Check -Name 'forged-production-authorization' -Passed (
        $forgedAuthorization.ExitCode -eq 86 -and
        $forgedAuthorization.Stderr -match 'excluded from the committed D54 production policy' -and
        $forgedAuthorization.Stdout -cnotmatch 'UNEXPECTED_CHILD_START' -and
        -not (Test-Path -LiteralPath $forgedAuthorizationReceipt) -and
        -not (Test-Path -LiteralPath $forgedAuthorizationState) -and
        $forgedAdapter.ExitCode -eq 86 -and
        $forgedAdapter.Stderr -match 'excluded from the committed D54 production policy' -and
        -not (Test-Path -LiteralPath $forgedAdapterReceipt) -and
        -not (Test-Path -LiteralPath $forgedAdapterState)
    ) -Expectation 'mutually self-hashed artifacts and synthetic protocol adapters cannot invent or execute a production phase, route, budget, or successor outside the committed D54 Codex policy' -Observation $(if ($forgedAdapter.ExitCode -eq 86) { $forgedAuthorization } else { $forgedAdapter })

    $productionInputRoot = New-Case -Name 'production-input-policy'
    $productionInputArgv = New-Argv `
        -CaseRoot $productionInputRoot `
        -Name 'child-argv' `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            $protocolAdapterCommand
        )
    $productionInputBinding = New-Binding `
        -CaseRoot $productionInputRoot `
        -ChildArgumentsPath $productionInputArgv `
        -ChildOperationId 'd52-test-protocol-adapter' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $PSScriptRoot `
        -Phase 'runner-zero-model-qualification' `
        -ModelContexts 0 `
        -TurnStarts 0
    $productionInputReceipt = Join-Path $productionInputRoot 'receipt.json'
    $productionInputState = Join-Path $productionInputRoot 'state.json'
    $productionInputArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $productionInputBinding `
        -ReceiptPath $productionInputReceipt `
        -StatePath $productionInputState `
        -ChildArgumentsPath $productionInputArgv `
        -ChildOperationId 'd52-test-protocol-adapter' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $PSScriptRoot `
        -ExpectedPhase 'runner-zero-model-qualification'
    $productionInitialize = [ordered]@{
        id = 0; method = 'initialize'; params = [ordered]@{
            clientInfo = [ordered]@{
                name = 'work-charter-d54-carrier'; title = 'Work Charter D54 carrier'; version = '1.0.0'
            }
        }
    } | ConvertTo-Json -Depth 10 -Compress
    $wrongModelThreadStart = [ordered]@{
        id = 1; method = 'thread/start'; params = [ordered]@{
            model = 'gpt-5.6-sol'; allowProviderModelFallback = $false
        }
    } | ConvertTo-Json -Depth 10 -Compress
    $productionInput = Invoke-Captured `
        -Arguments $productionInputArguments `
        -InputLines @($productionInitialize, $wrongModelThreadStart)
    Add-Check -Name 'production-input-policy' -Passed (
        $productionInput.ExitCode -eq 86 -and
        $productionInput.Stderr -match 'Production thread/start does not match' -and
        -not ($productionInput.Stdout -match 'turn/started|turn/start')
    ) -Expectation 'a receipt-bound app-server route rejects a wrong-model thread/start before any turn/start can be forwarded or consumed' -Observation $productionInput

    $productionProtocolRoot = New-Case -Name 'production-protocol-positive'
    $productionProtocolArgv = New-Argv `
        -CaseRoot $productionProtocolRoot `
        -Name 'child-argv' `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            $protocolAdapterCommand
        )
    $productionProtocolBinding = New-Binding `
        -CaseRoot $productionProtocolRoot `
        -ChildArgumentsPath $productionProtocolArgv `
        -ChildOperationId 'd52-test-protocol-adapter' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $PSScriptRoot `
        -Phase 'runner-zero-model-qualification' `
        -ModelContexts 0 `
        -TurnStarts 0
    $productionProtocolReceipt = Join-Path $productionProtocolRoot 'receipt.json'
    $productionProtocolState = Join-Path $productionProtocolRoot 'state.json'
    $productionProtocolArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $productionProtocolBinding `
        -ReceiptPath $productionProtocolReceipt `
        -StatePath $productionProtocolState `
        -ChildArgumentsPath $productionProtocolArgv `
        -ChildOperationId 'd52-test-protocol-adapter' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $PSScriptRoot `
        -ExpectedPhase 'runner-zero-model-qualification'
    $productionThreadStart = [ordered]@{
        id = 1; method = 'thread/start'; params = [ordered]@{
            model = 'gpt-5.6-terra'; allowProviderModelFallback = $false
        }
    } | ConvertTo-Json -Depth 10 -Compress
    $productionTurnStart = [ordered]@{
        id = 2; method = 'turn/start'; params = [ordered]@{
            threadId = 'd52-sim-thread'
            model = 'gpt-5.6-terra'
            effort = 'high'
            input = @([ordered]@{ type = 'text'; text = 'zero-model simulated prompt' })
        }
    } | ConvertTo-Json -Depth 10 -Compress
    $productionPhaseComplete = [ordered]@{
        d52_control = 'phase_complete'; phase = 'assessor-terra-high'
    } | ConvertTo-Json -Compress

    $segmentRoot = New-Case -Name 'production-protocol-segment'
    $segmentPolicies = @(Get-ProtocolQualificationPolicy)
    $segmentPhases = @{}
    foreach ($policy in $segmentPolicies) {
        $phaseRoot = Join-Path $segmentRoot $policy.DirectoryName
        [void](New-Item -ItemType Directory -Path $phaseRoot)
        $phaseArgv = New-Argv `
            -CaseRoot $phaseRoot `
            -Name 'child-argv' `
            -Arguments @(
                '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
                $protocolAdapterCommand
            )
        $segmentPhases[$policy.Phase] = [ordered]@{
            Policy = $policy
            Root = $phaseRoot
            Argv = $phaseArgv
            Receipt = Join-Path $phaseRoot 'receipt.json'
            State = Join-Path $phaseRoot 'dispatch-state.json'
            Binding = $null
            Next = ''
        }
    }
    for ($index = $segmentPolicies.Count - 1; $index -ge 0; $index--) {
        $policy = $segmentPolicies[$index]
        $phase = $segmentPhases[$policy.Phase]
        if ($index + 1 -lt $segmentPolicies.Count) {
            $nextPolicy = $segmentPolicies[$index + 1]
            $next = $segmentPhases[$nextPolicy.Phase]
            $phase.Next = Join-Path $phase.Root 'next-dispatch.json'
            Write-Json -Path $phase.Next -Value ([ordered]@{
                schema_version = 'work-charter-d54-next-dispatch/v1'
                binding_path = $next.Binding
                authority_snapshot_path = Join-Path $next.Root 'authority-snapshot.json'
                carrier_manifest_path = Join-Path $next.Root 'carrier-manifest.json'
                frozen_inputs_path = Join-Path $next.Root 'frozen-inputs.json'
                receipt_path = $next.Receipt
                dispatch_state_path = $next.State
                expected_phase = $nextPolicy.Phase
                child_executable_path = $pwshPath
                child_operation_id = 'd52-test-protocol-adapter'
                child_executable_anchor_id = 'd52-powershell-current'
                child_arguments_path = $next.Argv
                child_working_directory = $next.Root
                next_dispatch_path = $next.Next
            })
        }
        $phase.Binding = New-Binding `
            -CaseRoot $phase.Root `
            -ChildArgumentsPath $phase.Argv `
            -ChildOperationId 'd52-test-protocol-adapter' `
            -ChildExecutablePath $pwshPath `
            -ChildExecutableAnchorId 'd52-powershell-current' `
            -ChildWorkingDirectory $phase.Root `
            -NextDispatchPath $phase.Next `
            -Phase $policy.Phase `
            -ModelContexts $policy.RemainingContexts `
            -TurnStarts $policy.RemainingTurns
    }
    $segmentInput = [System.Collections.Generic.List[string]]::new()
    for ($index = 0; $index -lt $segmentPolicies.Count; $index++) {
        $policy = $segmentPolicies[$index]
        $requestBase = 100 + ($index * 10)
        $segmentInput.Add(([ordered]@{
            id = $requestBase
            method = 'initialize'
            params = [ordered]@{
                clientInfo = [ordered]@{
                    name = 'work-charter-d54-carrier'
                    title = 'Work Charter D54 carrier'
                    version = '1.0.0'
                }
            }
        } | ConvertTo-Json -Depth 10 -Compress))
        $segmentInput.Add(([ordered]@{
            id = $requestBase + 1
            method = 'thread/start'
            params = [ordered]@{
                model = $policy.Model
                allowProviderModelFallback = $false
            }
        } | ConvertTo-Json -Depth 10 -Compress))
        for ($turn = 0; $turn -lt [long]$policy.TurnStarts; $turn++) {
            $segmentInput.Add(([ordered]@{
                id = $requestBase + 2 + $turn
                method = 'turn/start'
                params = [ordered]@{
                    threadId = 'd52-sim-thread'
                    model = $policy.Model
                    effort = $policy.Effort
                    input = @([ordered]@{
                        type = 'text'
                        text = "zero-model segment prompt $($policy.Phase)"
                    })
                }
            } | ConvertTo-Json -Depth 10 -Compress))
        }
        $segmentInput.Add(([ordered]@{
            d52_control = 'phase_complete'
            phase = $policy.Phase
        } | ConvertTo-Json -Compress))
    }
    $segmentFirst = $segmentPhases[$segmentPolicies[0].Phase]
    $segmentArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $segmentFirst.Binding `
        -ReceiptPath $segmentFirst.Receipt `
        -StatePath $segmentFirst.State `
        -ChildArgumentsPath $segmentFirst.Argv `
        -ChildOperationId 'd52-test-protocol-adapter' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $segmentFirst.Root `
        -ExpectedPhase $segmentPolicies[0].Phase `
        -NextDispatchPath $segmentFirst.Next
    $segmentProtocol = Invoke-Captured `
        -Arguments $segmentArguments `
        -InputLines $segmentInput.ToArray()
    $segmentStatesPass = $segmentProtocol.ExitCode -eq 0 -and
        [string]::IsNullOrEmpty($segmentProtocol.Stderr)
    foreach ($policy in $segmentPolicies) {
        $phase = $segmentPhases[$policy.Phase]
        $phaseState = if (Test-Path -LiteralPath $phase.State -PathType Leaf) {
            Get-Content -LiteralPath $phase.State -Raw -Encoding UTF8 |
                ConvertFrom-Json -Depth 20
        }
        else { $null }
        $segmentStatesPass = $segmentStatesPass -and
            $null -ne $phaseState -and
            [string]$phaseState.status -ceq 'completed' -and
            [long]$phaseState.child_exit_code -eq 0 -and
            [long]$phaseState.next_dispatch_count -eq
                $(if ([string]::IsNullOrEmpty($policy.NextPhase)) { 0 } else { 1 }) -and
            (Test-Path -LiteralPath ($phase.Receipt + '.consumed') -PathType Leaf)
    }
    $productionProtocol = Invoke-Captured `
        -Arguments $productionProtocolArguments `
        -InputLines @(
            $productionInitialize, $productionThreadStart,
            $productionTurnStart, $productionPhaseComplete
        )
    $productionProtocolRecord = Get-Content -Raw -Encoding UTF8 $productionProtocolState | ConvertFrom-Json
    Add-Check -Name 'production-protocol-positive' -Passed (
        $productionProtocol.ExitCode -eq 0 -and
        [int]$productionProtocolRecord.child_exit_code -eq 0 -and
        [string]$productionProtocolRecord.status -ceq 'completed' -and
        [int]$productionProtocolRecord.next_dispatch_count -eq 0 -and
        $segmentStatesPass
    ) -Expectation 'the protocol adapter forwards one authorized request stream per phase, completes a three-phase test-only qualification segment through the same outer reader with separate one-shot receipts and typed-zero states, and returns without a real model call or production-phase receipt' -Observation $(if ($segmentStatesPass) { $productionProtocol } else { $segmentProtocol })

    $failedCompletionRoot = New-Case -Name 'production-failed-completion'
    $failedCompletionArgv = New-Argv `
        -CaseRoot $failedCompletionRoot `
        -Name 'child-argv' `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            $failedProtocolAdapterCommand
        )
    $failedCompletionBinding = New-Binding `
        -CaseRoot $failedCompletionRoot `
        -ChildArgumentsPath $failedCompletionArgv `
        -ChildOperationId 'd52-test-protocol-failed-completion' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $PSScriptRoot `
        -Phase 'runner-zero-model-qualification' `
        -ModelContexts 0 `
        -TurnStarts 0
    $failedCompletionReceipt = Join-Path $failedCompletionRoot 'receipt.json'
    $failedCompletionState = Join-Path $failedCompletionRoot 'state.json'
    $failedCompletionArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $failedCompletionBinding `
        -ReceiptPath $failedCompletionReceipt `
        -StatePath $failedCompletionState `
        -ChildArgumentsPath $failedCompletionArgv `
        -ChildOperationId 'd52-test-protocol-failed-completion' `
        -ChildExecutablePath $pwshPath `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $PSScriptRoot `
        -ExpectedPhase 'runner-zero-model-qualification'
    $failedCompletion = Invoke-Captured `
        -Arguments $failedCompletionArguments `
        -InputLines @(
            $productionInitialize, $productionThreadStart,
            $productionTurnStart, $productionPhaseComplete
        )
    $failedCompletionRecord = if (Test-Path -LiteralPath $failedCompletionState -PathType Leaf) {
        Get-Content -Raw -Encoding UTF8 $failedCompletionState | ConvertFrom-Json
    }
    else { $null }
    Add-Check -Name 'production-failed-completion' -Passed (
        $failedCompletion.ExitCode -eq 86 -and
        $failedCompletion.Stderr -match 'turn did not complete successfully' -and
        [string]$failedCompletionRecord.status -cne 'completed' -and
        [int]$failedCompletionRecord.next_dispatch_count -eq 0
    ) -Expectation 'a failed terminal turn notification rejects the phase before phase-complete can advance or dispatch a successor' -Observation $failedCompletion

    $wrongAnchorRoot = New-Case -Name 'wrong-executable-anchor'
    $wrongAnchorArgv = New-Argv -CaseRoot $wrongAnchorRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "[Console]::Out.Write('CHILD_OUT'); [Console]::Error.Write('CHILD_ERR'); exit 0"
    )
    $wrongAnchorBinding = New-Binding `
        -CaseRoot $wrongAnchorRoot `
        -ChildArgumentsPath $wrongAnchorArgv `
        -ChildOperationId 'd52-test-powershell-outer-positive' `
        -ChildExecutablePath $emptyExecutable `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $emptyWorking
    $wrongAnchorReceipt = Join-Path $wrongAnchorRoot 'receipt.json'
    $wrongAnchorState = Join-Path $wrongAnchorRoot 'state.json'
    $wrongAnchorArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $wrongAnchorBinding `
        -ReceiptPath $wrongAnchorReceipt `
        -StatePath $wrongAnchorState `
        -ChildArgumentsPath $wrongAnchorArgv `
        -ChildOperationId 'd52-test-powershell-outer-positive' `
        -ChildExecutablePath $emptyExecutable `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $emptyWorking
    $wrongAnchor = Invoke-Captured -Arguments $wrongAnchorArguments
    Add-Check -Name 'wrong-executable-anchor' -Passed (
        $wrongAnchor.ExitCode -eq 86 -and
        $wrongAnchor.Stderr -match 'path does not match its authenticated trust anchor' -and
        -not (Test-Path -LiteralPath $wrongAnchorReceipt) -and
        -not (Test-Path -LiteralPath $wrongAnchorState)
    ) -Expectation 'a valid but wrong executable cannot self-authorize under another trust anchor' -Observation $wrongAnchor

    $shadowRoot = New-Case -Name 'shadow-executable'
    $shadowExecutable = Join-Path $shadowRoot 'pwsh.exe'
    [System.IO.File]::WriteAllText($shadowExecutable, 'not an executable', $strictUtf8)
    $shadowArgv = New-Argv -CaseRoot $shadowRoot -Name 'child-argv' -Arguments @(
        '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
        "[Console]::Out.Write('CHILD_OUT'); [Console]::Error.Write('CHILD_ERR'); exit 0"
    )
    $shadowBinding = New-Binding `
        -CaseRoot $shadowRoot `
        -ChildArgumentsPath $shadowArgv `
        -ChildOperationId 'd52-test-powershell-outer-positive' `
        -ChildExecutablePath $shadowExecutable `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $shadowRoot
    $shadowReceipt = Join-Path $shadowRoot 'receipt.json'
    $shadowState = Join-Path $shadowRoot 'state.json'
    $shadowArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $shadowBinding `
        -ReceiptPath $shadowReceipt `
        -StatePath $shadowState `
        -ChildArgumentsPath $shadowArgv `
        -ChildOperationId 'd52-test-powershell-outer-positive' `
        -ChildExecutablePath $shadowExecutable `
        -ChildExecutableAnchorId 'd52-powershell-current' `
        -ChildWorkingDirectory $shadowRoot
    $shadow = Invoke-Captured -Arguments $shadowArguments
    Add-Check -Name 'shadow-executable' -Passed (
        $shadow.ExitCode -eq 86 -and
        $shadow.Stderr -match 'path does not match its authenticated trust anchor' -and
        -not (Test-Path -LiteralPath $shadowReceipt) -and
        -not (Test-Path -LiteralPath $shadowState)
    ) -Expectation 'a path-shadow executable is rejected before launch or receipt creation' -Observation $shadow

    $wrongOperationRoot = New-Case -Name 'wrong-operation-argv'
    $wrongOperationArgv = New-Argv `
        -CaseRoot $wrongOperationRoot `
        -Name 'child-argv' `
        -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            "[Console]::Out.Write('CALLER_SELECTED_ARGV'); exit 0"
        )
    $wrongOperationBinding = New-Binding `
        -CaseRoot $wrongOperationRoot `
        -ChildArgumentsPath $wrongOperationArgv `
        -ChildOperationId 'd52-test-powershell-outer-positive'
    $wrongOperationReceipt = Join-Path $wrongOperationRoot 'receipt.json'
    $wrongOperationState = Join-Path $wrongOperationRoot 'state.json'
    $wrongOperationArguments = Get-RunnerArguments `
        -Mode Outer `
        -BindingPath $wrongOperationBinding `
        -ReceiptPath $wrongOperationReceipt `
        -StatePath $wrongOperationState `
        -ChildArgumentsPath $wrongOperationArgv `
        -ChildOperationId 'd52-test-powershell-outer-positive'
    $wrongOperation = Invoke-Captured -Arguments $wrongOperationArguments
    Add-Check -Name 'wrong-operation-argv' -Passed (
        $wrongOperation.ExitCode -eq 86 -and
        $wrongOperation.Stderr -match 'does not match the tracked operation table' -and
        $wrongOperation.Stdout -cnotmatch 'CALLER_SELECTED_ARGV' -and
        -not (Test-Path -LiteralPath $wrongOperationReceipt) -and
        -not (Test-Path -LiteralPath $wrongOperationState)
    ) -Expectation 'a caller-selected but self-hashed argv fails tracked operation policy before receipt issuance' -Observation $wrongOperation

    $evidenceArtifactFailures = [System.Collections.Generic.List[string]]::new()
    foreach ($evidenceMutation in @('carrier-subject', 'frozen-phase', 'ruleset-source', 'campaign-contract')) {
        $evidenceRoot = New-Case -Name "wrong-evidence-$evidenceMutation"
        $evidenceArgv = New-Argv -CaseRoot $evidenceRoot -Name 'child-argv' -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
        )
        $evidenceBinding = New-Binding `
            -CaseRoot $evidenceRoot `
            -ChildArgumentsPath $evidenceArgv `
            -ChildOperationId 'd52-test-powershell-unexpected'
        $evidenceAuthorityPath = Join-Path $evidenceRoot 'authority-snapshot.json'
        $evidenceCarrierPath = Join-Path $evidenceRoot 'carrier-manifest.json'
        $evidenceFrozenPath = Join-Path $evidenceRoot 'frozen-inputs.json'
        switch ($evidenceMutation) {
            'carrier-subject' {
                $record = Get-Content -Raw -Encoding UTF8 $evidenceCarrierPath | ConvertFrom-Json
                $record.campaign_id = 'WC-AR-NOT-D52'
                Write-Json -Path $evidenceCarrierPath -Value $record
            }
            'frozen-phase' {
                $record = Get-Content -Raw -Encoding UTF8 $evidenceFrozenPath | ConvertFrom-Json
                $record.phase = 'wrong-phase'
                Write-Json -Path $evidenceFrozenPath -Value $record
            }
            'ruleset-source' {
                $record = Get-Content -Raw -Encoding UTF8 $evidenceAuthorityPath | ConvertFrom-Json
                $record.ruleset_sources[0].normalized_sha256 = '0' * 64
                Write-Json -Path $evidenceAuthorityPath -Value $record
            }
            'campaign-contract' {
                $record = Get-Content -Raw -Encoding UTF8 $evidenceAuthorityPath | ConvertFrom-Json
                $record.campaign_contract_path = $runnerPath
                $record.campaign_contract_sha256 = Get-Sha256 -Path $runnerPath
                Write-Json -Path $evidenceAuthorityPath -Value $record
            }
        }
        Sync-EvidenceBindingHashes -CaseRoot $evidenceRoot -BindingPath $evidenceBinding
        $evidenceReceipt = Join-Path $evidenceRoot 'receipt.json'
        $evidenceState = Join-Path $evidenceRoot 'state.json'
        $evidenceArguments = Get-RunnerArguments `
            -Mode Outer `
            -BindingPath $evidenceBinding `
            -ReceiptPath $evidenceReceipt `
            -StatePath $evidenceState `
            -ChildArgumentsPath $evidenceArgv `
            -ChildOperationId 'd52-test-powershell-unexpected'
        $evidenceResult = Invoke-Captured -Arguments $evidenceArguments
        if ($evidenceResult.ExitCode -ne 86 -or
            $evidenceResult.Stdout -cmatch 'UNEXPECTED_CHILD_START' -or
            (Test-Path -LiteralPath $evidenceReceipt) -or
            (Test-Path -LiteralPath $evidenceState)) {
            $evidenceArtifactFailures.Add(
                "$evidenceMutation`: exit=$($evidenceResult.ExitCode); stderr=$($evidenceResult.Stderr)"
            )
        }
    }
    $evidenceArtifactObservation = [pscustomobject]@{
        ExitCode = if ($evidenceArtifactFailures.Count -eq 0) { 0 } else { 1 }
        Stderr = $evidenceArtifactFailures -join "`n"
    }
    Add-Check -Name 'wrong-evidence-artifact' -Passed (
        $evidenceArtifactFailures.Count -eq 0
    ) -Expectation 'self-rehashed carrier, frozen, ruleset, or Campaign-contract evidence cannot issue a receipt unless it matches the authenticated D54 source chain' -Observation $evidenceArtifactObservation

    $staticIdentityFailures = [System.Collections.Generic.List[string]]::new()
    foreach ($identityMutation in @(
        [pscustomobject]@{ Name = 'campaign'; Field = 'campaign_id'; Value = 'WC-AR-NOT-D52' },
        [pscustomobject]@{ Name = 'subject'; Field = 'stable_subject'; Value = 'another subject' },
        [pscustomobject]@{ Name = 'commit'; Field = 'candidate_commit'; Value = ('0' * 40) },
        [pscustomobject]@{ Name = 'manifest'; Field = 'candidate_manifest_sha256'; Value = ('0' * 64) }
    )) {
        $identityRoot = New-Case -Name "wrong-static-identity-$($identityMutation.Name)"
        $identityArgv = New-Argv -CaseRoot $identityRoot -Name 'child-argv' -Arguments @(
            '-NoLogo', '-NoProfile', '-NonInteractive', '-Command',
            "[Console]::Out.Write('UNEXPECTED_CHILD_START'); exit 0"
        )
        $identityBinding = New-Binding `
            -CaseRoot $identityRoot `
            -ChildArgumentsPath $identityArgv `
            -ChildOperationId 'd52-test-powershell-unexpected'
        $identityBindingRecord = Get-Content -Raw -Encoding UTF8 $identityBinding | ConvertFrom-Json
        $identityBindingRecord.($identityMutation.Field) = $identityMutation.Value
        Write-Json -Path $identityBinding -Value $identityBindingRecord
        $identityReceipt = Join-Path $identityRoot 'receipt.json'
        $identityState = Join-Path $identityRoot 'state.json'
        $identityArguments = Get-RunnerArguments `
            -Mode Outer `
            -BindingPath $identityBinding `
            -ReceiptPath $identityReceipt `
            -StatePath $identityState `
            -ChildArgumentsPath $identityArgv `
            -ChildOperationId 'd52-test-powershell-unexpected'
        $identityResult = Invoke-Captured -Arguments $identityArguments
        if ($identityResult.ExitCode -ne 86 -or
            $identityResult.Stderr -cnotmatch 'does not match the authorized D54' -or
            $identityResult.Stdout -cmatch 'UNEXPECTED_CHILD_START' -or
            (Test-Path -LiteralPath $identityReceipt) -or
            (Test-Path -LiteralPath $identityState)) {
            $staticIdentityFailures.Add(
                "$($identityMutation.Name): exit=$($identityResult.ExitCode); stderr=$($identityResult.Stderr)"
            )
        }
    }
    $staticIdentityObservation = [pscustomobject]@{
        ExitCode = if ($staticIdentityFailures.Count -eq 0) { 0 } else { 1 }
        Stderr = $staticIdentityFailures -join "`n"
    }
    Add-Check -Name 'wrong-static-identity' -Passed (
        $staticIdentityFailures.Count -eq 0
    ) -Expectation 'campaign, stable subject, candidate commit, and candidate manifest are exact tracked policy anchors rather than caller-selected labels' -Observation $staticIdentityObservation

    $nextStateHashBeforeDuplicate = Get-Sha256 -Path $nextState
    $duplicate = Invoke-Captured -Arguments $positiveArguments
    Add-Check -Name 'duplicate-dispatch' -Passed (
        $duplicate.ExitCode -eq 86 -and
        $duplicate.Stderr -match 'Duplicate dispatch is forbidden' -and
        $duplicate.Stdout -ceq '' -and
        (Get-Sha256 -Path $nextState) -ceq $nextStateHashBeforeDuplicate
    ) -Expectation 'a claimed dispatch cannot run its child or next phase twice' -Observation $duplicate

    $directCase = New-ManualInnerCase -Name 'direct-inner'
    $direct = Invoke-InnerCase -Case $directCase
    Add-Check -Name 'direct-inner' -Passed (
        $direct.ExitCode -eq 86 -and
        $direct.Stderr -match 'no live outer object capability is present' -and
        $direct.Stdout -cnotmatch 'UNEXPECTED_CHILD_START' -and
        -not (Test-Path -LiteralPath $directCase.ChildMarker)
    ) -Expectation 'a direct inner invocation with self-forged state and receipt still lacks the live outer object capability and fails before child start' -Observation $direct

    $absentCase = Invoke-OuterReceiptNegative `
        -Name 'absent-receipt' `
        -OperationId 'd52-test-receipt-absent'
    $absent = $absentCase.Result
    Add-Check -Name 'absent-receipt' -Passed (
        $absent.ExitCode -eq 86 -and
        $absent.Stderr -match 'launch receipt' -and
        $absent.Stdout -cnotmatch 'UNEXPECTED_CHILD_START'
    ) -Expectation 'a receipt removed after authentic Outer issuance fails before child start' -Observation $absent

    $staleCase = Invoke-OuterReceiptNegative `
        -Name 'stale-receipt' `
        -OperationId 'd52-test-receipt-stale'
    $stale = $staleCase.Result
    Add-Check -Name 'stale-receipt' -Passed (
        $stale.ExitCode -eq 86 -and
        $stale.Stderr -match 'stale or from the future' -and
        $stale.Stdout -cnotmatch 'UNEXPECTED_CHILD_START'
    ) -Expectation 'a receipt made stale after authentic Outer issuance fails before child start' -Observation $stale

    $phaseCase = Invoke-OuterReceiptNegative `
        -Name 'wrong-phase' `
        -OperationId 'd52-test-receipt-wrong-phase'
    $phase = $phaseCase.Result
    Add-Check -Name 'wrong-phase' -Passed (
        $phase.ExitCode -eq 86 -and
        $phase.Stderr -match 'receipt dispatch or phase is mismatched' -and
        $phase.Stdout -cnotmatch 'UNEXPECTED_CHILD_START'
    ) -Expectation 'a receipt changed to another phase after authentic Outer issuance fails before child start' -Observation $phase

    $hashCase = Invoke-OuterReceiptNegative `
        -Name 'wrong-hash' `
        -OperationId 'd52-test-receipt-wrong-hash'
    $hash = $hashCase.Result
    Add-Check -Name 'wrong-hash' -Passed (
        $hash.ExitCode -eq 86 -and
        $hash.Stderr -match 'binding hash is mismatched' -and
        $hash.Stdout -cnotmatch 'UNEXPECTED_CHILD_START'
    ) -Expectation 'a receipt changed to the wrong frozen binding hash after authentic Outer issuance fails before child start' -Observation $hash

    $reusedCase = Invoke-OuterReceiptNegative `
        -Name 'reused-receipt' `
        -OperationId 'd52-test-receipt-reused'
    $reused = $reusedCase.Result
    Add-Check -Name 'reused-receipt' -Passed (
        $reused.ExitCode -eq 86 -and
        $reused.Stderr -match 'already consumed' -and
        $reused.Stdout -cnotmatch 'UNEXPECTED_CHILD_START'
    ) -Expectation 'a receipt marked consumed after authentic Outer issuance cannot start another child' -Observation $reused

    $failed = @($checks | Where-Object { -not $_.passed })
    [ordered]@{
        schema_version = 'work-charter-d54-runner-check/v1'
        verdict = if ($failed.Count -eq 0) { 'PASS' } else { 'FAIL' }
        passed = $checks.Count - $failed.Count
        total = $checks.Count
        checks = @($checks)
        scratch_retained = [bool]$KeepScratch
        scratch_root = if ($KeepScratch) { $scratchRoot } else { $null }
    } | ConvertTo-Json -Depth 100
    if ($failed.Count -gt 0) {
        exit 1
    }
    exit 0
}
finally {
    if (-not $KeepScratch -and (Test-Path -LiteralPath $scratchRoot)) {
        $resolvedScratch = [System.IO.Path]::GetFullPath($scratchRoot)
        $resolvedBase = [System.IO.Path]::GetFullPath($scratchBase) + [System.IO.Path]::DirectorySeparatorChar
        if (-not $resolvedScratch.StartsWith($resolvedBase, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw 'Scratch cleanup target escaped its exact test root.'
        }
        Remove-Item -LiteralPath $resolvedScratch -Recurse -Force
    }
}
