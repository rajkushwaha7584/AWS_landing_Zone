# Purpose: Create an AWS Organizations Service Control Policy.
# Use: Converts a JSON policy document into a customer-managed SCP.
# Why: SCPs provide organization-level guardrails across accounts/OUs.
# Where: Used by environments/management/scps.tf.
#
resource "aws_organizations_policy" "this" {
  name        = var.name
  description = var.description
  type        = "SERVICE_CONTROL_POLICY"
  content     = var.policy_content
}
