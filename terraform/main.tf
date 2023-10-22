
resource "azurerm_storage_account" "example-adding-storage" {
  location                 = "eastus"
  name                     = "examplestorageaccount"
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.example-adding.name
  account_tier             = "Standard"
  lifecycle {
    precondition {
      condition     = azurerm_resource_group.example-adding.location == "eastus"
      error_message = "The selected resource group must be located in the eastus region."
    }

    postcondition {
      condition     = self.id != ""
      error_message = "The storage account was not created successfully."
    }
  }
}

resource "azurerm_resource_group" "example-adding" {
  name     = "adding-resource-group"
  location = "eastus" // change this to "northeurope" to see the error

}

terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.46.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "terraformdemostatefiles"
    container_name       = "terraform-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
