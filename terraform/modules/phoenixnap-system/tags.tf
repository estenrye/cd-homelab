resource pnap_tag this {
    for_each = var.tags
    name = each.key
    is_billing_tag = each.value.is_billing_tag
    description = each.value.description
}