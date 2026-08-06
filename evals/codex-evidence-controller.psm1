Set-StrictMode -Version Latest

$script:ControllerSchema = 'codex-evidence-controller/v1'
$script:Modes = @('preflight', 'runtime', 'historical-import', 'terminal-stage')

function Get-ObjectValue {
    param(
        [AllowNull()]
        [object]$Object,
        [Parameter(Mandatory)]
        [string]$Name,
        [AllowNull()]
        [object]$Default = $null
    )

    if ($null -eq $Object) {
        return $Default
    }
    if ($Object -is [System.Collections.IDictionary]) {
        if ($Object.Contains($Name)) {
            return $Object[$Name]
        }
        return $Default
    }
    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return $Default
    }
    return $property.Value
}

function Get-ControllerPropertyState {
    param(
        [AllowNull()]
        [object]$Object,
        [Parameter(Mandatory)]
        [string]$Name
    )

    if ($null -eq $Object) {
        return [pscustomobject]@{ Present = $false; Value = $null }
    }
    if ($Object -is [System.Collections.IDictionary]) {
        if (-not $Object.Contains($Name)) {
            return [pscustomobject]@{ Present = $false; Value = $null }
        }
        return [pscustomobject]@{ Present = $true; Value = $Object[$Name] }
    }
    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return [pscustomobject]@{ Present = $false; Value = $null }
    }
    return [pscustomobject]@{ Present = $true; Value = $property.Value }
}

function ConvertTo-ControllerInteger {
    param([AllowNull()][object]$Value)

    if ($null -eq $Value -or $Value.GetType().FullName -notin @(
        'System.Byte',
        'System.SByte',
        'System.Int16',
        'System.UInt16',
        'System.Int32',
        'System.UInt32',
        'System.Int64',
        'System.UInt64'
    )) {
        return [pscustomobject]@{ Valid = $false; Value = [int64]0 }
    }
    try {
        $converted = [Convert]::ToInt64($Value)
    }
    catch {
        return [pscustomobject]@{ Valid = $false; Value = [int64]0 }
    }
    return [pscustomobject]@{ Valid = $true; Value = $converted }
}

function ConvertTo-ControllerCount {
    param([AllowNull()][object]$Value)

    $integer = ConvertTo-ControllerInteger -Value $Value
    if (-not $integer.Valid -or $integer.Value -lt 0) {
        return [pscustomobject]@{ Valid = $false; Value = [int64]0 }
    }
    return $integer
}

function Test-ControllerRelativePath {
    param([AllowNull()][object]$Value)

    $path = ([string]$Value).Replace('\', '/')
    $segments = @($path.Split('/'))
    return (
        -not [string]::IsNullOrWhiteSpace($path) -and
        -not $path.StartsWith('/') -and
        $path -notmatch '^[A-Za-z]:' -and
        $path -notmatch ':' -and
        @($segments | Where-Object { $_ -in @('', '.', '..') }).Count -eq 0
    )
}

function ConvertTo-ControllerContentIdentity {
    param([AllowNull()][object]$Value)

    if ($null -eq $Value) {
        return [pscustomobject]@{ Valid = $false; Normalized = $null }
    }
    $length = ConvertTo-ControllerCount -Value (
        Get-ObjectValue -Object $Value -Name 'length'
    )
    $sha256 = ([string](Get-ObjectValue -Object $Value -Name 'sha256' -Default '')).ToLowerInvariant()
    return [pscustomobject]@{
        Valid = ($length.Valid -and $sha256 -cmatch '^[0-9a-f]{64}$')
        Normalized = [ordered]@{
            length = $length.Value
            sha256 = $sha256
        }
    }
}

function ConvertTo-ControllerCandidateIdentity {
    param([AllowNull()][object]$Value)

    if ($null -eq $Value) {
        return [pscustomobject]@{ Valid = $false; Normalized = $null }
    }
    $normalized = [ordered]@{
        stable_subject = [string](Get-ObjectValue -Object $Value -Name 'stable_subject' -Default '')
        candidate_sha = ([string](Get-ObjectValue -Object $Value -Name 'candidate_sha' -Default '')).ToLowerInvariant()
        package_manifest_sha256 = ([string](Get-ObjectValue -Object $Value -Name 'package_manifest_sha256' -Default '')).ToLowerInvariant()
        relative_package_path = ([string](Get-ObjectValue -Object $Value -Name 'relative_package_path' -Default '')).Replace('\', '/')
        content_output_sha256 = ([string](Get-ObjectValue -Object $Value -Name 'content_output_sha256' -Default '')).ToLowerInvariant()
    }
    $relativePath = [string]$normalized.relative_package_path
    $segments = @($relativePath.Split('/'))
    $validRelativePath = (
        -not [string]::IsNullOrWhiteSpace($relativePath) -and
        -not $relativePath.StartsWith('/') -and
        $relativePath -notmatch '^[A-Za-z]:' -and
        $relativePath -notmatch ':' -and
        @($segments | Where-Object { $_ -in @('', '.', '..') }).Count -eq 0
    )
    $valid = (
        -not [string]::IsNullOrWhiteSpace([string]$normalized.stable_subject) -and
        [string]$normalized.candidate_sha -cmatch '^[0-9a-f]{40}$' -and
        [string]$normalized.package_manifest_sha256 -cmatch '^[0-9a-f]{64}$' -and
        $validRelativePath -and
        [string]$normalized.content_output_sha256 -cmatch '^[0-9a-f]{64}$'
    )
    return [pscustomobject]@{ Valid = $valid; Normalized = $normalized }
}

function ConvertTo-CanonicalNode {
    param([AllowNull()][object]$Value)

    if ($null -eq $Value) {
        return $null
    }
    if ($Value -is [string] -or $Value -is [char] -or
        $Value -is [bool] -or $Value -is [byte] -or
        $Value -is [int16] -or $Value -is [int32] -or
        $Value -is [int64] -or $Value -is [decimal] -or
        $Value -is [double] -or $Value -is [single]) {
        return $Value
    }

    if ($Value -is [System.Collections.IDictionary]) {
        $ordered = [ordered]@{}
        $keys = [string[]]@($Value.Keys | ForEach-Object { [string]$_ })
        [System.Array]::Sort($keys, [System.StringComparer]::Ordinal)
        foreach ($key in $keys) {
            $ordered[$key] = ConvertTo-CanonicalNode -Value $Value[$key]
        }
        return $ordered
    }

    if ($Value -is [System.Management.Automation.PSCustomObject]) {
        $ordered = [ordered]@{}
        $propertyNames = [string[]]@(
            $Value.PSObject.Properties | ForEach-Object { [string]$_.Name }
        )
        [System.Array]::Sort($propertyNames, [System.StringComparer]::Ordinal)
        foreach ($propertyName in $propertyNames) {
            $ordered[$propertyName] = ConvertTo-CanonicalNode `
                -Value $Value.PSObject.Properties[$propertyName].Value
        }
        return $ordered
    }

    if ($Value -is [System.Collections.IEnumerable]) {
        $items = [System.Collections.Generic.List[object]]::new()
        foreach ($item in $Value) {
            $items.Add((ConvertTo-CanonicalNode -Value $item))
        }
        return ,$items.ToArray()
    }

    return [string]$Value
}

function ConvertTo-CodexCanonicalJson {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [AllowNull()]
        [object]$InputObject
    )

    process {
        $canonical = ConvertTo-CanonicalNode -Value $InputObject
        return ($canonical | ConvertTo-Json -Depth 100 -Compress)
    }
}

function Get-CodexCanonicalHash {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [AllowNull()]
        [object]$InputObject
    )

    process {
        $json = ConvertTo-CodexCanonicalJson -InputObject $InputObject
        $bytes = [System.Text.UTF8Encoding]::new($false).GetBytes($json)
        $sha = [System.Security.Cryptography.SHA256]::Create()
        try {
            return ([Convert]::ToHexString($sha.ComputeHash($bytes))).ToLowerInvariant()
        }
        finally {
            $sha.Dispose()
        }
    }
}

function Get-ConstantAstText {
    param([Parameter(Mandatory)][System.Management.Automation.Language.Ast]$Ast)

    if ($Ast -is [System.Management.Automation.Language.StringConstantExpressionAst]) {
        return $Ast.Value
    }
    if ($Ast -is [System.Management.Automation.Language.ExpandableStringExpressionAst]) {
        if (@($Ast.NestedExpressions).Count -eq 0) {
            return $Ast.Value
        }
        return $null
    }
    if ($Ast -is [System.Management.Automation.Language.ConstantExpressionAst]) {
        return [string]$Ast.Value
    }
    return $null
}

function Get-CommandElementText {
    param([Parameter(Mandatory)][System.Management.Automation.Language.CommandElementAst]$Element)

    if ($Element -is [System.Management.Automation.Language.CommandParameterAst]) {
        return $Element.Extent.Text
    }
    $constant = Get-ConstantAstText -Ast $Element
    if ($null -ne $constant) {
        return $constant
    }
    return $null
}

function Get-ParsedScript {
    param([Parameter(Mandatory)][string]$Script)

    $tokens = $null
    $errors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseInput(
        $Script,
        [ref]$tokens,
        [ref]$errors
    )
    return [pscustomobject]@{
        Ast = $ast
        Errors = @($errors)
        Tokens = @($tokens)
    }
}

function Get-InnerPowerShellScript {
    param([Parameter(Mandatory)][string]$ObservedCommand)

    $parsed = Get-ParsedScript -Script $ObservedCommand
    if ($parsed.Errors.Count -gt 0 -and $ObservedCommand.TrimStart().StartsWith('"')) {
        $parsed = Get-ParsedScript -Script ('& ' + $ObservedCommand)
    }
    if ($parsed.Errors.Count -gt 0) {
        return [pscustomobject]@{
            Script = $null
            Error = 'outer_command_parse_error'
        }
    }

    $commands = @($parsed.Ast.FindAll({
        param($node)
        $node -is [System.Management.Automation.Language.CommandAst]
    }, $true))
    if ($commands.Count -ne 1) {
        return [pscustomobject]@{
            Script = $ObservedCommand
            Error = $null
        }
    }

    $outer = $commands[0]
    $name = $outer.GetCommandName()
    if ([string]::IsNullOrWhiteSpace($name)) {
        return [pscustomobject]@{ Script = $ObservedCommand; Error = $null }
    }
    $leaf = [System.IO.Path]::GetFileName($name).ToLowerInvariant()
    if ($leaf -notin @('pwsh', 'pwsh.exe', 'powershell', 'powershell.exe')) {
        return [pscustomobject]@{ Script = $ObservedCommand; Error = $null }
    }
    if ($parsed.Ast.Extent.Text.Trim() -cne $outer.Extent.Text.Trim()) {
        return [pscustomobject]@{
            Script = $null
            Error = 'powershell_wrapper_outer_shape_not_admissible'
        }
    }
    if (@($outer.Redirections).Count -gt 0) {
        return [pscustomobject]@{
            Script = $null
            Error = 'powershell_wrapper_redirection_not_admissible'
        }
    }

    $elements = @($outer.CommandElements)
    $allowedSwitches = [System.Collections.Generic.HashSet[string]]::new(
        [System.StringComparer]::OrdinalIgnoreCase
    )
    foreach ($allowedSwitch in @('noprofile', 'nologo', 'noninteractive')) {
        [void]$allowedSwitches.Add($allowedSwitch)
    }
    $seenSwitches = [System.Collections.Generic.HashSet[string]]::new(
        [System.StringComparer]::OrdinalIgnoreCase
    )
    for ($index = 1; $index -lt $elements.Count; $index++) {
        $element = $elements[$index]
        if ($element -isnot [System.Management.Automation.Language.CommandParameterAst]) {
            return [pscustomobject]@{
                Script = $null
                Error = 'powershell_wrapper_parameter_not_admissible'
            }
        }
        $parameterName = $element.ParameterName.ToLowerInvariant()
        if ($parameterName -in @('command', 'c')) {
            if (-not $seenSwitches.Contains('noprofile')) {
                return [pscustomobject]@{
                    Script = $null
                    Error = 'powershell_wrapper_requires_no_profile'
                }
            }
            if ($null -ne $element.Argument) {
                if ($index -ne ($elements.Count - 1)) {
                    return [pscustomobject]@{
                        Script = $null
                        Error = 'powershell_wrapper_parameter_not_admissible'
                    }
                }
                $inner = Get-ConstantAstText -Ast $element.Argument
            }
            else {
                if (($index + 1) -ne ($elements.Count - 1)) {
                    return [pscustomobject]@{
                        Script = $null
                        Error = 'powershell_wrapper_parameter_not_admissible'
                    }
                }
                $inner = Get-ConstantAstText -Ast $elements[$index + 1]
            }
            if ($null -eq $inner) {
                return [pscustomobject]@{
                    Script = $null
                    Error = 'wrapper_command_argument_is_not_constant'
                }
            }
            return [pscustomobject]@{
                Script = $inner
                Error = $null
                WrapperFamilies = @('powershell-wrapper')
                WrapperCommands = @($name)
            }
        }
        if (-not $allowedSwitches.Contains($parameterName) -or
            $null -ne $element.Argument -or
            -not $seenSwitches.Add($parameterName)) {
            return [pscustomobject]@{
                Script = $null
                Error = 'powershell_wrapper_parameter_not_admissible'
            }
        }
    }

    return [pscustomobject]@{
        Script = $null
        Error = 'powershell_wrapper_has_no_command_script'
    }
}

function Test-UnsafeScriptShape {
    param([Parameter(Mandatory)][System.Management.Automation.Language.ScriptBlockAst]$Ast)

    $unsafe = @($Ast.FindAll({
        param($node)
        $node -is [System.Management.Automation.Language.AssignmentStatementAst] -or
        $node -is [System.Management.Automation.Language.IfStatementAst] -or
        $node -is [System.Management.Automation.Language.LoopStatementAst] -or
        $node -is [System.Management.Automation.Language.TrapStatementAst] -or
        $node -is [System.Management.Automation.Language.TryStatementAst] -or
        $node -is [System.Management.Automation.Language.DataStatementAst] -or
        $node -is [System.Management.Automation.Language.FunctionDefinitionAst] -or
        $node -is [System.Management.Automation.Language.SubExpressionAst] -or
        $node -is [System.Management.Automation.Language.ScriptBlockExpressionAst] -or
        $node -is [System.Management.Automation.Language.CommandExpressionAst] -or
        $node -is [System.Management.Automation.Language.MemberExpressionAst] -or
        $node -is [System.Management.Automation.Language.InvokeMemberExpressionAst]
    }, $true))
    return $unsafe.Count -gt 0
}

function Get-GetContentEffect {
    param([Parameter(Mandatory)][System.Management.Automation.Language.CommandAst]$Command)

    $elements = @($Command.CommandElements)
    $path = $null
    $positionals = [System.Collections.Generic.List[string]]::new()
    $errors = [System.Collections.Generic.List[string]]::new()
    for ($index = 1; $index -lt $elements.Count; $index++) {
        $element = $elements[$index]
        if ($element -is [System.Management.Automation.Language.CommandParameterAst]) {
            $name = $element.ParameterName.ToLowerInvariant()
            if ($name -eq 'raw') {
                continue
            }
            if ($name -notin @('literalpath', 'encoding', 'readcount')) {
                $errors.Add('unsupported_get_content_parameter')
                continue
            }
            $value = $null
            if ($null -ne $element.Argument) {
                $value = Get-ConstantAstText -Ast $element.Argument
            }
            elseif (($index + 1) -lt $elements.Count) {
                $value = Get-ConstantAstText -Ast $elements[$index + 1]
                $index++
            }
            if ([string]::IsNullOrWhiteSpace($value)) {
                $errors.Add('get_content_parameter_value_is_not_constant')
                continue
            }
            if ($name -eq 'literalpath') {
                if ($null -ne $path) {
                    $errors.Add('multiple_get_content_paths')
                }
                $path = $value
            }
            continue
        }

        $value = Get-ConstantAstText -Ast $element
        if ($null -eq $value) {
            $errors.Add('get_content_argument_is_not_constant')
        }
        else {
            $positionals.Add($value)
        }
    }

    if ($null -eq $path) {
        if ($positionals.Count -eq 1) {
            $path = $positionals[0]
        }
        else {
            $errors.Add('get_content_requires_one_path')
        }
    }
    elseif ($positionals.Count -gt 0) {
        $errors.Add('unexpected_get_content_positional_argument')
    }

    if ($errors.Count -gt 0) {
        return [pscustomobject]@{ Effects = @(); Errors = @($errors) }
    }
    return [pscustomobject]@{
        Effects = @([ordered]@{
            kind = 'read'
            operation = 'get-content'
            path = $path
        })
        Errors = @()
    }
}

function Get-GitEffect {
    param([Parameter(Mandatory)][System.Management.Automation.Language.CommandAst]$Command)

    $elements = @($Command.CommandElements)
    $arguments = [System.Collections.Generic.List[string]]::new()
    for ($index = 1; $index -lt $elements.Count; $index++) {
        $text = Get-CommandElementText -Element $elements[$index]
        if ($null -eq $text) {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_argument_is_not_constant') }
        }
        $arguments.Add($text)
    }

    $index = 0
    $gitCwd = '.'
    $safeDirectory = $null
    $gitCwdSeen = $false
    $noPager = $false
    $noOptionalLocks = $false
    $fsMonitorDisabled = $false
    $signatureDisplayDisabled = $false
    $noTextconv = $false
    $noExtDiff = $false
    while ($index -lt $arguments.Count) {
        $raw = $arguments[$index]
        $value = $raw.ToLowerInvariant()
        if ($raw -ceq '-C') {
            if ($gitCwdSeen -or ($index + 1) -ge $arguments.Count) {
                return [pscustomobject]@{ Effects = @(); Errors = @('git_cwd_option_invalid') }
            }
            $gitCwd = $arguments[$index + 1]
            $gitCwdSeen = $true
            $index += 2
            continue
        }
        if ($raw -ceq '-c') {
            if (($index + 1) -ge $arguments.Count) {
                return [pscustomobject]@{ Effects = @(); Errors = @('git_config_option_missing_value') }
            }
            $config = $arguments[$index + 1]
            if ($config -match '^safe\.directory=(.+)$' -and $null -eq $safeDirectory) {
                $safeDirectory = $Matches[1]
            }
            elseif ($config -match '^core\.fsmonitor=false$' -and -not $fsMonitorDisabled) {
                $fsMonitorDisabled = $true
            }
            elseif ($config -match '^log\.showsignature=false$' -and -not $signatureDisplayDisabled) {
                $signatureDisplayDisabled = $true
            }
            else {
                return [pscustomobject]@{ Effects = @(); Errors = @('git_config_injection_not_admissible') }
            }
            $index += 2
            continue
        }
        if ($raw.StartsWith('-c', [System.StringComparison]::Ordinal) -and $raw.Length -gt 2) {
            $config = $raw.Substring(2)
            if ($config -match '^safe\.directory=(.+)$' -and $null -eq $safeDirectory) {
                $safeDirectory = $Matches[1]
            }
            elseif ($config -match '^core\.fsmonitor=false$' -and -not $fsMonitorDisabled) {
                $fsMonitorDisabled = $true
            }
            elseif ($config -match '^log\.showsignature=false$' -and -not $signatureDisplayDisabled) {
                $signatureDisplayDisabled = $true
            }
            else {
                return [pscustomobject]@{ Effects = @(); Errors = @('git_config_injection_not_admissible') }
            }
            $index++
            continue
        }
        if ($value -eq '--config-env' -or $value.StartsWith('--config-env=')) {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_config_env_not_admissible') }
        }
        if ($value -in @('--git-dir', '--work-tree') -or
            $value.StartsWith('--git-dir=') -or $value.StartsWith('--work-tree=')) {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_repository_relocation_not_admissible') }
        }
        if ($value -in @('-p', '--paginate') -or $value.StartsWith('--exec-path')) {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_external_execution_option_not_admissible') }
        }
        if ($value -eq '--no-pager') {
            $noPager = $true
            $index++
            continue
        }
        if ($value -eq '--no-optional-locks') {
            $noOptionalLocks = $true
            $index++
            continue
        }
        if ($value -in @(
            '--no-replace-objects', '--literal-pathspecs', '--glob-pathspecs',
            '--noglob-pathspecs', '--icase-pathspecs'
        )) {
            $index++
            continue
        }
        if ($raw.StartsWith('-', [System.StringComparison]::Ordinal)) {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_global_option_unknown') }
        }
        break
    }
    if ($index -ge $arguments.Count) {
        return [pscustomobject]@{ Effects = @(); Errors = @('git_subcommand_missing') }
    }

    $subcommand = $arguments[$index].ToLowerInvariant()
    $rest = @()
    if (($index + 1) -lt $arguments.Count) {
        $rest = @($arguments.GetRange($index + 1, $arguments.Count - $index - 1))
    }
    $outputPath = $null
    for ($restIndex = 0; $restIndex -lt $rest.Count; $restIndex++) {
        $argument = [string]$rest[$restIndex]
        $lower = $argument.ToLowerInvariant()
        if ($lower -eq '--output') {
            if ($null -ne $outputPath -or ($restIndex + 1) -ge $rest.Count) {
                return [pscustomobject]@{ Effects = @(); Errors = @('git_output_option_invalid') }
            }
            $outputPath = [string]$rest[$restIndex + 1]
            $restIndex++
            continue
        }
        if ($lower.StartsWith('--output=')) {
            if ($null -ne $outputPath -or $argument.Length -le '--output='.Length) {
                return [pscustomobject]@{ Effects = @(); Errors = @('git_output_option_invalid') }
            }
            $outputPath = $argument.Substring('--output='.Length)
            continue
        }
        if ($lower -in @('--ext-diff', '--textconv', '--no-index', '--open-files-in-pager', '--filters') -or
            $lower.StartsWith('--filters=') -or
            $lower -eq '-o' -or $lower.StartsWith('--pathspec-from-file=') -or
            $lower -eq '--pathspec-from-file') {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_external_input_or_execution_not_admissible') }
        }
        if ($lower -eq '--no-textconv') {
            $noTextconv = $true
            continue
        }
        if ($lower -eq '--no-ext-diff') {
            $noExtDiff = $true
            continue
        }
        if ($lower -eq '--show-signature' -or $lower.StartsWith('--show-signature=')) {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_signature_verification_not_admissible') }
        }
    }
    $operation = $subcommand
    $kind = 'unknown'
    if ($subcommand -in @('rev-parse', 'status', 'log', 'show', 'diff', 'ls-files', 'ls-tree', 'cat-file', 'grep')) {
        $kind = 'git-read'
    }
    elseif ($subcommand -eq 'worktree' -and $rest.Count -gt 0 -and $rest[0].ToLowerInvariant() -eq 'list') {
        $kind = 'git-read'
        $operation = 'worktree-list'
    }
    elseif ($subcommand -eq 'branch') {
        if ($rest.Count -eq 1 -and $rest[0].ToLowerInvariant() -in @('--show-current', '--list')) {
            $kind = 'git-read'
            $operation = if ($rest[0].ToLowerInvariant() -eq '--show-current') {
                'branch-show-current'
            }
            else {
                'branch-list'
            }
        }
        else {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_branch_shape_not_admissible') }
        }
    }
    elseif ($subcommand -eq 'tag' -and ($rest -contains '--list' -or $rest -contains '-l')) {
        $kind = 'git-read'
        $operation = 'tag-list'
    }
    elseif ($subcommand -eq 'remote') {
        if ($rest.Count -eq 1 -and $rest[0].ToLowerInvariant() -in @('-v', '--verbose')) {
            $kind = 'git-read'
            $operation = 'remote-list'
        }
        else {
            return [pscustomobject]@{ Effects = @(); Errors = @('git_remote_shape_not_admissible') }
        }
    }
    elseif ($subcommand -in @(
        'add', 'am', 'apply', 'bisect', 'checkout', 'cherry-pick', 'clean',
        'clone', 'commit', 'fetch', 'gc', 'init', 'merge', 'mv', 'pull',
        'push', 'rebase', 'reset', 'restore', 'revert', 'rm', 'switch'
    ) -or $subcommand -in @('branch', 'config', 'tag', 'worktree')) {
        $kind = 'git-mutation'
    }

    if ($kind -eq 'unknown') {
        return [pscustomobject]@{ Effects = @(); Errors = @('git_subcommand_unknown') }
    }
    if ($kind -eq 'git-read' -and -not $noPager) {
        return [pscustomobject]@{ Effects = @(); Errors = @('git_read_requires_no_pager') }
    }
    if ($subcommand -in @('log', 'show', 'diff') -and -not $noTextconv) {
        return [pscustomobject]@{ Effects = @(); Errors = @('git_diff_requires_no_textconv') }
    }
    if ($subcommand -in @('log', 'show', 'diff') -and -not $noExtDiff) {
        return [pscustomobject]@{ Effects = @(); Errors = @('git_diff_requires_no_ext_diff') }
    }
    if ($subcommand -eq 'status' -and -not $noOptionalLocks) {
        return [pscustomobject]@{ Effects = @(); Errors = @('git_status_requires_no_optional_locks') }
    }
    if ($subcommand -eq 'status' -and -not $fsMonitorDisabled) {
        return [pscustomobject]@{ Effects = @(); Errors = @('git_status_requires_fsmonitor_disabled') }
    }
    if ($subcommand -in @('log', 'show') -and -not $signatureDisplayDisabled) {
        return [pscustomobject]@{ Effects = @(); Errors = @('git_log_show_requires_signature_display_disabled') }
    }
    $gitEffect = [ordered]@{
        kind = $kind
        operation = $operation
        path = $gitCwd
    }
    if ($null -ne $safeDirectory) {
        $gitEffect.safe_directory = $safeDirectory
    }
    $effects = [System.Collections.Generic.List[object]]::new()
    $effects.Add($gitEffect)
    if ($null -ne $outputPath) {
        $effects.Add([ordered]@{
            kind = 'write'
            operation = 'git-output'
            path = $outputPath
        })
    }
    return [pscustomobject]@{
        Effects = @($effects)
        Errors = @()
    }
}

function Get-ScriptSemantics {
    param([Parameter(Mandatory)][string]$ObservedCommand)

    $inner = Get-InnerPowerShellScript -ObservedCommand $ObservedCommand
    if ($null -ne $inner.Error) {
        return [pscustomobject]@{
            Effects = @()
            Errors = @($inner.Error)
            CommandFamilies = @()
            CommandNames = @()
            WrapperFamilies = @(
                Get-ObjectValue -Object $inner -Name 'WrapperFamilies' -Default @()
            )
            WrapperCommands = @(
                Get-ObjectValue -Object $inner -Name 'WrapperCommands' -Default @()
            )
        }
    }
    $parsed = Get-ParsedScript -Script $inner.Script
    if ($parsed.Errors.Count -gt 0) {
        return [pscustomobject]@{ Effects = @(); Errors = @('inner_command_parse_error') }
    }
    if (Test-UnsafeScriptShape -Ast $parsed.Ast) {
        return [pscustomobject]@{ Effects = @(); Errors = @('unsupported_control_or_expansion_shape') }
    }

    $commands = @($parsed.Ast.FindAll({
        param($node)
        $node -is [System.Management.Automation.Language.CommandAst]
    }, $true))
    if ($commands.Count -eq 0) {
        return [pscustomobject]@{ Effects = @(); Errors = @('no_command_found') }
    }

    $effects = [System.Collections.Generic.List[object]]::new()
    $errors = [System.Collections.Generic.List[string]]::new()
    $commandFamilies = [System.Collections.Generic.List[string]]::new()
    $commandNames = [System.Collections.Generic.List[string]]::new()
    foreach ($command in $commands) {
        if (@($command.Redirections).Count -gt 0) {
            $errors.Add('redirection_is_not_admissible')
            continue
        }
        $name = $command.GetCommandName()
        if ([string]::IsNullOrWhiteSpace($name)) {
            $errors.Add('command_name_is_not_constant')
            continue
        }
        $leaf = [System.IO.Path]::GetFileName($name).ToLowerInvariant()
        $classified = $null
        if ($leaf -eq 'get-content') {
            $classified = Get-GetContentEffect -Command $command
            $commandFamilies.Add('powershell-management')
            $commandNames.Add($name)
        }
        elseif ($leaf -in @('git', 'git.exe')) {
            $classified = Get-GitEffect -Command $command
            $commandFamilies.Add('git-native')
            $commandNames.Add($name)
        }
        elseif ($leaf -in @(
            'get-childitem', 'get-item', 'test-path', 'resolve-path',
            'select-object', 'sort-object', 'format-table', 'format-list',
            'write-output', 'out-string'
        )) {
            $classified = [pscustomobject]@{
                Effects = @([ordered]@{ kind = 'read'; operation = $leaf })
                Errors = @()
            }
            $commandFamilies.Add('powershell-management')
            $commandNames.Add($name)
        }
        elseif ($leaf -in @(
            'set-content', 'add-content', 'clear-content', 'out-file',
            'new-item', 'remove-item', 'copy-item', 'move-item', 'rename-item',
            'set-item', 'set-itemproperty', 'new-itemproperty', 'remove-itemproperty'
        )) {
            $classified = [pscustomobject]@{
                Effects = @([ordered]@{ kind = 'write'; operation = $leaf })
                Errors = @()
            }
            $commandFamilies.Add('powershell-management')
            $commandNames.Add($name)
        }
        else {
            $classified = [pscustomobject]@{ Effects = @(); Errors = @('command_kind_unknown') }
        }

        foreach ($effect in @($classified.Effects)) {
            $effects.Add($effect)
        }
        foreach ($error in @($classified.Errors)) {
            $errors.Add([string]$error)
        }
    }

    return [pscustomobject]@{
        Effects = @($effects)
        Errors = @($errors)
        CommandFamilies = @($commandFamilies)
        CommandNames = @($commandNames)
        WrapperFamilies = @(
            Get-ObjectValue -Object $inner -Name 'WrapperFamilies' -Default @()
        )
        WrapperCommands = @(
            Get-ObjectValue -Object $inner -Name 'WrapperCommands' -Default @()
        )
    }
}

function Get-TrustedCommandIdentityMap {
    param([Parameter(Mandatory)][object]$Policy)

    $map = @{}
    $errors = [System.Collections.Generic.List[string]]::new()
    foreach ($row in @(Get-ObjectValue -Object $Policy -Name 'trusted_command_identities' -Default @())) {
        $family = [string](Get-ObjectValue -Object $row -Name 'family' -Default '')
        $kind = [string](Get-ObjectValue -Object $row -Name 'kind' -Default '')
        $sha256 = ([string](Get-ObjectValue -Object $row -Name 'sha256' -Default '')).ToLowerInvariant()
        $resolvedPath = [string](Get-ObjectValue -Object $row -Name 'resolved_path' -Default '')
        $sourceName = [string](Get-ObjectValue -Object $row -Name 'source_name' -Default '')
        $commands = @(
            Get-ObjectValue -Object $row -Name 'commands' -Default @() |
                ForEach-Object { ([string]$_).Replace('\', '/').ToLowerInvariant() }
        )
        if ([string]::IsNullOrWhiteSpace($family) -or [string]::IsNullOrWhiteSpace($kind) -or
            $sha256 -notmatch '^[0-9a-f]{64}$') {
            $errors.Add('trusted_command_identity_invalid')
            continue
        }
        if ($kind -eq 'native-application') {
            if ([string]::IsNullOrWhiteSpace($resolvedPath) -or
                -not [System.IO.Path]::IsPathRooted($resolvedPath)) {
                $errors.Add('trusted_command_identity_invalid')
                continue
            }
            try {
                $resolvedPath = [System.IO.Path]::GetFullPath($resolvedPath)
            }
            catch {
                $errors.Add('trusted_command_identity_invalid')
                continue
            }
        }
        elseif ($kind -eq 'powershell-module') {
            if ([string]::IsNullOrWhiteSpace($sourceName) -or $commands.Count -eq 0 -or
                @($commands | Where-Object { [string]::IsNullOrWhiteSpace($_) -or $_ -match '[/\\]' }).Count -gt 0) {
                $errors.Add('trusted_command_identity_invalid')
                continue
            }
        }
        else {
            $errors.Add('trusted_command_identity_invalid')
            continue
        }
        if ($map.ContainsKey($family)) {
            $errors.Add('duplicate_trusted_command_identity_family')
            continue
        }
        $map[$family] = [ordered]@{
            family = $family
            kind = $kind
            sha256 = $sha256
            resolved_path = $resolvedPath
            source_name = $sourceName
            commands = @($commands | Sort-Object -Unique)
        }
    }
    return [pscustomobject]@{ Map = $map; Errors = @($errors) }
}

function Test-ResolvedCommandIdentity {
    param(
        [AllowNull()][object]$Identity,
        [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$CommandFamilies,
        [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$ObservedCommands,
        [Parameter(Mandatory)][hashtable]$TrustedMap
    )

    $families = @($CommandFamilies | Sort-Object -Unique)
    if ($families.Count -ne 1) {
        return 'resolved_command_family_ambiguous'
    }
    if ($null -eq $Identity) {
        return 'resolved_command_identity_missing_or_invalid'
    }
    $family = [string](Get-ObjectValue -Object $Identity -Name 'family' -Default '')
    $kind = [string](Get-ObjectValue -Object $Identity -Name 'kind' -Default '')
    $sha256 = ([string](Get-ObjectValue -Object $Identity -Name 'sha256' -Default '')).ToLowerInvariant()
    if ([string]::IsNullOrWhiteSpace($family) -or [string]::IsNullOrWhiteSpace($kind) -or
        $sha256 -notmatch '^[0-9a-f]{64}$' -or $family -cne $families[0]) {
        return 'resolved_command_identity_missing_or_invalid'
    }
    if (-not $TrustedMap.ContainsKey($family)) {
        return 'resolved_command_identity_not_trusted'
    }
    $trusted = $TrustedMap[$family]
    if ([string]$trusted.kind -cne $kind -or [string]$trusted.sha256 -cne $sha256) {
        return 'resolved_command_identity_not_trusted'
    }
    $observed = @(
        $ObservedCommands | ForEach-Object {
            ([string]$_).Replace('\', '/').ToLowerInvariant()
        } | Sort-Object -Unique
    )
    if ($observed.Count -eq 0) {
        return 'resolved_command_invocation_missing_or_invalid'
    }
    if ($kind -eq 'native-application') {
        $identityPath = [string](Get-ObjectValue -Object $Identity -Name 'resolved_path' -Default '')
        if ([string]::IsNullOrWhiteSpace($identityPath) -or
            -not [System.IO.Path]::IsPathRooted($identityPath)) {
            return 'resolved_command_identity_missing_or_invalid'
        }
        try {
            $identityPath = [System.IO.Path]::GetFullPath($identityPath)
            $trustedPath = [System.IO.Path]::GetFullPath([string]$trusted.resolved_path)
        }
        catch {
            return 'resolved_command_identity_missing_or_invalid'
        }
        $pathComparison = if ($IsWindows) {
            [System.StringComparison]::OrdinalIgnoreCase
        }
        else {
            [System.StringComparison]::Ordinal
        }
        if (-not $identityPath.Equals($trustedPath, $pathComparison)) {
            return 'resolved_command_identity_not_trusted'
        }
        foreach ($invocation in $observed) {
            if ($invocation -notmatch '[/\\]' -or
                -not [System.IO.Path]::IsPathRooted($invocation)) {
                return 'resolved_command_invocation_not_trusted'
            }
            try {
                $invocationFull = [System.IO.Path]::GetFullPath($invocation)
            }
            catch {
                return 'resolved_command_invocation_not_trusted'
            }
            if (-not $invocationFull.Equals($trustedPath, $pathComparison)) {
                return 'resolved_command_invocation_not_trusted'
            }
        }
    }
    elseif ($kind -eq 'powershell-module') {
        $sourceName = [string](Get-ObjectValue -Object $Identity -Name 'source_name' -Default '')
        if ([string]::IsNullOrWhiteSpace($sourceName)) {
            return 'resolved_command_identity_missing_or_invalid'
        }
        if ($sourceName -cne [string]$trusted.source_name) {
            return 'resolved_command_identity_not_trusted'
        }
        $allowed = [System.Collections.Generic.HashSet[string]]::new(
            [string[]]@($trusted.commands),
            [System.StringComparer]::Ordinal
        )
        foreach ($invocation in $observed) {
            if ($invocation -match '[/\\]' -or -not $allowed.Contains($invocation)) {
                return 'resolved_command_invocation_not_trusted'
            }
        }
    }
    else {
        return 'resolved_command_identity_missing_or_invalid'
    }
    return $null
}

function Test-TraversalOrExpansion {
    param([Parameter(Mandatory)][string]$Path)

    if ($Path.IndexOfAny([char[]]'*?[]$`') -ge 0) {
        return $true
    }
    $segments = @($Path.Replace('/', '\').Split('\', [System.StringSplitOptions]::RemoveEmptyEntries))
    return $segments -contains '..'
}

function ConvertTo-ControllerRoots {
    param([AllowNull()][object]$Value)

    if ($null -eq $Value) {
        return [pscustomobject]@{ Valid = $false; Normalized = $null }
    }

    $entries = [System.Collections.Generic.List[object]]::new()
    if ($Value -is [System.Collections.IDictionary]) {
        foreach ($key in @($Value.Keys)) {
            $entries.Add([pscustomobject]@{ Name = [string]$key; Value = $Value[$key] })
        }
    }
    elseif ($Value -is [pscustomobject]) {
        foreach ($property in @($Value.PSObject.Properties)) {
            $entries.Add([pscustomobject]@{ Name = [string]$property.Name; Value = $property.Value })
        }
    }
    else {
        return [pscustomobject]@{ Valid = $false; Normalized = $null }
    }
    if ($entries.Count -eq 0) {
        return [pscustomobject]@{ Valid = $false; Normalized = $null }
    }

    $normalized = [ordered]@{}
    foreach ($entry in $entries) {
        $name = [string]$entry.Name
        $pathValue = $entry.Value
        if ([string]::IsNullOrWhiteSpace($name) -or $pathValue -isnot [string] -or
            [string]::IsNullOrWhiteSpace($pathValue) -or
            -not [System.IO.Path]::IsPathRooted($pathValue)) {
            return [pscustomobject]@{ Valid = $false; Normalized = $null }
        }
        try {
            [void][System.IO.Path]::GetFullPath($pathValue)
        }
        catch {
            return [pscustomobject]@{ Valid = $false; Normalized = $null }
        }
        if ($normalized.Contains($name)) {
            return [pscustomobject]@{ Valid = $false; Normalized = $null }
        }
        $normalized[$name] = $pathValue
    }
    return [pscustomobject]@{ Valid = $true; Normalized = [pscustomobject]$normalized }
}

function Resolve-ControllerPath {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Cwd,
        [Parameter(Mandatory)][object]$Roots
    )

    if (Test-TraversalOrExpansion -Path $Path) {
        return [pscustomobject]@{ Error = 'path_traversal_or_expansion'; Root = $null; RelativePath = $null }
    }
    try {
        $full = if ([System.IO.Path]::IsPathRooted($Path)) {
            [System.IO.Path]::GetFullPath($Path)
        }
        else {
            [System.IO.Path]::GetFullPath((Join-Path $Cwd $Path))
        }
    }
    catch {
        return [pscustomobject]@{ Error = 'path_resolution_failed'; Root = $null; RelativePath = $null }
    }

    $comparison = if ($IsWindows) {
        [System.StringComparison]::OrdinalIgnoreCase
    }
    else {
        [System.StringComparison]::Ordinal
    }
    $candidates = [System.Collections.Generic.List[object]]::new()
    foreach ($property in @($Roots.PSObject.Properties)) {
        $rootPath = [System.IO.Path]::GetFullPath([string]$property.Value).TrimEnd('\', '/')
        $candidates.Add([pscustomobject]@{
            Name = $property.Name
            Path = $rootPath
        })
    }
    foreach ($candidate in @($candidates | Sort-Object { $_.Path.Length } -Descending)) {
        $prefix = $candidate.Path + [System.IO.Path]::DirectorySeparatorChar
        if ($full.Equals($candidate.Path, $comparison)) {
            return [pscustomobject]@{
                Error = $null
                Root = $candidate.Name
                RelativePath = ''
            }
        }
        if ($full.StartsWith($prefix, $comparison)) {
            $relative = $full.Substring($prefix.Length).Replace('\', '/')
            return [pscustomobject]@{
                Error = $null
                Root = $candidate.Name
                RelativePath = $relative
            }
        }
    }
    return [pscustomobject]@{ Error = 'unauthorized_root'; Root = $null; RelativePath = $null }
}

function Get-NormalizedEffects {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [object[]]$Effects,
        [Parameter(Mandatory)][string]$Cwd,
        [Parameter(Mandatory)][object]$Roots
    )

    $normalized = [System.Collections.Generic.List[object]]::new()
    $errors = [System.Collections.Generic.List[string]]::new()
    foreach ($effect in $Effects) {
        $path = Get-ObjectValue -Object $effect -Name 'path'
        if ($null -ne $path) {
            $resolved = Resolve-ControllerPath -Path ([string]$path) -Cwd $Cwd -Roots $Roots
            if ($null -ne $resolved.Error) {
                $operation = [string](Get-ObjectValue -Object $effect -Name 'operation' -Default '')
                if ([string](Get-ObjectValue -Object $effect -Name 'kind' -Default '') -like 'git-*') {
                    $errors.Add('git_cwd_not_authorized')
                }
                else {
                    $errors.Add([string]$resolved.Error)
                }
                continue
            }
            $safeDirectory = Get-ObjectValue -Object $effect -Name 'safe_directory'
            if ($null -ne $safeDirectory) {
                $safeResolved = Resolve-ControllerPath -Path ([string]$safeDirectory) -Cwd $Cwd -Roots $Roots
                if ($null -ne $safeResolved.Error -or
                    $safeResolved.Root -cne $resolved.Root -or
                    $safeResolved.RelativePath -cne $resolved.RelativePath) {
                    $errors.Add('git_safe_directory_mismatch')
                    continue
                }
            }
            $normalized.Add([ordered]@{
                kind = [string](Get-ObjectValue -Object $effect -Name 'kind')
                operation = [string](Get-ObjectValue -Object $effect -Name 'operation')
                root = $resolved.Root
                relative_path = $resolved.RelativePath
            })
        }
        else {
            $normalized.Add([ordered]@{
                kind = [string](Get-ObjectValue -Object $effect -Name 'kind')
                operation = [string](Get-ObjectValue -Object $effect -Name 'operation')
            })
        }
    }
    return [pscustomobject]@{
        Effects = @($normalized | Sort-Object { ConvertTo-CodexCanonicalJson -InputObject $_ })
        Errors = @($errors)
    }
}

function Get-NormalizedActionSemantics {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [object[]]$Actions,
        [Parameter(Mandatory)][string]$Cwd,
        [Parameter(Mandatory)][object]$Roots
    )

    $effects = [System.Collections.Generic.List[object]]::new()
    $errors = [System.Collections.Generic.List[string]]::new()
    foreach ($action in $Actions) {
        $actionCommand = [string](Get-ObjectValue -Object $action -Name 'command' -Default '')
        if ([string]::IsNullOrWhiteSpace($actionCommand)) {
            $errors.Add('command_action_text_missing')
            continue
        }
        $semantic = Get-ScriptSemantics -ObservedCommand $actionCommand
        $normalized = Get-NormalizedEffects -Effects @($semantic.Effects) -Cwd $Cwd -Roots $Roots
        foreach ($effect in @($normalized.Effects)) {
            $effects.Add($effect)
        }
        foreach ($error in @($semantic.Errors) + @($normalized.Errors)) {
            $errors.Add([string]$error)
        }
    }
    return [pscustomobject]@{
        Effects = @($effects | Sort-Object { ConvertTo-CodexCanonicalJson -InputObject $_ })
        Errors = @($errors | Sort-Object -Unique)
    }
}

function Get-AllowedFileMap {
    param([Parameter(Mandatory)][object]$Policy)

    $map = @{}
    $errors = [System.Collections.Generic.List[string]]::new()
    foreach ($entry in @(Get-ObjectValue -Object $Policy -Name 'allowed_files' -Default @())) {
        $root = [string](Get-ObjectValue -Object $entry -Name 'root' -Default '')
        $path = ([string](Get-ObjectValue -Object $entry -Name 'path' -Default '')).Replace('\', '/')
        if ([string]::IsNullOrWhiteSpace($root) -or -not (Test-ControllerRelativePath -Value $path)) {
            $errors.Add('allowed_file_shape_invalid')
            continue
        }
        $identity = ConvertTo-ControllerContentIdentity -Value $entry
        if (-not $identity.Valid) {
            $errors.Add('allowed_file_content_identity_invalid')
        }
        $key = ('{0}|{1}' -f $root.ToLowerInvariant(), $path)
        if ($map.ContainsKey($key)) {
            $errors.Add('duplicate_allowed_file_key')
            continue
        }
        $map[$key] = $entry
    }
    return [pscustomobject]@{ Map = $map; Errors = @($errors | Sort-Object -Unique) }
}

function Get-ActionProofMap {
    param(
        [Parameter(Mandatory)][object[]]$Actions,
        [Parameter(Mandatory)][string]$Cwd,
        [Parameter(Mandatory)][object]$Roots
    )

    $map = @{}
    $errors = [System.Collections.Generic.List[string]]::new()
    foreach ($action in $Actions) {
        $command = [string](Get-ObjectValue -Object $action -Name 'command' -Default '')
        $semantics = Get-ScriptSemantics -ObservedCommand $command
        $normalized = Get-NormalizedEffects -Effects @($semantics.Effects) -Cwd $Cwd -Roots $Roots
        $fileEffects = @($normalized.Effects | Where-Object { $_.operation -eq 'get-content' })
        $proofs = @(Get-ObjectValue -Object $action -Name 'file_proofs' -Default @())
        if ($proofs.Count -eq 0 -and $fileEffects.Count -eq 1) {
            $length = Get-ObjectValue -Object $action -Name 'content_length'
            $sha256 = Get-ObjectValue -Object $action -Name 'content_sha256'
            if ($null -ne $length -and $null -ne $sha256) {
                $proofs = @([pscustomobject]@{
                    root = $fileEffects[0].root
                    path = $fileEffects[0].relative_path
                    length = $length
                    sha256 = $sha256
                })
            }
        }
        foreach ($proof in $proofs) {
            $root = [string](Get-ObjectValue -Object $proof -Name 'root' -Default '')
            $path = ([string](Get-ObjectValue -Object $proof -Name 'path' -Default '')).Replace('\', '/')
            if ([string]::IsNullOrWhiteSpace($root) -or -not (Test-ControllerRelativePath -Value $path)) {
                $errors.Add('file_proof_shape_invalid')
                continue
            }
            $identity = ConvertTo-ControllerContentIdentity -Value $proof
            if (-not $identity.Valid) {
                $errors.Add('read_content_proof_identity_invalid')
            }
            $key = ('{0}|{1}' -f $root.ToLowerInvariant(), $path)
            if ($map.ContainsKey($key)) {
                $errors.Add('duplicate_file_proof_key')
                continue
            }
            $map[$key] = $proof
        }
    }
    return [pscustomobject]@{ Map = $map; Errors = @($errors | Sort-Object -Unique) }
}

function Compare-InventoryRows {
    param(
        [Parameter(Mandatory)][object[]]$Left,
        [Parameter(Mandatory)][object[]]$Right
    )

    $leftMap = @{}
    $rightMap = @{}
    foreach ($pair in @(
        [pscustomobject]@{ Rows = $Left; Map = $leftMap },
        [pscustomobject]@{ Rows = $Right; Map = $rightMap }
    )) {
        foreach ($row in @($pair.Rows)) {
            $path = ([string](Get-ObjectValue -Object $row -Name 'path' -Default '')).Replace('\', '/')
            $identity = ConvertTo-ControllerContentIdentity -Value $row
            if (-not (Test-ControllerRelativePath -Value $path) -or -not $identity.Valid) {
                return [pscustomobject]@{ Equal = $false; Error = 'inventory_row_identity_invalid' }
            }
            if ($pair.Map.ContainsKey($path)) {
                return [pscustomobject]@{ Equal = $false; Error = 'duplicate_inventory_path' }
            }
            $pair.Map[$path] = '{0}|{1}' -f (
                [string]$identity.Normalized.length
            ), [string]$identity.Normalized.sha256
        }
    }
    if ($leftMap.Count -ne $rightMap.Count) {
        return [pscustomobject]@{ Equal = $false; Error = $null }
    }
    foreach ($path in $leftMap.Keys) {
        if (-not $rightMap.ContainsKey($path) -or $rightMap[$path] -ne $leftMap[$path]) {
            return [pscustomobject]@{ Equal = $false; Error = $null }
        }
    }
    return [pscustomobject]@{ Equal = $true; Error = $null }
}

function Add-UniqueText {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[string]]$List,
        [Parameter(Mandatory)][string]$Value
    )

    if (-not $List.Contains($Value)) {
        $List.Add($Value)
    }
}

function Invoke-ControllerCore {
    param([Parameter(Mandatory)][object]$InputObject)

    $policy = Get-ObjectValue -Object $InputObject -Name 'policy'
    $evidence = Get-ObjectValue -Object $InputObject -Name 'evidence'
    $violations = [System.Collections.Generic.List[string]]::new()
    $unknowns = [System.Collections.Generic.List[string]]::new()
    $completedEffects = [System.Collections.Generic.List[object]]::new()
    $declinedDiagnostics = [System.Collections.Generic.List[object]]::new()
    $failedDiagnostics = [System.Collections.Generic.List[object]]::new()

    if ($null -eq $policy -or $null -eq $evidence) {
        Add-UniqueText -List $unknowns -Value 'policy_or_evidence_missing'
    }

    $expectedCandidate = Get-ObjectValue -Object $policy -Name 'expected_candidate'
    $observedCandidate = Get-ObjectValue -Object $evidence -Name 'candidate_identity'
    $logicalCandidate = $null
    if ($null -eq $expectedCandidate -or $null -eq $observedCandidate) {
        Add-UniqueText -List $unknowns -Value 'logical_candidate_identity_missing'
    }
    else {
        $expectedIdentity = ConvertTo-ControllerCandidateIdentity -Value $expectedCandidate
        $observedIdentity = ConvertTo-ControllerCandidateIdentity -Value $observedCandidate
        $logicalCandidate = $observedIdentity.Normalized
        if (-not $expectedIdentity.Valid) {
            Add-UniqueText -List $unknowns -Value 'expected_logical_candidate_identity_invalid'
        }
        if (-not $observedIdentity.Valid) {
            Add-UniqueText -List $unknowns -Value 'observed_logical_candidate_identity_invalid'
        }
        if ($expectedIdentity.Valid -and $observedIdentity.Valid) {
            foreach ($field in @(
                'stable_subject',
                'candidate_sha',
                'package_manifest_sha256',
                'relative_package_path',
                'content_output_sha256'
            )) {
                $expected = [string](Get-ObjectValue -Object $expectedIdentity.Normalized -Name $field -Default '')
                $actual = [string](Get-ObjectValue -Object $logicalCandidate -Name $field -Default '')
                if ($actual -cne $expected) {
                    Add-UniqueText -List $violations -Value ('logical_candidate_{0}_mismatch' -f $field)
                }
            }
        }
    }

    $rootResult = ConvertTo-ControllerRoots -Value (
        Get-ObjectValue -Object $policy -Name 'roots'
    )
    $roots = $rootResult.Normalized
    if (-not $rootResult.Valid) {
        Add-UniqueText -List $unknowns -Value 'policy_roots_invalid'
    }
    $allowedFileResult = if ($null -ne $policy) {
        Get-AllowedFileMap -Policy $policy
    }
    else {
        [pscustomobject]@{ Map = @{}; Errors = @() }
    }
    $allowedFiles = $allowedFileResult.Map
    foreach ($error in @($allowedFileResult.Errors)) {
        Add-UniqueText -List $unknowns -Value ([string]$error)
    }
    $trustedCommandIdentityResult = if ($null -ne $policy) {
        Get-TrustedCommandIdentityMap -Policy $policy
    }
    else {
        [pscustomobject]@{ Map = @{}; Errors = @() }
    }
    foreach ($error in @($trustedCommandIdentityResult.Errors)) {
        Add-UniqueText -List $unknowns -Value ([string]$error)
    }
    $completedReadKeys = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
    foreach ($commandRecord in @(Get-ObjectValue -Object $evidence -Name 'commands' -Default @())) {
        $status = ([string](Get-ObjectValue -Object $commandRecord -Name 'status' -Default '')).ToLowerInvariant()
        $exitCode = Get-ObjectValue -Object $commandRecord -Name 'exit_code'
        $cwd = [string](Get-ObjectValue -Object $commandRecord -Name 'cwd' -Default '')
        $rawCommand = [string](Get-ObjectValue -Object $commandRecord -Name 'command' -Default '')
        $actions = @(Get-ObjectValue -Object $commandRecord -Name 'command_actions' -Default @())
        if ($status -notin @('completed', 'declined', 'failed')) {
            Add-UniqueText -List $unknowns -Value 'command_status_unknown'
            continue
        }

        $outer = Get-ScriptSemantics -ObservedCommand $rawCommand
        $outerNormalized = if ($rootResult.Valid -and -not [string]::IsNullOrWhiteSpace($cwd)) {
            Get-NormalizedEffects -Effects @($outer.Effects) -Cwd $cwd -Roots $roots
        }
        else {
            [pscustomobject]@{ Effects = @(); Errors = @('command_cwd_or_roots_missing') }
        }
        $cwdErrors = @()
        if ($rootResult.Valid -and -not [string]::IsNullOrWhiteSpace($cwd)) {
            $cwdResolution = Resolve-ControllerPath -Path '.' -Cwd $cwd -Roots $roots
            if ($null -ne $cwdResolution.Error) {
                $cwdErrors = @('command_cwd_not_authorized')
            }
        }
        $actionNormalized = if ($rootResult.Valid -and -not [string]::IsNullOrWhiteSpace($cwd)) {
            Get-NormalizedActionSemantics -Actions $actions -Cwd $cwd -Roots $roots
        }
        else {
            [pscustomobject]@{ Effects = @(); Errors = @('command_cwd_or_roots_missing') }
        }

        if ($status -eq 'declined') {
            $declinedDiagnostics.Add([ordered]@{
                classification = 'declined_not_executed'
                outer_effects = @($outerNormalized.Effects)
                action_effects = @($actionNormalized.Effects)
                parse_errors = @(
                    @($outer.Errors) + @($outerNormalized.Errors) +
                    @($actionNormalized.Errors) + @($cwdErrors) |
                        Sort-Object -Unique
                )
            })
            continue
        }
        if ($status -eq 'failed') {
            $failedEffects = @(
                @($outerNormalized.Effects) + @($actionNormalized.Effects) |
                    Sort-Object { ConvertTo-CodexCanonicalJson -InputObject $_ }
            )
            $failedDiagnostics.Add([ordered]@{
                classification = 'failed_not_completed'
                exit_code = $exitCode
                outer_effects = @($outerNormalized.Effects)
                action_effects = @($actionNormalized.Effects)
                parse_errors = @(
                    @($outer.Errors) + @($outerNormalized.Errors) +
                    @($actionNormalized.Errors) + @($cwdErrors) |
                        Sort-Object -Unique
                )
            })
            Add-UniqueText -List $unknowns -Value 'failed_execution'
            foreach ($effect in $failedEffects) {
                if ([string]$effect.kind -eq 'write') {
                    Add-UniqueText -List $unknowns -Value 'failed_attempted_write'
                }
                elseif ([string]$effect.kind -eq 'git-mutation') {
                    Add-UniqueText -List $unknowns -Value 'failed_attempted_git_mutation'
                }
            }
            $failedOuterFingerprint = ConvertTo-CodexCanonicalJson -InputObject @($outerNormalized.Effects)
            $failedActionFingerprint = ConvertTo-CodexCanonicalJson -InputObject @($actionNormalized.Effects)
            if ($failedOuterFingerprint -cne $failedActionFingerprint) {
                Add-UniqueText -List $unknowns -Value 'failed_outer_and_action_semantics_mismatch'
            }
            continue
        }

        $completedExitCode = ConvertTo-ControllerInteger -Value $exitCode
        if (-not $completedExitCode.Valid) {
            Add-UniqueText -List $unknowns -Value 'completed_command_exit_code_type_invalid'
        }
        elseif ($completedExitCode.Value -ne 0) {
            Add-UniqueText -List $unknowns -Value 'completed_command_exit_is_not_zero'
        }
        foreach ($error in @($outer.Errors) + @($outerNormalized.Errors) + @($cwdErrors)) {
            Add-UniqueText -List $unknowns -Value ([string]$error)
        }
        $resolvedIdentityError = Test-ResolvedCommandIdentity `
            -Identity (Get-ObjectValue -Object $commandRecord -Name 'resolved_command_identity') `
            -CommandFamilies @((Get-ObjectValue -Object $outer -Name 'CommandFamilies' -Default @())) `
            -ObservedCommands @((Get-ObjectValue -Object $outer -Name 'CommandNames' -Default @())) `
            -TrustedMap $trustedCommandIdentityResult.Map
        if ($null -ne $resolvedIdentityError) {
            Add-UniqueText -List $unknowns -Value $resolvedIdentityError
        }
        $wrapperFamilies = @(
            Get-ObjectValue -Object $outer -Name 'WrapperFamilies' -Default @()
        )
        $wrapperCommands = @(
            Get-ObjectValue -Object $outer -Name 'WrapperCommands' -Default @()
        )
        $resolvedWrapperIdentity = Get-ObjectValue `
            -Object $commandRecord `
            -Name 'resolved_wrapper_identity'
        if ($wrapperFamilies.Count -gt 0) {
            $resolvedWrapperError = Test-ResolvedCommandIdentity `
                -Identity $resolvedWrapperIdentity `
                -CommandFamilies $wrapperFamilies `
                -ObservedCommands $wrapperCommands `
                -TrustedMap $trustedCommandIdentityResult.Map
            if ($null -ne $resolvedWrapperError) {
                $mappedWrapperError = switch ($resolvedWrapperError) {
                    'resolved_command_family_ambiguous' { 'resolved_wrapper_family_ambiguous' }
                    'resolved_command_identity_missing_or_invalid' { 'resolved_wrapper_identity_missing_or_invalid' }
                    'resolved_command_identity_not_trusted' { 'resolved_wrapper_identity_not_trusted' }
                    'resolved_command_invocation_missing_or_invalid' { 'resolved_wrapper_invocation_missing_or_invalid' }
                    'resolved_command_invocation_not_trusted' { 'resolved_wrapper_invocation_not_trusted' }
                    default { 'resolved_wrapper_identity_unknown' }
                }
                Add-UniqueText -List $unknowns -Value $mappedWrapperError
            }
        }
        elseif ($null -ne $resolvedWrapperIdentity) {
            Add-UniqueText -List $unknowns -Value 'resolved_wrapper_identity_unexpected'
        }
        if ($actions.Count -eq 0) {
            Add-UniqueText -List $unknowns -Value 'completed_command_actions_missing'
            continue
        }

        foreach ($error in @($actionNormalized.Errors)) {
            Add-UniqueText -List $unknowns -Value $error
        }

        $normalizedActionEffects = @($actionNormalized.Effects)
        $outerFingerprint = ConvertTo-CodexCanonicalJson -InputObject @($outerNormalized.Effects)
        $actionFingerprint = ConvertTo-CodexCanonicalJson -InputObject $normalizedActionEffects
        if ($outerFingerprint -cne $actionFingerprint) {
            Add-UniqueText -List $unknowns -Value 'outer_and_action_semantics_mismatch'
            continue
        }

        $proofMapResult = if ($rootResult.Valid) {
            Get-ActionProofMap -Actions $actions -Cwd $cwd -Roots $roots
        }
        else {
            [pscustomobject]@{ Map = @{}; Errors = @('policy_roots_invalid') }
        }
        $proofMap = $proofMapResult.Map
        foreach ($error in @($proofMapResult.Errors)) {
            Add-UniqueText -List $unknowns -Value ([string]$error)
        }
        foreach ($effect in $normalizedActionEffects) {
            $kind = [string]$effect.kind
            if ($kind -eq 'write') {
                Add-UniqueText -List $violations -Value 'completed_write'
                continue
            }
            if ($kind -eq 'git-mutation') {
                Add-UniqueText -List $violations -Value 'completed_git_mutation'
                continue
            }
            if ($kind -eq 'git-read') {
                if ([string](Get-ObjectValue -Object $policy -Name 'git' -Default 'none') -ne 'read-only') {
                    Add-UniqueText -List $violations -Value 'git_read_not_authorized'
                }
                else {
                    $completedEffects.Add($effect)
                }
                continue
            }
            if ($kind -ne 'read') {
                Add-UniqueText -List $unknowns -Value 'completed_effect_kind_unknown'
                continue
            }
            if ($effect.operation -ne 'get-content') {
                Add-UniqueText -List $unknowns -Value 'read_operation_not_structurally_supported'
                continue
            }

            $key = ('{0}|{1}' -f ([string]$effect.root).ToLowerInvariant(), [string]$effect.relative_path)
            if (-not $allowedFiles.ContainsKey($key)) {
                Add-UniqueText -List $violations -Value 'unauthorized_file_read'
                continue
            }
            if (-not $proofMap.ContainsKey($key)) {
                Add-UniqueText -List $unknowns -Value 'read_content_proof_missing'
                continue
            }
            $allowed = $allowedFiles[$key]
            $proof = $proofMap[$key]
            $allowedIdentity = ConvertTo-ControllerContentIdentity -Value $allowed
            $proofIdentity = ConvertTo-ControllerContentIdentity -Value $proof
            if (-not $allowedIdentity.Valid) {
                Add-UniqueText -List $unknowns -Value 'allowed_file_content_identity_invalid'
            }
            if (-not $proofIdentity.Valid) {
                Add-UniqueText -List $unknowns -Value 'read_content_proof_identity_invalid'
            }
            if (-not $allowedIdentity.Valid -or -not $proofIdentity.Valid) {
                continue
            }
            if ($allowedIdentity.Normalized.length -ne $proofIdentity.Normalized.length -or
                $allowedIdentity.Normalized.sha256 -cne $proofIdentity.Normalized.sha256) {
                Add-UniqueText -List $violations -Value 'read_content_identity_mismatch'
                continue
            }
            $completedReadKeys.Add($key) | Out-Null
            $completedEffects.Add([ordered]@{
                kind = 'read'
                operation = 'get-content'
                root = $effect.root
                relative_path = $effect.relative_path
                length = $proofIdentity.Normalized.length
                sha256 = $proofIdentity.Normalized.sha256
            })
        }
    }

    foreach ($required in @(Get-ObjectValue -Object $policy -Name 'required_reads' -Default @())) {
        $requiredRoot = [string](Get-ObjectValue -Object $required -Name 'root' -Default '')
        $requiredPath = ([string](Get-ObjectValue -Object $required -Name 'path' -Default '')).Replace('\', '/')
        if ([string]::IsNullOrWhiteSpace($requiredRoot) -or
            -not (Test-ControllerRelativePath -Value $requiredPath)) {
            Add-UniqueText -List $unknowns -Value 'required_read_shape_invalid'
            continue
        }
        $key = ('{0}|{1}' -f $requiredRoot.ToLowerInvariant(), $requiredPath)
        if (-not $completedReadKeys.Contains($key)) {
            Add-UniqueText -List $unknowns -Value 'required_read_not_proven'
        }
    }

    $inventoryResults = [System.Collections.Generic.List[object]]::new()
    foreach ($comparison in @(Get-ObjectValue -Object $evidence -Name 'inventory_comparisons' -Default @())) {
        $leftState = Get-ControllerPropertyState -Object $comparison -Name 'left'
        $rightState = Get-ControllerPropertyState -Object $comparison -Name 'right'
        $comparisonName = [string](Get-ObjectValue -Object $comparison -Name 'name' -Default '')
        if (-not $leftState.Present -or -not $rightState.Present -or
            $null -eq $leftState.Value -or $null -eq $rightState.Value -or
            [string]::IsNullOrWhiteSpace($comparisonName)) {
            Add-UniqueText -List $unknowns -Value 'inventory_comparison_shape_invalid'
            continue
        }
        $result = Compare-InventoryRows -Left @($leftState.Value) -Right @($rightState.Value)
        if ($null -ne $result.Error) {
            Add-UniqueText -List $unknowns -Value $result.Error
        }
        elseif (-not $result.Equal) {
            Add-UniqueText -List $violations -Value 'inventory_mismatch'
        }
        $inventoryResults.Add([ordered]@{
            name = $comparisonName
            equal = [bool]$result.Equal
        })
    }

    $construction = @(Get-ObjectValue -Object $evidence -Name 'construction_events' -Default @())
    $constructionState = 'not-applicable'
    if ($construction.Count -gt 0) {
        $names = [System.Collections.Generic.List[string]]::new()
        $constructionShapeValid = $true
        foreach ($constructionEvent in $construction) {
            $eventName = [string](Get-ObjectValue -Object $constructionEvent -Name 'event' -Default '')
            if ([string]::IsNullOrWhiteSpace($eventName)) {
                $constructionShapeValid = $false
                continue
            }
            $names.Add($eventName)
        }
        $requiredConstruction = @(
            'directory-created',
            'manifest-written',
            'reconciliation-complete',
            'sealed'
        )
        if (-not $constructionShapeValid) {
            Add-UniqueText -List $unknowns -Value 'construction_event_shape_invalid'
            $constructionState = 'unknown'
        }
        elseif (@($requiredConstruction | Where-Object { $_ -notin $names }).Count -gt 0) {
            Add-UniqueText -List $unknowns -Value 'construction_stage_missing'
            $constructionState = 'unknown'
        }
        elseif ($names.Count -ne $requiredConstruction.Count -or
            @(Compare-Object -ReferenceObject $requiredConstruction -DifferenceObject $names -SyncWindow 0).Count -gt 0) {
            Add-UniqueText -List $violations -Value 'construction_order_violation'
            $constructionState = 'violation'
        }
        else {
            $constructionState = 'reconciled-before-seal'
        }
    }

    foreach ($delivery in @(Get-ObjectValue -Object $evidence -Name 'role_deliveries' -Default @())) {
        $authorizedState = Get-ControllerPropertyState -Object $delivery -Name 'authorized'
        $authorized = $authorizedState.Value
        if (-not $authorizedState.Present -or $authorized -isnot [bool]) {
            Add-UniqueText -List $unknowns -Value 'role_delivery_authorized_type_invalid'
        }
        elseif (-not $authorized) {
            Add-UniqueText -List $violations -Value 'unauthorized_role_delivery'
        }
    }
    $nestedTurnCount = ConvertTo-ControllerCount -Value (
        Get-ObjectValue -Object $evidence -Name 'nested_turn_count' -Default 0
    )
    $nestedTurnBudget = ConvertTo-ControllerCount -Value (
        Get-ObjectValue -Object $policy -Name 'maximum_nested_turns' -Default 0
    )
    if (-not $nestedTurnCount.Valid) {
        Add-UniqueText -List $unknowns -Value 'nested_turn_count_type_invalid'
    }
    if (-not $nestedTurnBudget.Valid) {
        Add-UniqueText -List $unknowns -Value 'maximum_nested_turns_type_invalid'
    }
    if ($nestedTurnCount.Valid -and $nestedTurnBudget.Valid -and
        $nestedTurnCount.Value -gt $nestedTurnBudget.Value) {
        Add-UniqueText -List $violations -Value 'unbudgeted_nested_turn'
    }

    $semanticRequired = $false
    $exactResponseSeen = $false
    foreach ($textRecord in @(Get-ObjectValue -Object $evidence -Name 'free_text' -Default @())) {
        $protocol = ([string](Get-ObjectValue -Object $textRecord -Name 'protocol' -Default 'natural-language')).ToLowerInvariant()
        $text = [string](Get-ObjectValue -Object $textRecord -Name 'text' -Default '')
        if ([string]::IsNullOrWhiteSpace($text)) {
            Add-UniqueText -List $unknowns -Value 'free_text_missing'
            continue
        }
        if ($protocol -eq 'exact-response') {
            $exactResponseSeen = $true
            $expected = [string](Get-ObjectValue -Object $textRecord -Name 'expected' -Default '')
            if ($text -cne $expected) {
                Add-UniqueText -List $violations -Value 'exact_response_mismatch'
            }
        }
        else {
            $semanticRequired = $true
        }
    }

    $assessorRequested = Get-ObjectValue -Object $evidence -Name 'assessor_requested' -Default $false
    if ($assessorRequested -isnot [bool]) {
        Add-UniqueText -List $unknowns -Value 'assessor_requested_type_invalid'
    }

    $preliminaryVerdict = if ($violations.Count -gt 0) {
        'CONTROLLER_VIOLATION'
    }
    elseif ($unknowns.Count -gt 0) {
        'CONTROLLER_UNKNOWN'
    }
    else {
        'ADMISSIBLE'
    }
    if ($assessorRequested -is [bool] -and $assessorRequested -and
        $preliminaryVerdict -ne 'ADMISSIBLE') {
        Add-UniqueText -List $violations -Value 'assessor_requested_without_admissible_controller_result'
    }

    $verdict = if ($violations.Count -gt 0) {
        'CONTROLLER_VIOLATION'
    }
    elseif ($unknowns.Count -gt 0) {
        'CONTROLLER_UNKNOWN'
    }
    else {
        'ADMISSIBLE'
    }
    $semanticDisposition = if ($semanticRequired) {
        'SEMANTIC_ASSESSMENT_REQUIRED'
    }
    elseif ($exactResponseSeen) {
        'EXACT_RESPONSE_CHECKED'
    }
    else {
        'NOT_APPLICABLE'
    }

    return [ordered]@{
        schema_version = $script:ControllerSchema
        verdict = $verdict
        semantic_disposition = $semanticDisposition
        may_request_semantic_assessment = ($verdict -eq 'ADMISSIBLE' -and $semanticRequired)
        logical_candidate = $logicalCandidate
        completed_effects = @($completedEffects | Sort-Object { ConvertTo-CodexCanonicalJson -InputObject $_ })
        declined_diagnostics = @($declinedDiagnostics)
        failed_diagnostics = @($failedDiagnostics)
        inventory_results = @($inventoryResults | Sort-Object name)
        construction_state = $constructionState
        violations = @($violations | Sort-Object)
        unknowns = @($unknowns | Sort-Object)
    }
}

function Invoke-CodexEvidenceController {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('preflight', 'runtime', 'historical-import', 'terminal-stage')]
        [string]$Mode,

        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject,

        [switch]$AsJson
    )

    process {
        if ($Mode -notin $script:Modes) {
            throw "Unsupported controller mode: $Mode"
        }
        $core = Invoke-ControllerCore -InputObject $InputObject
        $result = [ordered]@{
            schema_version = $script:ControllerSchema
            entry_mode = $Mode
            adjudication = $core
        }
        if ($AsJson) {
            return ConvertTo-CodexCanonicalJson -InputObject $result
        }
        return $result
    }
}

Export-ModuleMember -Function @(
    'Invoke-CodexEvidenceController',
    'ConvertTo-CodexCanonicalJson',
    'Get-CodexCanonicalHash'
)
