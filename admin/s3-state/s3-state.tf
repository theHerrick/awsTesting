terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_s3_bucket" "s3-state" {
  bucket = "theherrickstate"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    app_identifier = var.app_identifier
    Environment    = var.environment
  }
}

resource "aws_s3_bucket_versioning" "s3-state-versioning" {
  bucket = aws_s3_bucket.s3-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "s3-state-dynamodb" {
  name           = "theherrickstate"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
        name = "LockID"
        type = "S"
    }

  tags = {
    app_identifier = var.app_identifier
    Environment    = var.environment
  }
}
