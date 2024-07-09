resource "azurerm_network_interface" "Nic-win" {
  name                = "nic-win"
  location            = local.location
  resource_group_name = local.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.Public.id
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "vm-win-machine"
  resource_group_name = local.name
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Password@12345"
  network_interface_ids = [
    azurerm_network_interface.Nic-win.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "Datawin" {
  managed_disk_id    = azurerm_managed_disk.datadisk.id
  virtual_machine_id = azurerm_windows_virtual_machine.example.id
  lun                = "10"
  caching            = "ReadWrite"
}