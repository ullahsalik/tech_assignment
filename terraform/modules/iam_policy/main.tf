module "blue-green" {
  source        = "../blue_green"
  product_name  = var.product_name
  env           = var.env
  name          = var.name
  tags          = var.tags
}


resource "aws_iam_policy" "iam_policy" {
  name          = module.blue-green.id
  policy        = var.iam_policy_doc_json
}