

terraform {
    backend "s3" {
        bucket = "runay-terraform-state"
        key = "myproject.state"
        region = "ap-south-1"
    }
}
