provider "azurerm" {
  features {}
}

#resource "azurerm_resource_group" "example" {
#  name     = "example-resource-group"
#  location = "eastus"
#}
# Another comment to invalidate the cache


#resource "azurerm_container_registry" "balbla" {
#  location = "eastus"
#  resource_group_name = azurerm_resource_group.example-adding.name
#  sku = "Basic"
#  name = "example-container-registry"
#  admin_enabled = true
#  lifecycle {
#    precondition {
#      condition     = self.location == "eastus"
#      error_message = "The resource group must be located in the eastus region."
#    }
#    postcondition {
#      condition = admin_enabled == false
#      error_message = "Admin must be enabled"
#    }
#  }
#}

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
  }
}

resource "azurerm_resource_group" "example-adding" {
  name     = "adding-resource-group"
  location = "northeurope"

}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "terraformdemostatefiles"
    container_name       = "terraform-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
