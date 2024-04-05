terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "open-tofu-remote"
        key = "rackspace-spot/tf-cluster/terraform.tfstate"
    }

    required_providers {
        local = {
          source = "hashicorp/local"
          version = "2.5.1"
        }

        spot = {
            source = "rackerlabs/spot"
            version = "0.0.4"
        }
    }
}

provider "spot" {}
