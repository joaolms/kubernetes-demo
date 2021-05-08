resource "azurerm_public_ip" "k8s_node2_public_ip" {
  name                = "k8s-node2-public-ip"
  resource_group_name = azurerm_resource_group.kubernetes_demo_rg.name
  location            = var.location

  allocation_method   = "Dynamic"

  tags                = var.common_tags
}

resource "azurerm_network_interface" "k8s_node2_nic" {
  name                = "k8s-node2-nic"
  resource_group_name = azurerm_resource_group.kubernetes_demo_rg.name
  location            = var.location

  ip_configuration {
    name                          = "k8s_node2_internal_ip"
    subnet_id                     = azurerm_subnet.snet_public.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.100.0.6"
    public_ip_address_id          = azurerm_public_ip.k8s_node2_public_ip.id
  }

  tags = var.common_tags
}

# data "template_file" "jenkinsconfig" {
#   template = file(var.jenkins_custom_data)
# }

resource "azurerm_linux_virtual_machine" "k8s_node2_vm" {
  name                = "k8s-node2"
  resource_group_name = azurerm_resource_group.kubernetes_demo_rg.name
  location            = var.location
  size                = "Standard_B2s"
  admin_username      = "ubuntu"
  # custom_data         = base64encode(data.template_file.jenkinsconfig.rendered)

  network_interface_ids = [
    azurerm_network_interface.k8s_node2_nic.id,
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = var.ssh_pubkey
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }

  tags = var.common_tags
}