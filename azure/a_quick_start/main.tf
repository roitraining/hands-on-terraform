terraform {
  required_providers {
  }
}

provider "azurerm" {
    features {
      
    }
}

resource "azurerm_resource_group" "az-rg" {
  name = "az-tf-res-grp"
  location = "eastus2"
}