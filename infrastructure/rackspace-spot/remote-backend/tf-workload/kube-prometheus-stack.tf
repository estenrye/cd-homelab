resource "helm_release" "kube_prometheus_stack" {
  name = "kube-prometheus-stack"
  namespace = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart     = "kube-prometheus-stack"
  version   = "57.2.0"
  create_namespace = true
  skip_crds = true
  
  values = [
    file("${path.module}/helm/kube-prometheus-stack.yaml")
  ]
}