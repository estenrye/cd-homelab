# Create a server
resource "pnap_server" "foo" {
    depends_on = [
        pnap_private_network.default,
        pnap_storage_network.this,
        pnap_ip_block.this,
        pnap_private_network.this,
        pnap_public_network.this,
        pnap_ssh_key.this
    ]

    hostname = "test.rye.ninja"
    os = "ubuntu/jammy"
    type = "s2.c1.small"
    location = var.location
    install_default_ssh_keys = true
    network_type = "PUBLIC_AND_PRIVATE"
    pricing_model = "HOURLY"

    storage_configuration {
        root_partition {
            raid = "NO_RAID"
            size = 200
        }
    }

    network_configuration {
      ip_blocks_configuration {
        configuration_type = "NONE"
      }

      private_network_configuration {
        configuration_type = "USER_DEFINED"
        private_networks {
           server_private_network {
             id = pnap_private_network.this["private"].id
             ips = ["10.20.3.15"]
             dhcp = false
           }
        }
        # private_networks {
        #   server_private_network {
        #     id = pnap_storage_network.this[0].id
        #     ips = []
        #     dhcp = true
        #   }
        # }
      }

    public_network_configuration {
      public_networks {
        server_public_network {
          id = pnap_public_network.this["public"].id
          ips = [local.public_ip_addresses[3]]
        }
      }
    }
  }
}