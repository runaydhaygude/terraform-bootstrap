# aws provider version #not needed if maintaining the .terraform.lock.hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82.2"
    }
  }
}



#make sure the aws region is enabled for your aws account
provider "aws" {
    region = "ap-south-1"
}

provider "aws" {
    region = "us-east-2"
    alias = "ohio"
}




resource "aws_vpc" "n_mumbai_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "ohio_vpc" {
    cidr_block = "10.1.0.0/16"
    provider = aws.ohio
}



resource "aws_s3_bucket" "first_bucket" {
    bucket = "runay-tf-first-bucket"
}
