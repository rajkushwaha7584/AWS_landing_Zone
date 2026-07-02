# Terraform Environments

This folder contains deployable Terraform root modules.

Each subfolder represents a separate execution context and should be planned/applied independently.

## Environments

| Folder | AWS Account | Purpose |
| --- | --- | --- |
| `management` | `039612843833` | AWS Organizations, OUs, SCPs, and protected lab account records. |
| `sandbox` | `961828155967` | Resources inside the sandbox account. |

## Safe Usage

Do not run `terraform plan` from this folder directly. Run Terraform from an environment folder or use helper scripts:

```bash
bash scripts/plan-management.sh
bash scripts/plan-sandbox.sh
```
