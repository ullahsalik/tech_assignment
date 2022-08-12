output "arn" {
  value       = aws_dynamodb_table.basic_dynamodb_table.arn
  description = "ARN of AWS dynamodb_table"
}

output "stream_arn" {
  value       = aws_dynamodb_table.basic_dynamodb_table.id
  description = "stream_arn of AWS dynamodb_table"
}

output "id" {
  value       = aws_dynamodb_table.basic_dynamodb_table.id
  description = "ID of AWS dynamodb_table"
}