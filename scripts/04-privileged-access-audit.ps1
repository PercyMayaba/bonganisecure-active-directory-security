# BonganiSecure Active Directory Security Engineering Lab
# Module 4: Privileged Accounts and Delegation Audit
# SIMULATION ONLY - Uses synthetic JSON data.
# Does not connect to or modify Active Directory.

$InventoryPath = Join-Path $PSScriptRoot "../data/privileged-access-inventory.json"

if (-not (Test-Path $InventoryPath)) {
    Write-Error "Inventory file not found: $InventoryPath"
    exit 1
}

$Inventory = Get-Content $InventoryPath -Raw | ConvertFrom-Json
$Accounts = $Inventory.accounts
$Findings = @()

Write-Host "`nBONGANISECURE PRIVILEGED ACCESS AUDIT" -ForegroundColor Cyan
Write-Host "Lab status: $($Inventory.lab_status)"
Write-Host "Domain: $($Inventory.domain)"

Write-Host "`n--- PRIVILEGED GROUP MEMBERSHIPS ---"

foreach ($Account in $Accounts) {
    foreach ($Group in $Account.privileged_groups) {
        Write-Host "$($Account.username) -> $Group"
    }
}

Write-Host "`n--- SECURITY FINDINGS ---"

foreach ($Account in $Accounts) {

    if ($Account.privileged_groups -contains "Domain Admins" -and
        $Account.account_type -eq "Standard User") {
        $Findings += "HIGH: Standard user '$($Account.username)' belongs to Domain Admins."
    }

    if (-not $Account.enabled -and $Account.privileged_groups.Count -gt 0) {
        $Findings += "HIGH: Disabled account '$($Account.username)' retains privileged-group membership."
    }

    if ($Account.account_type -eq "Service Account" -and
        $Account.privileged_groups.Count -gt 0) {
        $Findings += "REVIEW: Service account '$($Account.username)' has privileged-group membership."
    }

    if ($Account.uses_standard_account_for_admin) {
        $Findings += "MEDIUM: '$($Account.username)' uses a standard account for administrative activity."
    }
}

if ($Findings.Count -eq 0) {
    Write-Host "No findings detected in the supplied dataset."
}
else {
    foreach ($Finding in $Findings) {
        Write-Host $Finding
    }
}

Write-Host "`n--- AUDIT SUMMARY ---"
Write-Host "Accounts reviewed: $($Accounts.Count)"
Write-Host "Accounts with privileged memberships: $(($Accounts | Where-Object { $_.privileged_groups.Count -gt 0 }).Count)"
Write-Host "Findings generated: $($Findings.Count)"

Write-Host "`nSIMULATION COMPLETE - No live Active Directory changes made."
