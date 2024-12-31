# EC2 Instance in Public Subnet
resource "aws_instance" "public_instance" {
  ami                         = "ami-005fc0f236362e99f"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet[0].id
  security_groups             = [aws_security_group.test_sg.id]
  associate_public_ip_address = true
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
    # prevent_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              # Update and install Nginx
              yum update -y
              amazon-linux-extras enable nginx1
              yum install -y nginx
              
              # Start Nginx service
              systemctl start nginx
              systemctl enable nginx
              
              # Remove default index.html
              rm -f /usr/share/nginx/html/index.html
              
              # Create a custom index.html with the server name
              echo "<html>
              <head><title>Welcome to "${var.vpc_name}-public-instance"</title></head>
              <body>
              <h1>Server Name: "${var.vpc_name}-public-instance"</h1>
              </body>
              </html>" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name        = "${var.vpc_name}-public-instance"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }
}

