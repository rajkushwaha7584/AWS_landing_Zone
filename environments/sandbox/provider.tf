# Purpose: Configure AWS provider for sandbox-account resources.
# Use: Runs Terraform against sandbox account 961828155967.
# Why: allowed_account_ids prevents accidental changes in another AWS account.
# Where: Used by all .tf files in environments/sandbox.
#
# AWS provider for the sandbox member account.
# allowed_account_ids prevents accidental plans/applies against another account.
provider "aws" {
  region              = var.home_region
  allowed_account_ids = [var.sandbox_account_id]
}
