terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = var.AWS_PROFILE
}

variable "AWS_PROFILE" {
  default = "lahuen-devops"
  type    = string
}
