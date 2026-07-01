# AFT-style account request example
# This is documentation/sample only.
# Do not run terraform apply without full AFT setup.

module "network_account" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "RAJ24KUSH+network@gmail.com"
    AccountName               = "network-account"
    ManagedOrganizationalUnit = "Infrastructure"
    SSOUserEmail              = "abhaysahucse@gmail.com"
    SSOUserFirstName          = "Raj"
    SSOUserLastName           = "Kushwaha"
  }

  account_tags = {
    Environment = "shared"
    Owner       = "platform-team"
    Project     = "aws-landing-zone"
    ManagedBy   = "terraform"
  }
}
