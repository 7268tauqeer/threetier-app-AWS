#-------------------------ELB------------------------
resource "aws_elb" "webapp_elb" {
  name = "${var.elb_prefix}-elb"

  subnets = [aws_subnet.webapp_public1_subnet.id,
    aws_subnet.webapp_public2_subnet.id,
  ]

  security_groups = [aws_security_group.webapp_public_sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = var.elb_healthy_threshold
    unhealthy_threshold = var.elb_unhealthy_threshold
    timeout             = var.elb_timeout
    target              = "TCP:80"
    interval            = var.elb_interval
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.elb_prefix}-elb"
  }
}

#------------------------AGS------------------------

resource "random_id" "golden_ami" {
  byte_length = 8
}

resource "aws_ami_from_instance" "webapp_golden" {
  name               = "webapp_ami-${random_id.golden_ami.b64}"
  source_instance_id = "${aws_instance.webapp_dev.id}"
  depends_on = [aws_instance.webapp_dev,aws_db_instance.webapp_db, null_resource.initialize_webapp]

  
}
#launch configuration

resource "aws_launch_configuration" "webapp_lc" {
  name_prefix          = "webapp_lc-"
  image_id             = aws_ami_from_instance.webapp_golden.id
  instance_type        = var.prod-lc_instance_type
  security_groups      = [aws_security_group.webapp_private_sg.id]
  iam_instance_profile = aws_iam_instance_profile.s3access_profile.id
  key_name             = aws_key_pair.webapp_auth.id
  user_data            = file("userdata")

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_ami_from_instance.webapp_golden]
}

resource "aws_autoscaling_group" "webapp_asg" {
  name                      = "asg-${aws_launch_configuration.webapp_lc.id}"
  max_size                  = var.asg_max
  min_size                  = var.asg_min
  health_check_grace_period = var.asg_grace
  health_check_type         = var.asg_hct
  desired_capacity          = var.asg_cap
  force_delete              = true
  load_balancers            = [ aws_elb.webapp_elb.id]

  vpc_zone_identifier = [aws_subnet.webapp_private1_subnet.id,
    aws_subnet.webapp_private2_subnet.id,
  ]

  launch_configuration = aws_launch_configuration.webapp_lc.name

  tag {
    key                 = "Name"
    value               = "webapp_asg-instance"
    propagate_at_launch = true
  }

  lifecycle  {
    create_before_destroy = true
  }
}
