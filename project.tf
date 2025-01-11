# aws provider version #not needed if maintaining the .terraform.lock.hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82"
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




resource "aws_vpc" "mumbai_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "runay"
    }
}

resource "aws_vpc" "ohio_vpc" {
    cidr_block = "10.1.0.0/16"
    provider = aws.ohio
}



resource "aws_s3_bucket" "first_bucket" {
    bucket = "runay-tf-first-bucket"
}

locals {
   bucket_info =  "my bucket name: ${aws_s3_bucket.first_bucket.id}, bucket arn: ${aws_s3_bucket.first_bucket.arn}"
}

output "bucket_information" {
    value = local.bucket_info
}

output "all" {
    value = aws_s3_bucket.first_bucket
}


data "aws_s3_bucket" "existing-bucket-outside-this-terraform-project" {
    bucket = "devops23-1734970024"
}

resource "aws_iam_policy" "my_bucket_policy" {
    name = "my-bucket-policy"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Resource": [
                "${aws_s3_bucket.first_bucket.arn}",
                "${data.aws_s3_bucket.existing-bucket-outside-this-terraform-project.arn}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "my_bucket_policy_2" {
    name = "list-buckets-policy"
    policy = file("./policy.iam")
}


output "rendered_template" {
    value = templatefile("./backends.tpl", { name = "Runay", port = 8080, ip_addrs = ["10.0.0.1", "10.0.0.2"] })
}




variable "bucket_name" {
    description = "the name of the bucket you wish to create"
}

variable "bucket_suffix" {
    default = "-abcd"
}

output "variable_name" {
  value = "${var.bucket_name}${var.bucket_suffix}"
}






module "work_queue" {
    source = "./sqs-with-backoff"
    queue_name = "work-queue"
}

output "work_queue_name" {
    value = module.work_queue.queue_name
}

output "work_queue_dead_letter_name" {
    value = module.work_queue.dead_letter_queue_name
}

output "work_queue_all" {
  value = module.work_queue
}

output "work_queue_dead_letter_queue_all" {
  value = module.work_queue
}


module "thread_queue" {
    source = "./sqs-with-backoff"
    queue_name = "thread-queue"
}

output "thread_queue_name" {
    value = module.thread_queue.queue_name
}

output "thread_queue_dead_letter_name" {
    value = module.thread_queue.dead_letter_queue_name
}