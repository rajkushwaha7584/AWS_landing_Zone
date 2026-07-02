#!/usr/bin/env bash
set -euo pipefail

# Runs a safe Terraform plan for the management environment.
# This file stores only profile/account names, never AWS access keys.

EXPECTED_ACCOUNT_ID="039612843833"
PROFILE_NAME="${MANAGEMENT_AWS_PROFILE:-AWSAdministratorAccess-039612843833}"
ENVIRONMENT_DIR="environments/management"

cd "$(dirname "$0")/.."

if ! aws configure list-profiles | grep -qx "$PROFILE_NAME"; then
  echo "AWS profile '$PROFILE_NAME' was not found."
  echo "Create/login to the profile, or set MANAGEMENT_AWS_PROFILE to the correct profile name."
  exit 1
fi

export AWS_PROFILE="$PROFILE_NAME"

echo "Checking AWS identity for management account..."
if ! ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text 2>/dev/null)"; then
  echo "AWS session is expired or unavailable. Refreshing SSO login..."
  aws sso login --profile "$PROFILE_NAME"
  ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
fi

if [ "$ACCOUNT_ID" != "$EXPECTED_ACCOUNT_ID" ]; then
  echo "Wrong AWS account: expected $EXPECTED_ACCOUNT_ID but got $ACCOUNT_ID"
  exit 1
fi

terraform -chdir="$ENVIRONMENT_DIR" init -backend=false
terraform -chdir="$ENVIRONMENT_DIR" validate
terraform -chdir="$ENVIRONMENT_DIR" plan
