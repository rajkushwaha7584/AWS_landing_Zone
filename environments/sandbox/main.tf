# Purpose: Define resources that live inside the sandbox AWS account.
# Use: Creates the cross-account EC2 read-only role for network-account testing.
# Why: Demonstrates secure multi-account access through IAM AssumeRole.
# Where: Run from environments/sandbox with sandbox-account credentials.
#
# Purpose:
# Create resources inside the sandbox AWS account.
#
# Current scope:
# - A read-only IAM role that the network account can assume for EC2 testing.
# - This is useful for cross-account access validation, but it is not a full
#   sandbox account baseline yet.
module "sandbox_ec2_readonly_role" {
  source = "../../modules/cross-account-role"

  role_name         = "SandboxEC2ReadOnlyRole"
  description       = "EC2 read-only cross-account role for network-account testing."
  source_account_id = var.network_account_id

  # AWS managed read-only EC2 policy. For production, prefer customer-managed
  # least-privilege policies when access needs are more specific.
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  ]

  tags = {
    Environment = "sandbox"
    ManagedBy   = "terraform"
    Purpose     = "cross-account-readonly"
  }
}
