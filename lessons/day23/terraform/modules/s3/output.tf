
# ----------------------------------------
# Upload Bucket Outputs
# ----------------------------------------

output "upload_bucket_name" {
  description = "Name of the original image upload bucket"
  value       = aws_s3_bucket.upload.id
}

output "upload_bucket_arn" {
  description = "ARN of the original image upload bucket"
  value       = aws_s3_bucket.upload.arn
}

# ----------------------------------------
# Processed Bucket Outputs
# ----------------------------------------

output "processed_bucket_name" {
  description = "Name of the processed image bucket"
  value       = aws_s3_bucket.processed.id
}

output "processed_bucket_arn" {
  description = "ARN of the processed image bucket"
  value       = aws_s3_bucket.processed.arn
}
