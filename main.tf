# aws provider version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "first_bucket" {
    bucket = "runay-tf-first-bucket"
}
