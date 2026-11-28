
# ----------------------------------------
# SNS Configuration
# ----------------------------------------

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

# ----------------------------------------
# Email Notification Configuration
# ----------------------------------------

variable "alert_email" {
  description = "Email address receiving SNS notifications"
  type        = string
  default     = ""
}

# ----------------------------------------
# Resource Tags
# ----------------------------------------

variable "tags" {
  description = "Common tags applied to SNS resources"
  type        = map(string)
  default     = {}
}
