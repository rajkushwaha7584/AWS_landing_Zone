variable "home_region" {
  description = "AWS Control Tower home region"
  type        = string
  default     = "ap-south-1"
}

variable "management_account_id" {
  description = "AWS Organizations management account ID where SCPs are managed"
  type        = string
  default     = "039612843833"
}

variable "sandbox_ou_id" {
  description = "Sandbox OU ID"
  type        = string
  default     = "ou-ekgw-p32c19gr"
}
