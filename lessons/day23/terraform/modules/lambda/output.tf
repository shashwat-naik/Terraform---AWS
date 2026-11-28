
# ----------------------------------------
# Lambda Function Outputs
# ----------------------------------------

output "lambda_function_name" {
  description = "Name of the image processing Lambda function"
  value       = aws_lambda_function.image_processor.function_name
}

output "lambda_function_arn" {
  description = "ARN of the image processing Lambda function"
  value       = aws_lambda_function.image_processor.arn
}

output "lambda_invoke_arn" {
  description = "Invocation ARN of the Lambda function"
  value       = aws_lambda_function.image_processor.invoke_arn
}

# ----------------------------------------
# IAM Outputs
# ----------------------------------------

output "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_execution_role.arn
}

# ----------------------------------------
# Lambda Layer Outputs
# ----------------------------------------

output "pillow_layer_arn" {
  description = "ARN of the Pillow Lambda layer"
  value       = aws_lambda_layer_version.pillow_layer.arn
}

# ----------------------------------------
# CloudWatch Outputs
# ----------------------------------------

output "lambda_log_group_name" {
  description = "CloudWatch log group for the Lambda function"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}
