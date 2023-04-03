# Generate admin password
resource "random_password" "admin-windoze02" {
  length           = 16
  special          = true
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "*!@#?"
}

# Create NIC
resource "azurerm_network_interface" "nic-azu-windoze02" {
  name                = "nic-azu-windoze02"
  location            = azurerm_resource_group.rg["server"].location
  resource_group_name = azurerm_resource_group.rg["server"].name

  ip_configuration {
    name                          = "ipconfigv4"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet["server01"].id
    public_ip_address_id          = azurerm_public_ip.pip-azu-windoze02.id
  }
  ip_configuration {
    name                          = "ipconfigv6"
    primary                       = false
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv6"
    subnet_id                     = azurerm_subnet.subnet["server01"].id
    public_ip_address_id          = azurerm_public_ip.pip6-azu-windoze02.id
  }
  tags = var.tags
}

# Create VM
resource "azurerm_windows_virtual_machine" "vm-azu-windoze02" {
  name                       = "vm-azu-windoze02"
  size                       = "Standard_B4ms"
  resource_group_name        = azurerm_resource_group.rg["server"].name
  location                   = azurerm_resource_group.rg["server"].location
  computer_name              = "azu-windoze02"
  secure_boot_enabled        = false
  encryption_at_host_enabled = true
  allow_extension_operations = false
  admin_username             = "admin-windoze02"
  admin_password             = random_password.admin-windoze02.result
  patch_assessment_mode      = "AutomaticByPlatform"

  network_interface_ids = [
    azurerm_network_interface.nic-azu-windoze02.id
  ]

  # boot_diagnostics {}

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-datacenter-gensecond"
    version   = "latest"
  }

  os_disk {
    name                 = "azu-windoze02-OsDisk"
    disk_size_gb         = 127
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  tags = var.tags
}