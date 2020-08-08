output "dev_server_ip" {
  description = "Dev Server Public IP"
  value       = aws_instance.webapp_dev.public_ip
}

output "prod_elb_endpoint" {
  description = "Prod ELB endpoints"
  value       = aws_elb.webapp_elb.dns_name 
}