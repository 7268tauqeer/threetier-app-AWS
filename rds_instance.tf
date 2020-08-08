#---------RDS instance-----------

resource "aws_db_instance" "webapp_db" {
  allocated_storage      = 8
  engine                 = "mysql"
  engine_version         = var.my_sql_version
  instance_class         = var.db_instance_class
  name                   = var.dbname
  username               = var.dbuser
  password               = var.dbpassword
  db_subnet_group_name   = aws_db_subnet_group.webapp_rds_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.webapp_rds_sg.id]
  skip_final_snapshot    = true
#  backup_retention_period = var.backup_retention_period
#  apply_immediately = "true"
  #final_snapshot_identifier = "foo"
  depends_on= [aws_instance.webapp_dev]
  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > db_info.yml 
rds_endpoint : ${aws_db_instance.webapp_db.address}
EOF
EOD
  }

    provisioner "local-exec" {
    command = "ansible-playbook -i aws_hosts initialize_db.yml"
  }

  
}

resource "null_resource" "initialize_webapp" {
  depends_on=[aws_instance.webapp_dev,aws_db_instance.webapp_db]
  provisioner "local-exec" {
    command = "ansible-playbook -i aws_hosts node_crud.yml"
    
  }
}



#----- RDS replica-----------

#resource "aws_db_instance" "webapp_db_replica" { 
#  allocated_storage      = 8
#  engine                 = "mysql"
#  engine_version         = "5.6.27"
#  instance_class         = var.db_instance_class
#  name                   = var.dbname
#  username               = var.dbuser
#  password               = var.dbpassword
#  #db_subnet_group_name   = aws_db_subnet_group.webapp_rds_subnetgroup.name
#  vpc_security_group_ids = [aws_security_group.webapp_rds_sg.id]
#  skip_final_snapshot    = true
#  replicate_source_db = aws_db_instance.webapp_db.id
#  backup_retention_period = var.backup_retention_period
#  depends_on = [aws_db_instance.webapp_db]
#  #final_snapshot_identifier = "foo"
   
#}


