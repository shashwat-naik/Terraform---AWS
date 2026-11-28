
# ----------------------------------------
# S3 Bucket Configuration
# ----------------------------------------

variable "upload_bucket_name" {
  description = "Globally unique name of the original image upload bucket"
  type        = string
}

variable "processed_bucket_name" {
  description = "Globally unique name of the processed image bucket"
  type        = string
}

# ----------------------------------------
# Versioning Configuration
# ----------------------------------------

variable "enable_versioning" {
  description = "Enable versioning on application S3 buckets"
  type        = bool
  default     = true
}

# ----------------------------------------
# Resource Tags
# ----------------------------------------

variable "tags" {
  description = "Common tags applied to S3 resources"
  type        = map(string)
  default     = {}
} 