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
  default = 12
}

variable "image_id" {
  description = "The id of the machine image to use for the server."
  type        = map(string)
  default = {
    11 = "debian-cloud/debian-11",
    12 = "debian-cloud/debian-12"
  }
}

variable "machine_type" {
  description = "The size of the VM instances."
  type        = string
  default     = "e2-micro"
}

variable "spot" {
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
