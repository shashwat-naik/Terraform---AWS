
output "critical_topic_arn" {
  description = "ARN of the SNS topic for critical alerts"
  value       = aws_sns_topic.critical.arn
}

output "performance_topic_arn" {
  description = "ARN of the SNS topic for performance alerts"
  value       = aws_sns_topic.performance.arn
}

output "logs_topic_arn" {
  description = "ARN of the SNS topic for log-based alerts"
  value       = aws_sns_topic.logs.arn
}
