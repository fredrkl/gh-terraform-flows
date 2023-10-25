provider "azurerm" {
  features {}
}

variables {
  name_prefix = "test"
  location    = "eastus"
}

run "valid_resource_group" {

  command = plan

  assert {
    condition     = azurerm_resource_group.example.name == "test-tf-workflowgroup"
    error_message = "Resource group name is not as expected"
  }
}
