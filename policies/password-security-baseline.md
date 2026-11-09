# BonganiSecure Active Directory Password Security Baseline

## 1. Purpose

This baseline defines proposed password and account-lockout security requirements for the simulated BonganiSecure Financial Services Active Directory environment.

## 2. Proposed Password Policy

| Setting | Proposed baseline |
|---|---:|
| Minimum password length | 14 characters |
| Password complexity | Enabled |
| Account lockout threshold | 10 invalid attempts |
| Account lockout duration | 15 minutes |
| Reset lockout counter after | 15 minutes |
| Maximum password age | No forced periodic expiry, subject to policy and risk review |
| Reversible password encryption | Disabled |

## 3. Security Rationale

**Password length:** Longer passwords and passphrases increase resistance to guessing attacks.

**Password complexity:** Supports a stronger password baseline, although length and screening against compromised passwords are also important.

**Account lockout:** Helps limit repeated guessing attempts. Thresholds should be balanced against denial-of-service risks.

**Lockout duration:** Provides a temporary response to repeated failed authentication attempts.

**Password expiry:** Forced periodic changes are not automatically beneficial. Changes should be driven by compromise, risk or applicable organisational requirements.

**Reversible encryption:** Should remain disabled because it weakens password storage security.

## 4. Privileged Account Protection

- Separate standard and administrative identities.
- Restrict Domain Admins membership.
- Use dedicated privileged accounts.
- Monitor privileged authentication activity.
- Review privileged access regularly.

## 5. Implementation Status

**Status: Proposed baseline — not deployed.**

These settings are documented security recommendations. No live Group Policy Object or domain password policy has been configured in this project.

## 6. Validation Plan

If a live Windows Server Active Directory environment becomes available, validate the effective domain password policy and applicable Group Policy settings using appropriate administrative tools and PowerShell.

