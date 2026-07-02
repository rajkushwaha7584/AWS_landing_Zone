# Purpose: Pin Terraform and provider requirements for the sandbox environment.
# Use: Ensures Terraform uses the AWS provider source and supported version range.
# Why: Keeps local and CI behavior consistent.
# Where: Used when running `terraform init` in environments/sandbox.
#
terraform {
  # Keep Terraform version reasonably current for provider compatibility.
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
