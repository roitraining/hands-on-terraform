resource "aws_elb" "elb" {
  name = "${var.project}-elb"
  security_groups = [var.allow_http_id]
  subnets = [var.subnet_a_id, var.subnet_b_id]
  cross_zone_load_balancing = true

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}