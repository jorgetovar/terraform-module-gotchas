resource "random_string" "id" {
  length  = 8
  special = false
}

variable "name" {
  type        = string
  description = "The name of the bucket"
}

resource "aws_s3_bucket" "aws_community_builder_bucket" {
  bucket = "aws-community-builder-separate-resource-${var.name}-${lower(random_string.id.result)}"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.aws_community_builder_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket  = aws_s3_bucket.aws_community_builder_bucket.id
  rule {
    id = "log"

    expiration {
      days = 90
    }

    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}