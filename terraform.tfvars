aws_profile = "test_profile"
aws_region = "us-west-1"
vpc_cidr = "10.0.0.0/16"
cidrs			= {
  public1  = "10.0.1.0/24"
  public2  = "10.0.2.0/24"
  private1 = "10.0.3.0/24"
  private2 = "10.0.4.0/24"
  rds1	   = "10.0.5.0/24"
  rds2     = "10.0.6.0/24"
  rds3     = "10.0.7.0/24"
}

localip= "106.51.30.241/32"
bucket_prefix = "test-webapp"

db_instance_class	= "db.t2.micro"
my_sql_version = "8.0.17"
backup_retention_period = "7"
dbname			= "webappdb"
keyname = "monolith"
public_key_path = "../keys/monolith.pub"
private_key_path = "../keys/monolith.pem"


dev_instance_type = "t2.micro"

elb_prefix = "test-webapp"
elb_healthy_threshold   = "2"
elb_unhealthy_threshold = "2"
elb_timeout 		= "3"
elb_interval		= "30"

prod-lc_instance_type = "t2.micro"

asg_max 		= "2"
asg_min			= "1"
asg_grace		= "300"
asg_hct			= "EC2"
asg_cap			= "2"
