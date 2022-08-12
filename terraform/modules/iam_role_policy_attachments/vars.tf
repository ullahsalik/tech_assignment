variable "custom_role_policy_arns" {
  type        = list(string)
  description = "Custom policy ARN"
  default     = []
}

variable "role_name" {
  type        = string
  description = "Role name"
}
