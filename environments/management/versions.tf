# Purpose: Pin Terraform and provider requirements for the management environment.
# Use: Ensures Terraform uses the AWS provider source and supported version range.
# Why: Version constraints reduce surprise behavior across machines and CI.
# Where: Used when running `terraform init` in environments/management.
#
terraform {
  # Keep Terraform reasonably modern while avoiding surprise upgrades to a
  # future incompatible major workflow.
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
