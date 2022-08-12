locals {
  id = "${var.env}-${var.product_name}-${var.name}-v${var.resource_version}"
  tags = "${var.tags}"
  identifier = "${var.env}-${var.product_name}-v${var.resource_version}"
}