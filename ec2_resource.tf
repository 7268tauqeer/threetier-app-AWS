



#--------------- private key------------------
resource "aws_key_pair" "webapp_auth" {
  key_name   = var.keyname
  public_key = file(var.public_key_path)
}

#-------------- Dev EC2 instance -------------

resource "aws_instance" "webapp_dev" {
  instance_type = var.dev_instance_type
  ami           = data.aws_ami.latest-amazon-ami.id

  tags = {
    Name = "webapp_dev"
    Env = "Dev"
  }

  key_name               = aws_key_pair.webapp_auth.id
  vpc_security_group_ids = [aws_security_group.webapp_dev_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.s3access_profile.id
  subnet_id              = aws_subnet.webapp_public1_subnet.id

  
  
  provisioner "local-exec" {
  command = <<EOD
cat <<EOF > aws_hosts 
[dev] 
${aws_instance.webapp_dev.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=${var.private_key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'

EOF
EOD
}



}