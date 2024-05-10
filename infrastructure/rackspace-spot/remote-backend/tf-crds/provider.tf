terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "open-tofu-remote"
        key = "rackspace-spot/example/terraform.crds.tfstate"
    }

    required_providers {
        kubernetes = {
          source = "hashicorp/kubernetes"
          version = "2.30.0"
        }
    }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}
