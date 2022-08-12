variable "product_name" {
  type        = string
  description = "product_name (e.g. `Falcon` or `Magicleap`)"
}

variable "env" {
  type        = string
  description = "e.g. `prod`, `dev`, `env`)"
}

variable "name" {
  type        = string
  description = "Name  (e.g. `Falcon` or `Magicleap`)"
}

variable "tags" {
  type        = map(string)
}

variable "lambda_function_name" {
  type        = string
  description = "A unique name for your Lambda Function"
}

variable "lambda_function_description" {
  type        = string
  description = "Description of what your Lambda Function does"
}

variable "lambda_handler" {
  type        = string
  default     = "main.main"
  description = "The function entrypoint in your code"
}

variable "env_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables for Lambda function"
}

variable "role" {
  type        = string
  description = "IAM role attached to the Lambda Function"
}

variable "runtime" {
  type        = string
  default     = "python2.7"
  description = "The function entrypoint in your code"
}

variable "timeout" {
  type        = number
  default     = 900
  description = "Timeout period of lambda function"
}

variable "memory_size" {
  type        = number
  default     = 3008
  description = "Memory allocated to lambda function"
}

variable "concurrency_limit" {
  type        = string
  default     = "-1"
  description = "The number of concurrent executions the lambda can serve"
}

variable "retention_in_days" {
  type        = number
  default     = 365
  description = "Specifies the number of days you want to retain log events in the specified log group"
}

variable "lambda_s3_bucket" {
  type        = string
  description = "The S3 bucket location containing the function's deployment package"
}

variable "path_dummy_code" {
  type        = string
  description = "Path to dummy code to be uploaded to S3"
}