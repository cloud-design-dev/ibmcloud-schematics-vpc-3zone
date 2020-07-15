output "vpc_name" {
  value = module.vpc.name
}

output "bastion_floatingip" {
  value = module.floating_ip.bastion_floatingip
}

output "web_1_ip" {
  value = module.web_instances.instance_ip[0]
}

output "web_2_ip" {
  value = module.web_instances.instance_ip[1]
}

output "web_3_ip" {
  value = module.web_instances.instance_ip[2]
}