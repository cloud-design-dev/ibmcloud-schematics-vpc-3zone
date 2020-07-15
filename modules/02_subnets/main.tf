resource "ibm_is_vpc_address_prefix" "z1_prefix" {
  name = "z1-prefix"
  zone = data.ibm_is_zones.regional_zones.zones[0]
  vpc  = data.ibm_is_vpc.vpc.id
  cidr = "192.168.0.0/18"
}

resource "ibm_is_vpc_address_prefix" "z2_prefix" {
  name = "z2-prefix"
  zone = data.ibm_is_zones.regional_zones.zones[1]
  vpc  = data.ibm_is_vpc.vpc.id
  cidr = "192.168.64.0/18"
}

resource "ibm_is_vpc_address_prefix" "z3_prefix" {
  name = "z3-prefix"
  zone = data.ibm_is_zones.regional_zones.zones[2]
  vpc  = data.ibm_is_vpc.vpc.id
  cidr = "192.168.128.0/18"
}

resource "ibm_is_public_gateway" "z1_public_gateway" {
  name           = "z1-pgw"
  resource_group = data.ibm_resource_group.default_rg.id
  vpc            = data.ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[0]
  tags           = [data.ibm_is_zones.regional_zones.zones[0], "ryantiffany", var.vpc_name]
}

resource "ibm_is_public_gateway" "z2_public_gateway" {
  name           = "z2-pgw"
  resource_group = data.ibm_resource_group.default_rg.id
  vpc            = data.ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[1]
  tags           = [data.ibm_is_zones.regional_zones.zones[1], "ryantiffany", var.vpc_name]
}

resource "ibm_is_public_gateway" "z3_public_gateway" {
  name           = "z3-pgw"
  resource_group = data.ibm_resource_group.default_rg.id
  vpc            = data.ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[2]
  tags           = [data.ibm_is_zones.regional_zones.zones[3], "ryantiffany", var.vpc_name]
}

resource "ibm_is_subnet" "zone1_bastion_subnet" {
  name                     = "z1-bastion-subnet"
  resource_group           = data.ibm_resource_group.default_rg.id
  vpc                      = data.ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.regional_zones.zones[0]
  public_gateway           = ibm_is_public_gateway.z1_public_gateway.id
  total_ipv4_address_count = "28"
}

resource "ibm_is_subnet" "zone2_bastion_subnet" {
  name                     = "z2-bastion-subnet"
  resource_group           = data.ibm_resource_group.default_rg.id
  vpc                      = data.ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.regional_zones.zones[1]
  public_gateway           = ibm_is_public_gateway.z2_public_gateway.id
  total_ipv4_address_count = "28"
}

resource "ibm_is_subnet" "zone3_bastion_subnet" {
  name                     = "z3-bastion-subnet"
  resource_group           = data.ibm_resource_group.default_rg.id
  vpc                      = data.ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.regional_zones.zones[2]
  public_gateway           = ibm_is_public_gateway.z3_public_gateway.id
  total_ipv4_address_count = "28"
}