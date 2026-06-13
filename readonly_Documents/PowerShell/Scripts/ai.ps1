function ai {
    Write-Host "1) gemini"
    Write-Host "2) codex"
    Write-Host "3) opencode"
    Write-Host "4) pi"
    Write-Host "5) agy"
    Write-Host "6) claude"
    Write-Host "7) copilot"
    Write-Host "8) vibe (mistral)"
    Write-Host "9) kimi"
    Write-Host "10) qwen"

    $choice = (Read-Host "Select AI").ToLower()

    switch ($choice) {
        { $_ -in "1","gemini" } { gemini; break }
        { $_ -in "2","codex" } { codex; break }
        { $_ -in "3","opencode" } { opencode; break }
        { $_ -in "4","pi" } { pi; break }
        { $_ -in "5","agy" } { agy; break }
        { $_ -in "6","claude" } { ccc; break }
        { $_ -in "7","copilot" } { gh copilot; break }
        { $_ -in "8","vibe","mistral" } { vibe; break }
        { $_ -in "9","kimi" } { kimi; break }
        { $_ -in "10","qwen" } { qwen; break }
        default { Write-Host "Invalid choice" }
    }
}
