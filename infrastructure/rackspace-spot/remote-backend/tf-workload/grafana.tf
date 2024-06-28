resource "kubernetes_manifest" "reference_grant_grafana" {
    manifest = {
        apiVersion = "gateway.networking.k8s.io/v1alpha2"
        kind = "ReferenceGrant"
        metadata = {
            name = "lgtm-grafana"
            namespace = kubernetes_namespace.namespace["lgtm"].metadata[0].name
        }
        spec = {
            from = [
                {
                    group = "gateway.networking.k8s.io"
                    kind = "HTTPRoute"
                    namespace = resource.kubernetes_manifest.gateway_eg.manifest.metadata.namespace
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
      name = format("grafana-%s-%s", var.cluster_name, replace(var.top_level_domain, ".", "-"))
      namespace = resource.kubernetes_manifest.gateway_eg.manifest.metadata.namespace
    }
    spec = {
        parentRefs = [
            {
                name = resource.kubernetes_manifest.gateway_eg.manifest.metadata.name
                namespace = resource.kubernetes_manifest.gateway_eg.manifest.metadata.namespace
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
                        name = "lgtm-grafana"
                        namespace = "grafana-lgtm"
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

# resource "kubernetes_manifest" "http_route_prometheus" {
#   manifest = {
#     apiVersion = "gateway.networking.k8s.io/v1"
#     kind = "HTTPRoute"
#     metadata = {
#       name = format("prometheus-%s-%s", var.cluster_name, replace(var.top_level_domain, ".", "-"))
#       namespace = resource.kubernetes_manifest.gateway_eg.manifest.metadata.namespace
#     }
#     spec = {
#         parentRefs = [
#             {
#                 name = resource.kubernetes_manifest.gateway_eg.manifest.metadata.name
#                 namespace = resource.kubernetes_manifest.gateway_eg.manifest.metadata.namespace
#                 kind = "Gateway"
#             }
#         ]
#         hostnames = [
#             format("prometheus.%s.%s", var.cluster_name, var.top_level_domain)
#         ]
#         rules = [
#             {
#                 backendRefs = [
#                     {
#                         group = ""
#                         kind = "Service"
#                         name = "kube-prometheus-stack-prometheus"
#                         namespace = "monitoring"
#                         port = 9090
#                         weight = 1
#                     }
#                 ]
#                 matches = [
#                     {
#                         path = {
#                             type = "PathPrefix"
#                             value = "/"
#                         }
#                     }
#                 ]
#             }
#         ]
#     }
#   }
# }