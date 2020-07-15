resource "ibm_is_public_gateway" "bastion_public_gateway" {
  name           = "z1-${var.vpc_name}-gw"
  resource_group = data.ibm_resource_group.default.id
  vpc            = data.ibm_is_vpc.vpc.id
  zone           = var.zone
  tags           = [var.zone, var.vpc_name]
}

resource "ibm_is_subnet" "bastion_subnet" {
  name            = "z1-${var.vpc_name}-bastion-subnet"
  resource_group  = data.ibm_resource_group.default.id
  vpc             = data.ibm_is_vpc.vpc.id
  zone            = var.zone
  ipv4_cidr_block = "10.240.0.0/28"
  public_gateway  = ibm_is_public_gateway.bastion_public_gateway.id
}

resource "ibm_is_subnet" "private_subnet" {
  name            = "z1-${var.vpc_name}-private-subnet"
  resource_group  = data.ibm_resource_group.default.id
  vpc             = data.ibm_is_vpc.vpc.id
  zone            = var.zone
  ipv4_cidr_block = "10.240.1.0/24"
  public_gateway  = ibm_is_public_gateway.bastion_public_gateway.id
}

resource "ibm_is_security_group" "z1_bastion_sg" {
  name           = "z1-bastion-sg"
  resource_group = data.ibm_resource_group.default.id
  vpc            = data.ibm_is_vpc.vpc.id
}

resource "ibm_is_security_group" "z1_private_sg" {
  name           = "z1-private-sg"
  resource_group = data.ibm_resource_group.default.id
  vpc            = data.ibm_is_vpc.vpc.id
}


resource "ibm_is_security_group_rule" "z1_bastion_sg_icmp" {
  depends_on = [ibm_is_security_group.z1_bastion_sg]
  group      = ibm_is_security_group.z1_bastion_sg.id
  direction  = "inbound"
  remote     = "0.0.0.0/0"
  icmp {
    type = 8
  }
}

resource "ibm_is_security_group_rule" "z1_bastion_sg_ssh_inbound" {
  depends_on = [ibm_is_security_group.z1_bastion_sg]
  group      = ibm_is_security_group.z1_bastion_sg.id
  direction  = "inbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = "22"
    port_max = "22"
  }
}

resource "ibm_is_security_group_rule" "z1_bastion_sg_tcp_update_outbound" {
  depends_on = [ibm_is_security_group.z1_bastion_sg]
  group      = ibm_is_security_group.z1_bastion_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = "80"
    port_max = "80"
  }
}

resource "ibm_is_security_group_rule" "z1_bastion_sg_https_update_outbound" {
  depends_on = [ibm_is_security_group.z1_bastion_sg]
  group      = ibm_is_security_group.z1_bastion_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = "443"
    port_max = "443"
  }
}

resource "ibm_is_security_group_rule" "z1_bastion_sg_tcp_dns_outbound" {
  depends_on = [ibm_is_security_group.z1_bastion_sg]
  group      = ibm_is_security_group.z1_bastion_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = "53"
    port_max = "53"
  }
}

resource "ibm_is_security_group_rule" "z1_bastion_sg_udp_dns_outbound" {
  depends_on = [ibm_is_security_group.z1_bastion_sg]
  group      = ibm_is_security_group.z1_bastion_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = "53"
    port_max = "53"
  }
}

resource "ibm_is_security_group_rule" "z1_private_sg_tcp_dns_outbound" {
  depends_on = [ibm_is_security_group.z1_private_sg]
  group      = ibm_is_security_group.z1_private_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = "53"
    port_max = "53"
  }
}

resource "ibm_is_security_group_rule" "z1_private_sg_udp_dns_outbound" {
  depends_on = [ibm_is_security_group.z1_private_sg]
  group      = ibm_is_security_group.z1_private_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  udp {
    port_min = "53"
    port_max = "53"
  }
}

resource "ibm_is_security_group_rule" "z1_private_sg_tcp_http_outbound" {
  depends_on = [ibm_is_security_group.z1_private_sg]
  group      = ibm_is_security_group.z1_private_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = "80"
    port_max = "80"
  }
}

resource "ibm_is_security_group_rule" "z1_private_sg_tcp_https_outbound" {
  depends_on = [ibm_is_security_group.z1_private_sg]
  group      = ibm_is_security_group.z1_private_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = "443"
    port_max = "443"
  }
}


resource "ibm_is_security_group_rule" "z1_private_sg_ssh_inbound" {
  depends_on = [ibm_is_security_group.z1_private_sg]
  group      = ibm_is_security_group.z1_private_sg.id
  direction  = "inbound"
  remote     = ibm_is_security_group.z1_bastion_sg.id
  tcp {
    port_min = "22"
    port_max = "22"
  }
}