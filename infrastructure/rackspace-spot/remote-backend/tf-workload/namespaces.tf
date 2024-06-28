resource "kubernetes_namespace" "namespace" {
  for_each = var.namespaces

  metadata {
    name = each.value.name
    annotations = each.value.annotations
    labels = each.value.labels
  }
}