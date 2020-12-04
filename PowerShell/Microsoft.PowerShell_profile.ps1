Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Vbcpascal

# Set the workspace dir
$WorkspaceDir = "~\Documents\Workspace"

# Set command alias
New-Alias -Name to-ws -Value Enter-Workspace
New-Alias -Name ~~ -Value Enter-Workspace
New-Alias -Name to-proj -Value Enter-Project
New-Alias -Name `` -Value Enter-Project

# Command: Enter the Workspace directory
Function Enter-Workspace {
    [CmdletBinding()]
    param ()
    begin {
        if (Test-Path $WorkspaceDir) {
            Set-Location $WorkspaceDir
        }
        else {
            Write-Error "Workspace directory does not exist: $WorkspaceDir"
            break;
        }
    }
}

# Command: Enter the specific project
Function Enter-Project {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "Project name")]
        [string] $ProjectName,
        [Parameter(HelpMessage = "Use Push-Location instead of Set-Location")]
        [switch] $p
    )
    begin {
        $ProjectDir = "$WorkspaceDir/$ProjectName"
        if (Test-Path $ProjectDir) {
            if ($p) {
                Push-Location $ProjectDir
            }
            else {
                Set-Location $ProjectDir
            }
        }
        else {
            Write-Error "Project directory does not exist: $ProjectDir"
            break;
        }
    }
}
# $EnterProjectCompleter = { Get-ChildItem -Path $WorkspaceDir | Select-Object -ExpandProperty Name }
$EnterProjectCompleter = { 
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    (Get-ChildItem -Path $WorkspaceDir).Name | Where-Object {
        $_ -like "$wordToComplete*"
    } | ForEach-Object {
        $_.contains(" ") ? "'$_'" : "$_"
    } 
}
Register-ArgumentCompleter -CommandName Enter-Project -ParameterName ProjectName -ScriptBlock $EnterProjectCompleter

# Command: create a new project and enter to it
Function New-Project {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "Project name")]
        [string] $ProjectName,
        [Parameter(HelpMessage = "Do not enter the directory after creation.")]
        [switch] $n
    )
    begin {
        if (-NOT (Test-Path $WorkspaceDir)) {
            Write-Error "Workspace directory does not exist: $WorkspaceDir"
            break
        }
        $ProjectDir = "$WorkspaceDir/$ProjectName"
        if (Test-Path $ProjectDir) {
            Write-Warning "Project directory exists: $ProjectDir. Will enter the directory by Push-Location."
            Push-Location $ProjectDir
            break
        }
        mkdir $ProjectDir > $null
        if (-NOT $n) {
            Push-Location $ProjectDir
            break
        }
    }
}
