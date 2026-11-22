output "bucket_name" {
  description = "Name of the S3 bucket for the state management"
  value       = aws_s3_bucket.terraform_bucket.id
}

output "bucket_arn" {
  description = "AWS Resource Name"
  value       = aws_s3_bucket.terraform_bucket.arn
}
