output "cognitive_account_id" {
  value = azurerm_cognitive_account.openai.id
}

output "search_service_id" {
  value = azurerm_search_service.search.id
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}
