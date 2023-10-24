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
  name     = "terraform-workflowgroup"
  location = var.location // change this to "northeurope" to see the error
}

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

check "health_check" {
  assert {
    condition     = azurerm_resource_group.example.id != ""
    error_message = "${azurerm_resource_group.example.name} is up and running"
  }
}

## Example of a health check
#check "health_check" {
#  data "http" "terraform_io" {
#    url = "https://www.terraform.io"
#  }
#
#  assert {
#    condition     = data.http.terraform_io.status_code == 200
#    error_message = "${data.http.terraform_io.url} returned an unhealthy status code"
#  }
#}
