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

variable "acl" {
  type        = string
  description = "Todo "
  default     = "private"
}

variable "allowed_headers" {
  type    = list(string)
  default = ["*"]
}

variable "allowed_origins" {
  type    = list(string)
  default = ["*"]
}

variable "allowed_methods" {
  type    = list(string)
  default = ["GET", "HEAD"]
}

variable "max_age_seconds" {
  type    = number
  default = 1800
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "Server side encryption algorithm i.e AES256, aws:kms"
}

variable "enable_versioning" {
  type        = string
  default     = "false"
  description = "Versioning enable true or false"
}

variable "acceleration_status" {
  type = string
  default = "Suspended"
  description = "Enabel acceleration status."
}

variable "create_public_bucket" {
  type = bool
  description = "Enable public bucket."
  default = false
}

variable "block_public_acls" {
  type        = bool
  default     = true
}

variable "block_public_policy" {
  type = bool
  default = true
}
