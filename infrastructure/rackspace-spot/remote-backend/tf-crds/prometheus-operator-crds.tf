resource "helm_release" "prometheus_operator_crd" {
  name = "prometheus-operator-crds"
  namespace = "kube-system"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart     = "prometheus-operator-crds"
  version   = "14.0.0"
  create_namespace = false
  skip_crds = false
}