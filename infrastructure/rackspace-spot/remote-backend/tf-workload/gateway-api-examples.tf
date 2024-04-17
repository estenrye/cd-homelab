resource "kubernetes_namespace" "gateway_api_examples" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  metadata {
    name = "gateway-api-examples"
  }
}

resource "kubernetes_deployment_v1" "yages" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  metadata {
    name = "yages"
    namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    labels = {
      app = "yages"
      example = "grpc-routing"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "yages"
      }
    }

    template {
      metadata {
        labels = {
          app = "yages"
        }
      }

      spec {
        container {
          name = "grpcsrv"
          image = "ghcr.io/projectcontour/yages:v0.1.0"
          port {
            name = "grpc"
            container_port = 9000
            protocol = "TCP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "yages" {
  count = var.deploy_gateway_api_examples ? 1 : 0
  
  metadata {
    name = "yages"
    namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    labels = {
      app = "yages"
      example = "grpc-routing"
    }
  }

  spec {
    selector = {
      app = "yages"
    }

    type = "ClusterIP"

    port {
      name = "grpc"
      port = 9000
      protocol = "TCP"
      target_port = "grpc"
    }
  }
}


resource "kubernetes_manifest" "reference_grant_yages" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1alpha2"
    kind = "ReferenceGrant"
    metadata = {
      name = "yages"
      namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    }
    spec = {
      from = [
        {
          group = "gateway.networking.k8s.io"
          kind = "GRPCRoute"
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


resource "kubernetes_manifest" "grpcroute_yages" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1alpha2"
    kind = "GRPCRoute"

    metadata = {
      labels = {
        example = "grpc-routing"
      }
      name = format("grpc-example-%s-%s", var.cluster_name, replace(var.top_level_domain, ".", "-"))
      namespace = resource.kubernetes_manifest.gateway_eg.manifest.metadata.namespace
    }
    spec = {
      hostnames = [
        format("grpc-example.%s.%s", var.cluster_name, var.top_level_domain)
      ]
      parentRefs = [
        {
            name = resource.kubernetes_manifest.gateway_eg.manifest.metadata.name
            namespace = resource.kubernetes_manifest.gateway_eg.manifest.metadata.namespace
            kind = "Gateway"
        },
      ]
      rules = [
        {
          backendRefs = [
            {
              group = ""
              kind = "Service"
              name = "yages"
              namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
              port = 9000
              weight = 1
            },
          ]
        },
      ]
    }
  }
}

resource "kubernetes_deployment_v1" "echo_basic" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  metadata {
    name = "echo-basic"
    namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    labels = {
      app = "echo-basic"
      example = "tcp-routing"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "echo-basic"
      }
    }

    template {
      metadata {
        labels = {
          app = "echo-basic"
        }
      }

      spec {
        container {
          name = "backend"
          image = "gcr.io/k8s-staging-gateway-api/echo-basic:v20231214-v1.0.0-140-gf544a46e"
          port {
            name = "echo"
            container_port = 3000
            protocol = "TCP"
          }
          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }
          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "echo_basic" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  metadata {
    name = "echo-basic"
    namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    labels = {
      app = "echo-basic"
      example = "tcp-routing"
    }
  }
  
  spec {
    selector = {
      app = "echo-basic"
    }

    type = "ClusterIP"

    port {
      name = "echo"
      port = 3000
      protocol = "TCP"
      target_port = "echo"
    }
  }
}

resource "kubernetes_manifest" "example_gateway" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind = "Gateway"
    metadata = {
      name = "example-gateway"
      namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    }
    spec = {
      gatewayClassName = "eg"
      listeners = [
        {
          name = "foo"
          protocol = "TCP"
          port = 8888
          allowedRoutes = {
            kinds = [
              {
                kind = "TCPRoute"
              }
            ]
          }
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "tcproute_echo_basic" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1alpha2"
    kind = "TCPRoute"
    metadata = {
      name = "echo-basic"
      namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    }
    spec = {
      parentRefs = [
        {
          name = "example-gateway"
          group = "gateway.networking.k8s.io"
          kind = "Gateway"
          sectionName = "foo"
        }
      ]
      rules = [
        {
          backendRefs = [
            {
              group = ""
              kind = "Service"
              name = "echo-basic"
              port = 3000
              weight = 1
            }
          ]
        }
      ]
    }
  }
}