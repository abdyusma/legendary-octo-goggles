data "azurerm_resource_group" "example" {
  name     = "rahman"
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    owner = "rahman"
  }
}

resource "azurerm_monitor_activity_log_alert" "main" {
  name                = "example-activitylogalert"
  resource_group_name = data.azurerm_resource_group.example.name
  scopes              = [data.azurerm_resource_group.example.id]
  description         = "This alert will monitor NSG updates."

  criteria {
    resource_id    = azurerm_network_security_group.example.id
    operation_name = "Microsoft.Network/networkSecurityGroups/write"
    category       = "Recommendation"
  }
}
