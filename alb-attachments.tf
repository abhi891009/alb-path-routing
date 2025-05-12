resource "aws_lb_target_group_attachment" "root" {
  target_group_arn = module.alb.root_target_group_arn
  target_id        = module.ec2.instance_ids[0]
  port             = 80
}

resource "aws_lb_target_group_attachment" "images" {
  target_group_arn = module.alb.images_target_group_arn
  target_id        = module.ec2.instance_ids[1]
  port             = 80
}

resource "aws_lb_target_group_attachment" "register" {
  target_group_arn = module.alb.register_target_group_arn
  target_id        = module.ec2.instance_ids[2]
  port             = 80
}
