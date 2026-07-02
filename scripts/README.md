# Scripts

This folder contains local helper scripts.

## Files

| File | Purpose |
| --- | --- |
| `plan-management.sh` | Safely validates AWS identity and runs management Terraform plan. |
| `plan-sandbox.sh` | Safely validates AWS identity and runs sandbox Terraform plan. |
| `terraform-checks.ps1` | Runs local CI checks: Terraform formatting, init without backend, and validation. |

## Notes

Scripts do not store secrets and do not run `terraform apply`.
