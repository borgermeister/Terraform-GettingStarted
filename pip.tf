# Public IPv4 for 'vm-azu-windows'
resource "azurerm_public_ip" "pip-azu-windows" {
  name                = "pip-azu-windows"
  resource_group_name = azurerm_resource_group.rg["server"].name
  location            = azurerm_resource_group.rg["server"].location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "azu-windows"
  ip_tags = {
    RoutingPreference = "Internet"
  }
  zones = [1, 2, 3]

  tags = var.tags
}

# Public IPv6 for 'vm-azu-windows'
resource "azurerm_public_ip" "pip6-azu-windows" {
  name                = "pip6-azu-windows"
  resource_group_name = azurerm_resource_group.rg["server"].name
  location            = azurerm_resource_group.rg["server"].location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "azu-windows-v6"
  ip_version          = "IPv6"
  zones               = [1, 2, 3]

  tags = var.tags
}
