#--------------- Route Table ---------------
resource "aws_route_table" "webapp_public_route" {
  vpc_id = aws_vpc.webapp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.webapp_internet_gateway.id
  }
  tags = {
    Name = "webapp_public_rt"
  }
}

resource "aws_default_route_table" "webapp_private_route" {
  default_route_table_id = aws_vpc.webapp_vpc.default_route_table_id
  tags = {
    Name = "webapp_private_rt"
  }
}

# Subnet Associations

resource "aws_route_table_association" "webapp_public_assoc" {
  subnet_id      = aws_subnet.webapp_public1_subnet.id
  route_table_id = aws_route_table.webapp_public_route.id
}

resource "aws_route_table_association" "webapp_public2_assoc" {
  subnet_id      = aws_subnet.webapp_public2_subnet.id
  route_table_id = aws_route_table.webapp_public_route.id
}

resource "aws_route_table_association" "webapp_private1_assoc" {
  subnet_id      = aws_subnet.webapp_private1_subnet.id
  route_table_id = aws_default_route_table.webapp_private_route.id
}

resource "aws_route_table_association" "webapp_private2_assoc" {
  subnet_id      = aws_subnet.webapp_private2_subnet.id
  route_table_id = aws_default_route_table.webapp_private_route.id
}