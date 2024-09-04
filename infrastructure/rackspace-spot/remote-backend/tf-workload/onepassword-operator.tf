data "onepassword_item" "op_credentials" {
  vault = var.connect_credentials.vault
  title = var.connect_credentials.item
}

resource "kubernetes_secret_v1" "op_token" {
  metadata {
    name = "onepassword-token"
    namespace = kubernetes_namespace.namespace["one_password"].metadata[0].name
  }

  # TODO: parameterize the section and field names into variables.

  data = {
    "token" = data.onepassword_item.op_credentials.section[
        index(data.onepassword_item.op_credentials.section.*.label, "onepassword_token")
      ].field[
        index(data.onepassword_item.op_credentials.section[
          index(data.onepassword_item.op_credentials.section.*.label, "onepassword_token")
        ].field.*.label, "token")
      ].value
  }
}

resource "kubernetes_secret_v1" "op_credentials" {
  metadata {
    name = "op-credentials"
    namespace = kubernetes_namespace.namespace["one_password"].metadata[0].name
  }
  # TODO: parameterize the section and field names into variables.

  # TODO: This is a  hack.  Replace after this PR is merged: https://github.com/1Password/terraform-provider-onepassword/pull/161
  # TODO: Follow this issue for file support in 1Password tereraform provider: https://github.com/1Password/terraform-provider-onepassword/issues/51
  data = {
    "1password-credentials.json" = data.onepassword_item.op_credentials.section[
        index(data.onepassword_item.op_credentials.section.*.label, "op_credentials")
      ].field[
        index(data.onepassword_item.op_credentials.section[
          index(data.onepassword_item.op_credentials.section.*.label, "op_credentials")
        ].field.*.label, "connect_credentials_base64")
      ].value
  }
}

resource "helm_release" "onepassword_connect" {
  name = "connect"
  namespace = kubernetes_namespace.namespace["one_password"].metadata[0].name
  repository = "https://1password.github.io/connect-helm-charts"
  chart     = "connect"
  version   = "1.15.1"
  create_namespace = false
  skip_crds = true
  
  values = [
    file("${path.module}/helm/onepassword-connect.yaml")
  ]
}

resource "kubernetes_manifest" "onepassword_item" {
  for_each = var.op_items

  manifest = {
    apiVersion = "onepassword.com/v1"
    kind       = "OnePasswordItem"
    metadata = {
      name      = each.value.name
      namespace = each.value.namespace
    }
    spec = {
      itemPath = "/vaults/${each.value.vault}/items/${each.value.item}"
    }
  }
}