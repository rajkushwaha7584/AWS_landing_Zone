# Management Environment Industry Readiness Checklist

This file tracks what is still needed before the `management` Terraform environment should be treated as industry/production ready.

## Current Status

The management environment is a safer lab foundation. It can manage:

- AWS Organizations data lookup
- Protected lab OU
- Protected lab AWS accounts
- SCP creation
- SCP attachment
- Management account provider safety with `allowed_account_ids`

It is not yet a complete production landing zone control plane.

## Remaining Work

### 1. Remote Terraform State

Current local state is not industry ready.

Add an S3 backend with:

- S3 bucket versioning
- Server-side encryption
- State locking support
- Restricted IAM access
- Separate state keys per environment

Example target layout:

```text
s3://<terraform-state-bucket>/landing-zone/management/terraform.tfstate
s3://<terraform-state-bucket>/landing-zone/sandbox/terraform.tfstate
```

### 2. Account Vending Through Control Tower Or AFT

Direct `aws_organizations_account` resources are useful for learning, but production account creation should use:

- AWS Control Tower Account Factory
- AFT account requests

Keep direct `aws_organizations_account` resources protected with `prevent_destroy`.

### 3. Control Tower Registration

Terraform-created OUs/accounts must be checked in Control Tower.

Required actions:

- Register unmanaged OUs
- Enroll unmanaged accounts
- Confirm Control Tower baseline status is enabled where required
- Confirm AWS Config baseline status where required

### 4. Production OU Model

Replace lab naming with a real landing zone OU model.

Suggested target:

```text
Root
|-- Security
|   |-- LogArchive
|   `-- Audit
|-- Infrastructure
|   |-- Network
|   `-- SharedServices
|-- Workloads
|   |-- Dev
|   |-- QA
|   `-- Prod
`-- Sandbox
```

### 5. Stronger SCP Baseline

The current SCP is a Mumbai EC2 test policy. Add real baseline guardrails:

- Deny root user actions except approved break-glass flows
- Deny leaving the organization
- Deny disabling CloudTrail
- Deny disabling AWS Config
- Deny disabling GuardDuty/Security Hub where enabled
- Deny public S3 bucket exposure
- Deny non-approved regions with global service exceptions
- Deny IAM privilege escalation patterns

### 6. Security Services

Add Terraform coverage for:

- GuardDuty organization admin
- Security Hub organization admin
- AWS Config aggregator
- CloudTrail organization trail validation
- IAM Access Analyzer
- AWS Budgets and anomaly detection

### 7. Identity Center Access Model

Document and automate where possible:

- Groups
- Permission sets
- Account assignments
- Admin, read-only, break-glass, and workload roles

New accounts will not appear in the AWS access portal until IAM Identity Center assignments are created.

### 8. CI/CD Validation

Add automated checks before merge:

- `terraform fmt -recursive -check`
- `terraform validate`
- `tflint`
- `checkov` or `tfsec`
- Pull request plan review

### 9. Naming And Tags

Create naming/tagging standards for all resources.

Suggested required tags:

- `ManagedBy = terraform`
- `Environment`
- `Owner`
- `CostCenter`
- `DataClassification`
- `Purpose`

### 10. Runbooks

Add operational runbooks for:

- How to create a new OU
- How to create/request a new account
- How to attach an SCP
- How to recover from a failed account creation
- How to verify Control Tower enrollment
- How to verify AWS access portal visibility

## Safe Command Pattern

Always run:

```bash
cd /d/demo1/aws_landing_zone/environments/management
export AWS_PROFILE=AWSAdministratorAccess-039612843833
aws sts get-caller-identity
terraform validate
terraform plan
```

Only apply if the plan does not show unexpected destroy or replacement actions.
