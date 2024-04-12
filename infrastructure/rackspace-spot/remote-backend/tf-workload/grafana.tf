resource "kubernetes_manifest" "grafana_admin_password" {
  manifest = {
    "apiVersion" = "onepassword.com/v1"
    "kind"       = "OnePasswordItem"
    "metadata" = {
      "name"      = "grafana-admin"
      "namespace" = "monitoring"
    }
    "spec" = {
      "itemPath" = var.opitem_grafana_admin_credentials
    }
  }
}

resource helm_release grafana {
    name = "grafana"
    namespace = "monitoring"
    repository = "https://grafana.github.io/helm-charts"
    chart     = "grafana"
    version   = "6.16.2"
    create_namespace = true
    skip_crds = true
    
    values = [
        file("${path.module}/helm/grafana.yaml")
    ]
}

resource "kubernetes_manifest" "reference_grant_grafana" {
    manifest = {
        apiVersion = "gateway.networking.k8s.io/v1alpha2"
        kind = "ReferenceGrant"
        metadata = {
            name = "grafana"
            namespace = "monitoring"
        }
        spec = {
            from = [
                {
                    group = "gateway.networking.k8s.io"
                    kind = "HTTPRoute"
                    namespace = "envoy-gateway-system"
                }
            ]
            to = [
                {
                    group = ""
                    kind = "Service"
                }
            ]
        }
    }
}

resource "kubernetes_manifest" "http_route_grafana" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind = "HTTPRoute"
    metadata = {
      name = "grafana-example-rye-ninja"
      namespace = "envoy-gateway-system"
    }
    spec = {
        parentRefs = [
            {
                name = "eg"
                namespace = "envoy-gateway-system"
                kind = "Gateway"
            }
        ]
        hostnames = [
            format("grafana.%s.%s", var.cluster_name, var.top_level_domain)
        ]
        rules = [
            {
                backendRefs = [
                    {
                        group = ""
                        kind = "Service"
                        name = "grafana"
                        namespace = "monitoring"
                        port = 80
                        weight = 1
                    }
                ]
                matches = [
                    {
                        path = {
                            type = "PathPrefix"
                            value = "/"
                        }
                    }
                ]
            }
        ]
    }
  }
}

resource "kubernetes_manifest" "http_route_prometheus" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind = "HTTPRoute"
    metadata = {
      name = "prometheus-example-rye-ninja"
      namespace = "envoy-gateway-system"
    }
    spec = {
        parentRefs = [
            {
                name = "eg"
                namespace = "envoy-gateway-system"
                kind = "Gateway"
            }
        ]
        hostnames = [
            format("prometheus.%s.%s", var.cluster_name, var.top_level_domain)
        ]
        rules = [
            {
                backendRefs = [
                    {
                        group = ""
                        kind = "Service"
                        name = "kube-prometheus-stack-prometheus"
                        namespace = "monitoring"
                        port = 9090
                        weight = 1
                    }
                ]
                matches = [
                    {
                        path = {
                            type = "PathPrefix"
                            value = "/"
                        }
                    }
                ]
            }
        ]
    }
  }
}