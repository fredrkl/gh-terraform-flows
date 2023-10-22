variable "location" {
  type        = string
  description = "The location for the resource group."

  validation {
    condition     = contains(["eastus", "northeurope"], var.location)
    error_message = "The location must be between eastus and westus."
  }
}
