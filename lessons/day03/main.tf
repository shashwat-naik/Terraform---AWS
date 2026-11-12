terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  # Configuration options
    region = "ap-southeast-2"
}

# Create a S3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "710507380426-terraform-1st-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

