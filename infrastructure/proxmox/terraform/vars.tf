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
    "foo1.usmnblm01" = {
      ip = "10.5.12.1"
      mac = "de:ad:dc:00:00:01"
      bridge = "vmbr0"
      cpu = 4
      memory = 8192
      disk = "100G"
      storage = "local-data"
      target_node = "pve01"
    }
  }
}
