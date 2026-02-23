variable "location" {
  description = "Location for all infrastructure"
  default     = "westeurope"
}

variable "home_ip" {
  description = "Current IP - Open NSG for this IP"
}

variable "resourcegroups" {
  type = map(string)
}

variable "vnet_hub" {
  type = map(string)
}

variable "vnet_spoke" {
  type = map(string)
}

variable "vnet_hub_server" {
  type = map(string)
}
variable "vnet_hub_server_2" {
  type = map(string)
}

variable "vnet_spoke_server" {
  type = map(string)
}

variable "jumphost" {
  type = map(string)
}

variable "automationaccount" {
  type = map(string)
}

variable "loganalytics" {
  type = map(string)
}