# Resource Group
# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "chatbot-poc-rg"
  location = "West US"
}

# Azure AD Application for Chatbot Authentication
resource "azuread_application" "chatbot_app" {
  display_name = "EnterpriseChatBotPOC"
  owners       = [var.azure_user_object_id]
  
  # Define Microsoft Graph permissions (Sites.Read.All, Files.Read.All)
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph API ID
    
    resource_access {
      id   = "b2a3adf0-2a24-4cd6-a2e2-2e7e62f56581" # Sites.Read.All
      type = "Scope"
    }
    
    resource_access {
      id   = "df85f4d6-205c-4ac5-a5ea-6bf408b1d367" # Files.Read.All
      type = "Scope"
    }
  }
}

# Azure AD Service Principal
resource "azuread_service_principal" "chatbot_sp" {
  client_id = azuread_application.chatbot_app.client_id # Corrected from application_id
}

# Client Secret for the Application

# Output the Client ID
output "chatbot_client_id" {
  value = azuread_application.chatbot_app.client_id # Corrected from application_id
}

