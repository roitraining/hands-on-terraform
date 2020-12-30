resource "aws_lb" "load_balancer" {
  name               = "${var.project}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.allow_http_id]
  subnets            = [var.subnet_a_id, var.subnet_b_id]

  enable_deletion_protection = false

  tags = {
    Project = var.project
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.project}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "servers" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}


