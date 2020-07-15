resource "ibm_is_instance" "instance" {
  name    = "${var.zone}-bastion"
  image   = data.ibm_is_image.default.id
  profile = var.default_instance_profile

  primary_network_interface {
    subnet = var.subnet
  }

  resource_group = data.ibm_resource_group.default_rg.id
  tags           = [var.vpc_name, var.zone]

  vpc       = data.ibm_is_vpc.vpc.id
  zone      = var.zone
  keys      = [var.ssh_key]
  user_data = file("${path.module}/install.yml")
}


