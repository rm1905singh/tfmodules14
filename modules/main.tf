module "rgm" {
  source  = "../1RGS"
  rgnames = var.rgnames

}
module "vnetm" {
  depends_on = [module.rgm]
  source     = "../2VNETS"
  vnets      = var.vnets

}
module "subnetm" {
  depends_on = [module.vnetm]
  source     = "../3SUBNETS"
  subnets    = var.subnets

}
module "pipm" {
  depends_on = [module.rgm]
  source     = "../4PUBLIC IPS"
  pips       = var.pips

}
module "nicm" {
  depends_on = [module.rgm, module.vnetm, module.subnetm, module.pipm]
  source     = "../5NIC"
  nics       = var.nics

}
module "nsgm" {
  depends_on    = [module.rgm, module.subnetm]
  source        = "../6NSG"
  nsgs          = var.nsgs
  security_rule = var.security_rule
}
module "nsgassm" {
  depends_on = [module.nsgm, module.subnetm]
  source     = "../7NSGASS"
  nsgass     = var.nsgass

}
module "vms" {
  depends_on = [module.rgm, module.nicm]
  source     = "../8VMS"
  vms        = var.vms

}