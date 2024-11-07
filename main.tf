provider "aws" {
  region     = "eu-west-1"
  access_key = "test"
  secret_key = "test"
  endpoints {
    s3  = "http://s3.localhost.localstack.cloud:4566"
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
}

terraform {
  backend "s3" {
    bucket                      = "challenge"
    key                         = "localstack"
    region                      = "eu-west-1"
    dynamodb_table              = "terraform-lock-table"
    skip_metadata_api_check     = true
    skip_credentials_validation = true
    iam_endpoint                = "http://localhost:4566"
    sts_endpoint                = "http://localhost:4566"
    endpoint                    = "http://s3.localhost.localstack.cloud:4566"
    access_key                  = "test"
    secret_key                  = "test"
  }
}

module "backend_s3" {
  source         = "./modules/backend_s3"
  bucket         = "challenge"
  key            = "localstack"
  region         = "eu-west-1"
  dynamodb_table = "terraform-lock-table"
  access_key     = "test"
  secret_key     = "test"
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = "10.0.0.0/16"
  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"
  az_1                 = "eu-west-1a"
  az_2                 = "eu-west-1b"
}

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.vpc.security_group_id]
  subnets            = module.vpc.subnet_ids
}
