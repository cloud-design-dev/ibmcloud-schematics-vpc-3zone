data "ibm_resource_group" "default" {
  name = var.resource_group_name
}

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}