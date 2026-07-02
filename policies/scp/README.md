# Service Control Policies

This folder contains SCP JSON policy documents.

## Files

| File | Purpose |
| --- | --- |
| `deny-ec2-outside-mumbai.json` | Denies EC2 API actions outside `ap-south-1` for sandbox testing. |
| `sandbox-security-baseline.json` | Adds baseline sandbox guardrails against disabling organization/security/audit controls. |

## Notes

SCPs do not grant permissions. They only set maximum permissions for accounts/OUs.
