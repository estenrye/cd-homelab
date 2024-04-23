resource "kubernetes_namespace" "grafana_lgtm" {
  metadata {
    name = "grafana-lgtm"
  }
}

resource "kubernetes_manifest" "lgtm-s3-bucket" {
  manifest = {
    apiVersion = "onepassword.com/v1"
    kind       = "OnePasswordItem"
    metadata = {
      name      = "s3-bucket-credentials"
      namespace = resource.kubernetes_namespace.grafana_lgtm.metadata.0.name
    }
    spec = {
      itemPath = var.opitem_lgtm_s3_credentials_path
    }
  }
}

resource "helm_release" "grafana_lgtm" {
  name = "lgtm"
  namespace = kubernetes_namespace.grafana_lgtm.metadata.0.name
  repository = "https://grafana.github.io/helm-charts"
  chart     = "lgtm-distributed"
  version   = "1.0.1"
  create_namespace = true
  skip_crds = true
  
  values = [
    file("${path.module}/helm/grafana-lgtm-stack.yaml")
  ]
}