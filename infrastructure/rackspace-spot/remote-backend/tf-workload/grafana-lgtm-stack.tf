resource "helm_release" "grafana_lgtm" {
  name = "lgtm"
  namespace = kubernetes_namespace.namespace["lgtm"].metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart     = "lgtm-distributed"
  version   = "1.0.1"
  create_namespace = false
  skip_crds = true
  
  values = [
    file("${path.module}/helm/grafana-lgtm-stack.yaml")
  ]
}

resource "helm_release" "grafana_pyroscope" {
  name = "pyroscope"
  namespace = kubernetes_namespace.namespace["lgtm"].metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart     = "pyroscope"
  version   = "1.5.1"
  create_namespace = false
  skip_crds = false
  
  values = [
    file("${path.module}/helm/grafana-pyroscope.yaml")
  ]
}

resource "helm_release" "k8s_monitoring" {
  name = "k8s-monitoring"
  namespace = kubernetes_namespace.namespace["lgtm"].metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart     = "k8s-monitoring"
  version   = "1.2.1"
  create_namespace = false
  skip_crds = false
  
  values = [
    file("${path.module}/helm/k8s-monitoring.yaml")
  ]

  set {
    name = "cluster.name"
    value = var.cluster_name
  }

  set {
    name = "externalServices.prometheus.host"
    value = format("http://%s-mimir-distributor:9095", helm_release.grafana_lgtm.name)
  }

  set {
    name = "externalServices.loki.host"
    value = format("http://%s-loki-distributor:9095", helm_release.grafana_lgtm.name)
  }

  set {
    name = "externalServices.tempo.host"
    value = format("http://%s-tempo-distributor:9095", helm_release.grafana_lgtm.name)
  }
  
  set {
    name = "externalServices.pyroscope.host"
    value = "http://pyroscope-distributor:4040"
  }

}

# resource "helm_release" "grafana_alloy" {
#   name = "alloy"
#   namespace = kubernetes_namespace.namespace["lgtm"].metadata[0].name
#   repository = "https://grafana.github.io/helm-charts"
#   chart     = "alloy"
#   version   = "0.2.0"
#   create_namespace = true
#   skip_crds = true
  
#   values = [
#     file("${path.module}/helm/grafana-alloy.yaml")
#   ]
# }
