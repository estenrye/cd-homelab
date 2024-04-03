terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "open-tofu-remote"
        key = "rackspace-spot/argocd/terraform.tfstate"
    }

    required_providers {
        helm = {
          source = "hashicorp/helm"
          version = "2.12.1"
        }

        kubernetes = {
          source = "hashicorp/kubernetes"
          version = "2.27.0"
        }

        onepassword = {
            source = "1Password/onepassword"
            version = "1.4.3"
        }

        shell = {
          source = "scottwinkler/shell"
          version = "1.7.10"
        }

        spot = {
            source = "rackerlabs/spot"
            version = "0.0.3"
        }
    }
}

provider "onepassword" {
}

provider "shell" {
    environment = {}
    sensitive_environment = {}
    interpreter = ["/bin/sh", "-c"]
    enable_parallelism = false
}

provider "spot" {}

resource "spot_cloudspace" "cloudspace" {
  cloudspace_name    = "example"
  region             = "us-central-dfw-1"
  hacontrol_plane    = false
}

resource "spot_spotnodepool" "example" {
  cloudspace_name = "example"
  server_class    = "mh.vs1.2xlarge-dfw"
  bid_price       = 0.03
  autoscaling = {
    min_nodes = 2
    max_nodes = 4
  }
}

data "spot_cloudspace" "cloudspace" {
  id = spot_cloudspace.cloudspace.id
}

# resource "local_sensitive_file" "home_kubeconfig" {
#   content  = data.spot_cloudspace.cloudspace.kubeconfig
#   filename = pathexpand("~/.kube/${data.spot_cloudspace.cloudspace.id}-kubeconfig.yaml")
# }

resource "shell_script" "kubeconfig" {
    lifecycle_commands {
        //I suggest having these command be as separate files if they are non-trivial
        create = file("${path.module}/shell/manipulate_kubeconfig/create.sh")
        # read   = file("${path.module}/shell/manipulate_kubeconfig/read.sh")
        update = file("${path.module}/shell/manipulate_kubeconfig/create.sh")
        delete = file("${path.module}/shell/manipulate_kubeconfig/delete.sh")
    }

    environment = {
        //changes to one of these will trigger an update
        KUBECONFIG_PATH = pathexpand("~/.kube/${data.spot_cloudspace.cloudspace.id}-kubeconfig.yaml")
        ORG_ID = replace(split("/", data.spot_cloudspace.cloudspace.id)[0], "-", "_")
        NAME = split("/", data.spot_cloudspace.cloudspace.id)[1]
    }


    //sensitive environment variables are exactly the
    //same as environment variables except they don't
    //show up in log files
    sensitive_environment = {
        SERVER = data.spot_cloudspace.cloudspace.api_server_endpoint
        TOKEN  = data.spot_cloudspace.cloudspace.token
    }

    //sets current working directory
    working_directory = path.module

    //triggers a force new update if value changes, like null_resource
    triggers = {
        when_server_changed = data.spot_cloudspace.cloudspace.api_server_endpoint
        when_token_changed = data.spot_cloudspace.cloudspace.token
    }
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/${data.spot_cloudspace.cloudspace.id}-kubeconfig.yaml")
}

provider "helm" {
  kubernetes {
    config_path = pathexpand("~/.kube/${data.spot_cloudspace.cloudspace.id}-kubeconfig.yaml")
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name = "kube-prometheus-stack"
  namespace = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart     = "kube-prometheus-stack"
  version   = "57.2.0"
  create_namespace = true
  values = [
    file("${path.module}/helm/kube-prometheus-stack.yaml")
  ]
}

resource "kubernetes_namespace" "onepassword" {
  metadata {
    name = "1password"
  }
}

resource "shell_script" "op_connect_secrets" {
    lifecycle_commands {
        //I suggest having these command be as separate files if they are non-trivial
        create = file("${path.module}/shell/initialize_op_connect_credentials/create.sh")
        delete = file("${path.module}/shell/initialize_op_connect_credentials/delete.sh")
    }

    environment = {
        //changes to one of these will trigger an update
        OP_ACCOUNT = "ryefamily.1password.com"
        OP_CREDENTIALS_ITEM="op://Home_Lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json"
        OP_TOKEN_ITEM="op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential"
        KUBECONFIG=pathexpand("~/.kube/${data.spot_cloudspace.cloudspace.id}-kubeconfig.yaml")
    }

    triggers = {
        when_op_account_changed = "ryefamily.1password.com"
        when_op_credentials_item_changed = "op://Home_Lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json"
        when_op_token_item_changed = "op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential"
    }
}

resource "helm_release" "onepassword_connect" {
  name = "connect"
  namespace = kubernetes_namespace.onepassword.metadata.0.name
  repository = "https://1password.github.io/connect-helm-charts"
  chart     = "connect"
  version   = "1.15.0"
  create_namespace = true
  values = [
    file("${path.module}/helm/onepassword-connect.yaml")
  ]
}

resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = "external-dns"
  }
}

resource "kubernetes_manifest" "external_dns_credentials" {
  manifest = {
    "apiVersion" = "onepassword.com/v1"
    "kind"       = "OnePasswordItem"
    "metadata" = {
      "name"      = "dns-credentials"
      "namespace" = "external-dns"
    }
    "spec" = {
      "itemPath" = "vaults/jaou7gkrt6by3xnocca3rdyyii/items/bmiftmas3r36u3wbbfcyjxtx5a"
    }
  }
}