output "security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}
output "root_target_group_arn" {
  value = aws_lb_target_group.root.arn
}

output "images_target_group_arn" {
  value = aws_lb_target_group.images.arn
}

output "register_target_group_arn" {
  value = aws_lb_target_group.register.arn
}
