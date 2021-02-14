variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "bucket_name" {
  description = "Name of the container. Must be unique."
  type        = string
}

variable "home_page" {
  description = "Name of the website home page."
  type        = string
  default     = "index.html"
}

variable "error_page" {
  description = "Name of the website error page."
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
