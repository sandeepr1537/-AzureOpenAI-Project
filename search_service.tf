resource "azurerm_search_service" "search" {
  name                = var.searchServices_myprosearch01_name
  resource_group_name = azurerm_resource_group.example.name
  location            = "Australia East"
  sku                 = "basic"
  replica_count       = 1
  partition_count     = 1
  hosting_mode        = "Default"
  public_network_access = "Enabled"

  encryption_with_cmk {
    enforcement = "Unspecified"
  }
}
