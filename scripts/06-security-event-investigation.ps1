# BonganiSecure Active Directory Security Engineering Lab
# Module 6: Security Event Investigation
# SIMULATION ONLY - Synthetic Windows Security events.
# No live Windows Event Logs are accessed.

$EventsPath = Join-Path $PSScriptRoot "../data/security-events.json"

if (-not (Test-Path $EventsPath)) {
    Write-Error "Security events file not found."
    exit 1
}

$Data = Get-Content $EventsPath -Raw | ConvertFrom-Json
$Events = @($Data.events)
$Findings = @()

Write-Host "`nBONGANISECURE SECURITY EVENT INVESTIGATION" -ForegroundColor Cyan
Write-Host "Domain: $($Data.domain)"
Write-Host "Lab status: $($Data.lab_status)"

Write-Host "`n--- EVENT SUMMARY ---"

$Events |
    Group-Object event_id |
    Sort-Object Name |
    ForEach-Object {
        Write-Host "Event ID $($_.Name): $($_.Count) event(s)"
    }

Write-Host "`n--- DETECTION RULES ---"

# Detect repeated failed logons.
$FailedLogons = @($Events | Where-Object { $_.event_id -eq 4625 })

$FailureGroups = $FailedLogons | Group-Object source_ip

foreach ($Group in $FailureGroups) {
    if ($Group.Count -ge 3) {
        $Findings += "HIGH: $($Group.Count) failed logons from $($Group.Name). Investigate possible password guessing."
    }
}

# Detect account creation.
$CreatedAccounts = @($Events | Where-Object { $_.event_id -eq 4720 })

foreach ($Event in $CreatedAccounts) {
    $Findings += "HIGH: New account '$($Event.target_account)' created by '$($Event.username)' at $($Event.timestamp). Verify authorisation."
}

# Detect privileged group membership changes.
$PrivilegedChanges = @(
    $Events | Where-Object {
        $_.event_id -eq 4728 -and $_.group -eq "Domain Admins"
    }
)

foreach ($Event in $PrivilegedChanges) {
    $Findings += "CRITICAL: '$($Event.target_account)' added to Domain Admins by '$($Event.username)'."
}

# Detect successful logons for newly created accounts.
foreach ($Created in $CreatedAccounts) {
    $NewAccountLogons = @(
        $Events | Where-Object {
            $_.event_id -eq 4624 -and
            $_.username -eq $Created.target_account
        }
    )

    foreach ($Logon in $NewAccountLogons) {
        $Findings += "HIGH: Newly created account '$($Created.target_account)' successfully logged on from $($Logon.source_ip)."
    }
}

# Detect audit log clearing.
$LogClearing = @($Events | Where-Object { $_.event_id -eq 1102 })

foreach ($Event in $LogClearing) {
    $Findings += "CRITICAL: Security audit log cleared by '$($Event.username)' at $($Event.timestamp). Investigate immediately."
}

# Detect account deletion.
$DeletedAccounts = @($Events | Where-Object { $_.event_id -eq 4726 })

foreach ($Event in $DeletedAccounts) {
    $Findings += "REVIEW: Account '$($Event.target_account)' deleted by '$($Event.username)'. Verify the change was authorised."
}

Write-Host "`n--- INVESTIGATION FINDINGS ---"

if ($Findings.Count -eq 0) {
    Write-Host "No findings detected in the supplied dataset."
}
else {
    foreach ($Finding in $Findings) {
        Write-Host $Finding
    }
}

Write-Host "`n--- INCIDENT TIMELINE ---"

$Events |
    Sort-Object timestamp |
    ForEach-Object {
        Write-Host "$($_.timestamp) | Event $($_.event_id) | $($_.username) | $($_.description)"
    }

Write-Host "`n--- INVESTIGATION SUMMARY ---"
Write-Host "Events reviewed: $($Events.Count)"
Write-Host "Failed logons: $($FailedLogons.Count)"
Write-Host "Accounts created: $($CreatedAccounts.Count)"
Write-Host "Privileged group changes: $($PrivilegedChanges.Count)"
Write-Host "Audit log clearing events: $($LogClearing.Count)"
Write-Host "Findings generated: $($Findings.Count)"

Write-Host "`nSIMULATION COMPLETE - No live systems accessed or modified."
