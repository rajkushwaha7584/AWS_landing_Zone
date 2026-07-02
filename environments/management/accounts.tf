# These accounts were created during lab testing and are now protected from
# accidental removal. For production account vending, prefer Control Tower
# Account Factory or AFT account requests instead of direct Organizations APIs.
resource "aws_organizations_account" "test_ou_account" {
  name      = var.legacy_test_ou_account_name
  email     = var.legacy_test_ou_account_email
  role_name = "OrganizationAccountAccessRole"

  parent_id = aws_organizations_organizational_unit.new_ou.id

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_organizations_account" "test_ou_account1" {
  name      = var.test_ou_account1_name
  email     = var.test_ou_account1_email
  role_name = "OrganizationAccountAccessRole"

  parent_id = aws_organizations_organizational_unit.new_ou.id

  lifecycle {
    prevent_destroy = true
  }
}
