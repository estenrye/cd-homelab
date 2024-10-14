terraform {
  source = "${local.global.modules_dir}/terragurnt-tfstate-aws-backend"
}

inputs = {
  force_destroy     = false
  github_orgname    = local.global.github_org
  github_repo       = local.global.github_repo
  onepassword_vault = "Home_Lab"

  #checkov:skip=CKV_SECRET_6: This is a false positive. The secret is not hardcoded.
  onepassword_item_gh_pat         = "rackspace-spot-gh-admin-token"
  onepassword_item_op_svc_account = "op_service_account_token"

  tfstate_bucket_name                      = local.global.terragrunt_state.bucket
  tfstate_bucket_accesslogging_bucket_name = local.global.terragrunt_state.accesslogging_bucket_name
  tfstate_bucket_dynamodb_table_name       = local.global.terragrunt_state.dynamodb_table
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  global   = read_terragrunt_config(find_in_parent_folders("global.hcl")).locals
  provider = read_terragrunt_config(find_in_parent_folders("provider.hcl")).locals
  account  = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
  region   = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals
}

# Indicate what region and profile to deploy the resources into
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region.region}"
  profile = "${local.account.profile}"
}
EOF
}