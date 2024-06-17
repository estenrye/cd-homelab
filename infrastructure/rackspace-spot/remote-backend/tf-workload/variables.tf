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

variable "opitem_connect_credentials_vault" {
  description = "1Password vault name for the onepassword-connect credentials"
  type        = string
  default     = "Home_Lab"
}

variable "opitem_connect_credentials_title" {
  description = "1Password item title for the onepassword-connect credentials"
  type        = string
  default     = "onepassword-connect.rye.ninja"
}

variable "opitem_dns_credentials" {
  description = "1Password item path for the external-dns credentials"
  type        = string
  default     = "vaults/jaou7gkrt6by3xnocca3rdyyii/items/bmiftmas3r36u3wbbfcyjxtx5a"
}

variable opitem_grafana_admin_credentials {
  description = "1Password item path for the grafana admin credentials"
  type        = string
  default     = "vaults/jaou7gkrt6by3xnocca3rdyyii/items/grafana.rye.ninja"
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

variable opitem_lgtm_s3_credentials_path {
  description = "1Password item path for the LGTM S3 credentials"
  type        = string
  default     = "vaults/Home_Lab/items/cortex-rye-ninja-s3-creds"
}