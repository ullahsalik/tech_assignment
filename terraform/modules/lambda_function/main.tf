module "blue-green" {
    source                  = "../blue_green"
    product_name            = var.product_name
    env                     = var.env
    name                    = var.name
    tags                    = var.tags 
}

resource "aws_s3_bucket_object" "dummy_code" {
  bucket = var.lambda_s3_bucket
  key    = "lambda_dummy_code.zip"
  source = var.path_dummy_code
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${module.blue-green.id}"
  retention_in_days = var.retention_in_days
}

resource "aws_lambda_function" "lambda_function" {
  function_name = module.blue-green.id
  description   = var.lambda_function_description
  tags          = var.tags
  handler       = var.lambda_handler
  memory_size   = var.memory_size
  runtime       = var.runtime
  timeout       = var.timeout
  role          = var.role
  filename      = var.path_dummy_code

  dynamic environment {
    for_each=length(var.env_variables) > 0 ? [var.env_variables] : []
    iterator=env
    content {
      variables=env.value
    }
  }

  depends_on = [ aws_cloudwatch_log_group.log_group]
}