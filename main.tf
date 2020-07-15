module "vpc" {
  source              = "./modules/01_vpc"
  vpc_name            = var.vpc_name
  resource_group_name = var.resource_group_name
  region              = var.region
}

module "networking_security" {
  source              = "./modules/02_network_security"
  vpc_name            = module.vpc.name
  resource_group_name = var.resource_group_name
  zone                = module.vpc.zone1
}

module "bastion_instance" {
  source              = "./modules/03_instances"
  type                = "bastion"
  vpc_name            = module.vpc.name
  zone                = module.vpc.zone1
  resource_group_name = var.resource_group_name
  ssh_key             = data.ibm_is_ssh_key.ssh_key.id
  subnet              = module.networking_security.bastion_subnet_id
  security_group      = module.networking_security.bastion_security_group_id
}

module "web_instances" {
  source              = "./modules/03_instances"
  instance_count      = "3"
  type                = "web"
  vpc_name            = module.vpc.name
  zone                = module.vpc.zone1
  resource_group_name = var.resource_group_name
  ssh_key             = data.ibm_is_ssh_key.ssh_key.id
  subnet              = module.networking_security.private_subnet_id
  security_group      = module.networking_security.private_security_group_id
}

module "loadbalancer" {
  source              = "./modules/04_loadbalancer"
  instance_count      = "3"
  vpc_name            = module.vpc.name
  resource_group_name = var.resource_group_name
  instance_ip         = module.web_instances.instance_ip
  subnet              = module.networking_security.private_subnet_id
}

module "floating_ip" {
  source              = "./modules/05_floating_ip"
  vpc_name            = module.vpc.name
  resource_group_name = var.resource_group_name
  network_id          = module.bastion_instance.instance_interfaces[0]
}