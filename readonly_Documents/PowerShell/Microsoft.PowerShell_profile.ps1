# -------- CORE SETTINGS --------
Set-PSReadLineOption -EditMode Vi

function OnViModeChange($mode) {
	if ($mode -eq 'Command') {
		Write-Host -NoNewline "`e[1 q"
	} else {
		Write-Host -NoNewline "`e[5 q"
	}
}

Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -MaximumHistoryCount 10000

if ($Host.UI.SupportsVirtualTerminal) {
	Set-PSReadLineOption -PredictionSource HistoryAndPlugin
	Set-PSReadLineOption -PredictionViewStyle InlineView
	Set-PSReadLineOption -Colors @{ InlinePrediction = "`e[38;5;244m" }
}

$ErrorView = "ConciseView"

# -------- PROMPT (Oh My Posh + fallback) --------
# https://windowsterminalthemes.dev/
$ompConfig = "$HOME\AppData\Local\posh\my-config.omp.json"

if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
	oh-my-posh init pwsh --config $ompConfig | Invoke-Expression
} else {
	function prompt {
		$path = (Get-Location).Path
		if ($path -like "$HOME*") {
			$path = $path -replace [regex]::Escape($HOME), '~'
		}
		Write-Host "`n$path ⮞ " -ForegroundColor Blue -NoNewline
		return " "
	}
}

# -------- ENVIRONMENT --------
$env:EDITOR = "nvim"
$env:FZF_DEFAULT_COMMAND = "fd --type f --hidden --exclude .git"
$env:FZF_CTRL_T_COMMAND = $env:FZF_DEFAULT_COMMAND
$env:FZF_DEFAULT_OPTS = "--height 40% --layout=reverse"
$env:FZF_CTRL_T_OPTS = "--preview 'bat --color=always --style=plain --line-range=:200 {}'"
$env:FZF_CTRL_R_OPTS = "--preview 'echo {} | bat --color=always --language=sh'"
$env:BAT_THEME = "ansi"
$env:RIPGREP_CONFIG_PATH = "$HOME\.ripgreprc"

# -------- MODULES --------
Import-Module Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue
Import-Module posh-direnv -ErrorAction SilentlyContinue
Import-Module PSFzf -ErrorAction SilentlyContinue

# -------- EXTERNAL TOOLS INIT --------
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
Set-PsFzfOption -PSReadlineChordSetLocation 'Alt+c'

# -------- ALIASES --------
Set-Alias cat bat
Set-Alias find fd
Set-Alias grep rg
Set-Alias v nvim
Set-Alias fastcp robocopy

function .. { Set-Location .. }
function ... { Set-Location ../.. }

# -------- FUNCTIONS --------
if (Get-Command eza -ErrorAction SilentlyContinue) {
	function ll {
		eza --color=always --long --git --icons=always --no-user --no-time @args
	}
} else {
	function ll {
		Get-ChildItem @args
	}
}

function gitree {
	git log --graph --oneline --all --decorate --color=always
}

function nvims {
	if (-not $env:NVIM_LISTEN_ADDRESS) {
		$env:NVIM_LISTEN_ADDRESS = "127.0.0.1:6666"
	}
	nvim --listen $env:NVIM_LISTEN_ADDRESS @args
}

function zv {
	param ([Parameter(ValueFromRemainingArguments = $true)][string[]]$Args)
	if (Get-Command z -ErrorAction SilentlyContinue) {
		z @Args
		nvim
	}
}

function fedit {
	nvim (fd --type f | fzf --preview "bat --style=numbers --color=always {}")
}

function dif {
	param([string]$file1, [string]$file2)
	git diff --no-index $file1 $file2
}

function psln ($target, $link) {
	New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function fetch { fastfetch -c examples/13 }
function ncdu { dua i }
function ascii { less "$HOME\.local\share\ascii.txt" }

function Start-Conda {
	$condaPath = "$HOME\miniforge3\Scripts\conda.exe"
	if (Test-Path $condaPath) {
		(& $condaPath "shell.powershell" "hook") | Out-String | Invoke-Expression
		Write-Host "Conda initialized" -ForegroundColor Green
	} else {
		Write-Host "Conda not found" -ForegroundColor Red
	}
}
Set-Alias condaactivate Start-Conda

# -------- CUSTOM SCRIPTS --------
. "$HOME\Documents\PowerShell\Scripts\venv.ps1"
. "$HOME\Documents\PowerShell\Scripts\ai.ps1"
