# Purpose:
# Manage AWS Organizations member accounts that already exist in this lab OU.
#
# Important:
# - AWS account email is effectively immutable in Terraform. Changing an email
#   forces replacement, which can try to remove the old account from the org.
# - prevent_destroy is enabled so a bad plan cannot accidentally remove accounts.
# - For industry account vending, prefer Control Tower Account Factory or AFT.
resource "aws_organizations_account" "test_ou_account" {
  name      = var.legacy_test_ou_account_name
  email     = var.legacy_test_ou_account_email
  role_name = "OrganizationAccountAccessRole"

  # Creates or keeps this account under the Terraform-managed TestOU.
  parent_id = aws_organizations_organizational_unit.new_ou.id

  lifecycle {
    prevent_destroy = true
  }
}

# Second protected lab account under TestOU.
# To add another account, create a new resource block with a new Terraform name,
# a unique AWS account name, and a globally unique email address.
resource "aws_organizations_account" "test_ou_account1" {
  name      = var.test_ou_account1_name
  email     = var.test_ou_account1_email
  role_name = "OrganizationAccountAccessRole"

  parent_id = aws_organizations_organizational_unit.new_ou.id

  lifecycle {
    prevent_destroy = true
  }
}
