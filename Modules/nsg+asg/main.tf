resource "azurerm_application_security_group" "asg" {
  for_each            = var.asgs
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags                = lookup(each.value, "tags", {})
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsgs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                   = security_rule.value.name
      priority               = security_rule.value.priority
      direction              = security_rule.value.direction
      access                 = security_rule.value.access
      protocol               = security_rule.value.protocol
      destination_port_range = security_rule.value.destination_port_range

      # ASG linking resolved using string keys
      source_application_security_group_ids = [
  for k in coalesce(lookup(security_rule.value, "source_asgs", []), []) :
  azurerm_application_security_group.asg[k].id
]

destination_application_security_group_ids = [
  for k in coalesce(lookup(security_rule.value, "destination_asgs", []), []) :
  azurerm_application_security_group.asg[k].id
]

      
    }
  }
}
