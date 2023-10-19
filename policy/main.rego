package main

deny[msg] {
  # The setup
  resource := input.resource_changes[_].change.after.name

  # The test
  resource == "adding-resource-group"
  msg = "You cannot add a resource group"
}

deny[msg] {
  resource_location := input.planned_values.root_module.resources[_].values.location
  resource_location == "eastus"

  msg = "You cannot create resources in westus"
}
