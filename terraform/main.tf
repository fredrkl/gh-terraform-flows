provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "storage" {
  location                 = "eastus"
  name                     = "examplestorageaccount"
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.example.name
  account_tier             = "Standard"
  lifecycle {
    precondition {
      condition     = azurerm_resource_group.example.location == "eastus"
      error_message = "The selected resource group must be located in the eastus region."
    }

    postcondition {
      condition     = self.id != ""
      error_message = "The storage account was not created successfully."
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "${var.name_prefix}-tf-workflowgroup"
  location = var.location // change this to "northeurope" to see the error
}

check "storage_account_name_is_valid" {
  assert {
    condition     = substr(azurerm_storage_account.storage.name, 0, 7) == "example"
    error_message = "The storage account name must be between 3 and 24 characters and contain only lowercase letters and numbers."
  }

}

resource "azurerm_container_registry" "example" {
  name                = "example-registry"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Basic"
  admin_enabled       = false

  network_rule_set {
    default_action = "Deny"
  }
}

#check "resource_group_is_up" {
#  assert {
#    condition     = azurerm_resource_group.example.id != ""
#    error_message = "${azurerm_resource_group.example.name} is up and running"
#  }
#}

terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.77.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "terraformdemostatefiles"
    container_name       = "terraform-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
