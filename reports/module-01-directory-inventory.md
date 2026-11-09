# Module 1: Active Directory Directory Inventory Report

## Executive Summary

This exercise developed a simulated PowerShell-based directory inventory for BonganiSecure Financial Services.

The objective was to demonstrate how an identity security engineer can review account status, departmental distribution and privileged identities.

## Audit Results

The synthetic directory contains:

- 6 user accounts.
- 5 enabled accounts.
- 1 disabled account.
- 1 privileged account.
- 5 represented departments.

## Security Observations

### 1. Disabled Account

The account `pformer` is disabled in the simulated dataset.

**Security consideration:** Disabled accounts should be reviewed to confirm that their access has been removed and that the account is retained or deleted according to the organisation's identity lifecycle policy.

### 2. Privileged Account

The account `admin01` is identified as a member of the simulated `GRP-Domain-Admins` group.

**Security consideration:** Domain administrator privileges should be tightly controlled, monitored and restricted to authorised administrative tasks.

### 3. Departmental Identity Management

Accounts are associated with Finance, Human Resources, Information Technology and Risk and Compliance.

**Security consideration:** Departmental security groups can help implement access boundaries and reduce unnecessary permissions.

## Limitations

This exercise uses synthetic PowerShell objects. It does not query a live Active Directory domain, validate actual group membership or establish that the simulated accounts have real permissions.

## Conclusion

The exercise demonstrates foundational identity inventory, account-status review, privileged account identification and PowerShell reporting.

These capabilities form part of an effective Active Directory security audit process.

## Status

**Completed:** Simulated directory inventory script and report.

**Next:** Security group analysis and least-privilege review.
