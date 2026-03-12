' switch-audio.vbs
' Silent launcher for Switch-AudioDevice.ps1
' Place this file in the same folder as Switch-AudioDevice.ps1.
' Assign a hotkey to this .vbs via AutoHotkey or a Windows shortcut.

Dim scriptDir, ps1Path, cmd

scriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
ps1Path   = scriptDir & "\Switch-AudioDevice.ps1"

cmd = "powershell.exe -NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & ps1Path & """"

CreateObject("WScript.Shell").Run cmd, 0, False
