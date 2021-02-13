variable "project" {
  type        = string
  description = "Project name."
  default     = "my-project"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "eastus"
}

variable "vpc_cidr" {
  type        = list(string)
  description = "CIDR block for VPC"
  default     = ["10.0.0.0/16"]

}

variable "subnet_cidrs" {
  type        = map(string)
  description = "Subnet CIDRs for VPC"
  default = {
    a : "10.0.1.0/24"
  }

}
