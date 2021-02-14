variable "project" {
  type        = string
  description = "Application Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "eastus"
}
