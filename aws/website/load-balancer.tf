
# ------------------------
# Application Load Balancer
# ------------------------
resource "aws_lb" "web_alb" {
  name               = "${var.account}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-http.id]
  subnets            = [aws_subnet.subnet-a.id, aws_subnet.subnet-b.id]

}

# ------------------------
# Target Group
# ------------------------
resource "aws_lb_target_group" "web_tg" {
  name     = "${var.account}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    matcher             = "200"
  }
}

# ------------------------
# ALB Listener
# ------------------------
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
