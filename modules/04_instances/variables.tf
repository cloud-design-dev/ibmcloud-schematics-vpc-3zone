variable "zone" {
  type        = string
  description = "Zone where resources will be deployed."
  default     = ""
}

variable "resource_group_name" {
  type        = string
  description = "Default resource group where resources will be deployed."
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC. This is used in the naming and tagging of resources."
  default     = ""
}

variable "default_instance_profile" {
  description = "Default size/type of compute instance"
  type        = string
  default     = "cx2-2x4"
}

variable "default_instance_image" {
  description = "Default OS image of compute instance"
  type        = string
  default     = "ibm-ubuntu-18-04-1-minimal-amd64-1"
}

variable "instance_count" {
  description = "Number of instances to deploy."
  type        = string
  default     = "1"
}

variable "ssh_key" {
  description = "ID of SSH key to add to instances."
  type        = string
  default     = ""
}

variable "subnet" {
  description = "ID of the subnet to use for instances."
  type        = string
  default     = ""

}

variable "security_group" {
  description = "ID of the security group to use for instances."
  type        = string
  default     = ""

}

variable "type" {
  description = "Type of instance. Used in naming of instances."
  type        = string
  default     = ""
}