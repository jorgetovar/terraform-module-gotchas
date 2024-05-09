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
