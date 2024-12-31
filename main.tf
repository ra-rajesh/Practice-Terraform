
# Configure the AWS Provider
provider "aws" {
  region = var.region_name
}

# # Configure the AWS S3 under rajesh_rajendiran
# terraform {
#   backend "s3" {
#     bucket = "vpc-s3-task"
#     key    = "base-file"
#     region = "us-east-1"
#   }
# }


# Create a VPC
resource "aws_vpc" "testing" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  instance_tenancy     = "default"

  tags = {
    Name        = var.vpc_name
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.testing.id

  tags = {
    Name        = "${var.vpc_name}-igw"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.environment
  }

}

