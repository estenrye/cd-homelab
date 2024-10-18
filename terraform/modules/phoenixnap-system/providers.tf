terraform {
  required_version = ">= 1.0.0"

  required_providers {
    pnap = {
      source = "registry.terraform.io/phoenixnap/pnap"
      version = "0.25.1"
    }
  }
}