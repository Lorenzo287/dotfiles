function ai {
    Write-Host "1) claude"
    Write-Host "2) gemini"
    Write-Host "3) opencode"
    Write-Host "4) codex"
    Write-Host "5) vibe (mistral)"
    Write-Host "6) pi"

    $choice = (Read-Host "Select AI").ToLower()

    switch ($choice) {
        { $_ -in "1","claude" } { claude; break }
        { $_ -in "2","gemini" } { gemini; break }
        { $_ -in "3","opencode" } { opencode; break }
        { $_ -in "4","codex" } { codex; break }
        { $_ -in "5","vibe","mistral" } { vibe; break }
        { $_ -in "6","pi" } { pi; break }
        default { Write-Host "Invalid choice" }
    }
}
