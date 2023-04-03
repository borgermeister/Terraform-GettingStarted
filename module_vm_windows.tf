module "vm-azu-windows01" {
  source = "./modules/vm_windows"

  rg_name          = azurerm_resource_group.rg["server"].name
  rg_location      = azurerm_resource_group.rg["server"].location
  subnet_id        = azurerm_subnet.subnet["server01"].id
  vm_instance_size = "Standard_B2ms"
  vm_os = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  vm_name              = "azu-windows01"
  vm_admin_user        = "terraform"
  nic_name             = "nic1"
  nic_ip_name          = "internal"
  disk_name            = "disk1"
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 128
}
