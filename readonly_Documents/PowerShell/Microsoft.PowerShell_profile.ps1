# --- BASIC SETTINGS ---
Set-PSReadLineOption -EditMode Vi
if (Get-Module -ListAvailable PSReadLine -ErrorAction SilentlyContinue) {
    if ($Host.UI.SupportsVirtualTerminal) {
        Set-PSReadLineOption -PredictionSource History
        Set-PSReadLineOption -PredictionViewStyle InlineView
        Set-PSReadLineOption -Colors @{ InlinePrediction = "`e[38;5;244m" }
    }
}

# --- PATH SHORTENER + CUSTOM PROMPT ---
# function prompt {
#     $path = (Get-Location).Path
#     if ($path -like "$HOME*") {
#         $path = $path -replace [regex]::Escape($HOME), '~'
#     }
#     Write-Host ""
#     Write-Host "$path ⮞ " -ForegroundColor Blue -NoNewLine
#     return " "
# }

# --- OH-MY-POSH (Theme + Aesthetics) ---
# https://windowsterminalthemes.dev/
oh-my-posh init pwsh --config "C:/Users/ltumi/AppData/Local/posh/my-config.omp.json" | invoke-expression

# --- COMMAND-NOT-FOUND SUGGESTIONS ---
Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue

# --- ZOXIDE (Fast Directory Switching) ---
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# --- DIRENV (Load Environment Variables and Venv) ---
$env:EDITOR = "nvim"
Import-Module posh-direnv

# --- ALIASES for Modern Tools ---
function ll {
    & eza --color=always --long --git --icons=always --no-user --no-time @args
}
Set-Alias cat "bat"       
Set-Alias find "fd"  # find / -iname "*word*" 2>/dev/null    
Set-Alias grep "rg"     
Set-Alias v "nvim"     
function zv {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    z @Args
    v
}
function fetch {
    fastfetch -c examples/13
}
function dif {
    param(
        [string]$file1,
        [string]$file2
    )
    Compare-Object (Get-Content $file1) (Get-Content $file2) |
        Select-Object SideIndicator, InputObject
}

# --- FZF Integration ---
# --- Function to search files + open in default editor ---
function fedit {
    $file = fd --type f | fzf
    if ($file) { nvim $file }
}

# --- BAT as Default Pager ---
# $env:PAGER = "bat"
$env:BAT_THEME = "Nord"

# --- FZF Default Options ---
$env:FZF_DEFAULT_COMMAND = "fd --type f --hidden --exclude .git"
$env:FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border --preview 'bat --color=always --style=plain --line-range=:200 {}'"

# --- RIPGREP Defaults ---
$env:RIPGREP_CONFIG_PATH = "$HOME\.ripgreprc"
