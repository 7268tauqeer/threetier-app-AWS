resource "aws_subnet" "webapp_rds1_subnet" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = var.cidrs["rds1"]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "webapp_rds1"
  }
}

resource "aws_subnet" "webapp_rds2_subnet" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = var.cidrs["rds2"]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "webapp_rds2"
  }
}

resource "aws_db_subnet_group" "webapp_rds_subnetgroup" {
  name = "webapp_rds_subnetgroup"

  subnet_ids = [aws_subnet.webapp_rds1_subnet.id,
    aws_subnet.webapp_rds2_subnet.id
  
  ]

  tags = {
    Name = "wp_rds_sng"
  }
}