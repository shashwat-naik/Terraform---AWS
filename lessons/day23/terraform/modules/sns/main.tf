
# Critical alerts
resource "aws_sns_topic" "critical" {
  name = "${var.project_name}-${var.environment}-critical-alerts"

  tags = merge(var.tags, {
    Name      = "${var.project_name}-${var.environment}-critical-alerts"
    AlertType = "Critical"
  })
}

# Performance alerts
resource "aws_sns_topic" "performance" {
  name = "${var.project_name}-${var.environment}-performance-alerts"

  tags = merge(var.tags, {
    Name      = "${var.project_name}-${var.environment}-performance-alerts"
    AlertType = "Performance"
  })
}

# Log-based alerts
resource "aws_sns_topic" "logs" {
  name = "${var.project_name}-${var.environment}-log-alerts"

  tags = merge(var.tags, {
    Name      = "${var.project_name}-${var.environment}-log-alerts"
    AlertType = "Logs"
  })
}

# Email subscription - Critical alerts
resource "aws_sns_topic_subscription" "critical_email" {
  count = var.alert_email == "" ? 0 : 1

  topic_arn = aws_sns_topic.critical.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# Email subscription - Performance alerts
resource "aws_sns_topic_subscription" "performance_email" {
  count = var.alert_email == "" ? 0 : 1

  topic_arn = aws_sns_topic.performance.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# Email subscription - Log alerts
resource "aws_sns_topic_subscription" "logs_email" {
  count = var.alert_email == "" ? 0 : 1

  topic_arn = aws_sns_topic.logs.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
