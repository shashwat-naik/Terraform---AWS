
# Generate a unique suffix for the CloudTrail log bucket
resource "random_id" "cloudtrail_suffix" {
  count = var.enable_data_events ? 1 : 0

  byte_length = 4
}

# Dedicated CloudTrail log bucket
resource "aws_s3_bucket" "cloudtrail_logs" {
  count = var.enable_data_events ? 1 : 0

  bucket = "${var.project_name}-${var.environment}-cloudtrail-${random_id.cloudtrail_suffix[0].hex}"

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-cloudtrail-logs"
  })
}

# Block public access to CloudTrail log bucket
resource "aws_s3_bucket_public_access_block" "cloudtrail_logs" {
  count = var.enable_data_events ? 1 : 0

  bucket = aws_s3_bucket.cloudtrail_logs[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable encryption on CloudTrail log bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_logs" {
  count = var.enable_data_events ? 1 : 0

  bucket = aws_s3_bucket.cloudtrail_logs[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Allow CloudTrail to write logs into the bucket
resource "aws_s3_bucket_policy" "cloudtrail_logs" {
  count = var.enable_data_events ? 1 : 0

  bucket = aws_s3_bucket.cloudtrail_logs[0].id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AWSCloudTrailAclCheck"
        Effect = "Allow"

        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }

        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.cloudtrail_logs[0].arn
      },
      {
        Sid    = "AWSCloudTrailWrite"
        Effect = "Allow"

        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }

        Action = "s3:PutObject"

        Resource = "${aws_s3_bucket.cloudtrail_logs[0].arn}/AWSLogs/*"

        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

# CloudTrail trail
resource "aws_cloudtrail" "image_processing" {
  count = var.enable_data_events ? 1 : 0

  name                          = "${var.project_name}-${var.environment}-trail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs[0].id
  include_global_service_events = false
  is_multi_region_trail         = false
  enable_logging                = true

  event_selector {
    read_write_type           = "All"
    include_management_events = false

    data_resource {
      type = "AWS::S3::Object"

      values = [
        "${var.upload_bucket_arn}/",
        "${var.processed_bucket_arn}/"
      ]
    }
  }

  tags = var.tags

  depends_on = [
    aws_s3_bucket_policy.cloudtrail_logs
  ]
}
