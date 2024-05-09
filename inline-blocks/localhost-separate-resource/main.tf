terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

  }

  required_version = ">= 1.0.0, < 2.0.0"

}

provider "aws" {
  region = "us-west-2"
}

module "s3_bucket" {
  source = "../modules/separate-resource"
  name   = "jorgetovar"
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = module.s3_bucket.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = module.s3_bucket.bucket_name
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
