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
