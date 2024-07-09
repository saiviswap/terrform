resource "azurerm_managed_disk" "datadisk" {
  name                 = "datadisk"
  location             = local.location
  resource_group_name  = local.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "8"

  depends_on = [ azurerm_resource_group.App-grp]

}