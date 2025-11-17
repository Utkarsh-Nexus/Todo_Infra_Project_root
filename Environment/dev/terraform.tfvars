rgs = {
  dev = {
    name     = "rg-dev"
    location = "eastus"
    tags = {
      env = "dev"
    }
  }
}

storage_accounts = {
  appstore = {
    name                     = "appsa12345"
    resource_group_name      = "rg-dev"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      env = "dev"
    }
  }
}

networks = {
  hub = {
    name                = "hub-vnet"
    resource_group_name = "rg-dev"
    location            = "eastus"
    address_space       = ["10.0.0.0/16"]

    subnets = {
      web = {
        name             = "web-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      app = {
        name             = "app-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    }

    tags = {
      env = "dev"
    }
  }
}

asgs = {
  app_asg = {
    name                = "asg-app"
    resource_group_name = "rg-dev"
    location            = "eastus"
  }

  web_asg = {
    name                = "asg-web"
    resource_group_name = "rg-dev"
    location            = "eastus"
  }
}

nsgs = {
  web_nsg = {
    name                = "nsg-web"
    resource_group_name = "rg-dev"
    location            = "eastus"

    rules = {
      allow_http = {
        name                   = "Allow-HTTP"
        priority               = 100
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        destination_port_range = "80"

        # Link only to web ASG
        destination_asg_ids = ["web_asg"]

      }

      allow_app_to_db = {
        name                   = "Allow-App-To-DB"
        priority               = 200
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        destination_port_range = "1433"

        source_asg_ids = ["app_asg"]
      }
    }
  }
}
