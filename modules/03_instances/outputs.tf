output "instance_ip" {
  value = ibm_is_instance.instance[*].primary_network_interface[0].primary_ipv4_address
}

output "instance_interfaces" {
  value = ibm_is_instance.instance[*].primary_network_interface[0].id
}