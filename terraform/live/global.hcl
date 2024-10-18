locals {
  modules_dir = "${get_repo_root()}/terraform/modules"

  github_org  = "estenrye"
  github_repo = "cd-homelab"

  terragrunt_state = {
    bucket                    = "terragrunt-tfstate-rye-ninja"
    accesslogging_bucket_name = "terragrunt-tfstate-rye-ninja-access-logs"
    dynamodb_table            = "terragrunt-tfstate-locks"
  }

  onepassword_account = "ryefamily.1password.com"
  onepassword_service_account_token = {
    item_path = "op://Home_Lab/op_service_account_token/credential"
  }

  phoenixnap = {
    client_id_item_path     = "op://Home_Lab/bmc-api-credentials/username"
    client_secret_item_path = "op://Home_Lab/bmc-api-credentials/credential"
  }
}