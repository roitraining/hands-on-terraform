variable "project" {
  type    = string
  default = "my-project"
}

variable "project_id" {
  description = "The GCP Project ID."
  type        = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zones" {
  type    = list(string)
  default = ["us-central1-a", "us-central1-b"]
}

variable "subnet_cidr" {
  type        = string
  description = "Subnet CIDR for VPC"
  default = "10.1.1.0/24"
}

variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
  default = "debian-cloud/debian-9"
}

data "google_compute_image" "debian_image" {
  family   = "debian-9"
  project  = "debian-cloud"
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

variable "startup_script" {
  type = string
}




