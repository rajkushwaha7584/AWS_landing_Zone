variable "home_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "sandbox_account_id" {
  description = "Sandbox account ID where sandbox resources are managed"
  type        = string
  default     = "961828155967"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.sandbox_account_id))
    error_message = "sandbox_account_id must be a 12-digit AWS account ID."
  }
}

variable "network_account_id" {
  description = "Network account ID allowed to assume sandbox role"
  type        = string
  default     = "602506755932"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.network_account_id))
    error_message = "network_account_id must be a 12-digit AWS account ID."
  }
}
