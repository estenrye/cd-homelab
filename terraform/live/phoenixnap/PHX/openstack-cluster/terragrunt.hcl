terraform {
  source = "${local.global.modules_dir}/phoenixnap-system"
}

inputs = {
  location = local.region.region
  default_cidr = "10.20.0.0/24"
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

  storage_network_enabled = true
  storage_network = {
    description = "Fun Storage Network"
    location    = local.region.region
    vlan_id     = 1234
    cidr        = "10.20.1.0/24"
    path_suffix    = "/cinder"
    capacity_in_gb = 1000
    tags = {
      costcenter = "12345"
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