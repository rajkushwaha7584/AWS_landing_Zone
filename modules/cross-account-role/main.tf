# Purpose: Create a reusable cross-account IAM role.
# Use: Allows one AWS account to assume a role in another account.
# Why: Cross-account role access is safer than creating IAM users in every account.
# Where: Used by environments/sandbox to let the network account read EC2 metadata.
#
resource "aws_iam_role" "this" {
  name                 = var.role_name
  description          = var.description
  max_session_duration = var.max_session_duration

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      merge({
        Sid    = "AllowSourceAccountAssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.source_account_id}:root"
        }
        Action = "sts:AssumeRole"
        },
        var.external_id == null ? {} : {
          Condition = {
            StringEquals = {
              "sts:ExternalId" = var.external_id
            }
          }
        }
      )
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
