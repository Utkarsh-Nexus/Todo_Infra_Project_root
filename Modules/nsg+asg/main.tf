# ---------------------------
# CREATE APPLICATION SECURITY GROUPS (ASG)
# ---------------------------
resource "azurerm_application_security_group" "asg" {
  for_each            = var.asgs
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags                = lookup(each.value, "tags", {})
}

# ---------------------------
# CREATE NETWORK SECURITY GROUPS + RULES
# ---------------------------

resource "azurerm_network_security_group" "example" {
  for_each            = var.nsgs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = lookup(each.value, "tags", {})

  dynamic "security_rule" {
  for_each = lookup(each.value , "rules" , {})
  content {
    name                       = security_rule.value.name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   = security_rule.value.protocol
    source_port_range          = security_rule.value.source_port_range
    destination_port_range     = security_rule.value.destination_port_range
    source_address_prefix      = security_rule.value.source_address_prefix
    destination_address_prefix = security_rule.value.destination_address_prefix
  }

  # ASG Support (link NSG rules to ASGs)
      source_application_security_group_ids      = lookup(security_rule.value, "source_asg_ids", [])
      destination_application_security_group_ids = lookup(security_rule.value, "destination_asg_ids", [])
    }
  }
  