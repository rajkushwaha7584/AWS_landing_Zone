# Purpose: Expose the SCP attachment ID.
# Use: Helps verify which policy-target attachment Terraform manages.
# Why: Useful for state inspection and troubleshooting.
# Where: Available to environments that call modules/scp-attachment.
#
output "attachment_id" {
  description = "Policy attachment ID"
  value       = aws_organizations_policy_attachment.this.id
}
