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

output "bucket_name" {
  value = aws_s3_bucket.aws_community_builder_bucket.bucket
}