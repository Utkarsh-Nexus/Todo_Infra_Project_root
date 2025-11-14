resource "azurerm_resource_group" "rg" {
  for_each    = var.rgs
  name        = each.value.name
  location    = each.value.location
  managed_by  = try(each.value.managed_by, null)
  tags        = try(each.value.tags, null)
}