resource pnap_private_network default {
    name = "default-${var.location}"
    description = "Default Network"
    location = var.location
    location_default = true
    vlan_id = 2
    cidr = var.default_cidr
}