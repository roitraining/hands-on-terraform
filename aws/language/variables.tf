variable "account" {
  description = "The name of the current account."
  type        = string
  default     = "My Account"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = map(string)
  default = {
    us-east-1 = "ami-0532be01f26a3de55",
    us-east-2 = "ami-03ea746da1a2e36e7"
  }
}

variable "instance_type" {
  description = "The size of the VM instances."
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 5
    error_message = "Instance count must be between 1 and 5."
  }
}
