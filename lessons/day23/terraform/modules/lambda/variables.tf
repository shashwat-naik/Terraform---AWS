
# ----------------------------------------
# Lambda Function Configuration
# ----------------------------------------

variable "function_name" {
  description = "Name of the image processing Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime environment for Lambda"
  type        = string
  default     = "python3.12"
}

variable "handler" {
  description = "Python function entry point"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "memory_size" {
  description = "Lambda memory allocation in MB"
  type        = number
}

variable "timeout" {
  description = "Maximum Lambda execution time in seconds"
  type        = number
}

# ----------------------------------------
# Deployment Package Configuration
# ----------------------------------------

variable "lambda_zip_path" {
  description = "Path to the packaged Lambda deployment ZIP"
  type        = string
}

variable "layer_zip_path" {
  description = "Path to the Pillow Lambda layer ZIP"
  type        = string
}

# ----------------------------------------
# S3 Permissions Configuration
# ----------------------------------------

variable "upload_bucket_arn" {
  description = "ARN of the original image upload bucket"
  type        = string
}

variable "processed_bucket_arn" {
  description = "ARN of the processed image bucket"
  type        = string
}

# ----------------------------------------
# Image Processing Configuration
# ----------------------------------------

variable "max_image_size_mb" {
  description = "Maximum permitted image size in MB"
  type        = number
}

variable "max_image_dimension" {
  description = "Maximum image width or height in pixels"
  type        = number
}

variable "jpeg_quality" {
  description = "Quality setting for compressed JPEG images"
  type        = number
}

variable "low_quality_jpeg_quality" {
  description = "Quality setting for low-quality JPEG images"
  type        = number
}

variable "thumbnail_size" {
  description = "Maximum thumbnail dimension in pixels"
  type        = number
}

# ----------------------------------------
# Logging Configuration
# ----------------------------------------

variable "log_retention_days" {
  description = "CloudWatch log retention period in days"
  type        = number
  default     = 7
}

# ----------------------------------------
# Resource Tags
# ----------------------------------------

variable "tags" {
  description = "Common tags applied to Lambda resources"
  type        = map(string)
  default     = {}
}
