output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "alb_security_group_id" {
  value = module.alb.security_group_id
}

output "ec2_instance_ids" {
  value = module.ec2.instance_ids
}
