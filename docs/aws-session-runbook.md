# AWS Session Runbook

AWS access portal credentials are temporary. `ExpiredToken` means the session expired; refresh credentials before running Terraform.

## Do Not Store Secrets In This Repo

Never commit:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_SESSION_TOKEN`
- copied access portal credentials
- `.env` files with secrets

## Management Plan

Use the management account profile:

```bash
cd /d/demo1/aws_landing_zone
bash scripts/plan-management.sh
```

Expected account:

```text
039612843833
```

The script uses this profile by default:

```text
AWSAdministratorAccess-039612843833
```

If your profile has a different name:

```bash
MANAGEMENT_AWS_PROFILE=<profile-name> bash scripts/plan-management.sh
```

## Sandbox Plan

If you have a local sandbox profile:

```bash
SANDBOX_AWS_PROFILE=<profile-name> bash scripts/plan-sandbox.sh
```

If you do not have a local sandbox profile:

1. Open AWS access portal.
2. Expand `sandbox-account`.
3. Click `AWSAdministratorAccess > Access keys`.
4. Copy the temporary environment variable exports.
5. Paste them into Git Bash.
6. Run:

```bash
bash scripts/plan-sandbox.sh
```

Expected account:

```text
961828155967
```

## Why We Use Scripts

The scripts make demos easier and safer:

- verify the active AWS account
- catch expired sessions early
- run `terraform init -backend=false`
- run `terraform validate`
- run `terraform plan`

They do not run `terraform apply`.
