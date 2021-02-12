variable "prefix" {
  type    = string
  default = "azure-terra"
}

variable "res_grp_locale" {
  type    = string
}

variable "res_grp_name" {
  type  = string
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Terra Azure"
    Dept        = "Terra Introductions"
    Billing  = "Automation with Terraform"
  }
}

variable "regions" {
  type = set(string)
  default = ["westus2","eastus", "eastus2"]
}