variable "vpc_name" {
  description = "Name of the VPC to create."
  type        = string
  default     = "test"
}

variable "zone" {
  type        = string
  description = "Zone where resources will be deployed."
  default     = ""
}

variable "resource_group" {
  type        = string
  description = "Default resource group where resources will be deployed."
  default     = ""
}
