variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "My Project"
}

variable "vpc_id" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}

variable "allow_http_id" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "instance_ids" {
  type = list(string)
}
