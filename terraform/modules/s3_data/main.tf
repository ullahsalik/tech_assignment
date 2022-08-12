module "blue-green" {
  source        = "../blue_green"
  product_name  = var.product_name
  env           = var.env
  name          = var.name
  tags          = var.tags
}

locals {
  commonTags = {
    Name = module.blue-green.id
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = module.blue-green.id
  acl    = var.acl
  tags   = merge(var.tags, local.commonTags)
  cors_rule {
    allowed_headers = var.allowed_headers
    allowed_origins = var.allowed_origins
    allowed_methods = var.allowed_methods
    max_age_seconds = var.max_age_seconds
  }

  versioning {
    enabled = var.enable_versioning
  }

  acceleration_status = var.acceleration_status
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
      }
    }
  }
}

resource "aws_s3_bucket_policy" "policy" {
  count = var.create_public_bucket ? 1 : 0
  bucket = aws_s3_bucket.bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "sid1",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.bucket.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = var.block_public_acls
  block_public_policy = var.block_public_policy
}