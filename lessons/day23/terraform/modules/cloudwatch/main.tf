
# Metric filter: Lambda processing errors
resource "aws_cloudwatch_log_metric_filter" "processing_errors" {
  name           = "${var.project_name}-${var.environment}-processing-errors"
  log_group_name = var.lambda_log_group_name

  pattern = "\"ERROR\""

  metric_transformation {
    name      = "ImageProcessingErrors"
    namespace = "${var.project_name}/${var.environment}"
    value     = "1"
  }
}

# Metric filter: Oversized image warnings
resource "aws_cloudwatch_log_metric_filter" "large_images" {
  name           = "${var.project_name}-${var.environment}-large-images"
  log_group_name = var.lambda_log_group_name

  pattern = "\"LARGE_IMAGE\""

  metric_transformation {
    name      = "LargeImagesDetected"
    namespace = "${var.project_name}/${var.environment}"
    value     = "1"
  }
}

# Critical alarm: Image processing errors
resource "aws_cloudwatch_metric_alarm" "processing_errors" {
  alarm_name        = "${var.project_name}-${var.environment}-processing-errors"
  alarm_description = "Triggers when image processing errors are detected."

  namespace   = "${var.project_name}/${var.environment}"
  metric_name = "ImageProcessingErrors"

  statistic           = "Sum"
  period              = 60
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [
    var.critical_topic_arn
  ]

  tags = var.tags
}

# Performance alarm: Large image uploads
resource "aws_cloudwatch_metric_alarm" "large_images" {
  alarm_name        = "${var.project_name}-${var.environment}-large-images"
  alarm_description = "Triggers when five or more large images are detected within five minutes."

  namespace   = "${var.project_name}/${var.environment}"
  metric_name = "LargeImagesDetected"

  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 5
  comparison_operator = "GreaterThanOrEqualToThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [
    var.performance_topic_arn
  ]

  tags = var.tags
}


# CloudWatch monitoring dashboard
resource "aws_cloudwatch_dashboard" "image_processing" {
  dashboard_name = "${var.project_name}-${var.environment}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "Lambda Invocations and Errors"
          region = "ap-southeast-2"
          period = 300

          metrics = [
            ["AWS/Lambda", "Invocations", "FunctionName", var.lambda_function_name],
            [".", "Errors", ".", "."]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "Lambda Execution Duration"
          region = "ap-southeast-2"
          period = 300

          metrics = [
            ["AWS/Lambda", "Duration", "FunctionName", var.lambda_function_name]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "Image Processing Errors"
          region = "ap-southeast-2"
          period = 300

          metrics = [
            [
              "${var.project_name}/${var.environment}",
              "ImageProcessingErrors"
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "Large Images Detected"
          region = "ap-southeast-2"
          period = 300

          metrics = [
            [
              "${var.project_name}/${var.environment}",
              "LargeImagesDetected"
            ]
          ]
        }
      }
    ]
  })
}
