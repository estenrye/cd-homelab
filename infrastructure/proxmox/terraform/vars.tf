variable "unifi_network" {
  type = string
  default = "home-lab"
}

variable "cloudflare_zone" {
  type = string
  default = "rye.ninja"
}


variable "hosts" {
  type = map(object({
    clone = number
    vmid = number
    ip = string
    mac = string
    bridge = string
    cores = number
    memory = number
    target_node = string
    hastate = string
    hagroup = string
  }))
  default = {
    "controlplane01.infra.usmnblm01" = {
      clone = 9000
      vmid = 201
      ip = "10.5.216.1"
      mac = "de:ad:dc:05:d8:01"
      cores = 4
      memory = 8192
      target_node = "pve01"
      bridge = "vmbr0"
      hastate = "enabled"
      hagroup = "hagroup"
    }
    "controlplane02.infra.usmnblm01" = {
      clone = 9000
      vmid = 202
      ip = "10.5.216.2"
      mac = "de:ad:dc:05:d8:02"
      cores = 4
      memory = 8192
      target_node = "pve02"
      bridge = "vmbr0"
      hastate = "enabled"
      hagroup = "hagroup"
    }
    "controlplane03.infra.usmnblm01" = {
      clone = 9000
      vmid = 203
      ip = "10.5.216.3"
      mac = "de:ad:dc:05:d8:03"
      cores = 4
      memory = 8192
      target_node = "pve03"
      bridge = "vmbr0"
      hastate = "enabled"
      hagroup = "hagroup"
    }
    "node01.infra.usmnblm01" = {
      clone = 9000
      vmid = 210
      ip = "10.5.216.10"
      mac = "de:ad:dc:05:d8:0a"
      cores = 6
      memory = 16394
      target_node = "pve01"
      bridge = "vmbr0"
      hastate = "enabled"
      hagroup = "hagroup"
    }
    "node02.infra.usmnblm01" = {
      clone = 9000
      vmid = 211
      ip = "10.5.216.11"
      mac = "de:ad:dc:05:d8:0b"
      cores = 6
      memory = 16394
      target_node = "pve02"
      bridge = "vmbr0"
      hastate = "enabled"
      hagroup = "hagroup"
    }
    "node03.infra.usmnblm01" = {
      clone = 9000
      vmid = 212
      ip = "10.5.216.12"
      mac = "de:ad:dc:05:d8:0c"
      cores = 6
      memory = 16394
      target_node = "pve03"
      bridge = "vmbr0"
      hastate = "enabled"
      hagroup = "hagroup"
    }
  }
}