resource "helm_release" "cert_manager" {
  name = "cert-manager"
  namespace = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart     = "cert-manager"
  version   = "v1.14.4"
  create_namespace = true
  skip_crds = true

  values = [
    file("${path.module}/helm/cert-manager.yaml")
  ]
}