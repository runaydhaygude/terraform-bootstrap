resource "aws_s3_bucket" "second_bucket" {
    bucket = "${terraform.workspace}-runay-tf-second-bucket"
}