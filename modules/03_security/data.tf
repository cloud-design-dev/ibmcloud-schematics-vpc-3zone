data "ibm_resource_group" "default_rg" {
  name = var.resource_group
}

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}