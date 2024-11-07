variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "az_1" {
  description = "Availability Zone 1"
  type        = string
  default     = "eu-west-1a"
}

variable "az_2" {
  description = "Availability Zone 2"
  type        = string
  default     = "eu-west-1b"
}
