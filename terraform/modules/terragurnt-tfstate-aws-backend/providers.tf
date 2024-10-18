terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.71.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }

    github = {
      source  = "integrations/github"
      version = "6.2.2"
    }

    onepassword = {
      source  = "registry.terraform.io/1Password/onepassword"
      version = "2.1.2"
    }
  }
}

# provider "aws" {}

# provider "onepassword" {}

provider "github" {
  owner = var.github_orgname
  token = data.onepassword_item.gh_pat.credential
}