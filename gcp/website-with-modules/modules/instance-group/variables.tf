variable "project" {
  type    = string
}

variable "regions" {
  type    = set(string)
}

variable "machine_type" {
  description = "The size of the VM instances."
  type        = string
}

variable "preemptible" {
  type    = bool
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

variable "startup_script" {
  type = string
}

variable "vpc_id"{
    type = string
}

variable "subnets" {
  type = any
}