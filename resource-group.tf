resource azurerm_resource_group "kubernetes_demo_rg" {
  name     = "kubernetes-demo-rg"
  location = var.location
  tags     = var.common_tags
}