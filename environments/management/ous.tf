# Purpose: Manage AWS Organizations OUs from Terraform.
# Use: Creates the lab TestOU under the organization root.
# Why: OUs group accounts for governance, SCP attachment, and Control Tower structure.
# Where: Run from environments/management with the management account profile.
#
# Purpose:
# Create and protect the lab OU under the AWS Organizations root.
#
# In production, model OUs by business purpose, for example:
# Security, Infrastructure, Workloads, Sandbox, Dev, QA, Prod.
resource "aws_organizations_organizational_unit" "new_ou" {
  name      = var.test_ou_name
  parent_id = data.aws_organizations_organization.current.roots[0].id

  # OUs can contain accounts and policy attachments, so protect them from
  # accidental deletion during refactors.
  lifecycle {
    prevent_destroy = true
  }
}
