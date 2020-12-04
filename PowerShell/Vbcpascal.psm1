# based on Honukai
#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )

    # Write start symbol of the first line
    $prompt = Write-Prompt -Object "╭─ " -ForegroundColor $sl.Colors.StructColor

    # check for elevated prompt
    if (Test-Administrator) {
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.ElevatedSymbol) " -ForegroundColor $sl.Colors.AdminIconForegroundColor
    }

    # Write user
    $user = $sl.CurrentUser
    if (Test-NotDefaultUser($user)) {
        $prompt += Write-Prompt -Object "$user" -ForegroundColor $sl.Colors.UserColor
        
        # write in for folder
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.LocationSymbol)" -ForegroundColor $sl.Colors.StructColor
    }

    # Write folder
    $dir = Get-FullPath -dir $pwd
    $WSDirLength = $WorkspaceDir.Length
    if ((Get-Variable "WorkspaceDir") -AND ($dir.Length -GE $WSDirLength) -AND ($dir.Substring(0, $WSDirLength) -EQ $WorkspaceDir)) {
        # This is an error implementation. But I'm lazy~
        $wsdir = $dir.Substring($WSDirLength)
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.WorkspaceSymbol) $wsdir " -ForegroundColor $sl.Colors.DirColor
    }
    else {
        $prompt += Write-Prompt -Object " $dir " -ForegroundColor $sl.Colors.DirColor
    }
    
    # Write on (git:branchname status)
    $status = Get-VCSStatus
    if ($status) {
        $sl.GitSymbols.BranchSymbol = ''
        $themeInfo = Get-VcsInfo -status ($status)
        $prompt += Write-Prompt -Object 'on ' -ForegroundColor $sl.Colors.StructColor
        $prompt += Write-Prompt -Object "$($themeInfo.VcInfo) " -ForegroundColor $themeInfo.BackgroundColor
    }

    # Write virtualenv
    if (Test-VirtualEnv) {
        # for anaconda base environment
        $venvName = Get-VirtualEnvName
        $prompt += Write-Prompt -Object $sl.PromptSymbols.VenvSymbol -ForegroundColor $sl.Colors.StructColor
        $prompt += Write-Prompt -Object " $venvName " -ForegroundColor $sl.Colors.VenvColor
    }
    
    # check the last command state and indicate if failed
    $emojiSymbol = "(๑ •ㅂ•)"
    # $emojiColor = $sl.Colors.StructColor
    if ($lastCommandFailed) {
        $emojiSymbol = "[σ｀д′]σ"
        # $emojiColor = $sl.Colors.ErrorColor
    }

    if ($with) {
        $prompt += Write-Prompt -Object "$($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.WithForegroundColor
    }

    # write time
    $timeStamp = Get-Date -Format T
    $timeHour = [int](Get-Date -Format "HH")
    $timeMinute = [int](Get-Date -Format "mm")
    $clockIndex = ($timeHour % 12) * 2
    if ($timeMinute -ge 30) {
        $clockIndex += 1
    }
    
    $timeStr = $sl.PromptSymbols.ClockSymbols[$clockIndex] + " $timeStamp"
    if ($host.UI.RawUI.CursorPosition.X + $timeStr.Length + 9 -lt $host.UI.RawUI.WindowSize.Width) {
        $prompt += Set-CursorForRightBlockWrite -textLength ($timeStr.Length + 2)
        $prompt += Write-Prompt $timeStr -ForegroundColor $sl.Colors.StructColor
    }

    # Write the second line
    $prompt += Set-Newline
    $prompt += Write-Prompt -Object "╰─ " -ForegroundColor $sl.Colors.StructColor
    $prompt += Write-Prompt -Object $emojiSymbol -ForegroundColor $sl.Colors.StructColor # $emojiColor

    $prompt += ' '
    $prompt
}

function Get-TimeSinceLastCommit {
    return (git log --pretty=format:'%cr' -1)
}

$sl = $global:ThemeSettings #local settings

$sl.PromptSymbols.ClockSymbols = "🕛", "🕧", "🕐", "🕜", "🕑", "🕝", "🕒", "🕞", "🕓", "🕟", "🕔", "🕠", "🕕", "🕡", "🕖", "🕢", "🕗", "🕣", "🕘", "🕤", "🕙", "🕥", "🕚", "🕦"
$sl.PromptSymbols.LocationSymbol = "in"
$sl.PromptSymbols.WorkspaceSymbol = "⭍"
$sl.PromptSymbols.VenvSymbol = [char]::ConvertFromUtf32(0x2693)
$sl.Colors.StructColor = [System.ConsoleColor]::DarkGray
$sl.Colors.UserColor = [System.ConsoleColor]::Yellow
$sl.Colors.DirColor = [System.ConsoleColor]::Green
$sl.Colors.ErrorColor = [System.ConsoleColor]::Red
$sl.Colors.VenvColor = [System.ConsoleColor]::Magenta
$sl.Colors.GitDefaultColor = [System.ConsoleColor]::DarkGray
$sl.Colors.GitLocalChangesColor = [System.ConsoleColor]::Cyan
