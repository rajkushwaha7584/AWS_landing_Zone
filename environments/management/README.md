# Management Environment

This Terraform environment runs against the AWS Organizations management account.

Expected account:

```text
039612843833
```

## Files

| File | Purpose |
| --- | --- |
| `accounts.tf` | Tracks protected lab AWS accounts under the lab OU. Existing accounts use `prevent_destroy`. |
| `data.tf` | Reads AWS Organizations data such as the root ID. |
| `industry-readiness-checklist.md` | Tracks remaining production-readiness work. |
| `ous.tf` | Creates and protects the lab OU. |
| `outputs.tf` | Exposes useful IDs such as root ID, OU ID, and account IDs. |
| `provider.tf` | Configures AWS provider and blocks wrong account usage with `allowed_account_ids`. |
| `scps.tf` | Creates and attaches Service Control Policies. |
| `variables.tf` | Defines configurable account IDs, OU IDs, account names, and validation rules. |
| `versions.tf` | Defines Terraform and AWS provider version requirements. |

## Safe Plan

```bash
cd /d/demo1/aws_landing_zone
bash scripts/plan-management.sh
```
