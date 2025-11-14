variable "rgs" {
description = "Map of rg to create"
type        = map(object({
    name     = string
  location   = string
  managed_by = optional(string)
  tags       = optional(map(string))
  }))
}

  
