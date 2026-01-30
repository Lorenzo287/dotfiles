# can Override Chris config, for example
function Get-Theme_Override {
	oh-my-posh init pwsh --config "C:/Users/ltumi/AppData/Local/posh/my-config.omp.json" | invoke-expression
}

function fetch {
    fastfetch -c examples/13
}
