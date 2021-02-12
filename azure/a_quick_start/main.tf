terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
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