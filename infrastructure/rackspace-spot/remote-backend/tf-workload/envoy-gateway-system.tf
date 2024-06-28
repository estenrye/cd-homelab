resource kubernetes_manifest "issuer_envoy_selfsigned" {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Issuer"
        metadata = {
            name = "envoy-selfsigned-issuer"
            namespace = kubernetes_namespace.namespace["envoy_gateway_system"].metadata[0].name
        }
        spec = {
            selfSigned = {}
        }
    }
}

resource kubernetes_manifest "certificate_envoy_gateway_ca" {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Certificate"
        metadata = {
            name = "envoy-gateway-ca"
            namespace = kubernetes_namespace.namespace["envoy_gateway_system"].metadata[0].name
        }
        spec = {
            isCA = true
            commonName = "envoy-gateway"
            secretName = "envoy-gateway-ca"
            duration = "87600h00m"
            renewBefore = "8761h00m"
            privateKey = {
                algorithm = "RSA"
                rotationPolicy = "Always"
                size = 2048
            }
            issuerRef = {
                name = "envoy-selfsigned-issuer"
                kind = "Issuer"
                group = "cert-manager.io"
            }
        }
    }
}

resource kubernetes_manifest "issuer_eg_issuer" {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Issuer"
        metadata = {
            name = "eg-issuer"
            namespace = kubernetes_namespace.namespace["envoy_gateway_system"].metadata[0].name
        }
        spec = {
            ca = {
                secretName = "envoy-gateway-ca"
            }
        }
    }
}

resource "kubernetes_manifest" "certificate_envoy_gateway" {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Certificate"
        metadata = {
            name = "envoy-gateway"
            namespace = kubernetes_namespace.namespace["envoy_gateway_system"].metadata[0].name
            labels = {
                "app.kubernetes.io/name" = "envoy-gateway"
            }
        }
        spec = {
            commonName = "envoy-gateway"
            duration = "2160h00m"
            renewBefore = "1081h00m"
            dnsNames = [
                "envoy-gateway",
                "envoy-gateway.envoy-gateway-system",
                "envoy-gateway.envoy-gateway-system.svc",
                "envoy-gateway.envoy-gateway-system.svc.cluster.local"
            ]
            privateKey = {
                algorithm = "RSA"
                rotationPolicy = "Always"
                size = 2048
            }
            issuerRef = {
                name = "eg-issuer"
                kind = "Issuer"
                group = "cert-manager.io"
            }
            usages = [
                "digital signature",
                "data encipherment",
                "key encipherment",
                "content commitment",
            ]
            secretName = "envoy-gateway"
        }
    }
}

resource "kubernetes_manifest" "certificate_envoy" {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Certificate"
        metadata = {
            name = "envoy"
            namespace = kubernetes_namespace.namespace["envoy_gateway_system"].metadata[0].name
            labels = {
                "app.kubernetes.io/name" = "envoy"
            }
        }
        spec = {
            commonName = "*"
            duration = "2160h00m"
            renewBefore = "1081h00m"
            dnsNames = [
                "*.envoy-gateway-system"
            ]
            privateKey = {
                algorithm = "RSA"
                rotationPolicy = "Always"
                size = 2048
            }
            issuerRef = {
                name = "eg-issuer"
                kind = "Issuer"
                group = "cert-manager.io"
            }
            usages = [
                "digital signature",
                "data encipherment",
                "key encipherment",
                "content commitment",
            ]
            secretName = "envoy"
        }
    }
}

resource kubernetes_manifest "certificate_envoy_rate_limit" {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Certificate"
        metadata = {
            name = "envoy-rate-limit"
            namespace = kubernetes_namespace.namespace["envoy_gateway_system"].metadata[0].name
            labels = {
                "app.kubernetes.io/name" = "envoy-rate-limit"
            }
        }
        spec = {
            commonName = "envoy-rate-limit"
            duration = "2160h00m"
            renewBefore = "1081h00m"
            dnsNames = [
                "envoy-rate-limit",
                "envoy-rate-limit.envoy-gateway-system",
                "envoy-rate-limit.envoy-gateway-system.svc",
                "envoy-rate-limit.envoy-gateway-system.svc.cluster.local"
            ]
            privateKey = {
                algorithm = "RSA"
                rotationPolicy = "Always"
                size = 2048
            }
            issuerRef = {
                name = "eg-issuer"
                kind = "Issuer"
                group = "cert-manager.io"
            }
            usages = [
                "digital signature",
                "data encipherment",
                "key encipherment",
                "content commitment",
            ]
            secretName = "envoy-rate-limit"
        }
    }
}

resource "helm_release" "envoy_gateway_system" {
  name = "envoy-gateway-system"
  namespace = kubernetes_namespace.namespace["envoy_gateway_system"].metadata[0].name
  repository = "oci://docker.io/envoyproxy"
  chart     = "gateway-helm"
  version   = "v1.0.0"
  create_namespace = true

  values = [
    file("${path.module}/helm/envoy-gateway.yaml")
  ]
}
