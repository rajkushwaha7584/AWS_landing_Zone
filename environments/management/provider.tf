provider "aws" {
  region              = var.home_region
  allowed_account_ids = [var.management_account_id]
}
