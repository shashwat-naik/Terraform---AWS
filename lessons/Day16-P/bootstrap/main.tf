resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "terraform-state-710507380426"

  tags = {
    Name        = "terraform-statefile"
    Environment = "IAM"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_block" {
  bucket = aws_s3_bucket.terraform_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "bucket_version" {
  bucket = aws_s3_bucket.terraform_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}
