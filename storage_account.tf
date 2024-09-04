resource "azurerm_storage_account" "storage" {
  name                     = var.storageAccounts_myprojstor01_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = "Australia East"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
  allow_blob_public_access = true

  network_rules {
    default_action = "Allow"
  }

  encryption {
    services {
      blob {
        enabled = true
      }
      file {
        enabled = true
      }
    }
    key_source = "Microsoft.Storage"
  }

  access_tier = "Hot"
}

resource "azurerm_storage_container" "margies_travel" {
  name                  = "margies-travel"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}
