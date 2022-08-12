output "arn" {
  value       = aws_iam_policy.iam_policy.arn
  description = "ARN of AWS IAM Policy"
}

output "name" {
  value       = aws_iam_policy.iam_policy.name
  description = "Name of AWS IAM Policy"
}

output "id" {
  value       = aws_iam_policy.iam_policy.id
  description = "ID of AWS IAM Policy"
}