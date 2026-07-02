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
