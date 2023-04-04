output "pip-azu-ubuntu02" {
  value = azurerm_public_ip.pip-azu-ubuntu02.ip_address
}

output "pip6-azu-ubuntu02" {
  value = azurerm_public_ip.pip6-azu-ubuntu02.ip_address
}

output "pip-azu-windoze02" {
  value = azurerm_public_ip.pip-azu-windoze02.ip_address
}

output "pip6-azu-windoze02" {
  value = azurerm_public_ip.pip6-azu-windoze02.ip_address
}

output "vm-azu-ubuntu0201_password" {
  value = module.vm-azu-ubuntu01.vm_admin_password
  sensitive = true
}

output "vm-azu-windows01_password" {
  value = module.vm-azu-windows01.vm_admin_password
  sensitive = true
}