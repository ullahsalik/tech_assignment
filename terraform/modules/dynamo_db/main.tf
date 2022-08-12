resource "aws_dynamodb_table" "basic_dynamodb_table" {
  name           = "EKS_cluster_monitoring"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "cluster_name"
  range_key      = "alert_name"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  
  attribute {
    name = "cluster_name"
    type = "S"
  }

  attribute {
    name = "alert_name"
    type = "S"
  }

  tags    = {
              Name = "EKS_cluster_monitoring"
            }
}