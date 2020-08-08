#------------------S3 Endpoint------------------
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.webapp_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.s3"

  route_table_ids = [aws_vpc.webapp_vpc.main_route_table_id,
    aws_route_table.webapp_public_route.id,
  ]

  policy = <<EOF
{
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
EOF

  tags = {
    Environment = "s3_endpoint"
  }
}