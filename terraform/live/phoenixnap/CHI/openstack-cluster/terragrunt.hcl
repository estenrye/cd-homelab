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

  ssh_keys = {
    esten = {
      default = true
      key     = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBABRrM38w/r7E5eHrD5eeQ0tU5sNlpseYO3s0kKKf0tbYIOsGW52ofUBzzx2/3PoAANOX/rZIwk6DmmiQxPizKeF6QCZuHrzknDHNHtg2JNWlsh24zNI9OjX8e+bB1oPE8y/PQPXPA8hrf7RZhU0wb3Ld4I6tOpcdiimlOI4sYmPgITmKA=="
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