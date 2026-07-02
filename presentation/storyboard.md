# AWS Landing Zone PPT Storyboard

## Slide 1: Title

Title:

```text
AWS Landing Zone Foundation Using Terraform
```

Subtitle:

```text
Multi-account governance, SCP guardrails, cross-account IAM, and CI validation
```

Image:

```text
presentation/assets/01-access-portal.png
```

Speaker notes:

Explain that this is a working lab/demo foundation for an AWS Landing Zone.

## Slide 2: Project Objective

Points:

- Build a multi-account AWS Landing Zone foundation.
- Use Terraform for repeatable infrastructure.
- Use AWS Control Tower and AWS Organizations for governance.
- Add CI checks through GitHub Actions.
- Keep production hardening items documented.

Image:

```text
presentation/assets/10-project-structure.png
```

## Slide 3: Account Structure

Points:

- Management account: `039612843833`
- Sandbox account: `961828155967`
- Network account: `602506755932`
- Security accounts for aggregation and logging
- Dev sandbox account for workload testing

Image:

```text
presentation/assets/01-access-portal.png
```

## Slide 4: OU And Control Tower Structure

Points:

- OUs organize accounts by governance boundary.
- Control Tower provides baseline governance.
- Terraform manages lab OU and related references.
- New OUs/accounts must be registered/enrolled for full Control Tower governance.

Image:

```text
presentation/assets/02-control-tower-organization.png
```

## Slide 5: Terraform Repository Layout

Points:

- `environments/management`: OUs, SCPs, account records
- `environments/sandbox`: sandbox account resources
- `modules`: reusable Terraform modules
- `policies/scp`: SCP JSON documents
- `scripts`: local validation and safe plan helpers

Image:

```text
presentation/assets/10-project-structure.png
```

## Slide 6: Management Environment

Points:

- Uses management account provider safety with `allowed_account_ids`.
- Creates and attaches SCPs.
- Tracks protected lab accounts.
- Exposes outputs for verification.

Image:

```text
presentation/assets/09-terraform-plan-management.png
```

## Slide 7: SCP Guardrails

Points:

- Deny EC2 outside Mumbai for sandbox testing.
- Sandbox security baseline prevents disabling audit/security services.
- SCPs do not grant permissions; they set maximum allowed permissions.

Images:

```text
presentation/assets/03-organizations-scp.png
presentation/assets/04-scp-targets.png
```

## Slide 8: Sandbox Environment

Points:

- Runs in sandbox account `961828155967`.
- Creates `SandboxEC2ReadOnlyRole`.
- Network account can assume the role.
- Role has `AmazonEC2ReadOnlyAccess`.

Image:

```text
presentation/assets/05-sandbox-role.png
```

## Slide 9: Cross-Account IAM Flow

Points:

- Network account assumes role in sandbox account.
- Sandbox account trusts network account root principal.
- Temporary credentials are used through STS.
- This avoids creating long-lived IAM users in every account.

Image:

```text
presentation/assets/06-role-trust-policy.png
```

## Slide 10: CI/CD Pipeline

Points:

- GitHub Actions runs Terraform CI automatically.
- Checks formatting, init, and validate.
- Runs for both management and sandbox.
- `apply` remains manual for safety.

Image:

```text
presentation/assets/07-github-actions.png
```

## Slide 11: Local Validation

Points:

- Local script runs same checks as CI.
- Helps test before push or demo.
- Command:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\terraform-checks.ps1
```

Image:

```text
presentation/assets/08-local-ci-output.png
```

## Slide 12: Safe AWS Session Helpers

Points:

- `scripts/plan-management.sh` verifies management account before plan.
- `scripts/plan-sandbox.sh` verifies sandbox account before plan.
- Prevents wrong-account changes.
- Does not store AWS secrets.

Image:

```text
presentation/assets/09-terraform-plan-management.png
```

## Slide 13: Current Completion Status

Points:

- Landing Zone lab/demo foundation is complete.
- Terraform code is validated.
- CI pipeline is working.
- Management and sandbox resources are reflected in AWS.
- Production hardening is documented as next phase.

## Slide 14: Remaining Production Hardening

Points:

- Remote S3 backend for Terraform state
- AFT / Control Tower Account Factory automation
- GuardDuty / Security Hub / AWS Config automation
- Centralized logging
- Network baseline / Transit Gateway
- IAM Identity Center automation
- Cost governance

## Slide 15: Closing

Message:

```text
This project demonstrates a working AWS Landing Zone foundation with governance, automation, and CI validation.
```
