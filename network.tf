resource "azurerm_virtual_network" "vnet_kubernetes_demo" {
  name                = "vnet-kubernetes-demo"
  resource_group_name = azurerm_resource_group.kubernetes_demo_rg.name
  location            = var.location
  address_space       = [ "10.100.0.0/16" ]
  tags                = var.common_tags
}
resource "azurerm_subnet" "snet_public" {
  resource_group_name  = azurerm_resource_group.kubernetes_demo_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_kubernetes_demo.name
  name = "snet-pub"
  address_prefixes = [ "10.100.0.0/23" ]
}

resource "azurerm_subnet" "snet_private" {
  resource_group_name  = azurerm_resource_group.kubernetes_demo_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_kubernetes_demo.name
  name = "snet-priv"
  address_prefixes = [ "10.100.2.0/23" ]
}