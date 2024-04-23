resource kubernetes_namespace open_feature {
  metadata {
    name = "open-feature"
  }
}

resource helm_release open_feature_operator {
  name = "open-feature"
  namespace = kubernetes_namespace.open_feature.metadata.0.name
  repository = "https://open-feature.github.io/open-feature-operator/"
  chart     = "open-feature-operator"
  version   = "0.5.4"
  create_namespace = true
  skip_crds = true
  
  values = [
    file("${path.module}/helm/open-feature-operator.yaml")
  ]
}
