#----- Instance Profile for EC2 instance -----

# S3 access
resource "aws_iam_instance_profile" "s3access_profile" {
  name = "s3access_profile"
  role = aws_iam_role.s3access_role.name
}

resource "aws_iam_role" "s3access_role" {
  name = "s3access_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "s3access_policy" {
  name = "s3access_policy"
  role = aws_iam_role.s3access_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}