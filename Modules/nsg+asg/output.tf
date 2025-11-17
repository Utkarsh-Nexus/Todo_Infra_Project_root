output "asg_ids" {
  value = {
    for k, v in azurerm_application_security_group.asg : k => v.id
  }
}

output "nsg_ids" {
  value = {
    for k, v in azurerm_network_security_group.nsg : k => v.id
  }
}

output "nsg_names" {
  value = {
    for k, v in azurerm_network_security_group.nsg : k => v.name
  }
}
