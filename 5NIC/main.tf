
resource "azurerm_network_interface" "nicblock" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/1420c8d5-9bbc-4510-8c19-b5350cbc39c0/resourceGroups/rm-resources/providers/Microsoft.Network/virtualNetworks/rmvnet11/subnets/rmsubnet"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pipdata[each.key].id
  }
}


data "azurerm_public_ip" "pipdata" {
  for_each            = var.nics
  name                = each.value.publicipname
  resource_group_name = each.value.resource_group_name
}
