rgnames = {
  rg1 = {
    name     = "rm-resources"
    location = "Australia East"
  }
}

vnets = {
  vnet1 = {
    name                = "rmvnet11"
    location            = "Australia East"
    resource_group_name = "rm-resources"
    address_space       = ["10.0.1.0/24"]

  }

}

subnets = {
  subnet1 = {
    name                 = "rmsubnet"
    resource_group_name  = "rm-resources"
    virtual_network_name = "rmvnet11"
    address_prefixes     = ["10.0.1.0/24"]
  }
}





pips = {
  pip1 = {
    name                = "rmpublicip"
    resource_group_name = "rm-resources"
    location            = "Australia East"
    allocation_method   = "Static"

  }
}

nics = {

  nic1 = {
    name                 = "rmnetworkinterface"
    subnetname           = "rmsubnet"
    publicipname         = "rmpublicip"
    virtual_network_name = "rmvnet11"
    location             = "Australia East"
    resource_group_name  = "rm-resources"
  }

}


nsgs = {
  ngs1 = {
    name                = "rmnsg"
    location            = "Australia East"
    resource_group_name = "rm-resources"
    subnetname          = "rmsubnet"
  }
}
security_rule = {
  rule1 = {
    name                   = "rmr1"
    priority               = "100"
    destination_port_range = "80"
  }

  rule2 = {
    name                   = "rmr2"
    priority               = "101"
    destination_port_range = "22"
  }
}


nsgass = {
  nsgass1 = {
    name                 = "rmnsgass1"
    nsgname              = "rmnsg"
    resource_group_name  = "rm-resources"
    virtual_network_name = "rmvnet11"
    subnetname           = "rmsubnet"

  }
}

vms = {
  vm1 = {
    name                = "rmvm1"
    resource_group_name = "rm-resources"
    location            = "Australia East"

  }

}


