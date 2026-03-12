; pause-youtube.ahk  —  AutoHotkey v2
; Pauses / resumes any YouTube tab open in Firefox,
; without stealing focus from your current window.
;
; Default hotkey: Ctrl+Alt+P
; Change HOTKEY below to whatever you prefer.
;
; Requires AutoHotkey v2: https://www.autohotkey.com/

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Configuration -----------------------------------------------------------
MyKey := "^!p"   ; Ctrl+Alt+P
;   ^  = Ctrl   !  = Alt   #  = Win   +  = Shift
;   Examples:
;     "^!p"    →  Ctrl+Alt+P
;     "#F8"    →  Win+F8
;     "^!F9"   →  Ctrl+Alt+F9
; -----------------------------------------------------------------------------

Hotkey MyKey, ToggleYouTube

ToggleYouTube(*) {
    ; Find a Firefox window whose title contains "YouTube"
    targetWin := ""
    for hwnd in WinGetList("ahk_exe firefox.exe") {
        title := WinGetTitle(hwnd)
        if InStr(title, "YouTube") {
            targetWin := hwnd
            break
        }
    }

    if !targetWin {
        ShowBalloon("YouTube não encontrado",
                    "Nenhuma aba do YouTube foi detectada no Firefox.")
        return
    }

    ; Send "k" to the Firefox window (YouTube's native pause/play shortcut).
    ; ControlSend targets the MozillaWindowClass pane so the keypress lands
    ; in the page even when Firefox is in the background.
    try {
        ControlSend "k", "MozillaWindowClass1", targetWin
    } catch {
        ; Fallback: bring Firefox to front, send key, restore previous window
        prevWin := WinExist("A")
        WinActivate(targetWin)
        WinWaitActive(targetWin, , 1)
        Send "k"
        if prevWin
            WinActivate(prevWin)
    }
}

; --- Helper: tray balloon notification (disappears automatically) ----------
ShowBalloon(title, text, timeout := 3000) {
    TrayTip text, title
    SetTimer () => TrayTip(), -timeout
}
