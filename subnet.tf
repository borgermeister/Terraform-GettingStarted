# Create multiple subnets
resource "azurerm_subnet" "subnet" {
  for_each = local.subnet

  name                 = each.value.name
  address_prefixes     = each.value.address_prefixes
  resource_group_name  = each.value.rg.name
  virtual_network_name = each.value.vnet.name

  service_endpoints = each.value.service_endpoints
}