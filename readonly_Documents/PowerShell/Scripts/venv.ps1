# Virtualenv home
# $env:VENV_HOME = "$HOME\.virtualenvs"
$env:VENV_HOME = "$HOME\LORENZO\Probe"

# Ensure directory exists
if (!(Test-Path $env:VENV_HOME)) {
    New-Item -ItemType Directory -Path $env:VENV_HOME | Out-Null
}

function lsvenv {
    Get-ChildItem -Directory -Name $env:VENV_HOME
}

function mkvenv {
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    python -m venv (Join-Path $env:VENV_HOME $Name)
}

function venv {
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    $activateScript = Join-Path $env:VENV_HOME "$Name\Scripts\Activate.ps1"

    if (Test-Path $activateScript) {
        . $activateScript
    } else {
        Write-Host "Virtualenv '$Name' not found"
    }
}

function rmvenv {
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    $path = Join-Path $env:VENV_HOME $Name

    if (Test-Path $path) {
        Remove-Item -Recurse -Force $path
    } else {
        Write-Host "Virtualenv '$Name' not found"
    }
}
