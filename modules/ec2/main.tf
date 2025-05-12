resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)
  security_groups = [var.alb_security_group_id]
  associate_public_ip_address = true

  
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo 'Hello from EC2 instance ${count.index + 1}' > /var/www/html/index.html
              
              mkdir -p /var/www/html/images
              echo 'Hello from /images path on EC2 instance ${count.index + 1}' > /var/www/html/images/index.html
              
              mkdir -p /var/www/html/register
              echo 'Hello from /register path on EC2 instance ${count.index + 1}' > /var/www/html/register/index.html

              systemctl start nginx
              systemctl enable nginx
              EOF
  tags = {
    Name = "WebServer-${count.index + 1}"
  }
}
