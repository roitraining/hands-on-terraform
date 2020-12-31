variable "project_id" {
  description = "The GCP Project ID."
  type        = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "os_version" {
  type    = number
  default = 9
}
variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = map(string)
  default = {
    9  = "debian-cloud/debian-9",
    10 = "debian-cloud/debian-10"
  }
}

variable "machine_type" {
  description = "The size of the VM instances."
  type        = string
  default     = "f1-micro"
}

variable "preemptible" {
  type    = bool
  default = false

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
