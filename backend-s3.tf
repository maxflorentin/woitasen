terraform {
  backend "s3" {
    bucket         = "woitasem-tf-state-bucket"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
