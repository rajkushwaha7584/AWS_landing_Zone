# AWS provider for the sandbox member account.
# allowed_account_ids prevents accidental plans/applies against another account.
provider "aws" {
  region              = var.home_region
  allowed_account_ids = [var.sandbox_account_id]
}
