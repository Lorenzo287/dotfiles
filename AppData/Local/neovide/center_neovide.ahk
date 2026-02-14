#Requires AutoHotkey v2.0

Run("neovide.exe")
WinWait("ahk_exe neovide.exe")

; Wait for the window to actually exist in 2D space
Loop {
    WinGetPos(,, &W, &H, "ahk_exe neovide.exe")
    if (W > 100)
        break
    Sleep(50)
}

; GET COORDINATES OF THE MONITOR UNDER THE MOUSE
; This makes it work regardless of which monitor is "Primary"
MouseGetPos(&mX, &mY)
monitorCount := MonitorGetCount()
targetMonitor := 1

Loop monitorCount {
    MonitorGetWorkArea(A_Index, &mLeft, &mTop, &mRight, &mBottom)
    if (mX >= mLeft && mX <= mRight && mY >= mTop && mY <= mBottom) {
        targetMonitor := A_Index
        break
    }
}

; Get the dimensions of the specific monitor we found
MonitorGetWorkArea(targetMonitor, &Left, &Top, &Right, &Bottom)
WinGetPos(,, &Width, &Height, "ahk_exe neovide.exe")

CenterX := Left + ((Right - Left - Width) // 2)
CenterY := Top + ((Bottom - Top - Height) // 2)

WinMove(CenterX, CenterY,,, "ahk_exe neovide.exe")
