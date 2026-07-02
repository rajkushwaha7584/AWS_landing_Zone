# Purpose: Expose created SCP identifiers.
# Use: Allows attachment modules to consume the SCP policy ID.
# Why: Terraform modules should pass IDs through outputs instead of hardcoding.
# Where: Used by environments/management/scps.tf.
#
output "policy_id" {
  description = "Created SCP policy ID"
  value       = aws_organizations_policy.this.id
}

output "policy_arn" {
  description = "Created SCP policy ARN"
  value       = aws_organizations_policy.this.arn
}
