variable location {
    type = string
    description = "This is the location of the resource."
}

variable default_cidr {
    type = string
    description = "This is the default CIDR for the network."
}

variable tags {
    type = map(object({
        is_billing_tag = bool
        description = string
    }))
    default = {}
    description = "This is a map of tag objects to create.  These tags must exist prior to use on other objects."
}

variable "ssh_keys" {
    type = map(object({
        key = string
        default = bool
    }))
    default = {}
    description = "This is a map of ssh keys to create."
}

variable storage_network_enabled {
    type = bool
    default = false
    description = "This is a flag to enable the storage network."
}

variable "storage_network" {
    type = object({
        description = string
        location = string
        vlan_id = number
        path_suffix = string
        capacity_in_gb = number
        tags = map(string)
    })
    default = {
        description = ""
        location = ""
        vlan_id = 0
        path_suffix = ""
        capacity_in_gb = 0
        tags = {}
    }
    description = "This is a map of storage network configuration to create."
}

variable public_networks {
    type = map(object({
        description = string
        vlan_id = number
        ip_blocks = map(string)
        tags = map(string)
    }))
    default = {}
    description = "This is a map of public network configuration to create."
}

variable private_networks {
    type = map(object({
        description = string
        cidr = string
        vlan_id = number
    }))
    default = {}
    description = "This is a map of private network configuration to create."
}
