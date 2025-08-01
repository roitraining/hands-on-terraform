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

variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
  default = "debian-cloud/debian-11"
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
