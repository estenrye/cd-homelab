resource "helm_release" "kubernetes_replicator" {
  name = "kubernetes-replicator"
  namespace = "kube-system"
  repository = "https://helm.mittwald.de"
  chart     = "kubernetes-replicator"
  version   = "2.9.2"
  create_namespace = true
}