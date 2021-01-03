variable "project" {
  type    = string
}

variable "regions" {
  type    = set(string)
}

variable "subnet_cidrs" {
  type        = map(string)
  description = "Subnet CIDRs for VPC"
}
