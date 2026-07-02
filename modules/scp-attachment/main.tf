# Purpose: Attach an AWS Organizations SCP to a target.
# Use: Connects an SCP policy ID to an OU, root, or account ID.
# Why: SCPs do nothing until attached to a target.
# Where: Used by environments/management/scps.tf.
#
resource "aws_organizations_policy_attachment" "this" {
  policy_id = var.policy_id
  target_id = var.target_id
}
