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

variable "resource_group_name" {
    type        = string
    description = "Resource Group"
}

variable "tags" {
  description = "A map of the tags to use for the resources that are deployed"
  type        = map(string)

  default = {
    environment = "prod"
  }
}