variable "location" {
  description = "Location for all infrastructure"
  default     = "westeurope"
}

variable "resourcegroups" {
  type = "map"
}
