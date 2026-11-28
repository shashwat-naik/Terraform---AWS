
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region where CloudTrail will be configured"
  type        = string
}

variable "enable_data_events" {
  description = "Enable CloudTrail monitoring for S3 object-level events"
  type        = bool
  default     = false
}

variable "upload_bucket_arn" {
  description = "ARN of the original image upload bucket"
  type        = string
}

variable "processed_bucket_arn" {
  description = "ARN of the processed image bucket"
  type        = string
}

variable "tags" {
  description = "Common tags applied to CloudTrail resources"
  type        = map(string)
  default     = {}
}
