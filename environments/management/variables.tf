# Region where Control Tower and Organizations operations are managed for this lab.
variable "home_region" {
  description = "AWS Control Tower home region"
  type        = string
  default     = "ap-south-1"
}

# Expected management account. The provider uses this to block wrong-profile plans.
variable "management_account_id" {
  description = "AWS Organizations management account ID where SCPs are managed"
  type        = string
  default     = "039612843833"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.management_account_id))
    error_message = "management_account_id must be a 12-digit AWS account ID."
  }
}

# Existing Sandbox OU where the EC2 region-deny SCP is attached.
variable "sandbox_ou_id" {
  description = "Sandbox OU ID"
  type        = string
  default     = "ou-ekgw-p32c19gr"

  validation {
    condition     = can(regex("^ou-[a-z0-9]{4,32}-[a-z0-9]{8,32}$", var.sandbox_ou_id))
    error_message = "sandbox_ou_id must be a valid AWS Organizations OU ID."
  }
}

# Name of the lab OU created under the organization root.
variable "test_ou_name" {
  description = "Name for the lab OU managed in this environment"
  type        = string
  default     = "TestOU"
}

# Existing account already tracked by Terraform state. Avoid changing these
# values because account email/name updates may force replacement.
variable "legacy_test_ou_account_name" {
  description = "Name of the existing lab account already managed by Terraform state"
  type        = string
  default     = "test-ou-account"
}

variable "legacy_test_ou_account_email" {
  description = "Email of the existing lab account already managed by Terraform state. Do not change after creation."
  type        = string
  default     = "your-unique-email@example.com"

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.legacy_test_ou_account_email))
    error_message = "legacy_test_ou_account_email must be a valid email address."
  }
}

# Second lab account tracked by Terraform state. Add new accounts as new
# aws_organizations_account resources instead of editing this one.
variable "test_ou_account1_name" {
  description = "Name of the second lab account in TestOU"
  type        = string
  default     = "test-ou-account1"
}

variable "test_ou_account1_email" {
  description = "Email of the second lab account in TestOU. Do not change after creation."
  type        = string
  default     = "raj24kush@email.com"

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.test_ou_account1_email))
    error_message = "test_ou_account1_email must be a valid email address."
  }
}
