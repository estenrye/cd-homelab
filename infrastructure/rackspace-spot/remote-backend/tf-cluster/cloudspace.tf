
resource "spot_cloudspace" "cloudspace" {
  cloudspace_name    = var.cloudspace_name
  region             = var.region
  hacontrol_plane    = var.hacontrol_plane
}

resource "spot_spotnodepool" "example" {
  cloudspace_name = var.cloudspace_name
  server_class    = var.server_class
  bid_price       = var.bid_price
  autoscaling = {
    min_nodes = var.min_nodes
    max_nodes = var.max_nodes
  }
}

data "spot_kubeconfig" "cloudspace_config" {
  cloudspace_name = var.cloudspace_name
}

resource "local_sensitive_file" "home_kubeconfig" {
  content  = data.spot_kubeconfig.cloudspace_config.raw
  filename = pathexpand("~/.kube/${var.cloudspace_name}-kubeconfig.yaml")
}