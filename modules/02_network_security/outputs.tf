output "bastion_subnet_id" {
  value = ibm_is_subnet.bastion_subnet.id
}

output "private_subnet_id" {
  value = ibm_is_subnet.private_subnet.id
}

output "bastion_security_group_id" {
  value = ibm_is_security_group.z1_bastion_sg.id
}

output "private_security_group_id" {
  value = ibm_is_security_group.z1_private_sg.id
}