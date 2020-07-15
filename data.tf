data "ibm_resource_group" "default_rg" {
  name = var.resource_group
}

data "ibm_is_ssh_key" "ssh_key" {
  name = var.ssh_key_name
}


data "ibm_is_zones" "regional_zones" {
  region = var.region
}