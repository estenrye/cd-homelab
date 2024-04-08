resource "kubernetes_namespace" "onepassword" {
  metadata {
    name = "1password"
  }
}

data "onepassword_item" "op_credentials" {
  vault = var.opitem_connect_credentials_vault
  title = var.opitem_connect_credentials_title
}

resource "kubernetes_secret_v1" "op_token" {
  metadata {
    name = "onepassword-token"
    namespace = "1password"
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
    namespace = "1password"
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
  namespace = kubernetes_namespace.onepassword.metadata.0.name
  repository = "https://1password.github.io/connect-helm-charts"
  chart     = "connect"
  version   = "1.15.0"
  create_namespace = true
  skip_crds = true
  
  values = [
    file("${path.module}/helm/onepassword-connect.yaml")
  ]
}
