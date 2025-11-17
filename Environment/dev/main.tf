module "rg" {
  source = "../../Modules/resource_group"
  rgs    = var.rgs
}

module "vnet" {
  source   = "../../Modules/vnet"
  networks = var.networks
}

module "storage" {
  source           = "../../Modules/storage_account"
  storage_accounts = var.storage_accounts
}

module "asg" {
  source = "../../Modules/nsg+asg"
  asgs   = var.asgs
  nsgs   = var.nsgs
}

