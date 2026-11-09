
# BonganiSecure Active Directory Security Lab
# Module 2: Security Group Audit
# SIMULATION - synthetic directory data only

$GroupMemberships = @(
    [PSCustomObject]@{
        Username = "jfinance"
        Group = "GRP-Finance-Users"
        Privileged = $false
    },
    [PSCustomObject]@{
        Username = "shr"
        Group = "GRP-HR-Users"
        Privileged = $false
    },
    [PSCustomObject]@{
        Username = "dit"
        Group = "GRP-IT-Users"
        Privileged = $false
    },
    [PSCustomObject]@{
        Username = "admin01"
        Group = "GRP-Domain-Admins"
        Privileged = $true
    },
    [PSCustomObject]@{
        Username = "mrisk"
        Group = "GRP-Risk-Users"
        Privileged = $false
    },
    [PSCustomObject]@{
        Username = "pformer"
        Group = "GRP-Finance-Users"
        Privileged = $false
    },
    [PSCustomObject]@{
        Username = "jfinance"
        Group = "GRP-Domain-Admins"
        Privileged = $true
    }
)

Write-Host "===================================="
Write-Host " SECURITY GROUP MEMBERSHIP AUDIT"
Write-Host " SIMULATED DATA"
Write-Host "===================================="

Write-Host "`n1. ALL GROUP MEMBERSHIPS"

$GroupMemberships |
    Format-Table Username, Group, Privileged

Write-Host "`n2. PRIVILEGED GROUP MEMBERS"

$GroupMemberships |
    Where-Object { $_.Privileged -eq $true } |
    Format-Table Username, Group

Write-Host "`n3. USERS WITH MULTIPLE GROUP MEMBERSHIPS"

$GroupMemberships |
    Group-Object Username |
    Where-Object { $_.Count -gt 1 } |
    Select-Object Name, Count |
    Format-Table

Write-Host "`n4. GROUP MEMBERSHIP COUNTS"

$GroupMemberships |
    Group-Object Group |
    Select-Object Name, Count |
    Format-Table

Write-Host "`n5. SECURITY OBSERVATIONS"

$UnexpectedAdmin = @(
    $GroupMemberships |
    Where-Object {
        $_.Group -eq "GRP-Domain-Admins" -and
        $_.Username -ne "admin01"
    }
)

Write-Host "Unexpected domain admin memberships: $($UnexpectedAdmin.Count)"

if ($UnexpectedAdmin.Count -gt 0) {
    Write-Host "WARNING: Review unexpected privileged membership."
}

Write-Host "`nAUDIT COMPLETE"
Write-Host "No live Active Directory changes were made."
