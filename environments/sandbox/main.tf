module "sandbox_ec2_readonly_role" {
  source = "../../modules/cross-account-role"

  role_name         = "SandboxEC2ReadOnlyRole"
  description       = "EC2 read-only cross-account role for network-account testing."
  source_account_id = var.network_account_id

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  ]

  tags = {
    Environment = "sandbox"
    ManagedBy   = "terraform"
    Purpose     = "cross-account-readonly"
  }
}
