
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider for the primary region (us-east-1)
provider "aws" {
  region = var.primary_region
  alias  = "primary"

  endpoints {
    ec2 = "http://localhost.floci.io:4566"
    sts = "http://localhost.floci.io:4566"
  }

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_region_validation      = true
}

# Provider for the secondary region (us-west-2)
provider "aws" {
  region = var.secondary_region
  alias  = "secondary"

  endpoints {
    ec2 = "http://localhost.floci.io:4566"
    sts = "http://localhost.floci.io:4566"
  }

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_region_validation      = true
}
