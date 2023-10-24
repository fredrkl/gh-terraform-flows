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
    condition     = azurerm_resource_group.example.name == "test_"
    error_message = "S3 bucket name did not match expected"
  }
}
