
resource "azurerm_subnet_network_security_group_association" "nsgassblock" {
  for_each                  = var.nsgass
  subnet_id                 = data.azurerm_subnet.subnetdata[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsgdata[each.key].id
}
data "azurerm_subnet" "subnetdata" {
  for_each             = var.nsgass
  name                 = each.value.subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_network_security_group" "nsgdata" {
  for_each            = var.nsgass
  name                = each.value.nsgname  
  resource_group_name = each.value.resource_group_name
}
