# SCP Attachment Module

Attaches a Service Control Policy to an AWS Organizations target.

## Files

| File | Purpose |
| --- | --- |
| `main.tf` | Creates `aws_organizations_policy_attachment`. |
| `outputs.tf` | Exposes the attachment ID. |
| `variables.tf` | Defines and validates `policy_id` and `target_id`. |

## Target Types

`target_id` can be:

- root ID
- OU ID
- AWS account ID
