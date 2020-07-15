module "vpc" {
  source              = "./modules/01_vpc"
  vpc_name            = var.vpc_name
  resource_group_name = var.resource_group
  region              = var.region
}

module "subnets" {
  source              = "./modules/02_subnets"
  vpc_name            = module.vpc.name
  resource_group_name = var.resource_group_name
  zones               = data.ibm_is_zones.regional_zones.zones
}

module "security" {
  source              = "./modules/03_security"
  vpc_name            = module.vpc.name
  resource_group_name = var.resource_group_name
}

module "bastion_instance" {
  source              = "./modules/04_instances"
  vpc_name            = module.vpc.name
  resource_group_name = var.resource_group_name
  zone                = data.ibm_is_zones.regional_zones.zones[0]
}

module "floating_ip" {
  source              = "./modules/05_floating_ip"
  vpc_name            = module.vpc.name
  resource_group_name = var.resource_group_name
}