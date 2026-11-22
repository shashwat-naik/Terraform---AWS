terraform {
  backend "s3" {
    bucket       = "terraform-state-710507380426"
    key          = "IAM/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true
  }
}
