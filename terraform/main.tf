locals {
    product_name                = "assignment"
    env                         = "dev"
}

#####################################################################################
#####                                                                            ####
#####                                 IAM Policy                                 ####
#####                                                                            ####
#####################################################################################

data "aws_iam_policy_document" "iam_policy_for_dynamo_lambda" {
    statement {
        effect = "Allow"
        actions = [
            "dynamodb:BatchGetItem",
            "dynamodb:GetItem",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:BatchWriteItem",
            "dynamodb:PutItem",
            "dynamodb:UpdateItem"
        ]
        resources = [
            "${module.dynamo_table.arn}"]
    }
    statement {
        effect = "Allow"
        actions = [
            "logs:CreateLogStream",
			"logs:PutLogEvents"
        ]
        resources = ["arn:aws:logs:*:*:*"]
    }
    statement {
        effect = "Allow"
        actions = [
            "logs:CreateLogGroup"
        ]
        resources = ["*"]
    }
    statement {
        effect = "Allow"
        actions = [
            "s3:ListStorageLensConfigurations",
            "s3:ListAccessPointsForObjectLambda",
            "s3:GetAccessPoint",
            "s3:PutAccountPublicAccessBlock",
            "s3:GetAccountPublicAccessBlock",
            "s3:ListAllMyBuckets",
            "s3:ListAccessPoints",
            "s3:PutAccessPointPublicAccessBlock",
            "s3:ListJobs",
            "s3:PutStorageLensConfiguration",
            "s3:ListMultiRegionAccessPoints",
            "s3:CreateJob"
        ]
        resources = ["*"]
    }
}

module "iam_policy_for_lambda_function" {
    source              = "./modules/iam_policy"
    name                = "assignment-policy"
    product_name        = local.product_name
    tags                = {}
    env                 = local.env
    iam_policy_doc_json = data.aws_iam_policy_document.iam_policy_for_dynamo_lambda.json
}

#####################################################################################
#####                                                                            ####
#####                                 IAM Role                                 ####
#####                                                                            ####
#####################################################################################

data "aws_iam_policy_document" "assume_lambda_role_policy" {
    statement {
        sid         = "assumePolicy"
        actions     = [
                        "sts:AssumeRole",
                    ]
        principals {
                        type        = "Service"
                        identifiers = ["lambda.amazonaws.com"]
                    }
        effect      = "Allow"
    }
}

module "lambda_function_iam_role" {
    source                = "./modules/iam_roles"
    product_name          = local.product_name
    env                   = local.env
    assume_role_policy    = data.aws_iam_policy_document.assume_lambda_role_policy.json
    name                  = "lambda-role"
    tags                  = {}
}

#####################################################################################
#####                                                                            ####
#####                       IAM Role & Policy Attachment                         ####
#####                                                                            ####
#####################################################################################


module "assignment_lambda_role_policy_attachment" {
    source                      = "./modules/iam_role_policy_attachments"
    role_name                   =  module.lambda_function_iam_role.role_name
    custom_role_policy_arns     = [ module.iam_policy_for_lambda_function.arn ]
}

#####################################################################################
#####                                                                            ####
#####                               S3 Bucket for Assignment                          ####
#####                                                                            ####
#####################################################################################

module "s3_bucket_for_lambda" {
  source           = "./modules/s3_data"
  product_name     = local.product_name
  env              = local.env
  name             = "lambda-code-bucket"
  tags             = null
}

#####################################################################################
#####                                                                            ####
#####                       Dynamo Table for Assignment                          ####
#####                                                                            ####
#####################################################################################

module "dynamo_table" {
    source                      = "./modules/dynamo_db"
}

#####################################################################################
#####                                                                            ####
#####                       Lambda function for Assignment                       ####
#####                                                                            ####
#####################################################################################

module "lambda_function" {
    source                      = "./modules/lambda_function"
    product_name                = local.product_name
    env                         = local.env
    name                        = "ReceivePrometheusSNSNotifications"
    runtime                     = "python3.9"
    lambda_function_name        = "ReceivePrometheusSNSNotifications"
    lambda_function_description = "Lambda Function"
    lambda_handler              = "ReceivePrometheusSNSNotifications.lambda_handler"
    role                        = module.lambda_function_iam_role.role_arn
    lambda_s3_bucket            = module.s3_bucket_for_lambda.bucket_id
    path_dummy_code             = "lambda_code.zip"
    env_variables               = {}
    tags                        = null
}

resource "aws_sns_topic" "prometheus_alerts" {
    name            = "test-cluster-PrometheusAlerts"
    display_name    = "AWS Prometheus Alert for test-cluster"
}

resource "aws_sns_topic_subscription" "prometheus_alerts_sqs_target" {
    topic_arn = aws_sns_topic.prometheus_alerts.arn
    protocol  = "lambda"
    endpoint  = module.lambda_function.function_arn
}

resource "aws_lambda_permission" "with_sns" {
    statement_id = "AllowExecutionFromSNS"
    action = "lambda:InvokeFunction"
    function_name = "${module.lambda_function.function_name}"
    principal = "sns.amazonaws.com"
    source_arn = "${aws_sns_topic.prometheus_alerts.arn}"
}