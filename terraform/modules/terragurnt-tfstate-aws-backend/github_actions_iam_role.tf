data "aws_iam_policy_document" "github_actions_iam_assume_role_policy" {
  statement {
    sid    = "AllowAssumeRoleWithWebIdentity"
    effect = "Allow"
    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github_actions_oidc_provider.arn
      ]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${aws_iam_openid_connect_provider.github_actions_oidc_provider.url}:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "${aws_iam_openid_connect_provider.github_actions_oidc_provider.url}:sub"
      values   = ["repo:${var.github_orgname}/${var.github_repo}:*"]
    }
  }
}

data "aws_iam_policy_document" "github_actions_iam_policy" {
  statement {
    sid    = "AllowS3ObjectAccessForTFStateBucket"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]

    #tfsec:ignore:aws-iam-no-policy-wildcards
    resources = [
      aws_s3_bucket.tf_state_bucket.arn,
      "${aws_s3_bucket.tf_state_bucket.arn}/*",
    ]
  }

  statement {
    sid    = "AllowOIDCProviderManagement"
    effect = "Allow"
    actions = [
      "iam:CreateOpenIDConnectProvider",
      "iam:GetOpenIDConnectProvider",
      "iam:TagOpenIDConnectProvider"
    ]
    resources = [
      aws_iam_openid_connect_provider.github_actions_oidc_provider.arn
    ]
  }

  statement {
    sid    = "AllowKMSKeyManagement"
    effect = "Allow"
    actions = [
      "kms:CreateKey",
      "kms:TagResource"
    ]
    resources = [
      aws_kms_key.tf_state_bucket.arn,
      aws_kms_key.logging_bucket.arn
    ]
  }

  statement {
    sid    = "AllowIAMPolicyManagement"
    effect = "Allow"
    actions = [
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicies",
      "iam:ListPolicyVersions",
      "iam:ListPolicyTags",
      "iam:ListAttachedRolePolicies",
      "iam:TagPolicy",
      "iam:UntagPolicy"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/github-actions-iam-policy",
    ]
  }

  statement {
    sid    = "AllowIAMRoleManagement"
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListRoles",
      "iam:ListRolePolicies",
      "iam:ListRoleTags",
      "iam:ListAttachedRolePolicies",
      "iam:AttachRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:PutRolePolicy",
      "iam:UpdateAssumeRolePolicy"
    ]
    resources = [
      aws_iam_role.github_actions_iam_role.arn
    ]
  }

  statement {
    sid    = "AllowBucketManagement"
    effect = "Allow"
    actions = [
      "s3:CreateBucket",
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketNotification",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetAccelerateConfiguration",
      "s3:GetLifecycleConfiguration",
      "s3:GetReplicationConfiguration",
      "s3:GetEncryptionConfiguration",
      "s3:PutBucketCORS",
      "s3:PutBucketLogging",
      "s3:PutBucketNotification",
      "s3:PutBucketObjectLockConfiguration",
      "s3:PutBucketOwnershipControls",
      "s3:PutBucketPolicy",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketRequestPayment",
      "s3:PutBucketTagging",
      "s3:PutBucketVersioning",
      "s3:PutBucketWebsite",
      "s3:PutAccelerateConfiguration",
      "s3:PutLifecycleConfiguration",
      "s3:PutReplicationConfiguration",
      "s3:PutEncryptionConfiguration"
    ]
    resources = [
      aws_s3_bucket.logging_bucket.arn,
      aws_s3_bucket.tf_state_bucket.arn
    ]
  }
}

resource "aws_iam_policy" "github_actions_iam_policy" {
  name        = "github-actions-iam-policy"
  description = "IAM policy for GitHub Actions"
  policy      = data.aws_iam_policy_document.github_actions_iam_policy.json

  tags = {
    Name    = "GitHub Actions IAM Role"
    Project = "terraform-state-storage"
  }
}

resource "aws_iam_role" "github_actions_iam_role" {
  name               = "GitHubActionsIAMRole"
  assume_role_policy = data.aws_iam_policy_document.github_actions_iam_assume_role_policy.json

  tags = {
    Name    = "GitHub Actions IAM Role"
    Project = "terraform-state-storage"
  }
}

resource "aws_iam_role_policy_attachment" "github_actions_iam_policy_attachment" {
  role       = aws_iam_role.github_actions_iam_role.name
  policy_arn = aws_iam_policy.github_actions_iam_policy.arn
}
