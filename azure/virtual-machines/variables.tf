variable "project"{
    type = string
    description = "Project name."
    default = "my-project"
}

variable "location"{
    type = string
    description = "Azure Region"
    default = "eastus"
}

variable "admin_username" {
    type = string
    description = "Administrator user name for virtual machine"
}

variable "admin_password" {
    type = string
    description = "Password must meet Azure complexity requirements"
}

variable "instance_size" {
  description = "The size of the VM instances."
  type        = string
  default     = "Standard_F2"
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
