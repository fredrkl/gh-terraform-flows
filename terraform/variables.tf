variable "location" {
  type        = string
  description = "The location for the resource group."

  validation {
    condition     = range("eastus", "northeurope")
    error_message = "The location must be between eastus and westus."
  }
}
