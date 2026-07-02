variable "role_name" {
  description = "IAM role name"
  type        = string
}

variable "description" {
  description = "IAM role description"
  type        = string
  default     = null
}

variable "source_account_id" {
  description = "AWS account ID allowed to assume this role"
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.source_account_id))
    error_message = "source_account_id must be a 12-digit AWS account ID."
  }
}

variable "managed_policy_arns" {
  description = "Managed policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

variable "external_id" {
  description = "Optional external ID required when assuming this role"
  type        = string
  default     = null
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds for the role"
  type        = number
  default     = 3600

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "max_session_duration must be between 3600 and 43200 seconds."
  }
}

variable "tags" {
  description = "Tags for IAM role"
  type        = map(string)
  default     = {}
}
