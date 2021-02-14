resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-rg"
  location = var.location
}

module "website-bucket" {
  source = "../modules/website-bucket"

  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  bucket_name = "spaceinv"
  home_page   = "index.html"
  error_page  = "index.html"
}

resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "az storage blob sync -c \\$web --account-name ${module.website-bucket.storage_account_name}  -s ./website-files"
  }
}
