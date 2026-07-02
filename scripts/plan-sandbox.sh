#!/usr/bin/env bash
set -euo pipefail

# Runs a safe Terraform plan for the sandbox environment.
# This file stores only profile/account names, never AWS access keys.
#
# If you do not have a local sandbox profile, copy temporary access-key exports
# from AWS access portal first, then run this script without AWS_PROFILE.

EXPECTED_ACCOUNT_ID="961828155967"
PROFILE_NAME="${SANDBOX_AWS_PROFILE:-}"
ENVIRONMENT_DIR="environments/sandbox"

cd "$(dirname "$0")/.."

if [ -n "$PROFILE_NAME" ]; then
  export AWS_PROFILE="$PROFILE_NAME"
fi

echo "Checking AWS identity for sandbox account..."
if ! ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text 2>/dev/null)"; then
  echo "AWS credentials are missing or expired."
  echo "Open AWS access portal > sandbox-account > AWSAdministratorAccess > Access keys,"
  echo "copy the temporary export commands, paste them in Git Bash, then rerun this script."
  exit 1
fi

if [ "$ACCOUNT_ID" != "$EXPECTED_ACCOUNT_ID" ]; then
  echo "Wrong AWS account: expected $EXPECTED_ACCOUNT_ID but got $ACCOUNT_ID"
  exit 1
fi

terraform -chdir="$ENVIRONMENT_DIR" init -backend=false
terraform -chdir="$ENVIRONMENT_DIR" validate
terraform -chdir="$ENVIRONMENT_DIR" plan
