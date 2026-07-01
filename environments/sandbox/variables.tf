variable "home_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "network_account_id" {
  description = "Network account ID allowed to assume sandbox role"
  type        = string
  default     = "602506755932"
}
