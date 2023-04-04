### RESOURCE GROUPS ###
locals {
  rg = {
    infrastructure = {
      name     = lower("rg-${var.prefix}-infrastructure")
      location = var.location
    }
    server = {
      name     = lower("rg-${var.prefix}-server")
      location = var.location
    }
  }
}

### VIRTUAL NETWORKS ###
locals {
  vnet = {
    azure01 = {
      name          = lower("vnet-${var.prefix}-azure01")
      address_space = ["172.16.0.0/16", "fd54:544b:bef7::/48"]
      rg            = azurerm_resource_group.rg["infrastructure"]
    }
  }
}

### SUBNETS ###
locals {
  subnet = {
    server01 = {
      name              = lower("snet-${var.prefix}-server")
      address_prefixes  = ["172.16.10.0/24", "fd54:544b:bef7:a::/64"]
      vnet              = azurerm_virtual_network.vnet["azure01"]
      rg                = azurerm_resource_group.rg["infrastructure"]
      service_endpoints = []
    }
  }
}
