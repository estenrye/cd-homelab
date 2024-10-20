resource pnap_private_network this {
    depends_on = [ pnap_private_network.default ]
    for_each = var.private_networks

    name = each.key
    description = each.value.description
    location = var.location
    cidr = each.value.cidr
    vlan_id = each.value.vlan_id
    location_default = false
}