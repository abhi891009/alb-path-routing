terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source                     = "./modules/vpc"
  cidr_block                 = var.vpc_cidr
  public_subnet_count        = length(var.public_subnet_cidrs)
  public_subnet_cidr_blocks  = var.public_subnet_cidrs
  availability_zones         = var.availability_zones
}

module "alb" {
  source     = "./modules/alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  lb_name    = "alb-path-routing"
}

module "ec2" {
  source                = "./modules/ec2"
  instance_count        = 3
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  subnet_ids            = module.vpc.public_subnets
  alb_security_group_id = module.alb.security_group_id
}

module "asg_homepage" {
  source            = "./modules/asg"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  user_data         = file("scripts/homepage.sh")
  subnet_ids        = var.subnet_ids
  target_group_arns = [module.alb.homepage_target_group_arn]
  desired_capacity  = 1
  max_size          = 2
  min_size          = 1
}

module "asg_images" {
  source           = "./modules/asg"
  name             = "images-service"
  user_data        = file("${path.module}/scripts/user_data_images.sh")
  target_group_arn = aws_lb_target_group.images.arn
}

module "asg_register" {
  source           = "./modules/asg"
  name             = "register-service"
  user_data        = file("${path.module}/scripts/user_data_register.sh")
  target_group_arn = aws_lb_target_group.register.arn
}

