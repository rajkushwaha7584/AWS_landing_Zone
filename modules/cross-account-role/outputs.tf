# Purpose: Expose useful IAM role values from the module.
# Use: Allows callers to reference the created role name and ARN.
# Why: Outputs make integration, verification, and documentation easier.
# Where: Available to any environment that calls modules/cross-account-role.
#
output "role_name" {
  description = "IAM role name"
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "IAM role ARN"
  value       = aws_iam_role.this.arn
}
