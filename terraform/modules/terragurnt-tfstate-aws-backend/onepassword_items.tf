data "onepassword_item" "gh_pat" {
  vault = var.onepassword_vault
  title = var.onepassword_item_gh_pat
}

data "onepassword_item" "op_svc_account" {
  vault = var.onepassword_vault
  title = var.onepassword_item_op_svc_account
}