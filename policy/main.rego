package main

deny[msg] {
	# The setup
	resource := input.resource_changes[_].change.after.name

	# The test
	resource == "adding-resource-group"
	msg = "You cannot add a resource group named adding-resoruce-group"
}

deny[msg] {
	resource_location := input.planned_values.root_module.resources[_].values.location
	resource_location == "northcentralus"

	msg = "You cannot create resources in North Central US"
}
