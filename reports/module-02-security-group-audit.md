# Module 2: Active Directory Security Group Audit

## Executive Summary

This exercise analysed simulated Active Directory security group memberships to identify excessive privileges and potential violations of least-privilege principles.

## Audit Findings

### Finding 1: Excessive Privileged Access

**Account:** `jfinance`

**Group:** `GRP-Domain-Admins`

**Severity:** High

**Observation:**

The simulated Finance user account is assigned to the Domain Admins group.

**Risk:**

A compromised standard finance account could provide an attacker with highly privileged directory access.

**Recommended remediation:**

- Remove unnecessary Domain Admins membership.
- Use separate administrative identities.
- Grant administrative privileges only where justified.
- Review privileged group membership regularly.
- Monitor changes to sensitive groups.

### Finding 2: Privileged Account Monitoring

**Account:** `admin01`

**Group:** `GRP-Domain-Admins`

**Observation:**

The dedicated simulated administrative account is assigned to the Domain Admins group.

**Recommendation:**

Use privileged accounts only for authorised administrative tasks and monitor their activity.

## Technical Validation

The PowerShell script identified:

- Group membership records.
- Privileged group memberships.
- Users with multiple group memberships.
- Group membership counts.
- An unexpected Domain Admins membership.

## Limitations

The exercise uses synthetic data and does not inspect a live Active Directory domain.

The severity classification is a lab assessment, not a result from an automated production security scanner.

The exercise demonstrates how PowerShell can support access reviews and identify excessive privilege assignments.

The central security principle is least privilege: users should receive only the permissions necessary to perform their responsibilities.

## Status

**Completed:** Simulated security group audit and findings report.

**Next:** Group Policy and password security analysis.
