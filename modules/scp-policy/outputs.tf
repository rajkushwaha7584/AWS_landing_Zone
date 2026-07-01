output "policy_id" {
  description = "Created SCP policy ID"
  value       = aws_organizations_policy.this.id
}

output "policy_arn" {
  description = "Created SCP policy ARN"
  value       = aws_organizations_policy.this.arn
}
