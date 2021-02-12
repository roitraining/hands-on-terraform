resource "azurerm_resource_group" "tfrsg" {
  location = var.res_grp_locale
  name = "${var.prefix}-${var.res_grp_name}"
}