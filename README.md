# My Lazy Automations

Collection of Windows automation utilities for you. You're not lazy, you just love optimizing unnecessary stuff.

---

## AudioSwitch

Cycles through available audio output devices or switches to a specific one.

### Dependencies

- **PowerShell** (built into Windows)
- **AudioDeviceCmdlets** module — install once:
  ```powershell
  Install-Module -Name AudioDeviceCmdlets -Scope CurrentUser -Force
  ```
- **AutoHotkey v2** — required only to use the hotkey binding: https://www.autohotkey.com/

### Usage

**PowerShell (direct):**
```powershell
# Cycle to next device
.\AudioSwitch\Switch-AudioDevice.ps1

# List available devices
.\AudioSwitch\Switch-AudioDevice.ps1 -List

# Switch to a specific device by name (partial match)
.\AudioSwitch\Switch-AudioDevice.ps1 -Name "Speakers"
```

**Hotkey (Win + F9):**
Run `switch-audio.ahk` with AutoHotkey v2. Press `Windows + F9` to cycle to the next device.

**Silent launcher:**
Run `switch-audio.vbs` to trigger the script silently (no PowerShell window). Useful when assigning via Windows shortcuts or task scheduler.

**Compile to EXE:**
```
Ahk2Exe.exe /in switch-audio.ahk /out switch-audio.exe
```
> `.exe` files are excluded from version control — compile from source when needed.

---

## PauseYoutube

Pauses/resumes a YouTube tab open in Firefox without stealing focus from the current window.

### Dependencies

- **AutoHotkey v2**: https://www.autohotkey.com/
- **Firefox** with a YouTube tab open

### Usage

Run `pause-youtube.ahk` with AutoHotkey v2. The default hotkey is `Ctrl+Alt+P`.

To change the hotkey, edit the `MyKey` variable at the top of `pause-youtube.ahk`:
```ahk
MyKey := "^!p"   ; Ctrl+Alt+P
;   ^  = Ctrl   !  = Alt   #  = Win   +  = Shift
```

**Compile to EXE:**
```
Ahk2Exe.exe /in pause-youtube.ahk /out pause-youtube.exe
```
> `.exe` files are excluded from version control — compile from source when needed.
