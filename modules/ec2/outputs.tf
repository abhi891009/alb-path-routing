output "instance_ids" {
  description = "ID of the EC2 instances"
  value       = aws_instance.web[*].id
}