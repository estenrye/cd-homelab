import {
  to = aws_s3_bucket.tf_state_bucket
  id = var.tfstate_bucket_name
}

import {
  to = aws_s3_bucket.logging_bucket
  id = var.tfstate_bucket_accesslogging_bucket_name
}

import {
  to = aws_dynamodb_table.tf_state_locks
  id = var.tfstate_bucket_dynamodb_table_name
}