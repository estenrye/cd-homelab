locals {
  global = read_terragrunt_config(find_in_parent_folders("global.hcl")).locals
}

terraform {
  extra_arguments "onepassword_provider_config" {
    commands = ["plan", "apply", "destroy"]
    env_vars = {
      OP_SERVICE_ACCOUNT_TOKEN = run_cmd("op", "read", "--account",
        local.global.onepassword_account,
        local.global.onepassword_service_account_token.item_path
      )
      PNAP_CLIENT_ID = run_cmd("op", "read", "--account",
        local.global.onepassword_account,
        local.global.phoenixnap.client_id_item_path,
      )
      PNAP_CLIENT_SECRET = run_cmd("op", "read", "--account",
        local.global.onepassword_account,
        local.global.phoenixnap.client_secret_item_path,
      )
    }
  }
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket                    = local.global.terragrunt_state.bucket
    accesslogging_bucket_name = local.global.terragrunt_state.accesslogging_bucket_name
    key                       = "${path_relative_to_include()}/terraform.tfstate"
    region                    = "us-east-2"
    profile                   = "ops-opex-terraform-core-automation"
    encrypt                   = true
    dynamodb_table            = local.global.terragrunt_state.dynamodb_table
    disable_bucket_update     = true
  }
}
