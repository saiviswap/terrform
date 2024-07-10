resource "azurerm_virtual_network" "Appnetwork" {
  name                = "appnetwork"
  location            = local.location
  resource_group_name = local.name
  address_space       = ["10.0.0.0/16"]

  depends_on = [ azurerm_resource_group.App-grp ]
  
  }

  resource "azurerm_subnet" "SubnetA" {
  name                 = "subnetA"
  resource_group_name  = local.name
  virtual_network_name = "appnetwork"
  address_prefixes     = ["10.0.0.0/24"]

  depends_on = [ azurerm_virtual_network.Appnetwork ]

  }

  resource "azurerm_public_ip" "Public" {
  name                = "public-ip"
  resource_group_name = local.name
  location            = local.location
  allocation_method   = "Static"

  depends_on = [ azurerm_resource_group.App-grp ]
  }
resource "azurerm_public_ip" "linuxPublic" {
  name                = "linuxpublic-ip"
  resource_group_name = local.name
  location            = local.location
  allocation_method   = "Static"

  depends_on = [ azurerm_resource_group.App-grp ]

}


  resource "azurerm_network_security_group" "NSG" {
  name                = "nsg"
  location            = local.location
  resource_group_name = local.name

  security_rule {
    name                       = "win-nsg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "0-3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


    depends_on = [ azurerm_resource_group.App-grp ]
  }  

  resource "azurerm_subnet_network_security_group_association" "nsglink" {
    subnet_id = azurerm_subnet.SubnetA.id
    network_security_group_id = azurerm_network_security_group.NSG.id
    
  }