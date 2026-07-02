# Purpose: Define inputs for the sandbox Terraform environment.
# Use: Stores sandbox account ID, network source account ID, and region.
# Why: Validation prevents wrong account IDs and supports safer demos.
# Where: Used by provider.tf and main.tf in environments/sandbox.
#
# Region used for sandbox resources.
variable "home_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

# Expected sandbox account. The provider blocks plans if a different profile is active.
variable "sandbox_account_id" {
  description = "Sandbox account ID where sandbox resources are managed"
  type        = string
  default     = "961828155967"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.sandbox_account_id))
    error_message = "sandbox_account_id must be a 12-digit AWS account ID."
  }
}

# Source account allowed to assume the sandbox read-only role.
variable "network_account_id" {
  description = "Network account ID allowed to assume sandbox role"
  type        = string
  default     = "602506755932"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.network_account_id))
    error_message = "network_account_id must be a 12-digit AWS account ID."
  }
}
