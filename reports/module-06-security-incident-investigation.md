# Module 6: Active Directory Security Incident Investigation

## 1. Executive Summary

**Organisation:** BonganiSecure Financial Services  
**Domain:** corp.bonganisecure.local  
**Assessment:** Simulated Active Directory security incident  
**Status:** Simulation only

This investigation analyses synthetic Windows Security events to identify suspicious account activity, privileged group changes, authentication failures and potential attempts to interfere with security monitoring.

The simulated event sequence contains several high-priority indicators requiring investigation.

No live Windows Event Logs or Active Directory systems were accessed.

## 2. Incident Overview

The simulated incident involves the following sequence:

1. Repeated failed authentication attempts against an unknown account.
2. Creation of a temporary administrator account.
3. Addition of that account to Domain Admins.
4. Successful authentication using the newly created account.
5. Clearing of the security audit log.
6. Deletion of the temporary account.

The combination of these events warrants urgent investigation in a real environment.

## 3. Key Security Findings

### Finding 1: Repeated Failed Logons

**Event ID:** 4625  
**Source IP:** 10.10.1.55  
**Severity:** High investigation priority

Three failed logon events originated from the same source IP.

**Risk:** This pattern could indicate password guessing, a misconfigured application or another authentication problem.

**Recommendation:** Investigate the source device, correlate related authentication events and review account lockout activity.

### Finding 2: Unexpected Account Creation

**Event ID:** 4720  
**Account:** temp-admin  
**Created by:** admin01  
**Severity:** High

A temporary account was created by an administrative identity.

**Risk:** Unauthorised account creation can establish an additional route into an organisation's environment.

**Recommendation:** Verify the change against approved administrative requests and account provisioning records.

### Finding 3: Privileged Group Membership Change

**Event ID:** 4728  
**Account:** temp-admin  
**Group:** Domain Admins  
**Severity:** Critical

The newly created account was added to the Domain Admins group.

**Risk:** Domain Admins membership provides extensive control over an Active Directory domain.

**Recommendation:** Confirm authorisation immediately. If unauthorised, follow the incident response process to remove excessive privileges and investigate the administrator account involved.

### Finding 4: Successful Logon Using New Account

**Event ID:** 4624  
**Account:** temp-admin  
**Source IP:** 10.10.1.55  
**Severity:** High

The newly created account successfully authenticated from the same source IP associated with the repeated failed logons.

**Risk:** This sequence raises concern that the account may have been used to establish access after the earlier authentication failures.

**Recommendation:** Correlate authentication details, source device information, logon type and surrounding events.

### Finding 5: Security Audit Log Cleared

**Event ID:** 1102  
**Account:** admin01  
**Severity:** Critical

A security audit log clearing event was recorded.

**Risk:** Clearing security logs can reduce visibility into potentially unauthorised activity and complicate incident investigation.

**Recommendation:** Preserve available evidence, investigate the account and host involved, and correlate with centralised or independently retained logs.

### Finding 6: Temporary Account Deleted

**Event ID:** 4726  
**Account:** temp-admin  
**Deleted by:** admin01  
**Severity:** Medium — Review required

The temporary administrator account was subsequently deleted.

**Risk:** Account deletion does not establish that the associated activity was legitimate or that all access has been removed.

**Recommendation:** Review the account's complete activity history, group membership changes and any resources accessed before deletion.

## 4. Incident Timeline

| Time | Event | Significance |
|---|---|---|
| 09:10 | Failed logon | Authentication failure |
| 09:11 | Failed logon | Repeated failure |
| 09:12 | Failed logon | Repeated failure |
| 09:30 | Account created | New identity introduced |
| 09:35 | Domain Admins membership | Critical privilege escalation indicator |
| 09:40 | Successful logon | New account authenticated |
| 09:50 | Audit log cleared | Potential evidence interference |
| 10:15 | Account deleted | Identity removed after activity |

## 5. Incident Response Recommendations

### Phase 1: Identification

- Validate the suspicious account creation.
- Confirm whether Domain Admins membership was approved.
- Investigate the source IP and associated device.
- Correlate authentication and administrative activity.

### Phase 2: Containment

If the activity is confirmed as unauthorised:

- Follow the organisation's incident response authorisation process.
- Disable compromised identities where appropriate.
- Remove unauthorised privileged access.
- Restrict affected devices or network connections as necessary.

### Phase 3: Evidence Preservation

- Preserve available Windows Security logs.
- Collect relevant centralised logging records.
- Record timestamps, account names and source addresses.
- Maintain an investigation record and evidence handling history.

### Phase 4: Recovery

- Restore authorised identity configurations.
- Reset credentials where compromise is suspected.
- Validate privileged group membership.
- Review affected systems for persistence or additional unauthorised changes.

### Phase 5: Lessons Learned

- Improve privileged account monitoring.
- Review account provisioning controls.
- Centralise security event collection.
- Establish alerts for sensitive group membership changes.
- Periodically test incident response procedures.

## 6. Engineering Skills Demonstrated

- Windows Security Event ID analysis
- Active Directory account lifecycle investigation
- Privileged group change monitoring
- Authentication failure analysis
- Security log tampering awareness
- PowerShell-based event correlation
- Incident timeline reconstruction
- Incident response planning
- Security reporting and remediation

## 7. Limitations

This project uses synthetic JSON events and a PowerShell simulation.

It does not demonstrate live Windows Event Log collection, a deployed SIEM, a live domain controller, actual account containment or production incident response.

Event patterns are investigation indicators and do not independently establish malicious intent.

## 8. Conclusion

The simulated investigation identified a concerning sequence involving repeated authentication failures, account creation, privileged group membership, successful authentication, audit log clearing and account deletion.

The exercise demonstrates how an identity or security engineer can correlate authentication and administrative events, assess privilege escalation indicators and develop structured incident response recommendations.
