variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "East US"
}

variable "webapp_name" {
  type        = string
  description = "Web App Name"
}
