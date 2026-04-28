function ai {
    Write-Host "1) claude"
    Write-Host "2) gemini"
    Write-Host "3) opencode"
    Write-Host "4) codex"
    Write-Host "5) vibe (mistral)"
    Write-Host "6) pi"
    Write-Host "7) kimi"
    Write-Host "8) qwen"

    $choice = (Read-Host "Select AI").ToLower()

    switch ($choice) {
        { $_ -in "1","claude" } { ccc; break }
        { $_ -in "2","gemini" } { gemini; break }
        { $_ -in "3","opencode" } { opencode; break }
        { $_ -in "4","codex" } { codex; break }
        { $_ -in "5","vibe","mistral" } { vibe; break }
        { $_ -in "6","pi" } { pi; break }
        { $_ -in "7","kimi" } { kimi; break }
        { $_ -in "8","qwen" } { qwen; break }
        default { Write-Host "Invalid choice" }
    }
}
