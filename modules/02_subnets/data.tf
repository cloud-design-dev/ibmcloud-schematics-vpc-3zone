data "ibm_is_zones" "regional_zones" {
  region = var.region
}

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

data "ibm_resource_group" "default_rg" {
  name = var.resource_group
}