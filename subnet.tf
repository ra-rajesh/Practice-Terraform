resource "aws_subnet" "public_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.testing.id
  cidr_block              = element(var.sn_cidr_public, count.index)
  availability_zone       = element(var.sn_az_public, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name        = "${var.vpc_name}-public_subnet-${count.index + 1}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }
}


resource "aws_subnet" "private_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.testing.id
  cidr_block              = element(var.sn_cidr_private, count.index)
  availability_zone       = element(var.sn_az_private, count.index)
  map_public_ip_on_launch = "false"

  tags = {
    Name        = "${var.vpc_name}-private_subnet-${count.index + 1}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }
}
