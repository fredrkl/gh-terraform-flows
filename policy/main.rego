package main

deny[msg] {
  # The setup
  resource := input.resource_changes[_].change.after.name

  # The test
  resource == "adding-resource-group"
  msg = "You cannot add a resource group"
}
