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
variable "admin_username" {
  type        = string
  description = "Administrator user name for virtual machine"
}

variable "admin_password" {
  type        = string
  description = "Password must meet Azure complexity requirements"
}

variable "instance_size" {
  description = "The size of the VM instances."
  type        = string
  default     = "Standard_F2"
}

variable "instance_count" {
  description = "The size of the VM instances."
  type        = number
  default     = 1
}

variable "startup_script" {
  description = "The size of the VM instances."
  type        = string
  default     = ""
}

variable "application_port" {
  description = "The size of the VM instances."
  type        = number
  default     = 80
}

variable "tags" {
  description = "A map of the tags to use for the resources that are deployed"
  type        = map(string)

  default = {
    environment = "prod"
  }
}

variable "public_ip_address_id" {
  type = string
}

 variable "subnet_id" {
   type = string
 }