
# ----------------------------------------
# Upload Bucket
# ----------------------------------------

resource "aws_s3_bucket" "upload" {
  bucket = var.upload_bucket_name

  tags = merge(var.tags, {
    Name = var.upload_bucket_name
    Role = "Original-Image-Upload"
  })
}

# ----------------------------------------
# Processed Bucket
# ----------------------------------------

resource "aws_s3_bucket" "processed" {
  bucket = var.processed_bucket_name

  tags = merge(var.tags, {
    Name = var.processed_bucket_name
    Role = "Processed-Image-Storage"
  })
}

# ----------------------------------------
# Upload Bucket Versioning
# ----------------------------------------

resource "aws_s3_bucket_versioning" "upload" {
  bucket = aws_s3_bucket.upload.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

# ----------------------------------------
# Processed Bucket Versioning
# ----------------------------------------

resource "aws_s3_bucket_versioning" "processed" {
  bucket = aws_s3_bucket.processed.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

# ----------------------------------------
# Server-Side Encryption
# ----------------------------------------

resource "aws_s3_bucket_server_side_encryption_configuration" "upload" {
  bucket = aws_s3_bucket.upload.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "processed" {
  bucket = aws_s3_bucket.processed.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# ----------------------------------------
# Block Public Access
# ----------------------------------------

resource "aws_s3_bucket_public_access_block" "upload" {
  bucket = aws_s3_bucket.upload.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "processed" {
  bucket = aws_s3_bucket.processed.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
