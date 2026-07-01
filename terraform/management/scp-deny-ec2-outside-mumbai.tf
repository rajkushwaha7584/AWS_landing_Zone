# WARNING:
# This is an example Terraform version of the SCP we tested from console.
# Do not run terraform apply until existing SCPs are imported or reviewed.
# In production, SCPs should be tested on Sandbox OU first, not Root or Prod.

resource "aws_organizations_policy" "deny_ec2_outside_mumbai" {
  name        = "Deny-EC2-Outside-Mumbai-Test"
  description = "Deny EC2 actions outside ap-south-1 for sandbox testing"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DenyEC2OutsideMumbai"
        Effect   = "Deny"
        Action   = "ec2:*"
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = "ap-south-1"
          }
        }
      }
    ]
  })
}

resource "aws_organizations_policy_attachment" "deny_ec2_outside_mumbai_sandbox" {
  policy_id = aws_organizations_policy.deny_ec2_outside_mumbai.id
  target_id = var.ou_ids["sandbox"]
}
