# Industry Readiness Notes

This repository is moving from a lab landing zone into a safer production-style layout.

## Current Safe Operating Rules

- Run organization-level Terraform only from `environments/management`.
- Run account-level sandbox Terraform only from `environments/sandbox`.
- Always confirm `aws sts get-caller-identity` returns the expected account before `terraform plan`.
- Do not change the `email` value of an existing `aws_organizations_account`; AWS account email changes force replacement.
- Existing lab accounts are protected with `prevent_destroy` to avoid accidental account removal.

## Recommended Production Direction

- Use AWS Control Tower Account Factory or AFT for new account vending.
- Keep AWS Organizations, SCPs, and OU management in a dedicated state.
- Keep workload account resources in separate account-specific states.
- Configure remote state in S3 with locking, encryption, versioning, and restricted access.
- Register Terraform-created OUs/accounts in Control Tower before treating them as governed production resources.
- Prefer specific trusted role ARNs and optional external IDs for cross-account role trust.

## Suggested State Boundaries

```text
environments/
  management/     # Organizations, OUs, SCPs, account inventory protection
  security/       # Security tooling, GuardDuty, Security Hub, Config
  network/        # Transit Gateway, shared VPCs, resolver, inspection
  sandbox/        # Sandbox-account resources
```

## Account Vending

Direct `aws_organizations_account` resources are acceptable for learning, but they are not the preferred production path in a Control Tower landing zone. For industry use, move future account creation to AFT-style account requests and keep Terraform-managed account resources protected from destroy.
