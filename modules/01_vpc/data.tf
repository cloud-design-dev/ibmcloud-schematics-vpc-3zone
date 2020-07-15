data "ibm_resource_group" "default" {
  name = var.resource_group_name
}

data "ibm_is_zones" "region_zones" {
  region = var.region
}
