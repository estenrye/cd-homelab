resource "github_actions_variable" "github_actions_iam_role_arn" {
  repository    = var.github_repo
  variable_name = "IAM_ROLE_ARN"
  value         = aws_iam_role.github_actions_iam_role.arn
}

resource "github_actions_variable" "github_actions_aws_region" {
  repository    = var.github_repo
  variable_name = "AWS_REGION"
  value         = data.aws_region.current.name
}

resource "github_actions_variable" "github_actions_bucket_name" {
  repository    = var.github_repo
  variable_name = "TF_VAR_BUCKET_NAME"
  value         = resource.aws_s3_bucket.tf_state_bucket.id
}

resource "github_actions_secret" "github_actions_op_service_account_token" {
  repository      = var.github_repo
  secret_name     = "OP_SERVICE_ACCOUNT_TOKEN"
  plaintext_value = data.onepassword_item.op_svc_account.credential
}