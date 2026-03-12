# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

---

## [1.0.0] - 2026-03-12

### Added

- **AudioSwitch**: PowerShell script (`Switch-AudioDevice.ps1`) to cycle through or select audio output devices.
  - Supports `-List` flag to display available playback devices with the active one highlighted.
  - Supports `-Name` parameter to switch to a specific device by partial name match.
  - Auto-installs the `AudioDeviceCmdlets` module if not present.
  - AutoHotkey v2 hotkey binding (`switch-audio.ahk`) — default key: `F9`.
  - VBScript silent launcher (`switch-audio.vbs`) for use with Windows shortcuts or task scheduler.

- **PauseYoutube**: AutoHotkey v2 script (`pause-youtube.ahk`) to pause/resume YouTube in Firefox without stealing focus.
  - Sends the native YouTube `k` shortcut to the Firefox window in the background.
  - Falls back to temporarily activating Firefox if `ControlSend` fails.
  - Shows a tray balloon notification when no YouTube tab is detected.
  - Default hotkey: `Ctrl+Alt+P` (configurable via `MyKey` variable).

- `.gitignore` excluding compiled `.exe` binaries from version control.
- `README.md` with setup instructions, dependency list, and usage examples for both utilities.
