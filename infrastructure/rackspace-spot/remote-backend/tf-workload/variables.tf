variable "cloudspace_name" {
    description = "Name of the Rackspace Spot Cloudspace"
    type        = string
    default     = "example"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "example"
}

variable "top_level_domain" {
  description = "Top level domain for the cluster"
  type        = string
  default     = "rye.ninja"
}

variable "namespaces" {
  description = "Namespaces to create"
  type        = map(object({
    name   = string
    annotations = optional(map(string), {})
    labels = optional(map(string), {})
  }))
  default     = {
    cert_manager = { name = "cert-manager" }
    envoy_gateway_system = { name = "envoy-gateway-system" }
    external_dns = { name = "external-dns" }
    lgtm = { name = "grafana-lgtm" }
    one_password = { name = "1password" }
    open_feature = { name = "open-feature" }
  }
}

variable "connect_credentials" {
  description = "1Password item for the Connect credentials"
  type        = object({
    vault      = optional(string, "Home_Lab")
    item      = string
  })

  default     = {
    item = "onepassword-connect.rye.ninja"
  }

}
variable "op_items" {
  description = "1Password items for use with the automation."
  type        = map(object({
      name      = string
      namespace = string
      vault     = optional(string, "Home_Lab")
      item      = string
  }))

  default     = {
    external_dns_credentials = {
      name = "dns-credentials"
      namespace = "external-dns"
      item = "letsencrypt-dns01-credentials_cert-manager.rye.ninja"
    }

    certmanger_cluster_issuer_dns01_credentials = {
      name = "cloudflare-dns-credentials"
      namespace = "envoy-gateway-system"
      item = "letsencrypt-dns01-credentials_cert-manager.rye.ninja"
    }

    grafana_admin       = {
      name = "grafana-admin"
      namespace = "grafana-lgtm"
      item = "grafana.rye.ninja"
    }

    lgtm_s3_credentials = {
      name = "s3-bucket-credentials"
      namespace = "grafana-lgtm"
      item = "cortex-rye-ninja-s3-creds"
    }
  }
}

variable "letsencrypt_email" {
  description = "Email address for Let's Encrypt"
  type        = string
  default     = "esten.rye+letsencrypt@ryezone.com"
}

variable "deploy_gateway_api_examples" {
  description = "Deploy the gateway API examples"
  type        = bool
  default     = false
}
