resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)
  security_groups = [var.alb_security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              echo 'Hello from EC2 instance ${count.index + 1}' > /var/www/html/index.html
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "WebServer-${count.index + 1}"
  }
}
