
# BonganiSecure Active Directory Security Lab
# Module 1: Simulated Directory Inventory
# Status: SIMULATION - no live Active Directory connection

$Users = @(
    [PSCustomObject]@{
        Name = "John Finance"
        Department = "Finance"
        Username = "jfinance"
        Group = "GRP-Finance-Users"
        Privileged = $false
        Enabled = $true
    },
    [PSCustomObject]@{
        Name = "Sarah HR"
        Department = "Human Resources"
        Username = "shr"
        Group = "GRP-HR-Users"
        Privileged = $false
        Enabled = $true
    },
    [PSCustomObject]@{
        Name = "David IT"
        Department = "Information Technology"
        Username = "dit"
        Group = "GRP-IT-Users"
        Privileged = $false
        Enabled = $true
    },
    [PSCustomObject]@{
        Name = "Admin Account"
        Department = "Information Technology"
        Username = "admin01"
        Group = "GRP-Domain-Admins"
        Privileged = $true
        Enabled = $true
    },
    [PSCustomObject]@{
        Name = "Mary Risk"
        Department = "Risk and Compliance"
        Username = "mrisk"
        Group = "GRP-Risk-Users"
        Privileged = $false
        Enabled = $true
    },
    [PSCustomObject]@{
        Name = "Peter Former Employee"
        Department = "Finance"
        Username = "pformer"
        Group = "GRP-Finance-Users"
        Privileged = $false
        Enabled = $false
    }
)

Write-Host "========================================"
Write-Host " BONGANISECURE DIRECTORY SECURITY AUDIT"
Write-Host " SIMULATED DATA - NOT A LIVE AD QUERY"
Write-Host "========================================"

Write-Host "`n1. TOTAL DIRECTORY ACCOUNTS"

$Users.Count

Write-Host "`n2. ENABLED ACCOUNTS"

$Users | Where-Object { $_.Enabled -eq $true } |
    Format-Table Name, Username, Department

Write-Host "`n3. DISABLED ACCOUNTS"

$Users | Where-Object { $_.Enabled -eq $false } |
    Format-Table Name, Username, Department

Write-Host "`n4. PRIVILEGED ACCOUNTS"

$Users | Where-Object { $_.Privileged -eq $true } |
    Format-Table Name, Username, Group

Write-Host "`n5. DEPARTMENT ACCOUNT COUNTS"

$Users | Group-Object Department |
    Select-Object Name, Count |
    Format-Table -AutoSize

Write-Host "`n6. SECURITY OBSERVATIONS"

$DisabledUsers = @(
    $Users | Where-Object { $_.Enabled -eq $false }
)

$PrivilegedUsers = @(
    $Users | Where-Object { $_.Privileged -eq $true }
)

Write-Host "Disabled accounts found: $($DisabledUsers.Count)"
Write-Host "Privileged accounts found: $($PrivilegedUsers.Count)"

Write-Host "`nAUDIT COMPLETE"
Write-Host "All results are based on synthetic lab data."
