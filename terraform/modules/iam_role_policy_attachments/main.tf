resource "aws_iam_role_policy_attachment" "custom" {
  count      = length(var.custom_role_policy_arns) > 0 ? length(var.custom_role_policy_arns) : 0
  role       = var.role_name
  policy_arn = element(var.custom_role_policy_arns, count.index)
}