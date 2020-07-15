output "bastion_floatingip" {
  value = ibm_is_floating_ip.bastion_floatingip.address
}