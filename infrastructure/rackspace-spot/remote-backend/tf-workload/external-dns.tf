resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = "external-dns"
  }
}

resource "kubernetes_manifest" "external_dns_credentials" {
  manifest = {
    "apiVersion" = "onepassword.com/v1"
    "kind"       = "OnePasswordItem"
    "metadata" = {
      "name"      = "dns-credentials"
      "namespace" = "external-dns"
    }
    "spec" = {
      "itemPath" = "vaults/jaou7gkrt6by3xnocca3rdyyii/items/bmiftmas3r36u3wbbfcyjxtx5a"
    }
  }
}