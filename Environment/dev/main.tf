module "rg"{
source         = "../../Modules/resource_group"
resource_group = var.rgs
}

module "vnet" {
  source   = "../../Modules/vnet"
  networks = var.networks
}

module "storage" {
  source           = "../../Modules/storage_account"
  storage_accounts = var.storage_accounts
}


#module "nsg" {
  #source     = "./modules/nsg"
  #nsgs       = var.nsgs
  #subnet_ids = module.vnet.subnet_ids
#}