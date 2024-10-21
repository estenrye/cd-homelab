locals {
 ip_blocks = flatten([
    for network_key, network in var.public_networks : [
        for ip_block_key, ip_block in network.ip_blocks : {
            key = "${network_key}_${ip_block_key}_${var.location}"
            ip_block = {
                network_key = network_key
                ip_block_key = ip_block_key
                cidr_block_size = ip_block
                location = var.location
                description = network.description
                tags = network.tags
            }
        }
    ]
 ])

 ip_blocks_map = {
    for ip_block in local.ip_blocks : ip_block.key => ip_block
 }
}

resource pnap_ip_block "this" {
    depends_on = [ pnap_private_network.default ]
    for_each = local.ip_blocks_map
    
    description = each.key
    location = each.value.ip_block.location
    cidr_block_size = each.value.ip_block.cidr_block_size

    dynamic "tags" {
        for_each = each.value.ip_block.tags
        content {
            tag_assignment {
                name = tags.key
                value = tags.value
            }
        }
    }
}

module "cidr_expand" {
  source = "git::https://github.com/binxio/terraform-cidr-expand.git?ref=1.1.0"
  for_each = resource.pnap_ip_block.this

  cidr = each.value.cidr
}

locals {
    public_ip_addresses = flatten([for ip_block in module.cidr_expand : ip_block.ip_addresses])
}
output "public_ip_addresses" {
    value = local.public_ip_addresses
}