resource "random_password" "netsecadmin-windows" {
  length           = 16
  special          = true
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "*!@#?"
}

# Create NIC
resource "azurerm_network_interface" "nic-azu-windows" {
  name                = "nic-azu-windows"
  location            = azurerm_resource_group.rg["server"].location
  resource_group_name = azurerm_resource_group.rg["server"].name

  ip_configuration {
    name                          = "ipconfigv4"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet["server01"].id
    public_ip_address_id          = azurerm_public_ip.pip-azu-windows.id
  }
  ip_configuration {
    name                          = "ipconfigv6"
    primary                       = false
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv6"
    subnet_id                     = azurerm_subnet.subnet["server01"].id
    public_ip_address_id          = azurerm_public_ip.pip6-azu-windows.id
  }
  tags = var.tags
}

# Create VM
resource "azurerm_windows_virtual_machine" "vm-azu-windows" {
  name                       = "vm-azu-windows"
  size                       = "Standard_B4ms"
  resource_group_name        = azurerm_resource_group.rg["server"].name
  location                   = azurerm_resource_group.rg["server"].location
  computer_name              = "azu-windows"
  secure_boot_enabled        = false
  encryption_at_host_enabled = true
  allow_extension_operations = false
  admin_username             = "netsecadmin-windows"
  admin_password             = random_password.netsecadmin-windows.result
  patch_assessment_mode      = "AutomaticByPlatform"

  network_interface_ids = [
    azurerm_network_interface.nic-azu-windows.id
  ]

  # boot_diagnostics {}

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-datacenter-gensecond"
    version   = "latest"
  }

  os_disk {
    name                 = "azu-windows-OsDisk"
    disk_size_gb         = 127
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  tags = var.tags
}