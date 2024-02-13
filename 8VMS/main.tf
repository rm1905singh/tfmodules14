# data "azurerm_network_interface" "nicdata" {
#   for_each = var.vms
#   name                = each.value.nicname
#   resource_group_name = each.value.resource_group_name
# }

resource "azurerm_linux_virtual_machine" "vmblock" {
  for_each = var.vms
  name                  = each.value.name
  resource_group_name   = each.value.resource_group_name
  location              = each.value.location
  size                  = "Standard_F2"
  network_interface_ids = ["/subscriptions/1420c8d5-9bbc-4510-8c19-b5350cbc39c0/resourceGroups/rm-resources/providers/Microsoft.Network/networkInterfaces/rmnetworkinterface"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  computer_name                   = "rmvm1"
  admin_username                  = "azureuser"
  disable_password_authentication = false
  admin_password                  = "adminrm@1234"

  connection {
    host     = self.public_ip_address
    user     = "azureuser"
    password = "adminrm@1234"
    type     = "ssh"
    timeout  = "2m"
  }

  provisioner "file" {
    source      = "index.html"      // Mera Laptop
    destination = "/tmp/index.html" //remote VM
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo cp /tmp/index.html /var/www/html",
      "sudo systemctl restart nginx"
    ]
  }

  provisioner "local-exec" {
    command = "echo complete > completed.txt"
  }
}



