variable "region" {
  description = "The region where resources will be deployed."
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "The VPC where resources will be deployed."
  type        = string
  default     = ""
}

variable "resource_group" {
  description = "The Resource group where resources will be deployed."
  type        = string
  default     = ""
}
