
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the image processing Lambda function"
  type        = string
}

variable "lambda_log_group_name" {
  description = "CloudWatch log group containing Lambda execution logs"
  type        = string
}

variable "critical_topic_arn" {
  description = "SNS topic ARN for critical alerts"
  type        = string
}

variable "performance_topic_arn" {
  description = "SNS topic ARN for performance alerts"
  type        = string
}

variable "logs_topic_arn" {
  description = "SNS topic ARN for log-based alerts"
  type        = string
}

variable "tags" {
  description = "Common tags applied to CloudWatch resources"
  type        = map(string)
  default     = {}
}
