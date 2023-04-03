# Public IPv4 for 'vm-azu-ubuntu02'
resource "azurerm_public_ip" "pip-azu-ubuntu02" {
  name                = "pip-azu-ubuntu02"
  resource_group_name = azurerm_resource_group.rg["server"].name
  location            = azurerm_resource_group.rg["server"].location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = lower("azu-ubuntu02-${var.prefix}")
  ip_tags = {
    RoutingPreference = "Internet"
  }
  zones = [1, 2, 3]

  tags = var.tags
}

# Public IPv6 for 'vm-azu-ubuntu02'
resource "azurerm_public_ip" "pip6-azu-ubuntu02" {
  name                = "pip6-azu-ubuntu02"
  resource_group_name = azurerm_resource_group.rg["server"].name
  location            = azurerm_resource_group.rg["server"].location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = lower("azu-ubuntu02-v6-${var.prefix}")
  ip_version          = "IPv6"
  zones               = [1, 2, 3]

  tags = var.tags
}

# Public IPv4 for 'vm-azu-windoze02'
resource "azurerm_public_ip" "pip-azu-windoze02" {
  name                = "pip-azu-windoze02"
  resource_group_name = azurerm_resource_group.rg["server"].name
  location            = azurerm_resource_group.rg["server"].location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = lower("azu-windoze02-${var.prefix}")
  ip_tags = {
    RoutingPreference = "Internet"
  }
  zones = [1, 2, 3]

  tags = var.tags
}

# Public IPv6 for 'vm-azu-windoze02'
resource "azurerm_public_ip" "pip6-azu-windoze02" {
  name                = "pip6-azu-windoze02"
  resource_group_name = azurerm_resource_group.rg["server"].name
  location            = azurerm_resource_group.rg["server"].location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = lower("azu-windoze02-v6-${var.prefix}")
  ip_version          = "IPv6"
  zones               = [1, 2, 3]

  tags = var.tags
}
