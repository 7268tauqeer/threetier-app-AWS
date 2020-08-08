variable "aws_region" {}
variable "aws_profile" {}
variable "vpc_cidr" {
    default = "10.0.0.0/16" 
}
variable "localip" {}



data "aws_availability_zones" "available" {}

variable "cidrs" {
  type = map
}

variable "bucket_prefix" {}


variable "db_instance_class" {}
variable "my_sql_version" {}
variable "dbname" {}
variable "dbuser" {}
variable "dbpassword" {}
variable "backup_retention_period" {}

variable "keyname" {}
variable "public_key_path" {}
variable "private_key_path" {}

variable "dev_instance_type" {}

variable "elb_prefix" {}
variable "elb_healthy_threshold" {}
variable "elb_unhealthy_threshold" {}
variable "elb_timeout" {}
variable "elb_interval" {}

data "aws_ami" "latest-amazon-ami" {
most_recent = true
owners = ["amazon"] # Canonical

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "prod-lc_instance_type" {}

variable "asg_max" {}
variable "asg_min" {}
variable "asg_grace" {}
variable "asg_hct" {}
variable "asg_cap" {}
