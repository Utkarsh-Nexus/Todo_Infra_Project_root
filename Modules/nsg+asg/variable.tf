# -------------------
# ASG INPUT
# -------------------
variable "asgs" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    tags                = optional(map(string))
  }))
}

# -------------------
# NSG INPUT
# -------------------
variable "nsgs" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string

    rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      destination_port_range     = string

      # Replace IDs → use list of ASG keys
      source_asgs      = optional(list(string))
      destination_asgs = optional(list(string))
    }))
  }))
}
