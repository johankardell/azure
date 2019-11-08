variable "location" {
  description = "Location for all infrastructure"
  default     = "westeurope"
}

variable "home_ip" {
  description = "Current IP - Open NSG for this IP"
}

variable "resourcegroups" {
  type = "map"
}

variable "vnet_hub" {
    type = "map"
}

variable "vnet_spoke" {
    type = "map"
}

variable "vnet_hub_server" {
    type = "map"
}
variable "vnet_hub_server_2" {
    type = "map"
}

variable "vnet_spoke_server" {
    type = "map"
}

variable "jumphost" {
    type = "map"
}

variable "automationaccount" {
    type = "map"
}

variable "loganalytics" {
    type = "map"
}

variable "azurefirewall" {
    type = "map"
}