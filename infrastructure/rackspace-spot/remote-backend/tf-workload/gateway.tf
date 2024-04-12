resource "kubernetes_manifest" "envoy_proxy_configuration" {
    manifest = {
        apiVersion = "gateway.envoyproxy.io/v1alpha1"
        kind       = "EnvoyProxy"
        metadata = {
            name = "custom-proxy-config"
            namespace = "envoy-gateway-system"
        }
        spec = {
            provider = {
                type = "Kubernetes"
                kubernetes = {
                    envoyDeployment = {
                        pod = {
                            annotations = {
                                "linkerd.io/inject" = "enabled"
                            }
                        }
                    }
                }
            }
        }
    }
}

resource kubernetes_manifest gateway_class_envoy {
    manifest = {
        apiVersion = "gateway.networking.k8s.io/v1"
        kind       = "GatewayClass"
        metadata = {
            name = "eg"
        }
        spec = {
            controllerName = "gateway.envoyproxy.io/gatewayclass-controller"
            parametersRef = {
                group = "gateway.envoyproxy.io"
                kind = "EnvoyProxy"
                name = "custom-proxy-config"
                namespace = "envoy-gateway-system"
            }
        }
    }
}

resource "kubernetes_manifest" "cloudflare_dns_credentials" {
  manifest = {
    "apiVersion" = "onepassword.com/v1"
    "kind"       = "OnePasswordItem"
    "metadata" = {
      "name"      = "cloudflare-dns-credentials"
      "namespace" = "envoy-gateway-system"
    }
    "spec" = {
      "itemPath" = var.opitem_dns_credentials
    }
  }
}

resource kubernetes_manifest le_cluster_issuer {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Issuer"
        metadata = {
            name = "letsencrypt-prod"
            namespace = "envoy-gateway-system"
        }
        spec = {
            acme = {
                email = var.letsencrypt_email
                server = "https://acme-v02.api.letsencrypt.org/directory"
                privateKeySecretRef = {
                    name = "letsencrypt-account-key"
                }
                solvers = [
                    {
                        dns01 = {
                            cloudflare = {
                                apiTokenSecretRef = {
                                    name = "cloudflare-dns-credentials"
                                    key = "password"
                                }
                            }
                        }
                    }
                ]
            }
        }
    }
}

resource kubernetes_manifest gateway_eg {
    manifest = {
        apiVersion = "gateway.networking.k8s.io/v1"
        kind       = "Gateway"
        metadata = {
            name = "eg"
            namespace = "envoy-gateway-system"
            annotations = {
                "cert-manager.io/issuer" = "letsencrypt-prod"
                "cert-manager.io/revision-history-limit" = "3"
            }
        }
        spec = {
            gatewayClassName = "eg"
            listeners = [
                {
                    name = "http"
                    protocol = "HTTP"
                    port = 80
                },
                {
                    name = "https"
                    protocol = "HTTPS"
                    port = 443
                    hostname = format("*.%s.%s", var.cluster_name, var.top_level_domain)
                    tls = {
                        mode = "Terminate"
                        certificateRefs = [
                            {
                                kind = "Secret"
                                name = format("star-%s-%s-tls", var.cluster_name, replace(var.top_level_domain, ".", ""))
                            }
                        ]
                    }
                }
            ]
        }
    }
}