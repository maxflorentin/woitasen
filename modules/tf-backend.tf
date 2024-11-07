terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket                      = "challenge"
    key                         = "localstack"
    region                      = "eu-west-1"
    use_path_style              = true
    skip_metadata_api_check     = true
    skip_credentials_validation = true
    iam_endpoint                = "http://localhost:4566"
    sts_endpoint                = "http://localhost:4566"
    endpoints = {
      s3 = "http://s3.localhost.localstack.cloud:4566"
    }
    access_key = "test"
    secret_key = "test"
  }
}
