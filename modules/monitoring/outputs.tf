output "cpu_alarm_arn" {
  description = "ARN of the CPU CloudWatch Alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "memory_alarm_arn" {
  description = "ARN of the Memory CloudWatch Alarm"
  value       = aws_cloudwatch_metric_alarm.memory_high.arn
}
