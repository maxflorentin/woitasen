variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU usage threshold for CloudWatch alarm"
  type        = number
  default     = 70
}

variable "memory_threshold" {
  description = "Memory usage threshold for CloudWatch alarm"
  type        = number
  default     = 75
}

variable "alarm_actions" {
  description = "ARNs of actions to take (like SNS topic) when alarm is triggered"
  type        = list(string)
  default     = []
}
