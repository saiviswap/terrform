resource "azurerm_storage_account" "sai23484564" {
    count = 4
  name                     = "${count.index}sai23484564"
  resource_group_name      = local.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"

  }