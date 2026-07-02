# Cross Account Role Module

Creates an IAM role that another AWS account can assume.

## Files

| File | Purpose |
| --- | --- |
| `main.tf` | Creates the IAM role, trust policy, and managed policy attachments. |
| `outputs.tf` | Exposes role name and role ARN. |
| `variables.tf` | Defines role name, source account, policies, tags, external ID, and session duration. |

## Used By

```text
environments/sandbox
```
