variable "instance_ip" {
  default = []
  type    = list

}

variable "vpc_name" {
  type    = string
  default = ""
}

variable "instance_count" {
  type    = string
  default = ""
}


variable "resource_group_name" {
  description = ""
  type        = string
  default     = ""
}

variable "subnet" {
  description = ""
  type        = string
  default     = ""
}