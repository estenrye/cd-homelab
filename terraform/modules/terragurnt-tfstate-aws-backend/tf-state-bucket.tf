resource "aws_kms_key" "tf_state_bucket" {
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.default_kms_key_policy.json

  tags = {
    Name    = "${var.github_orgname}-${var.github_repo}-tfstate"
    Project = "terraform-state-storage"
  }
}

resource "aws_s3_bucket" "tf_state_bucket" {
  #checkov:skip=CKV2_AWS_62:Event notification is not required for this bucket
  #checkov:skip=CKV_AWS_144:Cross region replication is not required for this bucket
  bucket = var.tfstate_bucket_name

  tags = {
    Name    = var.tfstate_bucket_name
    Project = "terraform-state-storage"
  }
}

resource "aws_s3_bucket_versioning" "tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  target_bucket = aws_s3_bucket.logging_bucket.id
  target_prefix = "${resource.aws_s3_bucket.tf_state_bucket.id}/"
}

resource "aws_s3_bucket_public_access_block" "tf_state_bucket_public_access_block" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_bucket_sse" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket

  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tf_state_bucket.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_state_bucket" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.tf_state_bucket]

  bucket = aws_s3_bucket.tf_state_bucket.id

  rule {
    id = "versioning-rule"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    status = "Enabled"
  }
}