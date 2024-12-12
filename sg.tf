
resource "aws_security_group" "test_sg" {
  name        = "${var.vpc_name}-test-sg"
  description = "Allow SSH, HTTPS and HTTP traffic"
  vpc_id      = aws_vpc.testing.id

  dynamic "ingress" {
    for_each = var.ingress_service
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.vpc_name}-test-sg"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }
}
