variable "tfstate_bucket_name" {
  type    = string
  default = "tfstate-bucket"
}

variable "tfstate_bucket_accesslogging_bucket_name" {
  type    = string
  default = "tfstate-bucket-access-logs"
}

variable "tfstate_bucket_dynamodb_table_name" {
  type    = string
  default = "tfstate-locks"
}

variable "dynamodb_billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "The billing mode for the table. Possible values are PROVISIONED and PAY_PER_REQUEST. Default is PAY_PER_REQUEST."
}

variable "dynamodb_read_capacity" {
  type        = number
  default     = null
  description = "(Optional) Number of read units for this table. If the dynamodb_billing_mode is PROVISIONED, this field is required."
}

variable "dynamodb_write_capacity" {
  type        = number
  default     = null
  description = "(Optional) Number of write units for this table. If the dynamodb_billing_mode is PROVISIONED, this field is required."
}

variable "github_orgname" {
  type    = string
  default = "orgname"
}

variable "github_repo" {
  type    = string
  default = "example-repo"
}

variable "onepassword_vault" {
  type    = string
  default = "vault_name"
}

variable "onepassword_item_gh_pat" {
  type    = string
  default = "gh_pat_token"
}

variable "onepassword_item_op_svc_account" {
  type    = string
  default = "op_service_account_token"
}