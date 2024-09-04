resource "azurerm_cognitive_account" "openai" {
  name                = var.accounts_myprojopenai01_name
  resource_group_name = azurerm_resource_group.example.name
  location            = "Australia East"
  sku_name            = "S0"
  kind                = "OpenAI"

  properties {
    custom_sub_domain_name = var.accounts_myprojopenai01_name
    network_acls {
      default_action = "Allow"
    }
    public_network_access = "Enabled"
  }
}

resource "azurerm_cognitive_account_defender_for_ai_settings" "openai_defender" {
  name                = "${var.accounts_myprojopenai01_name}/Default"
  resource_group_name = azurerm_resource_group.example.name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  properties {
    state = "Disabled"
  }
}

resource "azurerm_cognitive_account_deployment" "gpt_35_turbo" {
  name                = "${var.accounts_myprojopenai01_name}/gpt-35-turbo-16k"
  resource_group_name = azurerm_resource_group.example.name
  cognitive_account_id = azurerm_cognitive_account.openai.id
  sku_name            = "Standard"
  capacity            = 5

  properties {
    model {
      format = "OpenAI"
      name   = "gpt-35-turbo-16k"
      version = "0613"
    }
    version_upgrade_option = "OnceCurrentVersionExpired"
    current_capacity       = 5
    rai_policy_name        = "Microsoft.DefaultV2"
  }
}

resource "azurerm_cognitive_account_deployment" "text_embedding" {
  name                = "${var.accounts_myprojopenai01_name}/text-embedding-ada-002"
  resource_group_name = azurerm_resource_group.example.name
  cognitive_account_id = azurerm_cognitive_account.openai.id
  sku_name            = "Standard"
  capacity            = 120

  properties {
    model {
      format = "OpenAI"
      name   = "text-embedding-ada-002"
      version = "2"
    }
    version_upgrade_option = "OnceCurrentVersionExpired"
    current_capacity       = 120
    rai_policy_name        = "Microsoft.DefaultV2"
  }
}

resource "azurerm_cognitive_account_rai_policy" "default_policy" {
  name                = "${var.accounts_myprojopenai01_name}/Microsoft.Default"
  resource_group_name = azurerm_resource_group.example.name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  properties {
    mode = "Blocking"
    content_filters {
      name                = "Hate"
      allowed_content_level = "Medium"
      blocking             = true
      enabled              = true
      source               = "Prompt"
    }
    # Add other content filters similarly...
  }
}

resource "azurerm_cognitive_account_rai_policy" "default_v2_policy" {
  name                = "${var.accounts_myprojopenai01_name}/Microsoft.DefaultV2"
  resource_group_name = azurerm_resource_group.example.name
  cognitive_account_id = azurerm_cognitive_account.openai.id

  properties {
    mode = "Blocking"
    content_filters {
      name                = "Hate"
      allowed_content_level = "Medium"
      blocking             = true
      enabled              = true
      source               = "Prompt"
    }
    # Add other content filters similarly...
  }
}
