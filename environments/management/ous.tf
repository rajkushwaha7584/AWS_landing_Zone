resource "aws_organizations_organizational_unit" "new_ou" {
  name      = var.test_ou_name
  parent_id = data.aws_organizations_organization.current.roots[0].id

  lifecycle {
    prevent_destroy = true
  }
}
