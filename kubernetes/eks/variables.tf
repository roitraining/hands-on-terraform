variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "user_name" {
  description = "User identifier for resource naming (e.g., user01, user02)"
  type        = string
  default     = "userxx"
}