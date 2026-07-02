# SCP Policy Module

Creates an AWS Organizations Service Control Policy.

## Files

| File | Purpose |
| --- | --- |
| `main.tf` | Creates `aws_organizations_policy`. |
| `outputs.tf` | Exposes policy ID and ARN. |
| `variables.tf` | Defines SCP name, description, and JSON policy content. |
