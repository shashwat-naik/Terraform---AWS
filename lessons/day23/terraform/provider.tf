provider "aws" {
  region = "ap-southeast-2"

  default_tags {
    tags = {
      Project     = "Project-Lambda"
      Environment = "Dev"
      ManagedBy   = "Terraform"
    }
  }
}
