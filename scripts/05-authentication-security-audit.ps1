# BonganiSecure Active Directory Security Engineering Lab
# Module 5: Kerberos, LDAP and Authentication Security Audit
# SIMULATION ONLY - Synthetic authentication events.
# No live Active Directory connection.

$EventsPath = Join-Path $PSScriptRoot "../data/authentication-events.json"

if (-not (Test-Path $EventsPath)) {
    Write-Error "Authentication events file not found."
    exit 1
}

$Data = Get-Content $EventsPath -Raw | ConvertFrom-Json
$Events = $Data.events
$Findings = @()

Write-Host "`nAUTHENTICATION SECURITY AUDIT" -ForegroundColor Cyan
Write-Host "Domain: $($Data.domain)"
Write-Host "Lab status: $($Data.lab_status)"

Write-Host "`n--- AUTHENTICATION PROTOCOL SUMMARY ---"

$Events |
    Group-Object authentication_protocol |
    ForEach-Object {
        Write-Host "$($_.Name): $($_.Count) events"
    }

Write-Host "`n--- FAILED AUTHENTICATION EVENTS ---"

$Failures = $Events | Where-Object { $_.result -eq "Failure" }

foreach ($Failure in $Failures) {
    Write-Host "$($Failure.timestamp) | $($Failure.username) | $($Failure.authentication_protocol) | $($Failure.source_ip)"
}

Write-Host "`n--- SECURITY INVESTIGATION ---"

# Detect repeated failed authentication from the same source IP.
$RepeatedFailures = $Failures |
    Group-Object source_ip |
    Where-Object { $_.Count -ge 3 }

foreach ($Group in $RepeatedFailures) {
    $Findings += "HIGH: $($Group.Count) failed authentication events from source IP $($Group.Name). Investigate possible password guessing or legacy authentication abuse."
}

# Identify NTLM authentication activity for review.
$NTLMEvents = $Events |
    Where-Object { $_.authentication_protocol -eq "NTLM" }

if ($NTLMEvents.Count -gt 0) {
    $Findings += "REVIEW: $($NTLMEvents.Count) NTLM events detected. Identify dependencies and plan controlled migration to stronger authentication."
}

# Identify service-ticket activity for investigation.
$ServiceTicketEvents = $Events |
    Where-Object { $_.event_type -like "*Service_Ticket*" }

if ($ServiceTicketEvents.Count -gt 0) {
    $Findings += "REVIEW: $($ServiceTicketEvents.Count) service-ticket events detected. Validate service account permissions and monitor unusual ticket-request patterns."
}

# Identify privileged authentication.
$PrivilegedEvents = $Events |
    Where-Object { $_.event_type -eq "Privileged_Authentication" }

if ($PrivilegedEvents.Count -gt 0) {
    $Findings += "REVIEW: $($PrivilegedEvents.Count) privileged authentication events detected. Confirm administrative activity is authorised."
}

# Identify standard accounts accessing services.
$StandardAccountEvents = $Events |
    Where-Object { $_.event_type -eq "Standard_Account_Service_Access" }

if ($StandardAccountEvents.Count -gt 0) {
    $Findings += "REVIEW: Standard account service access detected. Validate whether the access is appropriate."
}

Write-Host "`n--- AUDIT FINDINGS ---"

if ($Findings.Count -eq 0) {
    Write-Host "No findings detected."
}
else {
    foreach ($Finding in $Findings) {
        Write-Host $Finding
    }
}

Write-Host "`n--- AUDIT SUMMARY ---"
Write-Host "Events reviewed: $($Events.Count)"
Write-Host "Failed authentications: $($Failures.Count)"
Write-Host "NTLM events: $($NTLMEvents.Count)"
Write-Host "Findings generated: $($Findings.Count)"

Write-Host "`nSIMULATION COMPLETE - No live authentication activity inspected."
