provider "azurerm" {
  features {}
}

#resource "azurerm_resource_group" "example" {
#  name     = "example-resource-group"
#  location = "eastus"
#}
# Another comment to invalidate the cache

resource "azurerm_resource_group" "example-adding" {
  name     = "adding-resource-group"
  location = "eastus"

  lifecycle {
    precondition {
      condition     = self.location == "centralus"
      error_message = "The resource group must be located in the eastus region."
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "terraformdemostatefiles"
    container_name       = "terraform-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
