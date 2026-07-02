provider "aws" {
  region              = var.home_region
  allowed_account_ids = [var.sandbox_account_id]
}
