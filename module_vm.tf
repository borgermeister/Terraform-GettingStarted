module "vm-azu-ubuntu01" {
  source = "./vm"

  rg_name     = azurerm_resource_group.rg["server"].name
  rg_location = azurerm_resource_group.rg["server"].location
  subnet_id   = azurerm_subnet.subnet["server01"].id
  vm_instance_size = "Standard_B2ms"
  vm_os = {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  vm_name              = "azu-ubuntu01"
  vm_admin_user        = "terraform"
  nic_name             = "nic1"
  nic_ip_name          = "internal"
  disk_name            = "disk1"
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 30
}