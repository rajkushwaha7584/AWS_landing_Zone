# Purpose: Configure AWS provider for management-account resources.
# Use: Runs Organizations, OU, SCP, and account-tracking resources.
# Why: allowed_account_ids blocks Terraform if the wrong AWS profile is active.
# Where: Used by all .tf files in environments/management.
#
# AWS provider for the Organizations management account.
# allowed_account_ids is a safety check: Terraform will fail if the wrong AWS
# profile is active, instead of changing resources in another account.
provider "aws" {
  region              = var.home_region
  allowed_account_ids = [var.management_account_id]
}
