output "function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.lambda_function.arn
}

output "function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.lambda_function.function_name
}

output "invoke_arn" {
  value       = aws_lambda_function.lambda_function.invoke_arn
  description = "Invoke ARN for the Lambda function"
}