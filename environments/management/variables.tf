variable "home_region" {
  description = "AWS Control Tower home region"
  type        = string
  default     = "ap-south-1"
}

variable "sandbox_ou_id" {
  description = "Sandbox OU ID"
  type        = string
  default     = "ou-ekgw-p32c19gr"
}
