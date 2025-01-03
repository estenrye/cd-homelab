data "tls_certificate" "github_actions_cert" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github_actions_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.github_actions_cert.certificates[0].sha1_fingerprint
  ]

  tags = {
    Name    = "GitHub Actions OIDC Provider"
    Project = "terraform-state-storage"
  }
}