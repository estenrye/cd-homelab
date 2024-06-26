resource "helm_release" "external_dns" {
  name = "external-dns"
  namespace = kubernetes_namespace.namespace["external_dns"].metadata[0].name
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart     = "external-dns"
  version   = "1.14.4"
  create_namespace = true
  skip_crds = true
  
  values = [
    file("${path.module}/helm/external-dns.yaml")
  ]

  set {
    name = "domainFilters[0]"
    value =  format("%s.%s", var.cluster_name, var.top_level_domain)
  }

  set {
    name = "txtOwnerId"
    value = var.cluster_name
  }
}