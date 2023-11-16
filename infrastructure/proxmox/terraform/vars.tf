variable "unifi_network" {
  type = string
  default = "home-lab"
}

variable "cloudflare_zone" {
  type = string
  default = "rye.ninja"
}

variable "hosts_qemu_pxe" {
  type = map(object({
    ip = string
    mac = string
    cpu = number
    memory = number
    disk = string
    storage = string
    target_node = string
    bridge = string
  }))
  default = {
    # "foo1.usmnblm01" = {
    #   ip = "10.5.12.1"
    #   mac = "de:ad:dc:00:00:01"
    #   bridge = "vmbr0"
    #   cpu = 4
    #   memory = 8192
    #   disk = "100G"
    #   storage = "local-data"
    #   target_node = "pve01"
    # }
  }
}

variable "hosts" {
  type = map(object({
    vmid = number
    ip = string
    mac = string
    cores = number
    memory = number
  }))
  default = {
    "controlplane01.infra.usmnblm01" = {
      vmid = 201
      ip = "10.5.216.1"
      mac = "de:ad:dc:05:d8:01"
      cores = 4
      memory = 8192
    }
    "controlplane02.infra.usmnblm01" = {
      vmid = 202
      ip = "10.5.216.2"
      mac = "de:ad:dc:05:d8:02"
      cores = 4
      memory = 8192
    }
    "controlplane03.infra.usmnblm01" = {
      vmid = 203
      ip = "10.5.216.3"
      mac = "de:ad:dc:05:d8:03"
      cores = 4
      memory = 8192
    }
    "node01.infra.usmnblm01" = {
      vmid = 210
      ip = "10.5.216.10"
      mac = "de:ad:dc:05:d8:0a"
      cores = 6
      memory = 16394
    }
    "node02.infra.usmnblm01" = {
      vmid = 211
      ip = "10.5.216.11"
      mac = "de:ad:dc:05:d8:0b"
      cores = 6
      memory = 16394
    }
    "node03.infra.usmnblm01" = {
      vmid = 212
      ip = "10.5.216.12"
      mac = "de:ad:dc:05:d8:0c"
      cores = 6
      memory = 16394
    }
  }
}