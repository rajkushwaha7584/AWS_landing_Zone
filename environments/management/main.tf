module "deny_ec2_outside_mumbai_scp" {
  source = "../../modules/scp-policy"

  name           = "Deny-EC2-Outside-Mumbai-Test"
  description    = "Deny EC2 actions outside ap-south-1 for sandbox testing"
  policy_content = file("${path.module}/../../policies/scp/deny-ec2-outside-mumbai.json")
}

module "attach_deny_ec2_outside_mumbai_to_sandbox" {
  source = "../../modules/scp-attachment"

  policy_id = module.deny_ec2_outside_mumbai_scp.policy_id
  target_id = var.sandbox_ou_id
}
#===================================
data "aws_organizations_organization" "current" {}

resource "aws_organizations_organizational_unit" "new_ou" {
  name      = "TestOU"
  parent_id = data.aws_organizations_organization.current.roots[0].id
}

resource "aws_organizations_account" "test_ou_account1" {
  name      = "test-ou-account1"
  email     = "raj24kush@email.com"
  role_name = "OrganizationAccountAccessRole"

  parent_id = aws_organizations_organizational_unit.new_ou.id
}
resource "aws_organizations_account" "test_ou_account" {
  name      = "test-ou-account"
  email     = "your-unique-email@example.com"
  role_name = "OrganizationAccountAccessRole"

  parent_id = aws_organizations_organizational_unit.new_ou.id
}
