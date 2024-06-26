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
  count = var.deploy_gateway_api_examples ? 1 : 0

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
              namespace = coalesce(resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name, "default")
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
        },
        {
          name = "bar"
          protocol = "UDP"
          port = 5300
          allowedRoutes = {
            kinds = [
              {
                kind = "UDPRoute"
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

resource "kubernetes_config_map" "coredns" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  metadata {
    name = "coredns"
    namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
  }
  data = {
    Corefile = <<-EOF
    .:53 {
        forward . 1.1.1.1 8.8.8.8
        log
        errors
    }

    foo.bar.com:53 {
      whoami
    }
    EOF
  }
}

resource "kubernetes_deployment_v1" "coredns" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  metadata {
    name = "coredns"
    namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    labels = {
      gateway-k8s-app = "coredns"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        gateway-k8s-app = "coredns"
      }
    }

    template {
      metadata {
        labels = {
          gateway-k8s-app = "coredns"
        }
      }

      spec {
        container {
          name = "coredns"
          image = "coredns/coredns"
          port {
            name = "dns"
            container_port = 53
            protocol = "UDP"
          }
          args = [
            "-conf",
            "/etc/coredns/Corefile"
          ]
          volume_mount {
            name = "config-volume"
            mount_path = "/etc/coredns"
          }
        }

        volume {
          name = "config-volume"
          config_map {
            name = "coredns"
          }
        }
          
      }
    }
  }
}

resource "kubernetes_service_v1" "coredns" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  metadata {
    name = "coredns"
    namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    labels = {
      gateway-k8s-app = "coredns"
    }
  }

  spec {
    selector = {
      gateway-k8s-app = "coredns"
    }

    type = "ClusterIP"

    port {
      name = "dns"
      port = 53
      protocol = "UDP"
      target_port = "dns"
    }
  }
}

resource "kubernetes_manifest" "coredns" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1alpha2"
    kind = "UDPRoute"
    metadata = {
      name = "coredns"
      namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    }
    spec = {
      parentRefs = [
        {
          name = "example-gateway"
          group = "gateway.networking.k8s.io"
          kind = "Gateway"
          sectionName = "bar"
        }
      ]
      rules = [
        {
          backendRefs = [
            {
              group = ""
              kind = "Service"
              name = "coredns"
              port = 53
              weight = 1
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_deployment_v1" "tls_passthrough" {
  count = var.deploy_gateway_api_examples ? 1 : 0

  metadata {
    name = "tls-passthrough"
    namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
    labels = {
      app = "tls-passthrough"
      example = "tls-routing"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "tls-passthrough"
      }
    }

    template {
      metadata {
        labels = {
          app = "tls-passthrough"
        }
      }

      spec {
        container {
          name = "tls-passthrough"
          image = "gcr.io/k8s-staging-gateway-api/echo-basic:v20231214-v1.0.0-140-gf544a46e"
          port {
            name = "tls"
            container_port = 8443
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
          env {
            name = "HTTPS_PORT"
            value = "8443"
          }
          env {
            name = "TLS_SERVER_CERT"
            value = "/etc/server-certs/tls.crt"
          }
          env {
            name = "TLS_SERVER_KEY"
            value = "/etc/server-certs/tls.key"
          }
          volume_mount {
            name = "server-certs"
            mount_path = "/etc/server-certs"
            read_only = true
          }
        }
        volume {
          name = "server-certs"
          secret {
            secret_name = "server-certs"
          }
        }
      }
    }
  }
}

resource kubernetes_manifest "issuer_selfsigned" {
    count = var.deploy_gateway_api_examples ? 1 : 0
    
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Issuer"
        metadata = {
            name = "selfsigned-issuer"
            namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
        }
        spec = {
            selfSigned = {}
        }
    }
}


resource kubernetes_manifest "server_certs" {
    count = var.deploy_gateway_api_examples ? 1 : 0

    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Certificate"
        metadata = {
            name = "server-certs"
            namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
        }
        spec = {
            isCA = true
            commonName = format("tls-passthrough.%s.%s", var.cluster_name, var.top_level_domain)
            secretName = "server-certs"
            duration = "120h00m"
            renewBefore = "60h00m"
            privateKey = {
                algorithm = "RSA"
                rotationPolicy = "Always"
                size = 2048
            }
            issuerRef = {
                name = "selfsigned-issuer"
                kind = "Issuer"
                group = "cert-manager.io"
            }
            usages = [
                "digital signature",
                "key encipherment",
            ]
            dnsNames = [
                format("tls-passthrough.%s.%s", var.cluster_name, var.top_level_domain)
            ]
        }
    }
}

resource kubernetes_service_v1 "tls_passthrough" {
    count = var.deploy_gateway_api_examples ? 1 : 0

    metadata {
        name = "tls-passthrough"
        namespace = resource.kubernetes_namespace.gateway_api_examples.0.metadata.0.name
        labels = {
            app = "tls-passthrough"
            example = "tls-routing"
        }
    }

    spec {
        selector = {
            app = "tls-passthrough"
        }

        type = "ClusterIP"

        port {
            name = "tls"
            port = 8443
            protocol = "TCP"
            target_port = "tls"
        }
    }
}

resource kubernetes_manifest "tlsroute_tls_passthrough" {
    count = var.deploy_gateway_api_examples ? 1 : 0

    manifest = {
        apiVersion = "gateway.networking.k8s.io/v1alpha2"
        kind = "TLSRoute"
        metadata = {
            name = "tls-passthrough"
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
                            name = "tls-passthrough"
                            port = 8443
                            weight = 1
                        }
                    ]
                }
            ]
        }
    }
}