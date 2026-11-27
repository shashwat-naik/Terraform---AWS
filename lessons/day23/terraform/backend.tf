terraform {
  backend "s3" {
    bucket       = "terraform-state-710507380426"
    key          = "Observe-Img-processing/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true
  }
}
