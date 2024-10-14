data "aws_iam_policy_document" "default_kms_key_policy" {
  #checkov:skip=CKV_AWS_109: "This policy document is used as an inline policy for the KMS keys and is not intended to be attached to an IAM user or role."
  #checkov:skip=CKV_AWS_111: "This policy document is used as an inline policy for the KMS keys and is not intended to be attached to an IAM user or role."
  #checkov:skip=CKV_AWS_356: "This policy document is used as an inline policy for the KMS keys and is not intended to be attached to an IAM user or role."
  statement {
    sid    = "DefaultAllowKeyAdministration"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        aws_iam_role.github_actions_iam_role.arn
      ]
    }
    resources = ["*"]
    actions   = ["kms:*"]
  }
}