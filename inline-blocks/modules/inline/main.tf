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

resource "random_string" "id" {
  length  = 8
  special = false
}

variable "name" {
  type        = string
  description = "The name of the bucket"
}


resource "aws_s3_bucket" "aws_community_builder_bucket" {
  bucket = "aws-community-builder-inline-block-${var.name}-${lower(random_string.id.result)}"

  lifecycle_rule {
    enabled = true
    id      = random_string.id.result

    expiration {
      days = 90
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  versioning {
    enabled = true
  }
}
