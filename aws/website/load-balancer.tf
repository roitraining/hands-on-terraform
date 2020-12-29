resource "aws_lb" "load_balancer" {
  name               = "${var.project}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-http.id]
  subnets            = [aws_subnet.subnet-a.id, aws_subnet.subnet-b.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.project}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
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
  target_id        = aws_instance.vm[count.index].id
  port             = 80
}

output "load_balancer_address" {
  value       = aws_lb.load_balancer.dns_name
  description = "The DNS name for the Load Balancer."
}
