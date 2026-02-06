variable "account" {
  description = "The name of the current account."
  type        = string
  default     = "My Account"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_a_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "subnet_b_cidr" {
  type    = string
  default = "10.10.2.0/24"
}