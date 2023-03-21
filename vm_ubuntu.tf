resource "random_password" "netsecadmin-ubuntu" {
  length           = 16
  special          = true
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "*!@#?"
}


# Create NIC
resource "azurerm_network_interface" "nic-azu-ubuntu" {
  name                = "nic-azu-ubuntu"
  location            = azurerm_resource_group.rg["server"].location
  resource_group_name = azurerm_resource_group.rg["server"].name

  ip_configuration {
    name                          = "ipconfigv4"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet["server01"].id
    public_ip_address_id          = azurerm_public_ip.pip-azu-ubuntu.id
  }
  ip_configuration {
    name                          = "ipconfigv6"
    primary                       = false
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv6"
    subnet_id                     = azurerm_subnet.subnet["server01"].id
    public_ip_address_id          = azurerm_public_ip.pip6-azu-ubuntu.id
  }
  tags = var.tags
}

# Create VM
resource "azurerm_linux_virtual_machine" "vm-azu-ubuntu" {
  name                            = "vm-azu-ubuntu"
  size                            = "Standard_B2ms"
  resource_group_name             = azurerm_resource_group.rg["server"].name
  location                        = azurerm_resource_group.rg["server"].location
  computer_name                   = "azu-ubuntu"
  secure_boot_enabled             = false
  encryption_at_host_enabled      = false
  disable_password_authentication = false
  admin_username                  = "netsecadmin"
  admin_password                  = random_password.netsecadmin-ubuntu.result

  network_interface_ids = [
    azurerm_network_interface.nic-azu-ubuntu.id
  ]

  boot_diagnostics {}

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name                 = "azu-ubuntu_OsDisk"
    disk_size_gb         = 30
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  tags = var.tags
}