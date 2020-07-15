resource "ibm_is_floating_ip" "bastion_floatingip" {
  resource_group = data.ibm_resource_group.default.id
  name           = "z1-${var.vpc_name}-bastion-fip"
  target         = var.network_id
}