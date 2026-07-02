# Sandbox Environment Industry Readiness Checklist

This file tracks what is still needed before the `sandbox` Terraform environment should be treated as an industry-ready account baseline.

## Current Status

The sandbox environment currently manages:

- AWS provider safety using `allowed_account_ids`
- A cross-account IAM role for EC2 read-only access from the network account
- Basic account ID validations

It is a useful lab/test account, not yet a complete sandbox baseline.

## Remaining Work

### 1. Remote Terraform State

Move local state to the same remote-state standard used by the landing zone:

- S3 backend
- Versioning
- Encryption
- Locking
- Separate state key for sandbox

Example state key:

```text
landing-zone/sandbox/terraform.tfstate
```

### 2. Account Baseline

Add basic account-level resources:

- Standard IAM roles
- Baseline CloudWatch log groups if needed
- S3 public access block
- Default EBS encryption
- Budget alerts
- Cost anomaly detection subscription

### 3. Network Baseline

Add or reference sandbox networking:

- VPC
- Public/private subnets
- Route tables
- NAT gateway only if needed
- VPC endpoints for common AWS services
- Optional Transit Gateway attachment to network account

### 4. IAM Hardening

Current cross-account trust allows the network account root principal.

For stronger security:

- Trust a specific role ARN instead of the whole account root
- Use `external_id` when appropriate
- Use customer-managed least-privilege policies
- Add permission boundaries for human-created roles if required

### 5. Security Services

Confirm sandbox is covered by organization-level services:

- GuardDuty
- Security Hub
- AWS Config
- CloudTrail
- IAM Access Analyzer

### 6. Testing And Validation

Add repeatable tests:

- Verify wrong AWS profile is blocked
- Verify network account can assume the sandbox role
- Verify EC2 actions outside Mumbai are blocked by SCP
- Verify read-only role cannot create EC2 resources

### 7. Documentation

Document:

- Which AWS profile to use
- What the sandbox account is for
- What role can be assumed from the network account
- What actions are intentionally denied by SCP

## Safe Command Pattern

Always run:

```bash
cd /d/demo1/aws_landing_zone/environments/sandbox
export AWS_PROFILE=AWSAdministratorAccess-961828155967
aws sts get-caller-identity
terraform validate
terraform plan
```

Only apply if the plan does not show unexpected destroy or replacement actions.
