# Module 3: Active Directory Password Policy Audit

## Executive Summary

This exercise compared a synthetic Active Directory password policy against the proposed BonganiSecure security baseline.

The objective was to identify policy weaknesses and demonstrate automated security configuration auditing using PowerShell.

## Audit Results

| Control | Baseline | Simulated observation | Result |
|---|---:|---:|---|
| Minimum password length | 14 | 10 | Fail |
| Password complexity | Enabled | Enabled | Pass |
| Lockout threshold | 10 | 5 | Review |
| Lockout duration | 15 minutes | 30 minutes | Review |
| Lockout observation window | 15 minutes | 30 minutes | Review |
| Reversible encryption | Disabled | Disabled | Pass |

## Security Findings

### Finding 1: Password Length Below Baseline

**Severity:** Medium

The simulated policy requires a minimum of 10 characters rather than the proposed 14-character baseline.

**Recommendation:** Review password length requirements and adopt a stronger passphrase-oriented approach aligned with current organisational policy.

### Finding 2: Account Lockout Threshold

**Severity:** Medium

The simulated account lockout threshold is five invalid attempts, compared with the proposed threshold of ten.

**Recommendation:** Review the threshold in relation to password-guessing risks, account lockout abuse and business availability.

### Finding 3: Lockout Timing Differences

**Severity:** Low — configuration review

The lockout duration and observation window differ from the proposed baseline.

**Recommendation:** Document the business and security rationale for the chosen timings before approving the configuration.

## Controls Passing the Test

- Password complexity enabled.
- Reversible password encryption disabled.

## Technical Approach

The PowerShell script compares synthetic observed policy values against a defined baseline and reports differences.

## Limitations

No live domain password policy was retrieved. The results are simulated and must not be interpreted as findings from a production Active Directory environment.

The proposed baseline is a lab policy and should be reviewed against organisational requirements and current security guidance before deployment.

## Conclusion

The exercise demonstrates how security engineers can translate password policy requirements into automated configuration checks.

## Status

**Completed:** Simulated password policy audit and report.

**Next:** Privileged account security and delegation.
