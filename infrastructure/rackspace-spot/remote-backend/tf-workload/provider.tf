terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "open-tofu-remote"
        key = "rackspace-spot/example/terraform.tfstate"
    }

    required_version = ">= 0.12"

    required_providers {
        helm = {
          source = "hashicorp/helm"
          version = "2.13.2"
        }

        kubernetes = {
          source = "hashicorp/kubernetes"
          version = "2.27.0"
        }

        # kustomize = {
        #   source = "kbst/kustomize"
        #   version = "0.2.0-beta.3"
        # }

        onepassword = {
            source = "1Password/onepassword"
            version = "1.4.3"
        }
    }
}

# provider "kustomization" {
#   kubeconfig_path = var.kubeconfig_path
# }

provider "onepassword" {
}


provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}