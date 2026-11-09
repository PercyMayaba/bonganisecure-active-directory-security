# Module 5: Kerberos, LDAP and Authentication Security Audit

## 1. Assessment Overview

**Organisation:** BonganiSecure Financial Services  
**Domain:** corp.bonganisecure.local  
**Assessment:** Simulated authentication security investigation  
**Status:** Simulation only

This investigation reviews synthetic authentication events to identify suspicious authentication patterns, legacy protocol usage, privileged access and service-ticket activity.

No live Active Directory authentication logs were accessed.

## 2. Authentication Protocol Overview

### Kerberos

Kerberos is the primary ticket-based authentication protocol used in traditional Active Directory domain environments.

It uses a Key Distribution Center (KDC) to issue tickets that allow users and services to authenticate without repeatedly transmitting their passwords.

Security considerations include:
- Monitoring unusual service-ticket requests.
- Protecting service account credentials.
- Investigating suspicious ticket activity.
- Applying strong encryption and account security practices.

### LDAP

Lightweight Directory Access Protocol (LDAP) allows applications and users to query and interact with directory information.

Security considerations include:
- Protecting directory communications using LDAP over TLS.
- Avoiding anonymous or unnecessarily broad directory access.
- Restricting permissions on directory objects.
- Monitoring unusual directory queries and access patterns.

### NTLM

NTLM is an older Microsoft authentication protocol that may remain in use for legacy compatibility.

Security considerations include:
- Identifying applications that still depend on NTLM.
- Monitoring authentication failures.
- Reducing unnecessary NTLM usage.
- Planning controlled migration to stronger authentication methods.

## 3. Investigation Findings

### Finding 1: Repeated NTLM Authentication Failures

**Source IP:** 10.10.1.55  
**Account:** unknown-user  
**Severity:** High investigation priority

Three failed NTLM authentication events were recorded against a legacy application from the same source IP.

**Risk:** The pattern could be consistent with password guessing, an incorrectly configured application or another authentication problem.

**Recommendation:** Investigate the source host, review related authentication records and determine whether the legacy application still requires NTLM.

### Finding 2: NTLM Dependency Identified

**Application:** Legacy-Application  
**Severity:** Medium — Review required

The dataset contains NTLM authentication activity.

**Risk:** Continued dependency on legacy authentication can increase exposure to credential-related attacks.

**Recommendation:** Identify the application owner and document the dependency. Plan a controlled migration where technically possible.

### Finding 3: Service-Ticket Activity

**Account:** svc-backup  
**Service:** Backup-Service  
**Severity:** Medium — Review required

Multiple service-ticket-related events were recorded for the backup service account.

**Risk:** Service accounts and their associated credentials can become targets for Kerberoasting and other credential attacks. Repeated ticket activity alone does not prove such an attack.

**Recommendation:** Review service account permissions, credential protection, encryption configuration and unusual ticket-request patterns.

### Finding 4: Privileged Authentication

**Account:** admin01  
**Service:** Domain-Controller  
**Severity:** Review required

A successful privileged authentication event was recorded.

**Risk:** Privileged authentication requires additional monitoring because administrator account compromise can have a significant impact.

**Recommendation:** Confirm that the activity was authorised and review the associated account, source device and surrounding events.

### Finding 5: Standard Account Service Access

**Account:** dit  
**Service:** Finance-File-Server  
**Severity:** Review required

The standard IT account accessed a finance file service.

**Risk:** This may represent legitimate access or excessive permissions.

**Recommendation:** Validate the business requirement and enforce least-privilege access.

## 4. Kerberoasting Defensive Considerations

Kerberoasting involves requesting service tickets and attempting to recover service account passwords offline.

Defensive measures include:

- Use strong, long and randomly generated service account credentials.
- Prefer Group Managed Service Accounts where supported.
- Avoid unnecessary privileged group membership for service accounts.
- Monitor unusual service-ticket request patterns.
- Review service account encryption configuration.
- Rotate credentials when exposure is suspected.

The supplied dataset does not establish that Kerberoasting occurred.

## 5. Recommended Security Improvements

| Area | Recommendation |
|---|---|
| Kerberos | Monitor unusual ticket requests |
| LDAP | Require protected directory communications |
| NTLM | Identify and reduce legacy dependencies |
| Service accounts | Apply least privilege and protect credentials |
| Privileged accounts | Monitor administrative authentication |
| Investigation | Correlate source IP, account and event timestamps |

## 6. Engineering Skills Demonstrated

- Kerberos authentication concepts
- LDAP directory security
- NTLM legacy authentication risks
- Service-ticket investigation
- Kerberoasting defensive awareness
- PowerShell authentication-event auditing
- Security event correlation
- Incident investigation and reporting

## 7. Limitations

This project uses synthetic JSON authentication events and a PowerShell simulation.

It does not demonstrate live Kerberos ticket inspection, LDAP traffic analysis, Windows Event Log collection, domain-controller monitoring or a real Kerberoasting investigation.

A future live lab can validate these concepts using an authorised Active Directory environment.

## 8. Conclusion

The simulated investigation identified repeated NTLM failures, legacy authentication dependencies, service-ticket activity and privileged authentication requiring review.

The exercise demonstrates how identity security engineers investigate authentication patterns and translate technical observations into actionable security recommendations.
