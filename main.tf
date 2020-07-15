module "vpc" {
  source         = "./modules/01_vpc"
  vpc_name       = var.vpc_name
  resource_group = var.resource_group
  region         = var.region
}

module "subnets" {
  source         = "./modules/02_subnets"
  vpc_name       = module.vpc.name
  resource_group = var.resource_group
  region         = var.region
}

# module "security" {
#   source              = "./modules/03_security"
#   vpc_name            = module.vpc.name
#   resource_group_name = var.resource_group
# }

module "zone1_bastion_instance" {
  source         = "./modules/04_instances"
  vpc_name       = module.vpc.name
  resource_group = var.resource_group
  zone           = data.ibm_is_zones.regional_zones.zones[0]
  subnet         = module.subnets.zone1_bastion_subnet
  ssh_key        = var.ssh_key
}

module "zone2_bastion_instance" {
  source         = "./modules/04_instances"
  vpc_name       = module.vpc.name
  resource_group = var.resource_group
  zone           = data.ibm_is_zones.regional_zones.zones[1]
  subnet         = module.subnets.zone2_bastion_subnet
  ssh_key        = var.ssh_key
}

module "zone3_bastion_instance" {
  source         = "./modules/04_instances"
  vpc_name       = module.vpc.name
  resource_group = var.resource_group
  zone           = data.ibm_is_zones.regional_zones.zones[2]
  subnet         = module.subnets.zone3_bastion_subnet
  ssh_key        = var.ssh_key
}

# module "floating_ip" {
#   source              = "./modules/05_floating_ip"
#   vpc_name            = module.vpc.name
#   resource_group_name = var.resource_group_name
# }