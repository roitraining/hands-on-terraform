variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
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
