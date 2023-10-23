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

variable "hosts_qemu_clone" {
  type = map(object({
    vmid = number
    ip = string
    mac = string
    cpu = number
    memory = number
    disk = string
    storage = string
    target_node = string
    bridge = string
    clone = string
  }))
  default = {
    "controlplane01.infra.usmnblm01" = {
      vmid = 101
      ip = "10.5.216.1"
      mac = "de:ad:dc:05:d8:01"
      bridge = "vmbr0"
      cpu = 4
      memory = 8192
      disk = "40G"
      storage = "local-data"
      target_node = "pve01"
      clone = "ubuntu-cloud-image-jammy-current"
    }
    "controlplane02.infra.usmnblm01" = {
      vmid = 102
      ip = "10.5.216.2"
      mac = "de:ad:dc:05:d8:02"
      bridge = "vmbr0"
      cpu = 4
      memory = 8192
      disk = "40G"
      storage = "local-data"
      target_node = "pve01"
      clone = "ubuntu-cloud-image-jammy-current"
    }
    # "controlplane03.infra.usmnblm01" = {
    #   vmid = 103
    #   ip = "10.5.216.3"
    #   mac = "de:ad:dc:05:d8:03"
    #   bridge = "vmbr0"
    #   cpu = 4
    #   memory = 8192
    #   disk = "40G"
    #   storage = "local-data"
    #   target_node = "pve01"
    #   clone = "ubuntu-cloud-image-jammy-current"
    # }
    # "worker01.infra.usmnblm01" = {
    #   vmid = 104
    #   ip = "10.5.216.10"
    #   mac = "de:ad:dc:05:d8:0a"
    #   bridge = "vmbr0"
    #   cpu = 4
    #   memory = 16394
    #   disk = "40G"
    #   storage = "local-data"
    #   target_node = "pve01"
    #   clone = "ubuntu-cloud-image-jammy-current"
    # }
    # "worker02.infra.usmnblm01" = {
    #   vmid = 105
    #   ip = "10.5.216.11"
    #   mac = "de:ad:dc:05:d8:0b"
    #   bridge = "vmbr0"
    #   cpu = 4
    #   memory = 16394
    #   disk = "40G"
    #   storage = "local-data"
    #   target_node = "pve01"
    #   clone = "ubuntu-cloud-image-jammy-current"
    # }
    # "worker03.infra.usmnblm01" = {
    #   vmid = 106
    #   ip = "10.5.216.12"
    #   mac = "de:ad:dc:05:d8:0c"
    #   bridge = "vmbr0"
    #   cpu = 4
    #   memory = 16394
    #   disk = "40G"
    #   storage = "local-data"
    #   target_node = "pve01"
    #   clone = "ubuntu-cloud-image-jammy-current"
    # }
  }
}