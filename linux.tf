resource "azurerm_network_interface" "linux-nic" {
  name                = "Linux-nic"
  location            = local.location
  resource_group_name = local.name

  ip_configuration {
    name                          = "linux-ip"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.linuxPublic.id
  }
}

resource "azurerm_linux_virtual_machine" "linuxsvr" {
  name                = "linux-machine"
  resource_group_name = local.name
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password = "Sai@12345"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.linux-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}