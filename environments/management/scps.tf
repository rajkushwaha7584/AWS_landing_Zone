# Purpose:
# Create and attach Service Control Policies from the management account.
#
# SCPs are organization guardrails. They do not grant permissions; they only set
# the maximum permissions available to accounts/OUs.
module "deny_ec2_outside_mumbai_scp" {
  source = "../../modules/scp-policy"

  name           = "Deny-EC2-Outside-Mumbai-Test"
  description    = "Deny EC2 actions outside ap-south-1 for sandbox testing"
  policy_content = file("${path.module}/../../policies/scp/deny-ec2-outside-mumbai.json")
}

# Attaches the Mumbai-only EC2 deny policy to the existing Sandbox OU.
# Change target_id only when intentionally moving this guardrail to another OU
# or account.
module "attach_deny_ec2_outside_mumbai_to_sandbox" {
  source = "../../modules/scp-attachment"

  policy_id = module.deny_ec2_outside_mumbai_scp.policy_id
  target_id = var.sandbox_ou_id
}
