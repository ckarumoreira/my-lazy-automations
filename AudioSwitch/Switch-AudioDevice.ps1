# Switch-AudioDevice.ps1
# Cycles through available audio output devices or switches to a specific one.
#
# Usage:
#   .\Switch-AudioDevice.ps1                  # cycles to next device
#   .\Switch-AudioDevice.ps1 -List            # lists available devices
#   .\Switch-AudioDevice.ps1 -Name "Speakers" # switches to device matching name

param(
    [switch]$List,
    [string]$Name
)

# Requires AudioDeviceCmdlets module. Install with:
#   Install-Module -Name AudioDeviceCmdlets -Scope CurrentUser -Force
function Ensure-Module {
    if (-not (Get-Module -ListAvailable -Name AudioDeviceCmdlets)) {
        Write-Host "Installing AudioDeviceCmdlets module..." -ForegroundColor Yellow
        Install-Module -Name AudioDeviceCmdlets -Scope CurrentUser -Force -ErrorAction Stop
    }
    Import-Module AudioDeviceCmdlets -ErrorAction Stop
}

function Get-PlaybackDevices {
    # Returns only enabled playback (output) devices, sorted by index
    Get-AudioDevice -List | Where-Object { $_.Type -eq 'Playback' } | Sort-Object Index
}

function Show-Notification {
    param([string]$DeviceName)
    $wshell = New-Object -ComObject WScript.Shell
    $wshell.Popup("Audio output: $DeviceName", 2, "Audio Switcher", 64) | Out-Null
}

try {
    Ensure-Module

    $devices = Get-PlaybackDevices

    if ($List) {
        $current = Get-AudioDevice -Playback
        Write-Host "`nAvailable playback devices:" -ForegroundColor Cyan
        foreach ($d in $devices) {
            $marker = if ($d.ID -eq $current.ID) { " <-- active" } else { "" }
            Write-Host ("  [{0}] {1}{2}" -f $d.Index, $d.Name, $marker)
        }
        return
    }

    if ($Name) {
        $target = $devices | Where-Object { $_.Name -like "*$Name*" } | Select-Object -First 1
        if (-not $target) {
            Write-Error "No playback device found matching '$Name'."
            exit 1
        }
    } else {
        # Cycle: find current, pick the next one (wraps around)
        $current = Get-AudioDevice -Playback
        $currentIndex = $devices.Index.IndexOf($current.Index)
        if ($currentIndex -lt 0) { $currentIndex = 0 }
        $nextIndex = ($currentIndex + 1) % $devices.Count
        $target = $devices[$nextIndex]
    }

    Set-AudioDevice -Index $target.Index | Out-Null
    # Write-Host "Switched to: $($target.Name)" -ForegroundColor Green

    # Toast-style popup (disappears after 2 s, no click needed)
    # Show-Notification -DeviceName $target.Name

} catch {
    Write-Error $_.Exception.Message
    exit 1
}
