# Purpose: Define inputs for the SCP policy module.
# Use: Accepts SCP name, description, and JSON policy content.
# Why: Keeps SCP creation reusable for multiple guardrail policies.
# Where: Consumed by modules/scp-policy/main.tf.
#
variable "name" {
  description = "SCP policy name"
  type        = string
}

variable "description" {
  description = "SCP policy description"
  type        = string
}

variable "policy_content" {
  description = "SCP policy JSON content"
  type        = string
}
