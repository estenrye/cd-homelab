resource "helm_release" "cert_manager" {
  name = "cert-manager"
  namespace = kubernetes_namespace.namespace["cert_manager"].metadata[0].name
  repository = "https://charts.jetstack.io"
  chart     = "cert-manager"
  version   = "v1.14.5"
  create_namespace = true
  skip_crds = true

  values = [
    file("${path.module}/helm/cert-manager.yaml")
  ]
}