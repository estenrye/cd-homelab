resource pnap_public_network "this" {
  for_each = var.public_networks

  name = each.key
  description = each.value.description
  location = var.location
  vlan_id = each.value.vlan_id

  dynamic "ip_blocks" {
    for_each = each.value.ip_blocks
    content {
        public_network_ip_block {
            id = pnap_ip_block.this["${each.key}_${ip_blocks.key}_${var.location}"].id
        }
    }
  }
}