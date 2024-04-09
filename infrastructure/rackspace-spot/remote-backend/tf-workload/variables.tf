variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/org-pduvfizupzbnb6dq/example-kubeconfig.yaml"
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