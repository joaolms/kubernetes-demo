resource azurerm_resource_group "kubernetes_demo_rg" {
  name        = "kubernetes-demo-rg"
  location    = var.location
}

resource "azurerm_virtual_network" "vnet_kubernetes_demo" {
  name                = "vnet-kubernetes-demo"
  resource_group_name = azurerm_resource_group.kubernetes_demo_rg.name
  location            = var.location
  address_space       = [ "10.100.0.0/16" ]
  
  tags                = {
    plataforma = "kubernetes-demo"
  }
}

resource "azurerm_subnet" "snet_kubernetes_demo" {
  count                 = length(var.subnet_names)
  resource_group_name   = azurerm_resource_group.kubernetes_demo_rg.name
  name                  = var.subnet_names[count.index]
  address_prefixes      = [var.subnet_prefixes[count.index]]
  virtual_network_name  = azurerm_virtual_network.vnet_kubernetes_demo.name
}
