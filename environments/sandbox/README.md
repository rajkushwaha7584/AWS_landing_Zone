# Sandbox Environment

This Terraform environment runs inside the sandbox member account.

Expected account:

```text
961828155967
```

## Files

| File | Purpose |
| --- | --- |
| `industry-readiness-checklist.md` | Tracks remaining sandbox baseline work. |
| `main.tf` | Creates the sandbox cross-account EC2 read-only role. |
| `provider.tf` | Configures AWS provider and blocks wrong account usage with `allowed_account_ids`. |
| `variables.tf` | Defines sandbox and network account IDs with validation. |
| `versions.tf` | Defines Terraform and AWS provider version requirements. |

## Safe Plan

```bash
cd /d/demo1/aws_landing_zone
bash scripts/plan-sandbox.sh
```
