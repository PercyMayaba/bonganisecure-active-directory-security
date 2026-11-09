# Module 4: Privileged Access and Delegation Audit

## 1. Assessment Overview

**Organisation:** BonganiSecure Financial Services  
**Proposed domain:** corp.bonganisecure.local  
**Assessment type:** Simulated Active Directory privileged-access review  
**Status:** Simulation only

This assessment examines privileged group membership, administrative account separation, former employee access and service account privileges using synthetic directory records.

No live Active Directory environment was accessed or modified.

## 2. Key Findings

### Finding 1: Standard User in Domain Admins

**Account:** `dit`  
**Severity:** High  
**Group:** Domain Admins

A standard IT user account is included in the Domain Admins group.

**Risk:** Compromise of this account could provide excessive control over the simulated domain.

**Recommendation:** Remove unnecessary privileged membership. Use a separate, dedicated administrative identity for authorised administrative tasks.

### Finding 2: Disabled Former Employee Retains Privileged Membership

**Account:** `pformer`  
**Severity:** High  
**Group:** Backup Operators

The simulated former employee account is disabled but still retains membership in a privileged group.

**Risk:** This indicates incomplete access deprovisioning. If the account were re-enabled or otherwise misused, residual privileges could create an access risk.

**Recommendation:** Review and remove unnecessary group memberships during offboarding. Verify that disabled accounts have no remaining access requirements.

### Finding 3: Service Account Has Privileged Membership

**Account:** `svc-backup`  
**Severity:** Medium — Review required  
**Group:** Backup Operators

The backup service account has membership in a privileged group.

**Risk:** Service accounts can be attractive targets. Excessive permissions or poorly protected credentials could increase the impact of compromise.

**Recommendation:** Confirm that the membership is necessary. Apply least privilege, restrict interactive sign-in where appropriate, protect credentials and monitor account activity.

### Finding 4: Standard Account Used for Administrative Activity

**Account:** `dit`  
**Severity:** Medium

The inventory indicates that the standard account is used for administrative activity.

**Risk:** Mixing everyday activity with privileged administration increases exposure to phishing, malware and credential theft.

**Recommendation:** Separate standard and privileged identities. Use dedicated administrative accounts and restrict their use to approved administrative tasks.

## 3. Recommended Remediation Priorities

| Priority | Action |
|---|---|
| 1 | Review and remove unnecessary Domain Admins membership |
| 2 | Complete former employee privilege removal |
| 3 | Validate service account permissions |
| 4 | Separate standard and privileged identities |
| 5 | Establish recurring privileged-access reviews |

## 4. Engineering Concepts Demonstrated

- Active Directory privileged group auditing
- Domain Admins membership review
- Least-privilege access control
- Administrative account separation
- Former employee access reviews
- Service account security
- PowerShell-based security auditing
- Security findings and remediation reporting

## 5. Limitations

This assessment uses synthetic JSON records and a PowerShell simulation.

It does not demonstrate a live domain controller, actual Active Directory delegation, Group Policy enforcement, Kerberos activity or production account remediation.

A future live validation exercise could use Active Directory PowerShell cmdlets to inspect actual group memberships and account properties in an authorised lab domain.

## 6. Conclusion

The simulated assessment identified excessive administrative membership, residual privileges on a disabled former employee account, service account privilege exposure and inadequate separation of administrative identities.

These findings demonstrate how identity governance and privileged-access reviews can reduce the risk of domain compromise in a financial-services environment.
