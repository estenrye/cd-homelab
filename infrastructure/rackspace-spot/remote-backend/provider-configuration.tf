terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "open-tofu-remote"
        key = "rackspace-spot/argocd/terraform.tfstate"
    }

    required_providers {
        onepassword = {
            source = "1Password/onepassword"
            version = "1.4.3"
        }

        spot = {
            source = "rackerlabs/spot"
            version = "0.0.3"
        }
    }
}

provider "onepassword" {
}

# data "onepassword_item" "spot_credentials" {
#   vault = "Home_Lab"
#   title = "Rackspace-SPOT"
# }

provider "spot" {}

resource "spot_cloudspace" "my-cloudspace" {
  cloudspace_name    = "example"
  region             = "us-central-dfw-1"
  hacontrol_plane    = false
}

resource "spot_spotnodepool" "example" {
  cloudspace_name = "example"
  server_class    = "mh.vs1.2xlarge-dfw"
  bid_price       = 0.03
  autoscaling = {
    min_nodes = 2
    max_nodes = 4
  }
}