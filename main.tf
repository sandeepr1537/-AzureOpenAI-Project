resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Australia East"
}

# Include all other .tf files
