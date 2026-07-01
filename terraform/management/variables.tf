variable "home_region" {
  description = "AWS Control Tower home region"
  type        = string
  default     = "ap-south-1"
}

variable "management_account_id" {
  description = "AWS Organizations management account ID"
  type        = string
  default     = "039612843833"
}

variable "root_id" {
  description = "AWS Organizations root ID"
  type        = string
  default     = "r-ekgw"
}

variable "ou_ids" {
  description = "Existing OU IDs created from AWS Control Tower"
  type        = map(string)

  default = {
    security       = "ou-ekgw-gg6vzoga"
    dev            = "ou-ekgw-joc90n93"
    sandbox        = "ou-ekgw-p32c19gr"
    infrastructure = "ou-ekgw-7s2hlda6"
  }
}

variable "account_ids" {
  description = "Existing AWS account IDs"
  type        = map(string)

  default = {
    management       = "039612843833"
    aggregator       = "889947797924"
    cloudtrail_admin = "238480774313"
    dev_sandbox      = "855012563791"
    sandbox          = "961828155967"
    network          = "602506755932"
  }
}
