# Create multiple vnets
resource "azurerm_virtual_network" "vnet" {
  for_each = local.vnet

  name                = each.value.name
  address_space       = each.value.address_space
  resource_group_name = each.value.rg.name
  location            = each.value.rg.location
  tags                = var.tags
}