
# ----------------------------------------
# S3 Outputs
# ----------------------------------------

output "upload_bucket_name" {
  description = "Name of the S3 bucket used for original image uploads"
  value       = module.s3.upload_bucket_name
}

output "processed_bucket_name" {
  description = "Name of the S3 bucket used for processed images"
  value       = module.s3.processed_bucket_name
}

# ----------------------------------------
# Lambda Outputs
# ----------------------------------------

output "lambda_function_name" {
  description = "Name of the image processing Lambda function"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the image processing Lambda function"
  value       = module.lambda.lambda_function_arn
}

# ----------------------------------------
# SNS Outputs
# ----------------------------------------

output "critical_alert_topic_arn" {
  description = "SNS topic ARN for critical alerts"
  value       = module.sns.critical_topic_arn
}

# ----------------------------------------
# CloudWatch Outputs
# ----------------------------------------

output "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch monitoring dashboard"
  value       = module.cloudwatch.dashboard_name
}

# ----------------------------------------
# CloudTrail Outputs
# ----------------------------------------

output "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  value       = module.cloudtrail.trail_name
}
