variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the instances"
  type        = string
}

variable "user_data" {
  description = "User data script for the instances"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs for the ASG"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
}

