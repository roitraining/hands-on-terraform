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

