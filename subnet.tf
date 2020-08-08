#------------------- Subnets------------------------
resource "aws_subnet" "webapp_public1_subnet" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = var.cidrs["public1"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "webapp_public1"
  }
}

resource "aws_subnet" "webapp_public2_subnet" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = var.cidrs["public2"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "webapp_public1"
  }
}

resource "aws_subnet" "webapp_private1_subnet" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = var.cidrs["private1"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "webapp_private1"
  }
}

resource "aws_subnet" "webapp_private2_subnet" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = var.cidrs["private2"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "webapp_private2"
  }
}