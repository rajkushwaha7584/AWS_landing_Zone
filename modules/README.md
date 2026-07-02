# Terraform Modules

This folder contains reusable Terraform modules.

## Modules

| Module | Purpose |
| --- | --- |
| `cross-account-role` | Creates an IAM role that can be assumed by another AWS account. |
| `scp-attachment` | Attaches an AWS Organizations SCP to an OU, root, or account. |
| `scp-policy` | Creates an AWS Organizations Service Control Policy. |

Modules are called from environment folders and should not be applied directly.
