
output "dashboard_name" {
  description = "Name of the CloudWatch monitoring dashboard"
  value       = aws_cloudwatch_dashboard.image_processing.dashboard_name
}

output "processing_errors_alarm_arn" {
  description = "ARN of the image processing errors alarm"
  value       = aws_cloudwatch_metric_alarm.processing_errors.arn
}

output "large_images_alarm_arn" {
  description = "ARN of the large image detection alarm"
  value       = aws_cloudwatch_metric_alarm.large_images.arn
}
