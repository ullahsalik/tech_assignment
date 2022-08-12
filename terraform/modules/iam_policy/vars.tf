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

variable "iam_policy_doc_json" {
  type        = string
  description = "JSON of iam policy document"
}