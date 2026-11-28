
# ----------------------------------------
# Lambda Execution Role
# ----------------------------------------

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.function_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

# ----------------------------------------
# Lambda CloudWatch Logging Policy
# ----------------------------------------

resource "aws_iam_role_policy" "lambda_logging" {
  name = "${var.function_name}-logging-policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      }
    ]
  })
}

# ----------------------------------------
# Lambda S3 Access Policy
# ----------------------------------------

resource "aws_iam_role_policy" "lambda_s3_access" {
  name = "${var.function_name}-s3-policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]

        Resource = "${var.upload_bucket_arn}/*"
      },
      {
        Effect = "Allow"

        Action = [
          "s3:PutObject"
        ]

        Resource = "${var.processed_bucket_arn}/*"
      }
    ]
  })
}

# ----------------------------------------
# Pillow Lambda Layer
# ----------------------------------------

resource "aws_lambda_layer_version" "pillow_layer" {
  filename            = var.layer_zip_path
  layer_name          = "${var.function_name}-pillow-layer"
  compatible_runtimes = [var.runtime]

  source_code_hash = filebase64sha256(var.layer_zip_path)
}

# ----------------------------------------
# Lambda CloudWatch Log Group
# ----------------------------------------

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

# ----------------------------------------
# Lambda Function
# ----------------------------------------

resource "aws_lambda_function" "image_processor" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_execution_role.arn

  runtime = var.runtime
  handler = var.handler

  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  memory_size = var.memory_size
  timeout     = var.timeout

  layers = [
    aws_lambda_layer_version.pillow_layer.arn
  ]

  environment {
    variables = {
      UPLOAD_BUCKET_NAME    = split(":", var.upload_bucket_arn)[5]
      PROCESSED_BUCKET_NAME = split(":", var.processed_bucket_arn)[5]

      MAX_IMAGE_SIZE_MB   = tostring(var.max_image_size_mb)
      MAX_IMAGE_DIMENSION = tostring(var.max_image_dimension)

      JPEG_QUALITY             = tostring(var.jpeg_quality)
      LOW_QUALITY_JPEG_QUALITY = tostring(var.low_quality_jpeg_quality)
      THUMBNAIL_SIZE           = tostring(var.thumbnail_size)
    }
  }

  depends_on = [
    aws_iam_role_policy.lambda_logging,
    aws_iam_role_policy.lambda_s3_access,
    aws_cloudwatch_log_group.lambda_logs
  ]

  tags = var.tags
}
