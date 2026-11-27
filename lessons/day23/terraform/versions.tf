terraform {
#  Min terraform CLI version require
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    # For the lambda code ZIP file
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
    # Allocating random unique S3 bucket name
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

