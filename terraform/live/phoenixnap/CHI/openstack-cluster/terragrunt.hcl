terraform {
  source = "${local.global.modules_dir}/phoenixnap-system"
}

inputs = {
  tags = {
    costcenter = {
      is_billing_tag = true
      description    = "Cost Center"
    }
  }
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  global   = read_terragrunt_config(find_in_parent_folders("global.hcl")).locals
  provider = read_terragrunt_config(find_in_parent_folders("provider.hcl")).locals
  region   = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "pnap" {}
EOF
}