variable "project" {
  type    = string
  default = "my-project"
}

variable "project_id" {
  description = "The GCP Project ID."
  type        = string
}

variable "zone" {
  type = string
}

variable "subnet_cidr" {
  type        = string
  description = "Subnet CIDR for VPC"
  default     = "10.1.1.0/24"
}

variable "regions" {
  type    = set(string)
  default = ["us-central1"]
}

variable "subnet_cidrs" {
  type        = map(string)
  description = "Subnet CIDRs for VPC"
  default = {
    us-central1 = "10.1.1.0/24"
  }
}


