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
}

variable "managed_policy_arns" {
  description = "Managed policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for IAM role"
  type        = map(string)
  default     = {}
}
