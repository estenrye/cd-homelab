resource "aws_dynamodb_table" "tf_state_locks" {
  name                        = var.tfstate_bucket_dynamodb_table_name
  billing_mode                = var.dynamodb_billing_mode
  read_capacity               = var.dynamodb_billing_mode == "PROVISIONED" ? var.dynamodb_read_capacity : null
  write_capacity              = var.dynamodb_billing_mode == "PROVISIONED" ? var.dynamodb_write_capacity : null
  deletion_protection_enabled = true

  # https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table
  hash_key = "LockID"

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.tf_state_bucket.arn
  }

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = var.tfstate_bucket_dynamodb_table_name
    Project = "terraform-state-storage"
  }
}