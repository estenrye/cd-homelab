variable "cloudspace_name" {
    description = "Name of the Rackspace Spot Cloudspace"
    type        = string
    default     = "example"
}

variable "region" {
    description = "Region of the Rackspace Spot Cloudspace"
    type        = string
    default     = "us-central-dfw-1"
}

variable "server_class" {
    description = "Server class of the Rackspace Spot Node Pool"
    type        = string
    default     = "mh.vs1.2xlarge-dfw"
}

variable "bid_price" {
    description = "Bid price of the Rackspace Spot Node Pool"
    type        = number
    default     = 0.03
}

variable "min_nodes" {
    description = "Minimum number of nodes in the Rackspace Spot Node Pool"
    type        = number
    default     = 2
}

variable "max_nodes" {
    description = "Maximum number of nodes in the Rackspace Spot Node Pool"
    type        = number
    default     = 4
}

variable "hacontrol_plane" {
    description = "High availability control plane"
    type        = bool
    default     = false
}

