resource "ibm_is_instance" "instance" {
  count   = var.instance_count
  name    = "${var.vpc_name}-${var.type}-${count.index + 1}"
  image   = data.ibm_is_image.default.id
  profile = var.default_instance_profile

  primary_network_interface {
    subnet          = var.subnet
    security_groups = [var.security_group]
  }

  resource_group = data.ibm_resource_group.default.id
  tags           = [var.vpc_name, var.zone, var.type]

  vpc       = data.ibm_is_vpc.vpc.id
  zone      = var.zone
  keys      = [var.ssh_key]
  user_data = file("${path.module}/install.yml")
}


