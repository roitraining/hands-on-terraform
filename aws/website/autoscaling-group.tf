# ------------------------
# Launch Template
# ------------------------
resource "aws_launch_template" "web_template" {
  name_prefix   = "${var.project}-lt-"
  image_id      = var.image_id[var.region]
  instance_type = var.instance_type

  user_data = filebase64("install_space_invaders.sh")

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [
      aws_security_group.allow-http.id,
      aws_security_group.allow-ssh.id
    ]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project}-webserver"
    }
  }
}

# ------------------------
# Auto Scaling Group
# ------------------------
resource "aws_autoscaling_group" "web_asg" {
  name                      = "${var.project}-asg"
  max_size                  = var.instance_count_max
  min_size                  = var.instance_count_min
  desired_capacity          = var.instance_count_min
  vpc_zone_identifier       = [aws_subnet.subnet-a.id, aws_subnet.subnet-b.id]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web_tg.arn]

  tag {
    key                 = "Name"
    value               = "${var.project}-webserver"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}







