# --- BASIC SETTINGS ---
Set-PSReadLineOption -EditMode Vi 
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView 
Set-PSReadLineOption -Colors @{ "InlinePrediction" = "`e[38;5;244m" }

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
oh-my-posh init pwsh --config "C:/Users/ltumi/AppData/Local/posh/zash.omp.json" | invoke-expression

# --- COMMAND-NOT-FOUND SUGGESTIONS ---
Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue

# --- ZOXIDE (Fast Directory Switching) ---
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# --- ALIASES for Modern Tools ---
function ll {
    & eza --color=always --long --git --icons=always --no-user --no-time @args
}
Set-Alias cat "bat"       
Set-Alias find "fd"      
Set-Alias grep "rg"     

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
