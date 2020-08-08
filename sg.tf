#-----------------SG----------------------

resource "aws_security_group" "webapp_dev_sg" {
  name        = "webapp_dev_sg"
  description = "Used for access to the dev instance"
  vpc_id      = aws_vpc.webapp_vpc.id

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.localip]
  }

  #HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.localip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#------------------- Public SG------------------
resource "aws_security_group" "webapp_public_sg" {
  name        = "webapp_public_sg"
  description = "Used for public and private instances for load balancer access"
  vpc_id      = aws_vpc.webapp_vpc.id

  #HTTP 

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outbound internet access

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#----------------Private SG--------------------------

resource "aws_security_group" "webapp_private_sg" {
  name        = "webapp_private_sg"
  description = "Used for private instances"
  vpc_id      = aws_vpc.webapp_vpc.id

  # Access from other security groups

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#--------------------RDS SG---------------------

#RDS Security Group
resource "aws_security_group" "webapp_rds_sg" {
  name        = "webapp_rds_sg"
  description = "Used for DB instances"
  vpc_id      = aws_vpc.webapp_vpc.id

  # SQL access from public/private security group

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    security_groups = [aws_security_group.webapp_dev_sg.id,
      aws_security_group.webapp_public_sg.id,
      aws_security_group.webapp_private_sg.id,
    ]
  }
}
