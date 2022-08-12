variable "topic_name" {
  type        = string
  description = "The display name of the SNS topic"
}

variable "tags" {
  type        = map(string)
  default     = {}
}