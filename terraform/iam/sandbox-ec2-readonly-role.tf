# This Terraform file represents the cross-account role created manually in sandbox-account.
# It should be applied only when authenticated to the sandbox-account.

variable "network_account_id" {
  description = "Source account allowed to assume this role"
  type        = string
  default     = "602506755932"
}

resource "aws_iam_role" "sandbox_ec2_readonly_role" {
  name        = "SandboxEC2ReadOnlyRole"
  description = "EC2 read-only cross-account role for network-account testing."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowNetworkAccountAssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.network_account_id}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sandbox_ec2_readonly" {
  role       = aws_iam_role.sandbox_ec2_readonly_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
