resource "pnap_storage_network" "this" {
    depends_on = [ pnap_tag.this ]
    count = var.storage_network_enabled ? 1 : 0

    name = "storage-network-${var.location}"
    description = var.storage_network.description
    location = var.location
    client_vlan = var.storage_network.vlan_id

    volumes {
        volume {
            name = "storage-volume-${var.location}"
            path_suffix = var.storage_network.path_suffix
            capacity_in_gb = var.storage_network.capacity_in_gb

            dynamic "tags" {
              for_each = var.storage_network.tags
              content {
                tag_assignment {
                    name = tags.key
                    value = tags.value
                }
              }
            }
        }
      }
}