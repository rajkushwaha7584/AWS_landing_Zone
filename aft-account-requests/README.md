# AFT Account Requests

This folder is for Account Factory for Terraform style account request files.

## Files

| File | Purpose |
| --- | --- |
| `network-account.tf.example` | Example account request for the network account. It is not active Terraform code until copied/renamed in a complete AFT setup. |

## Notes

For industry use, new AWS accounts should be created through AWS Control Tower Account Factory or AFT instead of direct `aws_organizations_account` resources.
