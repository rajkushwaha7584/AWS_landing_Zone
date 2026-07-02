# Project Structure Guide

This repository is an AWS Landing Zone lab foundation. It is organized so each folder has one clear responsibility.

## Top-Level Folders

| Folder | Purpose |
| --- | --- |
| `.github/workflows` | GitHub Actions CI workflows for Terraform validation. |
| `aft-account-requests` | AFT-style account request examples for future account vending. |
| `cost-governance` | Placeholder for budgets, anomaly detection, and cost-control automation. |
| `docs` | Project documentation, account inventory, runbooks, and readiness notes. |
| `environments` | Deployable Terraform root modules for each AWS account/environment. |
| `iam` | IAM and cross-account access documentation. |
| `identity-center` | Placeholder for IAM Identity Center groups, permission sets, and assignments. |
| `modules` | Reusable Terraform modules used by environments. |
| `networking` | Network account and landing zone networking design notes. |
| `organizations` | AWS Organizations and OU design references. |
| `policies` | Policy documents such as Service Control Policies. |
| `scripts` | Local helper scripts for validation and safer Terraform planning. |
| `security` | Placeholder for GuardDuty, Security Hub, Config, and security baseline automation. |

## Terraform Flow

Use `environments/management` for organization-level work:

- OUs
- SCPs
- protected lab account records

Use `environments/sandbox` for resources inside the sandbox account:

- cross-account IAM role
- future sandbox baseline resources

## CI Flow

GitHub Actions runs `.github/workflows/terraform-ci.yml` on pushes and pull requests. It checks:

- Terraform formatting
- Terraform initialization without backend
- Terraform validation for management and sandbox

The same checks can be run locally with:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\terraform-checks.ps1
```
