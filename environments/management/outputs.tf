# Outputs expose important IDs after apply so verification is easier from CLI,
# docs, and future Terraform states.
output "organization_root_id" {
  description = "AWS Organizations root ID"
  value       = data.aws_organizations_organization.current.roots[0].id
}

output "test_ou_id" {
  description = "ID of the protected lab OU"
  value       = aws_organizations_organizational_unit.new_ou.id
}

output "test_ou_account_ids" {
  description = "Protected lab account IDs in TestOU"
  value = {
    test_ou_account  = aws_organizations_account.test_ou_account.id
    test_ou_account1 = aws_organizations_account.test_ou_account1.id
  }
}
