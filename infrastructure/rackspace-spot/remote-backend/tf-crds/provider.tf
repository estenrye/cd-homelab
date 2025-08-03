terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "open-tofu-remote"
        key = "rackspace-spot/example/terraform.crds.tfstate"
    }

    required_providers {
        helm = {
          source = "hashicorp/helm"
          version = "2.17.0"
        }

        kubernetes = {
          source = "hashicorp/kubernetes"
          version = "2.30.0"
        }
    }
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/${var.cloudspace_name}-kubeconfig.yaml")
}

provider "helm" {
  kubernetes {
    config_path = pathexpand("~/.kube/${var.cloudspace_name}-kubeconfig.yaml")
  }
}