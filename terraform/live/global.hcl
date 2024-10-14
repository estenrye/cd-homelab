locals {
  modules_dir = "${get_repo_root()}/terraform/modules"

  github_org  = "estenrye"
  github_repo = "cd-homelab"

  terragrunt_state = {
    bucket                    = "terragrunt-tfstate-rye-ninja"
    accesslogging_bucket_name = "terragrunt-tfstate-rye-ninja-access-logs"
    dynamodb_table            = "terragrunt-tfstate-locks"
  }

  onepassword_service_account_token = {
    account   = "ryefamily.1password.com"
    item_path = "op://Home_Lab/op_service_account_token/credential"
  }
}