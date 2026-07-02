# Purpose: Define inputs for the SCP attachment module.
# Use: Accepts the SCP policy ID and the Organizations target ID.
# Why: Validation catches bad IDs before Terraform reaches AWS APIs.
# Where: Consumed by modules/scp-attachment/main.tf.
#
variable "policy_id" {
  description = "SCP policy ID"
  type        = string

  validation {
    condition     = can(regex("^p-[a-z0-9]{8,}$", var.policy_id))
    error_message = "policy_id must be an AWS Organizations policy ID, for example p-12345678."
  }
}

variable "target_id" {
  description = "Target OU ID or account ID"
  type        = string

  validation {
    condition     = can(regex("^(r-[a-z0-9]{4,32}|ou-[a-z0-9]{4,32}-[a-z0-9]{8,32}|[0-9]{12})$", var.target_id))
    error_message = "target_id must be an AWS Organizations root ID, OU ID, or 12-digit AWS account ID."
  }
}
