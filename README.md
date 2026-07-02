# AWS Landing Zone IaC

This repository documents and automates an AWS Landing Zone using AWS Control Tower, AWS Organizations, IAM Identity Center, SCPs, CloudTrail, AWS Config, cross-account IAM roles, networking foundation, and AFT-style account vending.

## Current Lab Accounts

| Account Name             | Account ID   | OU             | Purpose                          |
| ------------------------ | ------------ | -------------- | -------------------------------- |
| abhaysahucse             | 039612843833 | Root           | Management account               |
| Aggregator account       | 889947797924 | Security       | AWS Config Aggregator            |
| CloudTrail administrator | 238480774313 | Security       | Central CloudTrail / Log Archive |
| dev-sandbox              | 855012563791 | DEV            | Dev workload                     |
| sandbox-account          | 961828155967 | Sandbox        | SCP and testing                  |
| network-account          | 602506755932 | Infrastructure | Central networking               |

## Current OU Design

```text
Root
|-- Security
|-- DEV
|-- Sandbox
|-- Infrastructure
`-- Management account
```

## Terraform Environments

| Environment | Purpose | Expected AWS Account |
| --- | --- | --- |
| `environments/management` | AWS Organizations, OUs, SCPs, protected lab account inventory | `039612843833` |
| `environments/sandbox` | Resources inside the sandbox account | `961828155967` |

Before planning, verify the active account:

```bash
aws sts get-caller-identity
```

For management changes:

```bash
cd environments/management
export AWS_PROFILE=AWSAdministratorAccess-039612843833
terraform validate
terraform plan
```

For sandbox changes:

```bash
cd environments/sandbox
export AWS_PROFILE=AWSAdministratorAccess-961828155967
terraform validate
terraform plan
```

## Safety Notes

- Existing lab-created AWS accounts are protected with Terraform `prevent_destroy`.
- Do not change the email address on an existing `aws_organizations_account`; AWS treats that as a replacement.
- Prefer AWS Control Tower Account Factory or AFT for future production account vending.
- Register new OUs/accounts in Control Tower before treating them as governed production resources.
- See `docs/industry-readiness.md` for the current hardening path.

## Completed Practicals

- AWS Control Tower landing zone structure
- OU design
- Account Factory account creation
- SCP deny outside Mumbai test
- Control Tower controls catalog review
- CloudTrail organization trail review
- CloudTrail Event History validation
- AWS Config Aggregator validation
- Infrastructure OU creation
- Network account creation
- Cross-account AssumeRole test

## Pending Industry Topics

- AFT / Terraform account vending
- AWS Config rules and conformance packs
- GuardDuty and Security Hub
- Centralized networking with Transit Gateway
- Cost governance
- Break-glass access
- Multi-account CI/CD
