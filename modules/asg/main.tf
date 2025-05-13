resource "aws_launch_template" "example" {
  name_prefix   = "web-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = base64encode(file("${path.module}/user_data.sh"))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnet_ids
  target_group_arns    = var.target_group_arns

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  alb_target_group_arn   = var.target_group_arn
  vpc_security_group_ids = [var.alb_security_group_id]

}
