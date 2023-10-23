terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    onepassword = {
      source = "1Password/onepassword"
      version = "~> 1.2.0"
    }
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
    }
    unifi = {
      source = "paultyng/unifi"
      version = "0.41.0"
    }
  }
}

provider "onepassword" {
  url = "http://op-connect-api.127-0-0-1.a.rye.ninja:8080"
}

data "onepassword_item" "unifi_credentials" {
  vault = "Home_Lab"
  uuid = "unifi-tf-admin.usmnblm01.rye.ninja"
}

data "onepassword_item" "cloudflare_api_token" {
  vault = "Home_Lab"
  uuid = "cloudflare_api_token"
}

data "onepassword_item" "proxmox_credentials" {
  vault = "Home_Lab"
  uuid = "proxmox-tf-admin.usmnblm01.rye.ninja"
}

provider "cloudflare" {
  api_token = data.onepassword_item.cloudflare_api_token.password
}

provider "proxmox" {
  pm_api_url = data.onepassword_item.proxmox_credentials.url
  pm_user = data.onepassword_item.proxmox_credentials.username
  pm_password = data.onepassword_item.proxmox_credentials.password
}

provider "unifi" {
  username = data.onepassword_item.unifi_credentials.username
  password = data.onepassword_item.unifi_credentials.password
  api_url = data.onepassword_item.unifi_credentials.url
  allow_insecure = true
}

data "unifi_network" "lab_network" {
  name = "${var.unifi_network}"
}

data "cloudflare_zone" "zone" {
  name = "${var.cloudflare_zone}"
}

# register a host with unifi
resource "unifi_user" "qemu_server_pxe_static_ip" {
  for_each = var.hosts_qemu_pxe

  name = join(".", [each.key, var.cloudflare_zone])
  mac = each.value.mac
  network_id = "${data.unifi_network.lab_network.id}"
  fixed_ip = each.value.ip
  local_dns_record = join(".", [each.key, var.cloudflare_zone])
}

# create a cloudflare a record using the cloudflare terraform provider
resource "cloudflare_record" "qemu_server_pxe_a_record" {
  for_each = var.hosts_qemu_pxe

  zone_id = "${data.cloudflare_zone.zone.id}"
  name    = each.key
  value   = each.value.ip
  type    = "A"
  ttl     = 300
  proxied = false
}

resource "proxmox_vm_qemu" "qemu_server_pxe" {
    for_each = var.hosts_qemu_pxe

    name                      = join(".", [each.key, var.cloudflare_zone])
    agent                     = 1
    boot                      = "order=virtio0;net0"
    pxe                       = true
    target_node               = each.value.target_node
    scsihw                   = "virtio-scsi-single"
    memory                    = each.value.memory
    cores                     = each.value.cpu

    network {
        bridge    = each.value.bridge
        firewall  = false
        link_down = false
        model     = "virtio"
        macaddr   = each.value.mac
    }
    disk {
        size = each.value.disk
        storage = each.value.storage
        type = "virtio"
    }
}

# register a host with unifi
resource "unifi_user" "qemu_server_clone_static_ip" {
  for_each = var.hosts_qemu_clone

  name = join(".", [each.key, var.cloudflare_zone])
  mac = each.value.mac
  network_id = "${data.unifi_network.lab_network.id}"
  fixed_ip = each.value.ip
  local_dns_record = join(".", [each.key, var.cloudflare_zone])
}

# create a cloudflare a record using the cloudflare terraform provider
resource "cloudflare_record" "qemu_server_clone_a_record" {
  for_each = var.hosts_qemu_clone

  zone_id = "${data.cloudflare_zone.zone.id}"
  name    = each.key
  value   = each.value.ip
  type    = "A"
  ttl     = 300
  proxied = false
}

resource "proxmox_vm_qemu" "qemu_server_clone" {
    for_each = var.hosts_qemu_clone

    vmid                      = each.value.vmid
    name                      = join(".", [each.key, var.cloudflare_zone])
    agent                     = 1
    clone                     = each.value.clone
    target_node               = each.value.target_node
    memory                    = each.value.memory
    cores                     = each.value.cpu
    boot = "scsi0"
    full_clone = false
    network {
        bridge    = each.value.bridge
        firewall  = false
        link_down = false
        model     = "virtio"
        macaddr   = each.value.mac
    }
    disk {
        size = each.value.disk
        storage = each.value.storage
        type = "scsi"
    }
}