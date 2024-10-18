resource pnap_ssh_key this {
    for_each = var.ssh_keys
    name = each.key
    key = each.value.key
    default = each.value.default
}