#-------- VPC --------

#VPC
resource "aws_vpc" "webapp_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "webapp_vpc"
  }
}

#IGW
resource "aws_internet_gateway" "webapp_internet_gateway" {
  vpc_id = aws_vpc.webapp_vpc.id
tags = {
    Name = "webapp_IGW"
  }
}