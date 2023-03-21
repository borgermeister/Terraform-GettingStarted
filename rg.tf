# Create multiple resource groups
resource "azurerm_resource_group" "rg" {
  for_each = local.rg

  name     = each.value.name
  location = each.value.location

  tags = var.tags
}