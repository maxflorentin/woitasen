variable "bucket" {
  description = "Nombre del bucket S3 para almacenar el estado"
  type        = string
}

variable "key" {
  description = "Ruta en el bucket S3 para el archivo de estado"
  type        = string
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "access_key" {
  description = "Clave de acceso para el backend S3"
  type        = string
}

variable "secret_key" {
  description = "Clave secreta para el backend S3"
  type        = string
}

variable "iam_endpoint" {
  description = "Endpoint de IAM en Localstack"
  type        = string
  default     = "http://localhost:4566"
}

variable "sts_endpoint" {
  description = "Endpoint de STS en Localstack"
  type        = string
  default     = "http://localhost:4566"
}

variable "s3_endpoint" {
  description = "Endpoint de S3 en Localstack"
  type        = string
  default     = "http://s3.localhost.localstack.cloud:4566"
}

variable "dynamodb_table" {
  description = "Nombre de la tabla DynamoDB para el locking del backend"
  type        = string
}

output "bucket" {
  value = var.bucket
}

output "key" {
  value = var.key
}

output "region" {
  value = var.region
}

output "access_key" {
  value = var.access_key
}

output "secret_key" {
  value = var.secret_key
}

output "iam_endpoint" {
  value = var.iam_endpoint
}

output "sts_endpoint" {
  value = var.sts_endpoint
}

output "s3_endpoint" {
  value = var.s3_endpoint
}

output "dynamodb_table" {
  value = var.dynamodb_table
}
