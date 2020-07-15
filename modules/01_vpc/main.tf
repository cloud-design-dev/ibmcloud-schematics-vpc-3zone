resource "ibm_is_vpc" "prod_vpc" {
  name                      = var.vpc_name
  resource_group            = data.ibm_resource_group.default.id
  address_prefix_management = "manual"
  tags                      = ["ryantiffany", var.vpc_name, var.region]
}