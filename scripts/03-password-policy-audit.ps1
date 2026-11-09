
# BonganiSecure Active Directory Security Lab
# Module 3: Password Policy Audit
# SIMULATION - no live domain policy is queried or changed

# Proposed security baseline
$Baseline = [PSCustomObject]@{
    MinimumPasswordLength = 14
    PasswordComplexity = $true
    LockoutThreshold = 10
    LockoutDurationMinutes = 15
    LockoutObservationWindowMinutes = 15
    ReversibleEncryption = $false
}

# Synthetic observed policy for audit testing
$ObservedPolicy = [PSCustomObject]@{
    MinimumPasswordLength = 10
    PasswordComplexity = $true
    LockoutThreshold = 5
    LockoutDurationMinutes = 30
    LockoutObservationWindowMinutes = 30
    ReversibleEncryption = $false
}

$Findings = @()

if ($ObservedPolicy.MinimumPasswordLength -lt $Baseline.MinimumPasswordLength) {
    $Findings += "FAIL: Minimum password length is below the proposed baseline."
}

if ($ObservedPolicy.PasswordComplexity -ne $Baseline.PasswordComplexity) {
    $Findings += "FAIL: Password complexity does not match the baseline."
}

if ($ObservedPolicy.LockoutThreshold -gt $Baseline.LockoutThreshold -or
    $ObservedPolicy.LockoutThreshold -eq 0) {
    $Findings += "FAIL: Account lockout threshold is weaker than the baseline."
}

if ($ObservedPolicy.LockoutDurationMinutes -ne $Baseline.LockoutDurationMinutes) {
    $Findings += "REVIEW: Account lockout duration differs from the baseline."
}

if ($ObservedPolicy.LockoutObservationWindowMinutes -ne $Baseline.LockoutObservationWindowMinutes) {
    $Findings += "REVIEW: Lockout observation window differs from the baseline."
}

if ($ObservedPolicy.ReversibleEncryption -ne $Baseline.ReversibleEncryption) {
    $Findings += "FAIL: Reversible password encryption setting is unsafe."
}

Write-Host "=========================================="
Write-Host " BONGANISECURE PASSWORD POLICY AUDIT"
Write-Host " SIMULATED POLICY DATA"
Write-Host "=========================================="

Write-Host "`nPROPOSED BASELINE"
$Baseline | Format-List

Write-Host "SYNTHETIC OBSERVED POLICY"
$ObservedPolicy | Format-List

Write-Host "AUDIT FINDINGS"

if ($Findings.Count -eq 0) {
    Write-Host "No differences detected."
}
else {
    $Findings | ForEach-Object { Write-Host $_ }
}

Write-Host "`nTotal findings: $($Findings.Count)"
Write-Host "AUDIT COMPLETE"
Write-Host "No live Active Directory policy was queried or changed."
