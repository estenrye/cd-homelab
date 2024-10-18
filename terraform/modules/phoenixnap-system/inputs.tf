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