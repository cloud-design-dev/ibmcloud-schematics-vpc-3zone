variable "vpc_name" {
  type    = string
  default = ""
}

variable "resource_group_name" {
  type        = string
  description = "Default resource group where resources will be deployed."
  default     = ""
}

variable "network_id" {
  type        = string
  description = "Instance Network ID for fip."
  default     = ""
}

