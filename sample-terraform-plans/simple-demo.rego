## test/list-resources.rego
#
#package terraform
#
##import data.json
#
## List all resources that will get created in the Terraform plan
##list_resources(plan) {
##    # Unmarshal the Terraform plan from JSON data
##    parsed_plan := json.unmarshal(plan)
##
##    # Get the resource changes from the Terraform plan
##    resource_changes := parsed_plan.resource_changes[_]
##
##    # Loop through the resource changes and print the resource type and name for all resources that will be created
##    [resource.type, resource.name] := [change.type, change.name] {
##        change := resource_changes[_]
##        change.change.actions[_] == "delete"
##    }
##}
#
#deleted_resource = [res | 
#  res := input.resource_changes[_].change.actions[_]
#  res == "delete"
#]
#
#num_deleted_resource := count(deleted_resource)
#
#deny[msg] {
#  not num_deleted_resource == 1
#  msg := "there should be 1 deleted resource"
#}
#
