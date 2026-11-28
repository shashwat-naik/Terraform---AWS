
# ----------------------------------------
# AWS Configuration
# ----------------------------------------

variable "aws_region" {
  description = "AWS region where infrastructure will be deployed"
  type        = string
  default     = "ap-southeast-2"
}

# ----------------------------------------
# Project Configuration
# ----------------------------------------

variable "project_name" {
  description = "Name of the image processing project"
  type        = string
  default     = "Lambda-Image-Observe"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

# ----------------------------------------
# Lambda Configuration
# ----------------------------------------

variable "lambda_runtime" {
  description = "Python runtime used by Lambda"
  type        = string
  default     = "python3.12"
}

variable "lambda_memory_size" {
  description = "Lambda memory allocation in MB"
  type        = number
  default     = 1024

  validation {
    condition     = var.lambda_memory_size >= 128 && var.lambda_memory_size <= 10240
    error_message = "Lambda memory must be between 128 and 10240 MB."
  }
}

variable "lambda_timeout" {
  description = "Maximum Lambda execution time in seconds"
  type        = number
  default     = 60

  validation {
    condition     = var.lambda_timeout >= 1 && var.lambda_timeout <= 900
    error_message = "Lambda timeout must be between 1 and 900 seconds."
  }
}

# ----------------------------------------
# Image Processing Configuration
# ----------------------------------------

variable "max_image_size_mb" {
  description = "Maximum image size allowed for processing"
  type        = number
  default     = 10
}

variable "max_image_dimension" {
  description = "Maximum width or height allowed during image processing"
  type        = number
  default     = 4096
}

variable "jpeg_quality" {
  description = "Quality level for compressed JPEG output"
  type        = number
  default     = 85
}

variable "low_quality_jpeg_quality" {
  description = "Quality level for low-quality JPEG output"
  type        = number
  default     = 60
}

variable "thumbnail_size" {
  description = "Maximum thumbnail width and height in pixels"
  type        = number
  default     = 300
}

# ----------------------------------------
# S3 Configuration
# ----------------------------------------

variable "enable_s3_versioning" {
  description = "Enable versioning on application S3 buckets"
  type        = bool
  default     = true
}

# ----------------------------------------
# Monitoring Configuration
# ----------------------------------------

variable "log_retention_days" {
  description = "CloudWatch log retention period in days"
  type        = number
  default     = 7
}

variable "alert_email" {
  description = "Email address for SNS notifications"
  type        = string
  default     = ""

  validation {
    condition = (
      var.alert_email == "" ||
      can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.alert_email))
    )
    error_message = "Provide a valid email address or leave it empty."
  }
}

variable "enable_cloudtrail_data_events" {
  description = "Enable CloudTrail monitoring for S3 object-level events"
  type        = bool
  default     = false
}
