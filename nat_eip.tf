# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  count = 1

  tags = {
    Name        = "${var.vpc_name}-nat-eip-${count.index + 1}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }
  depends_on = [aws_instance.private_instance]
}

# Create NAT Gateway in a Public Subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip[0].id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name        = "${var.vpc_name}-nat-gateway"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }
  depends_on = [aws_instance.private_instance]
}

