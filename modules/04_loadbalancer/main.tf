resource "ibm_is_lb" "private_instance_lb" {
  name           = "${var.vpc_name}-private-instance-lb"
  subnets        = [var.subnet]
  resource_group = data.ibm_resource_group.default.id
  type           = "private"
  tags           = [var.vpc_name]
}


resource "ibm_is_lb_listener" "private_instance_listener" {
  lb         = ibm_is_lb.private_instance_lb.id
  port       = "80"
  protocol   = "http"
  depends_on = [ibm_is_lb.private_instance_lb]
}

resource "ibm_is_lb_pool" "private_instance_pool" {
  lb                 = ibm_is_lb.private_instance_lb.id
  name               = "${var.vpc_name}-private-instance-pool"
  protocol           = "http"
  algorithm          = "round_robin"
  health_delay       = "5"
  health_retries     = "2"
  health_timeout     = "2"
  health_type        = "http"
  health_monitor_url = "/"
  depends_on         = [ibm_is_lb_listener.private_instance_listener]
}

resource "ibm_is_lb_pool_member" "private_instance_pool_member_zone" {
  count          = var.instance_count
  lb             = ibm_is_lb.private_instance_lb.id
  pool           = ibm_is_lb_pool.private_instance_pool.id
  port           = "80"
  target_address = element(var.instance_ip, count.index)
  depends_on     = [ibm_is_lb_pool.private_instance_pool]
}

resource "ibm_is_lb_listener_policy" "lb_listener_policy" {
  lb        = ibm_is_lb.private_instance_lb.id
  listener  = ibm_is_lb_listener.private_instance_listener.listener_id
  action    = "forward"
  priority  = 1
  name      = "${var.vpc_name}-listener-policy"
  target_id = ibm_is_lb_pool.private_instance_pool.id
}

resource "ibm_is_lb_listener_policy_rule" "lb_listener_policy_rule" {
  lb        = ibm_is_lb.private_instance_lb.id
  listener  = ibm_is_lb_listener.private_instance_listener.listener_id
  policy    = ibm_is_lb_listener_policy.lb_listener_policy.policy_id
  condition = "equals"
  type      = "path"
  value     = "/"
}