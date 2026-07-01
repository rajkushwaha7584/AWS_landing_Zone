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
